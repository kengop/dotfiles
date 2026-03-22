#!/bin/bash
DIR="${1:-.}"
rtrim() { awk '{n=length; print (n>15 ? substr($0,n-14) : $0)}'; }

claude_state() {
  local abs_dir
  abs_dir=$(realpath "$1" 2>/dev/null || echo "$1")
  local session_name="claude-$(echo "$abs_dir" | md5sum | cut -c1-8)"
  tmux has-session -t "$session_name" 2>/dev/null || return

  local last_output
  last_output=$(tmux capture-pane -t "$session_name" -p 2>/dev/null)

  if echo "$last_output" | grep -q "esc to interrupt"; then
    echo "🤔"  # 処理中
  else
    echo "❓"  # 入力待ち
  fi
}

TOPLEVEL=$(git -C "$DIR" rev-parse --show-toplevel 2>/dev/null)
STATE=$(claude_state "$DIR")

if [ -z "$TOPLEVEL" ]; then
    TITLE=$(basename "$DIR" | rtrim)
    echo "${TITLE}${STATE:+ $STATE}"
    exit 0
fi
NAME=$(basename "$TOPLEVEL" | rtrim)
GITDIR=$(git -C "$DIR" rev-parse --git-dir 2>/dev/null)
if echo "$GITDIR" | grep -q worktrees; then
    echo "[wt]${NAME}${STATE:+ $STATE}"
else
    echo "${NAME}${STATE:+ $STATE}"
fi

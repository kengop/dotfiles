#!/bin/bash
DIR="${1:-.}"
PANE_ID="${2:-}"
MODE="${3:-}"
PANE_PID="${4:-}"
rtrim() { awk '{n=length; print (n>15 ? substr($0,n-14) : $0)}'; }

# claude ウィンドウ自身の状態を直接参照する
claude_state_direct() {
  local pane_id="$1"
  local content
  content=$(tmux capture-pane -t "$pane_id" -p 2>/dev/null)
  if echo "$content" | grep -q "esc to interrupt"; then
    echo "🤔"  # 処理中
  elif echo "$content" | grep -q "Esc to cancel"; then
    echo "💬"  # 権限確認待ち
  elif echo "$content" | grep -q "Would you like to proceed"; then
    echo "📋"  # プラン承認待ち
  else
    echo "❓"  # 入力待ち
  fi
}

# Claude セッション名を取得（pane_pid の子プロセス PID でセッションファイルを参照）
get_session_name() {
  local pane_pid="$1"
  [ -n "$pane_pid" ] || return
  local pid session_file
  for pid in $(pgrep -P "$pane_pid" 2>/dev/null); do
    session_file="$HOME/.claude/sessions/${pid}.json"
    if [ -f "$session_file" ]; then
      grep -o '"name":"[^"]*"' "$session_file" | head -1 | sed 's/"name":"//;s/"$//'
      return
    fi
  done
}

# bash ウィンドウから同パスの claude ペインを検索（処理中優先）
claude_state_by_path() {
  local abs_dir
  abs_dir=$(realpath "$1" 2>/dev/null || echo "$1")
  local found=""
  local state=""
  while IFS='|' read -r pid pcmd ppath; do
    [ "$pcmd" = "claude" ] || continue
    local abs_ppath
    abs_ppath=$(realpath "$ppath" 2>/dev/null || echo "$ppath")
    [ "$abs_ppath" = "$abs_dir" ] || continue
    found=1
    local content
    content=$(tmux capture-pane -t "$pid" -p 2>/dev/null)
    if echo "$content" | grep -q "esc to interrupt"; then
      echo "🤔"
      return  # 処理中を見つけたら即リターン（処理中優先）
    elif echo "$content" | grep -q "Esc to cancel"; then
      state="💬"  # 権限確認待ち（処理中より優先度低）
    elif echo "$content" | grep -q "Would you like to proceed"; then
      state="📋"  # プラン承認待ち
    elif [ -z "$state" ]; then
      state="❓"
    fi
  done < <(tmux list-panes -a -F '#{pane_id}|#{pane_current_command}|#{pane_current_path}')
  [ -n "$found" ] && echo "$state"
  # 同パスの claude が1つも見つからなければ空文字を返す
}

TOPLEVEL=$(git -C "$DIR" rev-parse --show-toplevel 2>/dev/null)
# claude モード: 自分のペインを直接参照、bash モード: 同パスの claude を検索
if [ "$MODE" = "claude" ] && [ -n "$PANE_ID" ]; then
  STATE=$(claude_state_direct "$PANE_ID")
else
  STATE=$(claude_state_by_path "$DIR")
fi

# claude モードの場合、セッション名を取得
SESSION_NAME=""
if [ "$MODE" = "claude" ] && [ -n "$PANE_PID" ]; then
  SESSION_NAME=$(get_session_name "$PANE_PID")
fi

if [ -n "$SESSION_NAME" ]; then
    echo "${STATE:+$STATE }${SESSION_NAME:0:15}"
    exit 0
fi

if [ -z "$TOPLEVEL" ]; then
    TITLE=$(basename "$DIR" | rtrim)
    echo "${STATE:+$STATE }${TITLE}"
    exit 0
fi
NAME=$(basename "$TOPLEVEL" | rtrim)
GITDIR=$(git -C "$DIR" rev-parse --git-dir 2>/dev/null)
if echo "$GITDIR" | grep -q worktrees; then
    echo "${STATE:+$STATE }[wt]${NAME}"
else
    echo "${STATE:+$STATE }${NAME}"
fi

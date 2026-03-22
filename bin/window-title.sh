#!/bin/bash
DIR="${1:-.}"
rtrim() { awk '{n=length; print (n>15 ? substr($0,n-14) : $0)}'; }

TOPLEVEL=$(git -C "$DIR" rev-parse --show-toplevel 2>/dev/null)
if [ -z "$TOPLEVEL" ]; then
    basename "$DIR" | rtrim
    exit 0
fi
NAME=$(basename "$TOPLEVEL" | rtrim)
GITDIR=$(git -C "$DIR" rev-parse --git-dir 2>/dev/null)
if echo "$GITDIR" | grep -q worktrees; then
    echo "[wt]$NAME"
else
    echo "$NAME"
fi

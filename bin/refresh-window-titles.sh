#!/bin/bash
# 全セッションの bash / claude ウィンドウのタイトルを window-title.sh で更新する
tmux list-windows -a \
  -F '#{session_name}:#{window_index}|#{pane_id}|#{pane_current_command}|#{pane_current_path}' \
  | while IFS='|' read -r win pid cmd path; do
    if [ "$cmd" = "bash" ]; then
      new_title=$(~/dotfiles/bin/window-title.sh "$path" "$pid")
      [ -n "$new_title" ] || continue
      tmux rename-window -t "$win" "$new_title" 2>/dev/null
      tmux set-window-option -t "$win" automatic-rename on 2>/dev/null
    elif [ "$cmd" = "claude" ]; then
      new_title=$(~/dotfiles/bin/window-title.sh "$path" "$pid" claude)
      [ -n "$new_title" ] || continue
      tmux rename-window -t "$win" "$new_title" 2>/dev/null
      tmux set-window-option -t "$win" automatic-rename on 2>/dev/null
    fi
  done

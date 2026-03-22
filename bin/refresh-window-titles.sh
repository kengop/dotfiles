#!/bin/bash
# 全セッションの bash ウィンドウのタイトルを window-title.sh で更新する
tmux list-windows -a \
  -F '#{session_name}:#{window_index}|#{pane_current_command}|#{pane_current_path}' \
  | while IFS='|' read -r win cmd path; do
    [ "$cmd" = "bash" ] || continue
    new_title=$(~/dotfiles/bin/window-title.sh "$path")
    tmux rename-window -t "$win" "$new_title"
    tmux set-window-option -t "$win" automatic-rename on
  done

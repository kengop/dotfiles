#!/bin/sh

## init TMUX plugin manager
if [ ! -d "${HOME}/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

## fzf (fuzzy finder)
if [ ! -d "${HOME}/.fzf" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
fi
~/.fzf/install --bin

## fzf.vim (Vim 用拡張コマンド)
FZF_VIM_DIR="${HOME}/.vim/pack/plugins/start/fzf.vim"
if [ ! -d "${FZF_VIM_DIR}" ]; then
  mkdir -p "${HOME}/.vim/pack/plugins/start"
  git clone --depth 1 https://github.com/junegunn/fzf.vim.git "${FZF_VIM_DIR}"
fi

## catppuccin (colorscheme)
CATPPUCCIN_DIR="${HOME}/.vim/pack/plugins/start/catppuccin"
if [ ! -d "${CATPPUCCIN_DIR}" ]; then
  git clone --depth 1 https://github.com/catppuccin/vim.git "${CATPPUCCIN_DIR}"
fi

## ripgrep (:Rg コマンドに必要)
if ! command -v rg > /dev/null 2>&1; then
  echo "NOTE: ripgrep (rg) 未インストール。:Rg を使うには: sudo apt install ripgrep"
fi

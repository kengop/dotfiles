set nocompatible
filetype off

set laststatus=2
set showtabline=2
set noshowmode


" Required:
filetype plugin indent on

" タブ
set ts=2 sw=2 et

autocmd VimEnter, Colorschme * : highligh IndentGudesOdd ctermbg=236
autocmd VimEnter, Colorschme * : highligh IndentGudesEven ctermbg=black
" 行番号
set number
" ビジュアルベルの表示内容．空文字なら何もしない
set vb t_vb=
" インクリメンタルサーチを行う
set incsearch
" 小文字のみで検索したときに大文字小文字を無視する
set smartcase
" 検索結果をハイライト表示
set hlsearch
" 見えない特殊文字を見えるようにする
set list
" タブと行の続きを可視化する
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<
" エディタウィンドウの末尾から2行目にステータスラインを常時表示させる 
set laststatus=2
" ステータスラインに表示させる情報 
set statusline=%F%r%h%=
set fileencoding=utf-8
" 改行コードの確認
set fileformat=unix
" カーソルの行数を表示
set ruler
" ウィンドウのタイトルバーにファイルのパス情報を表示
set title
" カーソルを行頭，行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
" コマンドラインモードで<Tab>キーによるファイル名補完を有効にする
set wildmenu
" 入力中のコマンドを表示
set showcmd
" 対応する括弧を強調させる
set showmatch
filetype on
" ステータスラインのフォーマット指定
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P,%Y
set viminfo=
" 構文毎に文字色を変化させる
syntax on
" 色
set background=dark
" set term=xterm
" set t_Co=256
" let &t_AB="\e[48;5;%dm"
" let &t_AF="\e[38;5;%dm"

" colorscheme
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
colorscheme catppuccin_mocha

" スクロール送りを開始する前後の行数を指定
set scrolloff=5

" 行間
set linespace=3
" タブ関連
"autocmd VimEnter * tab all
"autocmd BufAdd * exe 'Tablast | tabe "' . expand( "<afile") .'"'
" タブ文字の表示幅
set tabstop=2
" タブ入力を複数の空白入力に置き換える
"set expandtab
" vimが入力するタブのサイズ
set shiftwidth=2
set expandtab
set autoindent
" カーソル行の背景色を変更する
set cursorline
" ヤンクしたデータをクリップボードで使用＆選択範囲自動コピー
set clipboard=unnamed,autoselect
" WSL 対応: vim が -clipboard ビルドのため上記だけでは Windows クリップボードへ
" 渡らない。tmux copy-mode と同じ win32yank.exe 経由でヤンク時に橋渡しする。
if executable('win32yank.exe')
  function! s:Win32YankOnYank() abort
    if v:event.operator !=# 'y'
      return
    endif
    let l:text = join(v:event.regcontents, "\n")
    if v:event.regtype ==# 'V'
      let l:text .= "\n"
    endif
    call system('win32yank.exe -i --crlf', l:text)
  endfunction
  augroup WSLClipboardYank
    autocmd!
    autocmd TextYankPost * call s:Win32YankOnYank()
  augroup END
endif
" ファイル名に普通にスラッシュを使う(完全ではない)
set shellslash
" カーソルを表示行（visual line）で移動する
" ただし diff モードでは論理行単位で動かしたいので real line 移動に戻す
" （wrap した長行で j を押しても進まない、という挙動を避ける）
nnoremap <expr> j      &diff ? 'j' : 'gj'
nnoremap <expr> k      &diff ? 'k' : 'gk'
nnoremap <expr> <Down> &diff ? 'j' : 'gj'
nnoremap <expr> <Up>   &diff ? 'k' : 'gk'

" 検索結果のハイライトと取り消し
nnoremap <ESC><ESC> : nohlsearch<CR>

" エラービープ音の全停止
set visualbell t_vb=
set noerrorbells

" 検索結果の対象を中央に表示
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" INSERTモードから抜けるときに便利なキーバインド
inoremap <silent> jj <ESC>

set encoding=utf-8

" fzf
set rtp+=~/.fzf
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
nnoremap <C-p> :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>r :Rg<CR>
nnoremap <Leader>h :History<CR>

" vim-gitgutter
set updatetime=100
let g:gitgutter_highlight_lines = 1
nnoremap <Leader>gt :GitGutterLineHighlightsToggle<CR>
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

" Claude Code diff palette
function! s:GitGutterClaudeColors() abort
  highlight GitGutterAdd               guifg=#2EA043 guibg=#022800
  highlight GitGutterChange            guifg=#2EA043 guibg=#022800
  highlight GitGutterDelete            guifg=#5C0200 guibg=NONE
  highlight GitGutterAddLine           guibg=#022800
  highlight GitGutterChangeLine        guibg=#022800
  " guibg=NONE だけでは Vim が「属性未設定」扱いし catppuccin の
  " DiffDelete (#F38BA8) への default link を打ち消せないため明示リンクで無効化
  highlight link GitGutterDeleteLine Normal
  highlight GitGutterChangeDeleteLine  guibg=#022800
endfunction
augroup GitGutterClaudeColors
  autocmd!
  autocmd ColorScheme * call s:GitGutterClaudeColors()
augroup END
call s:GitGutterClaudeColors()

" vimdiff のハイライト
" Catppuccin デフォルトでは CursorLine + DiffText で前景・背景が同色になり
" 読めなくなるため、GitGutter と同じパレットで明示的に上書きする
function! s:DiffClaudeColors() abort
  highlight DiffAdd     guibg=#0A4D0A guifg=NONE  gui=NONE
  highlight DiffChange  guibg=#0A4D0A guifg=NONE  gui=NONE
  highlight DiffDelete  guibg=#4D0A0A guifg=#5C0200 gui=NONE
  highlight DiffText    guibg=#1F7A1F guifg=NONE  gui=bold
endfunction
augroup DiffClaudeColors
  autocmd!
  autocmd ColorScheme * call s:DiffClaudeColors()
augroup END
call s:DiffClaudeColors()

" vimdiff 起動時は両ペインで wrap を有効化（長い行を画面内で折り返して見せる）
" diff モードは既定で nowrap になるため、起動完了時に明示的に上書きする
function! s:VimDiffWrapEnable() abort
  if &diff
    windo setlocal wrap
    wincmd t
  endif
endfunction
augroup VimDiffWrap
  autocmd!
  autocmd VimEnter * call s:VimDiffWrapEnable()
augroup END

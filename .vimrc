set nocompatible
filetype off
" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
   if &compatible
     set nocompatible " Be iMproved
   endif
   " Required:
   set runtimepath+=~/.vim/bundle/neobundle.vim/
 endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
"NeoBundle 'alkt/plantuml-syntax'
" markdown中のテーブル部分の整形
NeoBundle 'godlygeek/tabular'
" markdownのシンタックスハイライト
NeoBundle 'plasticboy/vim-markdown'
" markdownのソースコードのシンタックスハイライト
NeoBundle "joker1007/vim-markdown-quote-syntax"
" インデントに色を付けて見やすくする
NeoBundle 'nathanaelkane/vim-indent-guides'

NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'sickill/vim-monokai'

NeoBundleLazy 'leafgarland/typescript-vim', {
\ 'autoload' : {
\   'filetypes' : ['typescript'] }
\}

NeoBundleLazy 'jason0x43/vim-js-indent', {
\ 'autoload' : {
\   'filetypes' : ['javascript', 'typescript', 'html'],
\}}
let g:js_indent_typescript = 1

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" vim-indent-guidsの設定
" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
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
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
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
colorscheme monokai

" スクロール送りを開始する前後の行数を指定
set scrolloff=5

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
" ファイル名に普通にスラッシュを使う(完全ではない)
set shellslash
" カーソルを表示行（物理行）で移動する
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk

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

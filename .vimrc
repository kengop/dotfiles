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
NeoBundle 'alkt/plantuml-syntax'
NeoBundle 'godlygeek/tabular'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle "joker1007/vim-markdown-quote-syntax"

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

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
" カーソルを表示行（物理行）で移動する
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
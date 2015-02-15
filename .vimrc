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
" タブと行の続きを可視化する
set listchars=tab:>\ ,extends:<
" エディタウィンドウの末尾から2行目にステータスラインを常時表示させる 
set laststatus=2
" ステータスラインに表示させる情報 
set statusline=%F%r%h%=
set fileencoding=utf-8
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

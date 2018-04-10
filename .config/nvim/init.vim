"dein -----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state($HOME . '/.cache/dein')
  let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
  let s:dein_dir = s:cache_home . '/dein'
  let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
  endif
  let &runtimepath = s:dein_repo_dir .",". &runtimepath
  let s:toml = '~/.config/nvim/dein/toml/dein.toml'
  if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    call dein#load_toml(s:toml)
    call dein#end()
    call dein#save_state()
  endif

  " If you want to install not installed plugins on startup.
  if has('vim_starting') && dein#check_install()
    call dein#install()
  endif
endif

" Required:
filetype plugin indent on
syntax enable
"End dein -------------------------

set wrapscan      " 最後まで検索したら先頭へ戻る
set ignorecase    " 大文字小文字無視
set smartcase     " 大文字ではじめたら大文字小文字無視しない
set incsearch     " インクリメンタルサーチ
set hlsearch      " 検索文字をハイライト
nmap <Esc><Esc> :nohlsearch<CR><Esc>  " Esc2回でハイライトを消す

"" text ----------
set textwidth=0   " text幅無制限
set nowrap        " 折り返し無し
set number        " 行番号表示
set tabstop=2     " tabの空白の数
set softtabstop=2 " tab入力時の空白の数
set shiftwidth=2  " インデントの空白の数
set expandtab     " tab入力で<tab>ではなく空白を入力
set autoindent
set smartindent
set clipboard=unnamed "クリップボードを利用する
set bs=indent,eol,start " インデント、行頭でもbackspaceを有効に
set hid           " 編集中のバッファを保存しないでも切り替え可能に
set nobackup      " backupファイル関連作らない
set nowritebackup "
set noswapfile    "
autocmd BufWritePre * :%s/\s\+$//ge " 保存時に行末空白削除

"" line number
hi LineNr ctermfg=4
set cursorline
hi clear CursorLine

" command ----------
set wildmenu      " コマンドライン補完を拡張モードに

" misc ----------
set visualbell    " beep音を消す
set laststatus=2  " statuslineを常に表示
set modeline

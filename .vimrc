set nocompatible  " vi互換モードoff
filetype off

" NeoBundle setting
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle/'))
  NeoBundleFetch 'Shougo/neobundle.vim'

  " NeoBundled plugins
  NeoBundle 'Shougo/neocomplcache.git'
  NeoBundle 'Shougo/neocomplcache-rsense'
  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
      \ 'windows' : 'make -f make_mingw32.mak',
      \ 'cygwin' : 'make -f make_cygwin.mak',
      \ 'mac' : 'make -f make_mac.mak',
      \ 'unix' : 'make -f make_unix.mak',
    \ },
  \ }
  NeoBundle 'Shougo/vimfiler'
  NeoBundle 'thinca/vim-ref'
  NeoBundle 'thinca/vim-quickrun'
  NeoBundle 'tpope/vim-endwise'
  NeoBundle 'bling/vim-bufferline'
  NeoBundle 'bling/vim-airline'
  NeoBundle 'rhysd/clever-f.vim'
  NeoBundle 'szw/vim-tags'
  NeoBundle 'altercation/vim-colors-solarized'
  " node.js
  NeoBundle 'moll/vim-node'
  NeoBundle 'myhere/vim-nodejs-complete'
  NeoBundle 'kchmck/vim-coffee-script'
  
  NeoBundle 'markcornick/vim-terraform'
call neobundle#end()

" neocomplcache setting ----------
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplcache.
  let g:neocomplcache_enable_at_startup = 1
  " Use smartcase.
  let g:neocomplcache_enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplcache_min_syntax_length = 3
  let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
  
  " Enable heavy features.
  " Use camel case completion.
  "let g:neocomplcache_enable_camel_case_completion = 1
  " Use underbar completion.
  let g:neocomplcache_enable_underbar_completion = 1
  
  " Define dictionary.
  let g:neocomplcache_dictionary_filetype_lists = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
      \ }
  
  " Define keyword.
  if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
  endif
  let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
  
  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplcache#undo_completion()
  inoremap <expr><C-l>     neocomplcache#complete_common_string()
  
  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    "return neocomplcache#smart_close_popup() . "\<CR>"
    " For no inserting <CR> key.
    return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
  endfunction
 
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplcache#close_popup()
  inoremap <expr><C-e>  neocomplcache#cancel_popup()

  " Close popup by <Space>.
  "inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"
  
  " For cursor moving in insert mode(Not recommended)
  "inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
  "inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
  "inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
  "inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
  " Or set this.
  "let g:neocomplcache_enable_cursor_hold_i = 1
  " Or set this.
  "let g:neocomplcache_enable_insert_char_pre = 1
  
  " AutoComplPop like behavior.
  "let g:neocomplcache_enable_auto_select = 1
  
  " Shell like behavior(not recommended).
  "set completeopt+=longest
  "let g:neocomplcache_enable_auto_select = 1
  "let g:neocomplcache_disable_auto_complete = 1
  "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
  
  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  
  " Enable heavy omni completion.
  if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
  endif
  let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
  
  " rsense (ruby) setting
  if filereadable( expand('~/.vim/rsense/rsense-0.3/bin/rsense') )
    let g:rsenseHome = expand('~/.vim/rsense/rsense-0.3')
    let g:rsenseUseOmniFunc = 1
    let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
  endif

  " For perlomni.vim setting.
  " https://github.com/c9s/perlomni.vim
  let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" neocomplcache setting ----------

" Unite.vim setting ----------
  cnoremap ub<CR> Unite buffer<CR>  
  cnoremap uf<CR> Unite file<CR>  
" Unite.vim setting ----------

" VimFiler setting ----------
  " 引数なしで実行したとき、VimFilerExplorerを実行する
  let file_name = expand("%:p")
  if has('vim_starting') &&  file_name == ""
      autocmd VimEnter * VimFilerExplorer
  endif
  nnoremap <Leader>e :VimFilerExplorer<CR>  " \eでVimFilerExplorerを開く
" VimFiler setting ----------

" airline setting ----------
  let g:airline_left_sep = ''
  let g:airline_right_sep= ''
" airline setting ----------

" solarized setting ----------
  syntax enable
  set background=dark
  colorscheme solarized
" solarized setting ----------

" coffee script setting ------
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
autocmd FileType coffee     setlocal sw=2 sts=2 ts=2 et

filetype plugin indent on  " required for Neobundle
filetype indent on
syntax on

" search ----------
set wrapscan      " 最後まで検索したら先頭へ戻る
set ignorecase    " 大文字小文字無視
set smartcase     " 大文字ではじめたら大文字小文字無視しない
set incsearch     " インクリメンタルサーチ
set hlsearch      " 検索文字をハイライト
set wrapscan      " 末尾まで検索したら再び先頭から検索
nmap <Esc><Esc> :nohlsearch<CR><Esc>  " Esc2回でハイライトを消す
nnoremap <C-]> g<C-]> " tagsジャンプの時に複数ある時は一覧表示                                        

" move
set whichwrap=b,s,h,l,<,>,[,] " カーソルを行頭末で止まらないように

" buffer
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprevious<CR>

" text ----------
set textwidth=0   " text幅無制限
set nowrap        " 折り返し無し
set number        " 行番号表示
set tabstop=2     " tabの空白の数
set softtabstop=2 " tab入力時の空白の数
set shiftwidth=2  " インデントの空白の数
set expandtab     " tab入力で<tab>ではなく空白を入力
set autoindent    " オートインデント
set clipboard=unnamed "クリップボードを利用する
set undofile            " enalbe to persistent undo
set undodir=~/.vimundo  " persistent undo dir
set bs=indent,eol,start " インデント、行頭でもbackspaceを有効に
set hid           " 編集中のバッファを保存しないでも切り替え可能に
set nobackup      " backupファイル関連作らない
set nowritebackup " 
set noswapfile    " 
" カレントウィンドウのみカーソル行をハイライト
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

" command ----------
set wildmenu      " コマンドライン補完を拡張モードに

" misc ----------
set visualbell    " beep音を消す
set laststatus=2  " statuslineを常に表示

" enable local customize if needed ----------
if filereadable(expand('~/.vimrc'))
  source ~/.vimrc
endif

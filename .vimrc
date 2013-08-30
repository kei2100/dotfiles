set nocompatible  " vi互換モードoff
filetype off

" NeoBundle setting
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

" NeoBundled plugins
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache.git'
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
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'itchyny/lightline.vim'

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
  "let g:neocomplcache_enable_underbar_completion = 1
  
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
    return neocomplcache#smart_close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
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
  
  " For perlomni.vim setting.
  " https://github.com/c9s/perlomni.vim
  let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" neocomplcache setting ----------

" Unite.vim setting ----------
  cnoremap ub<CR> Unite buffer<CR>  
" Unite.vim setting ----------

" VimFiler setting ----------
  " 引数なしで実行したとき、VimFilerExplorerを実行する
  let file_name = expand("%:p")
  if has('vim_starting') &&  file_name == ""
      autocmd VimEnter * VimFilerExplorer
  endif
  nnoremap <Leader>e :VimFilerExplorer<CR>  " \eでVimFilerExplorerを開く
" VimFiler setting ----------

" solarized setting ----------
  syntax enable
  set background=dark
  colorscheme solarized
" solarized setting ----------

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

" move
set whichwrap=b,s,h,l,<,>,[,] " カーソルを行頭末で止まらないように

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

" command ----------
set wildmenu      " コマンドライン補完を拡張モードに

" misc ----------
set visualbell    " beep音を消す
" enable local customize if needed ----------
if filereadable(expand('~/.vimrc'))
  source ~/.vimrc
endif

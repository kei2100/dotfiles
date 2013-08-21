" vi互換モードoff
set nocompatible
filetype off

" NeoBundle setting
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

" NeoBundled plugins
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-quickrun'

filetype plugin indent on 
filetype indent on
syntax on


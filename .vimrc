set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugin 'vim-scripts/matlab.vim'

Plugin 'grep.vim'

Plugin 'kien/rainbow_parentheses.vim'

Plugin 'guns/vim-clojure-static'

Plugin 'scrooloose/nerdcommenter'

Plugin 'tpope/vim-fireplace'

Plugin 'chriskempson/base16-vim'

Plugin 'vim-scripts/paredit.vim'

Plugin 'JuliaEditorSupport/julia-vim'

Plugin 'scrooloose/nerdtree'

Plugin 'tpope/vim-fugitive'

Plugin 'tpope/vim-surround'

Plugin 'vim-airline/vim-airline'

Plugin 'vim-airline/vim-airline-themes'

Plugin 'scrooloose/syntastic'

Plugin 'posva/vim-vue'

" Plugin 'valloric/youcompleteme'

Plugin 'othree/yajs.vim'

Plugin 'digitaltoad/vim-pug'

Plugin 'jvirtanen/vim-octave'

Plugin 'ervandew/supertab'

Plugin 'rakr/vim-one'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
au VimEnter * RainbowParenthesesToggle
set t_Co=256
" let base16colorspace=256
set background=light
colorscheme one
set number
syntax on

"set nowrap
set tabstop=2
set shiftwidth=2
set autoindent
set copyindent
set shiftround
set showmatch
set hlsearch
set ignorecase
set smarttab

nnoremap ; :
map <C-n> :NERDTreeToggle<CR>

let filetype_m='matlab'

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='one'

set laststatus=2

nmap <C-h> :nohlsearch<CR>

set wrap
set linebreak
set nolist

let g:paredit_shortmaps = 1
let mapleader = ','

autocmd filetype crontab setlocal nobackup nowritebackup

set exrc
set secure

if has('nvim')
	map <C-o> :tabe<CR> :terminal<CR>
endif

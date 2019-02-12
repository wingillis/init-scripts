set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'ajh17/VimCompletesMe'
Plugin 'xolox/vim-misc'
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'
Plugin 'grep.vim'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'xolox/vim-session'
Plugin 'guns/vim-clojure-static'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-fireplace'
Plugin '907th/vim-auto-save'
Plugin 'vim-scripts/paredit.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'reedes/vim-pencil'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Plugin 'scrooloose/syntastic'
" Plugin 'valloric/youcompleteme'
Plugin 'jvirtanen/vim-octave'
" Plugin 'ervandew/supertab'
Plugin 'neomake/neomake'
Plugin 'majutsushi/tagbar'
" These are the new colorschemes I like that I should use
" carbonized-dark
Plugin 'nightsense/carbonized'
Plugin 'beigebrucewayne/skull-vim'
Plugin 'hauleth/blame.vim'
" stellarized_dark
Plugin 'nightsense/stellarized'
Plugin 'wingillis/skwull-vim'

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
" au VimEnter * RainbowParenthesesToggle
set t_Co=256
set background=dark
set termguicolors
colorscheme dracula
syntax on

set tabstop=2
set shiftwidth=2
set autoindent
set copyindent
set shiftround
set showmatch
set hlsearch
set incsearch
set ignorecase
set smarttab
set number
set wrap
set linebreak
set nolist
set laststatus=2
set history=100


nnoremap ; :
map <C-n> :NERDTreeToggle<CR>

let filetype_m='matlab'
autocmd BufNewFile,BufRead *.nf set syntax=groovy

let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'

let g:syntastic_disabled_filetypes=['py']

nmap <C-h> :nohlsearch<CR>

let g:pencil#textwidth=120
let g:paredit_shortmaps = 1
let mapleader = ','

set exrc
set secure
"set mouse=a

set list
set listchars=tab:\|•

noremap <silent> <Leader>s :call ToggleScheme()<CR>
nnoremap <silent> <Leader>pn :call StartPencil()<CR>

function g:ToggleScheme()
	if g:colors_name == 'Tomorrow'
		"set background=dark
		colorscheme dracula
		AirlineTheme bubblegum
	else
		"set background=light
		colorscheme Tomorrow
		AirlineTheme light
	endif
endfunction

function g:StartPencil()
	if PencilMode() == ''
		SoftPencil
		set numberwidth=10
	else
		PencilOff
		set numberwidth=4
	endif
endfunction

" turn off autosave
let g:auto_save = 0
let g:auto_save_events = ["InsertLeave", "TextChanged"]
let g:session_autosave = 'no'

autocmd VimEnter * :AirlineRefresh

set hidden

" add a line containing today's date to the text 
nnoremap <silent> <Leader>dt "=strftime("\n## %A, %B %d, %Y\n")<CR>p

let &t_SI.="\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
set timeoutlen=1000 ttimeoutlen=10
set backspace=indent,eol,start

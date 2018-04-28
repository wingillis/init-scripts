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

Plugin 'junegunn/goyo.vim'

Plugin 'grep.vim'

Plugin 'kien/rainbow_parentheses.vim'

Plugin 'flazz/vim-colorschemes'

Plugin 'guns/vim-clojure-static'

Plugin 'scrooloose/nerdcommenter'

Plugin 'tpope/vim-fireplace'

"Plugin 'chriskempson/base16-vim'

Plugin 'vim-scripts/paredit.vim'

"Plugin 'JuliaEditorSupport/julia-vim'

Plugin 'scrooloose/nerdtree'

Plugin 'tpope/vim-fugitive'

Plugin 'tpope/vim-surround'

Plugin 'vim-airline/vim-airline'

Plugin 'vim-airline/vim-airline-themes'

" Plugin 'scrooloose/syntastic'

"Plugin 'posva/vim-vue'

" Plugin 'valloric/youcompleteme'

"Plugin 'othree/yajs.vim'

"Plugin 'digitaltoad/vim-pug'

Plugin 'jvirtanen/vim-octave'

Plugin 'ervandew/supertab'

"Plugin 'rakr/vim-one'

Plugin 'neomake/neomake'

Plugin 'majutsushi/tagbar'

" These are the new colorschemes I like that I should use
" moonscape SUX
Plugin 'Drogglbecher/vim-moonscape'
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
" let base16colorspace=256
set background=dark
set termguicolors
colorscheme skwull
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
set number
set wrap
set linebreak
set nolist
set laststatus=2


nnoremap ; :
map <C-n> :NERDTreeToggle<CR>

let filetype_m='matlab'

let g:syntastic_disabled_filetypes=['py']
let g:airline#extensions#tabline#enabled = 1
let g:base16_airline=1
"let g:airline_theme='one'


nmap <C-h> :nohlsearch<CR>


let g:paredit_shortmaps = 1
let mapleader = ','

"autocmd filetype crontab setlocal nobackup nowritebackup

set exrc
set secure
"set mouse=a

if has('nvim')
	map <C-o> :tabe<CR> :terminal<CR>
endif

set list
set listchars=tab:\|•

noremap <silent> <Leader>w :call ToggleWrap()<CR>
let g:mywrap=0
function ToggleWrap()
  if g:mywrap
    echo "Wrap OFF"
    set virtualedit=all
    let g:mywrap=0
    silent! nunmap <buffer> <Up>
    silent! nunmap <buffer> <Down>
    silent! nunmap <buffer> <Home>
    silent! nunmap <buffer> <End>
    silent! iunmap <buffer> <Up>
    silent! iunmap <buffer> <Down>
    silent! iunmap <buffer> <Home>
    silent! iunmap <buffer> <End>
    silent! nunmap <buffer> k
    silent! nunmap <buffer> j
    silent! nunmap <buffer> 0
    silent! nunmap <buffer> $
  else
    echo "Wrap ON"
    let g:mywrap=1
    set virtualedit=
    setlocal display+=lastline
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    noremap  <buffer> <silent> k gk
    noremap  <buffer> <silent> j gj
    noremap  <buffer> <silent> 0 g0
    noremap  <buffer> <silent> $ g$
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
  endif
endfunction

hi Search guibg=#2c2c2c guifg=#838383
hi Cursor guifg=#bbbbbb guibg=#729FC2
hi iCursor guibg=#729FC2 guifg=#bbbbbb

let g:spacegray_low_contrast = 1

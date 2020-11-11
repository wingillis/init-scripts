set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')
Plug 'posva/vim-vue'
Plug 'plasticboy/vim-markdown'
Plug 'xolox/vim-misc'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'kien/rainbow_parentheses.vim', { 'for': 'clojure' }
Plug 'flazz/vim-colorschemes'
Plug 'xolox/vim-session'
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fireplace'
Plug '907th/vim-auto-save'
Plug 'vim-scripts/paredit.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'reedes/vim-pencil'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jvirtanen/vim-octave', { 'for': 'matlab' }
Plug 'majutsushi/tagbar'
" These are the new colorschemes I like that I should use
" carbonized-dark
Plug 'nightsense/carbonized'
Plug 'hauleth/blame.vim'
" stellarized_dark
Plug 'nightsense/stellarized'
Plug 'wingillis/skwull-vim'

Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

" All of your Plugins must be added before the following line
call plug#end()            " required

filetype plugin indent on    " required

set t_Co=256
set background=light
if system('hostname -s') !~ 'datta'
	set termguicolors
endif
colorscheme Tomorrow
"colorscheme solarized8_light
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
map <C-l> :Toc<CR>

let filetype_m='matlab'
autocmd BufNewFile,BufRead *.nf set syntax=groovy

let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='papercolor'

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
	if g:colors_name == 'solarized8_light'
		colorscheme skwull
		AirlineTheme bubblegum
		let &t_SI = "\<Esc>]1337;SetColors=curbg=fff\x7"
		let &t_SI .= "\<Esc>]1337;SetColors=curfg=000\x7"
		let &t_SI .="\<Esc>]50;CursorShape=1\x7"
		let &t_EI = "\<Esc>]1337;SetColors=curbg=fff\x7"
		let &t_EI .= "\<Esc>]1337;SetColors=curfg=000\x7"
		let &t_EI .= "\<Esc>]50;CursorShape=0\x7"
		normal i
	else
		colorscheme Tomorrow
		AirlineTheme solarized
		let &t_SI = "\<Esc>]1337;SetColors=curbg=000\x7"
		let &t_SI .= "\<Esc>]1337;SetColors=curbg=fff\x7"
		let &t_SI .="\<Esc>]50;CursorShape=1\x7"
		let &t_EI = "\<Esc>]1337;SetColors=curbg=000\x7"
		let &t_EI .= "\<Esc>]1337;SetColors=curbg=fff\x7"
		let &t_EI .= "\<Esc>]50;CursorShape=0\x7"
		normal i
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
nnoremap <silent> <Leader>dt "=strftime("## %A, %B %d, %Y  [[daily-notes]]\n\n\n")<CR>p

if g:colors_name == 'skwull'
	let &t_SI = "\<Esc>]1337;SetColors=curbg=fff\x7"
	let &t_SI .= "\<Esc>]1337;SetColors=curfg=000\x7"
	let &t_SI .="\<Esc>]50;CursorShape=1\x7"
	let &t_EI = "\<Esc>]1337;SetColors=curbg=fff\x7"
	let &t_EI .= "\<Esc>]1337;SetColors=curfg=000\x7"
	let &t_EI .= "\<Esc>]50;CursorShape=0\x7"
	normal i
endif


let &t_SI .="\<Esc>]50;CursorShape=1\x7"
let &t_EI .= "\<Esc>]50;CursorShape=0\x7"
set timeoutlen=1000 ttimeoutlen=10
set backspace=indent,eol,start

let g:vim_markdown_folding_disabled = 1

set lazyredraw
set regexpengine=1

" some coc definitions
set signcolumn=yes
set shortmess+=c
set updatetime=300
set cmdheight=2

nmap <silent> gd <Plug>(coc-definition)
inoremap <silent><expr> <c-space> coc#refresh()
" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space()
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" jump between diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

"autocmd VimLeave * silent !echo -ne "\033]1337;SetColors=curbg=000\a"
"autocmd VimLeave * silent !echo -ne "\033]1337;SetColors=curfg=fff\a"

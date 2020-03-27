" my configuration for markdown file editing
"
autocmd! VimLeave * silent !echo -ne "\033]1337;SetColors=curbg=000\a"
autocmd! VimLeave * silent !echo -ne "\033]1337;SetColors=curfg=fff\a"

SoftPencil

if &columns < 90
	Goyo 95%
elseif &columns > 136
	Goyo 110
else
	Goyo 80%
end

function! s:goyo_leave()
	" Quit out of the buffer that goyo then opens
	silent !echo -ne "\033]1337;SetColors=curbg=000\a"
	silent !echo -ne "\033]1337;SetColors=curfg=fff\a"
	q
	" shouldn't quit out of other open buffers
endfunction

autocmd! User GoyoLeave * silent !echo -ne "\033]1337;SetColors=curbg=000\a"
autocmd! User GoyoLeave * silent !echo -ne "\033]1337;SetColors=curfg=fff\a"
autocmd! User GoyoLeave call <SID>goyo_leave()

function NtToggle()
	NERDTreeToggle
	" if nerdtree is closed, make sure to resize the text buffer
	if exists("g:NERDTree") && !g:NERDTree.IsOpen()
		execute "normal \<plug>(goyo-resize)"
	end
endfunction

" make my own remaps for nerdtree to handle a goyo buffer
map <silent> <C-n> :call NtToggle()<cr>
" also map the = key to resize in normal mode
nnoremap <silent> = :execute "normal \<plug>(goyo-resize)"<cr>

" autosave my notes only if they are markdown
let g:auto_save = 1
let g:auto_save_events = ["InsertLeave", "TextChanged"]

set autoread
au CursorHold * checktime


" my configuration for markdown file editing
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
	q
	" shouldn't quit out of other open buffers
endfunction

autocmd! User GoyoLeave call <SID>goyo_leave()

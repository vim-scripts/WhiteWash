" WhiteWash.vim
" Remove trailing whitespace and sequential whitespace between words.

" Maintainer: Michael O'Neill <irish.dot@gmail.com>
" Version:    2014.09.08
" GetLatestVimScripts: 3920 1 :AutoInstall: WhiteWash.vim

function! s:WhiteWash()
	" Save cursor position
	let l:save_cursor = getpos(".")

	" Remove trailing whitespace, quietly.
	call s:WhiteWashTrailing()

	" Remove sequential whitespace with one of two options.
	if exists("g:WhiteWash_Aggressive") && (g:WhiteWash_Aggressive)
		call s:WhiteWashAggressive()
	else
		call s:WhiteWashLazy()
	endif

	" Restore cursor position
	call setpos('.', l:save_cursor)
endfunction

function! s:WhiteWashTrailing()
	" Remove trailing whitespace, quietly.
	%s/\s\+$//e
endfunction

function! s:WhiteWashLazy()
	" Remove sequential whitespace between words, quietly.
	%s/\>\s\{2,\}/ /eg
endfunction

function! s:WhiteWashAggressive()
	" Remove all sequential whitespace following non-whitespace, quietly.
	%s/\(\S\)\s\{2,\}/\1 /eg
endfunction

" :Commands
command! -range=% WhiteWash :silent call <SID>WhiteWash()
command! -range=% WhiteWashAggressive :silent call <SID>WhiteWashAggressive()
command! -range=% WhiteWashLazy :silent call <SID>WhiteWashLazy()
command! -range=% WhiteWashTrailing :silent call <SID>WhiteWashTrailing()

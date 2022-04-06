" toggling

" toggling boolean options

:let mapleader="\\"
:nnoremap <Leader>N :setlocal number!<Cr>

" toggling for non-boolean options is a bit more complicated

" toggling non-boolean options

:nnoremap <Leader>f :call FoldColumnToggle()<Cr>

:function FoldColumnToggle()
:  if &foldcolumn
:    setlocal foldcolumn=0
:  else
:    setlocal foldcolumn=5
:  endif
:endfunction

" toggling other things

:nnoremap <Leader>q :call QuickfixToggle()<Cr>

:let quickfix_is_open = 0

:function QuickfixToggle()
:  if g:quickfix_is_open
:    cclose
:    let g:quickfix_is_open = 0
:    execute g:quickfix_return_to_window ."wincmd w"
:  else
:    let g:quickfix_return_to_window = winnr()
:    copen
:    let g:quickfix_is_open = 1
:  endif
:endfunction


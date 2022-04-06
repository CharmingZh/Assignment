" case study - grep operator, part three

:nnoremap <Leader>g :set operatorfunc=Grep_operator<Cr>g@
" <SID> is the automatically generated id for the current script
:vnoremap <Leader>g :<C-u>call <SID>Grep_operator(visualmode())<Cr>

" save and restore the unnamed (@) register contents, and also avoid using
" visual mode to avoid destroying the last selected visual mode contents

" s:foo restricts foo to the current script's namespace
:function! s:Grep_operator(type) 
:  let saved_unnamed_register = @@
:  if a:type ==# 'v'
:    normal! `<v`>y
:  elseif a:type ==# 'char'
:    normal! `[y`] " note the difference
:  else
:    return
:  endif
:
:  silent execute "grep! -R " . shellescape(@@) . " ."
:  copen
:
:  let @@ = saved_unnamed_register
:endfunction
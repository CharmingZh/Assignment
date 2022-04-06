" case study - grep operator, part two

" to map a new operator, the set opfunc=<foo><Cr>g@ idiom is mandatory
 
:nnoremap <Leader>g :set operatorfunc=Grep_operator<Cr>g@

" <C-u> in this context simply removes the `<,'> you get when you visually
" select a block of text. 
:vnoremap <Leader>g :<C-u>call Grep_operator(visualmode())<Cr>

:function! Grep_operator(type)
:  if a:type ==# 'v'
:    execute "normal! `<v`>y"
:  elseif a:type ==# 'char'
:    execute "normal! `[v`]y"
:  else
:   return
:  endif
:  silent execute "grep! -R " . shellescape(expand(@@)) . " ."
:  copen
:endfunction

" test text - foo;bar that's nice!

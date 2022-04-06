" adding a grep operator

" <cword> is the word under the cursor
" :nnoremap <Leader>g :grep -R <cWORD> .<Cr>

" :nnoremap <Leader>g :execute "grep -R " . shellescape("<cWORD>") . " ."<Cr>

" Common idiom : expand() followed by shellescape()

" :nnoremap <Leader>g :execute "grep -R " . shellescape(expand("<cWORD>")) . " ." <Cr>

" use grep! to avoid going to the first result by default

":nnoremap <Leader>g :execute "grep! -R " . shellescape(expand("<cWORD>")) . " ." <Cr>

" open quickfix-window using 'copen'

" :nnoremap <Leader>g :execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<Cr>:copen<Cr>

" use 'silent' to remove noise

:nnoremap <Leader>g :silent :execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<Cr>:copen<Cr>
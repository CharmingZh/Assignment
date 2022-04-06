" The ":execute "normal! ..." idiom
"
" using normal! with execute (and escaping special characrters like <Cr>)
" makes running normal mode commands in VimScript files a breeze

" find the first occurrence of 'foo' and delete that whole line
:execute "normal! /foo\<Cr>dd"

" create a mark, append a semicolon at the end of that line, and go back to
" the marker
:execute "normal! mqA;\<Esc>`q`"
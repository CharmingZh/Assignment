:if 10 > 1
:  echom "10 > 1"
:endif

:if 10 > 2001
:  echom "10 > 2001"
:endif

:if 10 == 11
:  echom "10 == 11"
:else
:  echom "10 /= 11"
:endif

:if "foo" == "bar"
:  echom "foo == bar"
:elseif "foo" == "foo"
:  echom "foo == foo"
:endif

:set noignorecase
:if "foo" == "FOO"
:  echom "Vim is case insensitive"
:else
:  echom "Vim is case sensitive"
:endif

:set ignorecase
:if "foo" == "FOO"
:  echom "Vim is case insensitive"
:else
:  echom "Vim is case sensitive"
:endif

" avoid using bare ==. Instead, use the following equality operators for
" strings (especially)
"
" foo ==? bar (always case insentitive)

:set noignorecase
:if "foo" ==? "FOO"
:  echom "All right"
:else
:  echom "Not okay"
:endif

" or, foo ==# bar (always case sensitive)
:set ignorecase
:if "foo" ==# "FOO"
:  echom "Not okay"
:else
:  echom "All right"
:endif
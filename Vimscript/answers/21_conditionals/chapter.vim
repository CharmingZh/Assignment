" You can use the | character as a command separator in VimScipt
"

" if 

:if 1
:  echom "ONE"
:endif

:if 0
:  echom "ZERO"
:endif

:if "something"
:  echom "Something"
:endif

:if "100thisworks"
:  echo "Yes, it does"
:endif

:if "12345"
:  echom "12345"
:endif

:if 0
:  echom "Nope"
:elseif "nope!"
:  echom "Still no"
:else
:  echom "Finally!"
:endif
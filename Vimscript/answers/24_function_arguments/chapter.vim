" function arguments

:function Display(name)
:  echom "Nice to meet you, " a:name
:endfunction

:call Display("Timmy Jose")

" varargs

:function Varg(...)
: echom "Number of arguments = " a:0
: if a:0 > 0
:  for idx in range(a:0)
:    echom "Argument " idx ": " a:{idx}
:  endfor
: endif
:endfunction

:call Varg("hello", "world")
:call Varg()

" a:000 refers to all the remaining arguments, if any
:function More_varargs(...)
:  echom "Number of arguments = " a:0
:  if a:0 > 0
:    for arg in a:000
:     echom arg
:    endfor
:  endif
:endfunction

:call More_varargs("foo", "bar", "baz")

:function! Generic_sum(...)
:  let sum = 0
:  if a:0 == 0
:    echom "Sum = " 0
:    return
:  endif
:  for num in a:000
:    let sum += num
:  endfor
:  echom "Sum = " sum
:endfunction

:call Generic_sum()
:call Generic_sum(1)
:call Generic_sum(1, 2, 3)

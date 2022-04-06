{{{
:function Add(num1, num2)
:  return a:num1 + a:num2
:endfunction
}}}

{{{
:function Sub(num1, num2)
:  return a:num1 - a:num2
:endfunction
}}}

{{{
:function Mul(num1, num2)
:  return a:num1 * a:num2
:endfunction
}}}

:function Div(num1, num2)
:  if a:num2 == 0
:    return a:num1
:  endif
:  return a:num1 / a:num2
:endfunction

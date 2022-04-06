:function! Add_nums(num1, num2)
:  return a:num1 + a:num2
:endfunction

:function! Sub_nums(num1, num2)
:  return a:num1 - a:num2
:endfunction

:function! Mul_nums(num1, num2)
:  return a:num1 * a:num2
:endfunction

:function! Div_nums(num1, num2)
:  if a:num2 == 0
:    return num1
:  endif
:  return a:num1 / a:num2
:endfunction
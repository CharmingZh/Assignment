" functions

:function Meow()
:  echom "Meow"
:endfunction

:function Get_meow()
:  return "Meow"
:endfunction

:function Text_width_too_wide()
:  if &l:textwidth ># 80
:    return 1
:  endif
:endfunction

" taking advantage of the fact that functions return 0 if there is no explicit
" return value

:set textwidth=80
:if Text_width_too_wide()
:  echom "WARNING: Wide text!"
:endif

:setlocal textwidth=100
:if Text_width_too_wide()
:  echom "WARNING: Wide text!"
:endif
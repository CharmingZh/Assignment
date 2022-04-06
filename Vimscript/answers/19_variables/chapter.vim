:let foo = "bar"
:echo foo

:let foo = 42
:echo foo

" options

:echo &textwidth
:set textwidth=80
:echo &textwidth

:let &textwidth=100
:echo &textwidth

" setting the values of registers explicitly

:let @a = 100
:let @b = 200
:let @c = @a + @b
:echo "The value in the c register is " @c

" The " and / registers store the last value of yanking and searching respectively

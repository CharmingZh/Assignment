" string functions

:let str = "Hello, world!"
:echo printf("Length of %s = %d\n", g:str, strlen(g:str))
:echo "Length of str is (again) " len(g:str)

:echo split("one two three")
:echo split("one, two, three", ",")
:echo join(["foo", "bar", "baz"], ":")
:echo join(split("eins zwei drei"))
:echo tolower("hello")
:echo toupper("hello")

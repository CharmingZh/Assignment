" paths

" current filename
:echom expand("%") 

" absolute path of current file
:echom expand("%:p")

" new path with filename prefixed with the absolute directory path of the
" current file
:echom fnamemodify("foo.txt", ":p")

" listing files

:echo globpath(".", "*")
:echo split(globpath(".", "*"), '\n')
:echo split(globpath(".", "*.txt"), '\n')
:echo split(globpath(",", "*.abc"), '\n')

:echo split(globpath(".", "**"), '\n')
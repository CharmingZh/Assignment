" normal mode
"
" Suppose we remap G like so:
"
" :nnoremap G dd
"
" Now if we try to invoke normal commands, G is bound to dd's behaviour. To
" override this and make sure that we are invoking the original behaviour
" of GG, we have to use "normal!", especially in scripts being passed to 
" :execute (say)
"
" Always use "normal!" in Vim scripts.
"
" There is a problem with normal! though - it doesn't recognise special
" characters like <Cr>
"
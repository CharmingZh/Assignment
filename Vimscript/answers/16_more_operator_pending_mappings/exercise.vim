" run: `vim -u exercise.vim`

" chapter 1
:echo ">^.^<"

" chapter 2
:set nonumber
:set norelativenumber

" chapter 3
:map - ddp
:map _ ddkP

" to unmap a mapping, we can use :unmap

" chapter 4

:imap <C-u> <Esc>viwUi
:nmap <C-u> viwU

" chapter 5

" Always use the *noremap versions of the mapping commands:
" nnoremap, inoremap, and vnoremap

:unmap -
:unmap _
:noremap - ddp
:noremap _ ddkP

:iunmap <C-u>
:nunmap <C-u>
:inoremap <C-u> <Esc>viwUi
:nnoremap <C-u> viwU

" chapter 6
" <Leader> maps directly to mapleader
" <LocalLeader> maps directly to maplocalleader, and is intended for use with
" specific kinds of files

:let mapleader = "\\"
:nnoremap <Leader>d dd
:nnoremap <Leader>c ddO

:let maplocalleader = ","

" chapter 7

:nnoremap <Leader>ev :vsplit exercise.vim<Cr>
:nnoremap <Leader>sv :source exercise.vim<Cr>

:nnoremap <Leader>t :FZF<Cr>
:nnoremap <Leader>g :Ag<Cr>

" chapter 8

:iabbrev @@ zoltan.jose@gmail.com
:iabbrev ccopy Copyright Timmy Jose 2020, All Rights reserved.

" this can lead to weird results inside of strings containing this character
" combination - abbreviations don't have this problem
:inoremap ssig -- <Cr>Timmy Jose<Cr>zoltan.jose@gmail.com
:iunmap ssig
:iabbrev ssig -- <Cr>Timmy Jose<Cr>zoltan.jose@gmail.com

:iabbrev streanh strength
:iabbrev teh the
:iabbrev lenght length

" chapter 9

:nnoremap <Leader>" viw<Esc>a"<Esc>bi"<Esc>ww<Cr>
:nnoremap <Leader>' viw<Esc>a'<Esc>bi'<Esc>ww<Cr>
:vnoremap <Leader>v" <Esc>`>i"<Esc>`<i"<Esc>`><Cr>
:nnoremap H ^
:nnoremap L $

" chapter 10

" :inoremap jk <Esc>
" :inoremap <Esc> <nop>
" :inoremap <Left> <nop>
" :inoremap <Right> <nop>
" :inoremap <Up> <nop>
" :inoremap <Down> <nop>
" :nnoremap <Left> <nop>
" :nnoremap <Right> <nop>
" :nnoremap <Up> <nop>
" :nnoremap <Down> <nop>

" chapter 11

" In a buffer, :nnoremap <buffer><LocalLeader>x dd will set the mapping only
" for the currently active buffer.
" Always use <LocalLeader> for buffer-local mappings
" setlocal takes precedence over set, likewise <buffer> mappings take
" precedence over global mappings.

" chapter 12
" 
" Some important events are:
" BufRead, BufWrite, BufWritePre, BufNewFile

:autocmd BufNewFile,BufRead *.html setlocal nowrap

" FileType events are generated whenever a buffer's filetype is set by Vim

" IMPORTANT:  need to check up on this behaviour - right now, for these
" commands to work, one needs to explicitly set the file type inside the
" buffer like so: `:set filetype=javascript`

:augroup comment-file
:  autocmd!
:  autocmd FileType javascript nnoremap <buffer><LocalLeader>c I//<Esc>
:  autocmd FileType python nnoremap <buffer><LocalLeader>c I#<Esc>
:  autocmd FileType zig nnoremap <buffer><LocalLeader>c I//<Esc>
:  autocmd FileType haskell nnoremap <buffer><LocalLeader>c I--<Esc>
:augroup END

:autocmd BufNewFile,BufRead *.zig setlocal number

" chapter 13
"
" buffer local abbreviations are also possible:
"
" :iabbrev <buffer> --- &mdash;

:augroup iff-file
:  autocmd!
:  autocmd FileType python :iabbrev <buffer> iff if:<left>
:  autocmd FileType javascript :iabbrev <buffer> iff if ()<left>
:  autocmd FileType zig :iabbrev <buffer> iff if ()<left>
:augroup END

" chapter 14
"
" one problem with rawa autocommands is that Vim will not overwrite them. As
" such, the same autocmd might be duplicated many times over leading to
" performance problems at the very least and subtle bugs at worst.
"
" For instance, if one were to source a file multiple times over that had the
" following autocmd:
"
" :autocmd BufWrite * :sleep 200m
"
" The slowness will become apparent even after a few source operations
"
" The solution is to group autocmdS into named groups using augroup

:augroup testgroup
:  autocmd!
:  autocmd BufWrite * :echom "Foo"
:  autocmd BufWrite * :echom "Bar"
:augroup END

" Vim combines all autocmdS inside of all augroupS with the same name
:augroup testgroup
:  autocmd BufWrite * :echom "Baz"
:augroup END

" here, autocmd! clears the augroup, and so only this is run as part of the
" 'testgroup' augroup

:augroup testgroup
:  autocmd!
:  autocmd BufWrite * :echom "Cats!"
:augroup END

" in order to avoid duplicate behaviour upon sourcing the same file multiple
" times (as alluded to above), the idea is to clear using autocmd! and then
" define exactly the behaviour that we desire
:augroup filetype_html
:  autocmd!
:  autocmd FileType html nnoremap <buffer><LocalLeader>f Vatzf
:augroup END

:augroup sleep_message
:  autocmd!
:  autocmd BufWrite * :sleep 200m
:augroup END

" chapter 15
"
" Like the other mappings, nnoremap, inoremap, and vnoremap, onoremap is also
" a mapping for a very specific mode - operator-pending mode. So it works with 
" operators like d, c, y et al.
" 
" Note that either visual mode must be used, or Vim will choose the region
" between the start and end positions of the cursors after completing the
" movement(s).

:onoremap il( :<C-u>normal! F)vi(<Cr>
:onoremap il{ :<C-u>normal! F}vi{<Cr>

" chapter 16
"
" execute must be used when the script contains special characters since normal!
" cannot handle special characters like <Cr>
"

:augroup markdown_edit
:  autocmd!
:  autocmd BufRead *.md :onoremap ih :<C-u>execute "normal! ?^[-=]\\+$\r:nohlsearch\rkvg_" <Cr>
:  autocmd BufRead *.md :onoremap ah :<C-u>execute "normal! ?^[-=]\\+$\r:nohlsearch\rg_vk0" <Cr>
:augroup END

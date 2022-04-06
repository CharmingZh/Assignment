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

:autocmd FileType javascript nnoremap <buffer><LocalLeader>c I//<Esc>
:autocmd FileType python nnoremap <buffer><LocalLeader>c I#<Esc>
:autocmd FileType zig nnoremap <buffer><LocalLeader>c I//<Esc>
:autocmd FileType haskell nnoremap <buffer><LocalLeader>c I--<Esc>

:autocmd BufNewFile,BufRead *.zig setlocal number

" chapter 13
"
" buffer local abbreviations are also possible:
"
" :iabbrev <buffer> --- &mdash;

:autocmd FileType python :iabbrev <buffer> iff if:<left>
:autocmd FileType javascript :iabbrev <buffer> iff if ()<left>
:autocmd FileType zig :iabbrev <buffer> iff if ()<left>

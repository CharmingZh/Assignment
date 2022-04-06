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

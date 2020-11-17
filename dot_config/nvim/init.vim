"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/chocrates/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/chocrates/.cache/dein')
  call dein#begin('/Users/chocrates/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/chocrates/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:
  call dein#add('rust-lang/rust.vim')
  call dein#add('preservim/tagbar')
  call dein#add('vim-airline/vim-airline')
  "call dein#add('Shougo/neosnippet.vim')
  "call dein#add('Shougo/neosnippet-snippets')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------

colorscheme slate
highlight Normal guibg=black guifg=lightblue 
set background=dark

scriptencoding utf-8
set encoding=utf-8
" filetype on
" filetype plugin on


" The default for 'backspace' is very confusing to new users, so change it to a
" more sensible value.  Add "set backspace&" to your ~/.vimrc to reset it. 
set backspace=indent,eol,start

" Disable localized menus for now since only some items are translated (e.g.
" the entire MacVim menu is set up in a nib file which currently only is
" translated to English).
set langmenu=none
syntax on
se nu
se ruler
se tabstop=4
se shiftwidth=4
se expandtab
se foldmethod=syntax
let g:jsx_ext_required = 0

set listchars=eol:~,tab:>.,trail:~,extends:>,precedes:<,space:_
set list
set hlsearch
set cursorline " highlights the current line
hi CursorLine term=bold cterm=bold

set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

set laststatus=2

" Status Line
set statusline=%-10.3n\                        " buffer number
set statusline+=%t                               "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}]                         "file format
set statusline+=%h                              "help file flag
set statusline+=%m                              "modified flag
set statusline+=%r                              "read only flag
set statusline+=%y                              "filetype
set statusline+=%=                              "left/right separator
set statusline+=%c,                             "cursor column
set statusline+=%l/%L                           "cursor line/total lines
set statusline+=\ %P                            "percent through file

set path+=/mnt/c/workspace/**,~
set wildignore+=**/node_modules/**

nnoremap <C-j> :%!python3 -m json.tool<cr>
nnoremap <C-x> :%!xmllint --format -<cr>
nnoremap <C-o> :%!~/workspace/pyorder/order.py<cr>
nnoremap <C-y> :%!clip.exe && powershell.exe -command "get-clipboard" \| sed 's/\r/\n/g'<cr><cr>
nnoremap <C-p> :%!powershell.exe -command "get-clipboard" \| sed 's/\r/\n/g'<cr><cr>
nmap <F8> :TagbarToggle<CR>
nnoremap <C-f> :set foldenable<cr>
nnoremap <C-r> :set nofoldenable<cr>

autocmd VimResized * wincmd =

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

if has("autocmd")
    autocmd FileType go set ts=2 sw=2 sts=2 noet autowrite
endif

let g:rustfmt_autosave = 1
" Airline Config
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

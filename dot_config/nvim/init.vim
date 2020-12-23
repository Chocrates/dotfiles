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
  " call dein#add('preservim/tagbar')
  call dein#add('vim-airline/vim-airline')
  call dein#add('tpope/vim-eunuch')
  call dein#add('mcchrish/nnn.vim')
  call dein#add('racer-rust/vim-racer')
  call dein#add('autozimu/LanguageClient-neovim', {
    \ 'rev': 'next',
    \ 'build': 'bash install.sh',
    \ })
  call dein#add('liuchengxu/vista.vim')
  call dein#add('psf/black')
  call dein#add('prettier/vim-prettier')

  call dein#add('nvim-lua/popup.nvim')
  call dein#add('nvim-lua/plenary.nvim')
  call dein#add('nvim-telescope/telescope.nvim')
  call dein#add('pwntester/octo.nvim')


  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

colorscheme slate
highlight Normal guibg=black guifg=lightblue 
set background=dark

scriptencoding utf-8
set encoding=utf-8
" filetype on
" filetype plugin on

" Enable matchit macro for html/xml navigation
packadd! matchit

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
"nnoremap <C-o> :%!~/workspace/pyorder/order.py<cr>
nnoremap <C-y> :%!clip.exe && powershell.exe -command "get-clipboard" \| sed 's/\r/\n/g'<cr><cr>
nnoremap <C-p> :%!powershell.exe -command "get-clipboard" \| sed 's/\r/\n/g'<cr><cr>
" TagBar Config
" nmap <F8> :TagbarToggle<CR>
" Vista Config
nmap <F8> :Vista!!<CR>
let g:vista_default_executive = 'ctags'
let g:vista_sidebar_width = 20

nnoremap <C-f> :set foldenable<cr>
nnoremap <C-r> :set nofoldenable<cr>

autocmd VimResized * wincmd =

" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'

if has("autocmd")
    autocmd FileType go set ts=2 sw=2 sts=2 noet autowrite
endif
" rust.vim config
let g:rustfmt_autosave = 1

" Airline Config
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" Racer Config
set hidden
augroup Racer
    autocmd!
    autocmd FileType rust nmap <buffer> gd         <Plug>(rust-def)
    autocmd FileType rust nmap <buffer> gs         <Plug>(rust-def-split)
    autocmd FileType rust nmap <buffer> gx         <Plug>(rust-def-vertical)
    autocmd FileType rust nmap <buffer> gt         <Plug>(rust-def-tab)
    autocmd FileType rust nmap <buffer> <leader>gd <Plug>(rust-doc)
    autocmd FileType rust nmap <buffer> <leader>gD <Plug>(rust-doc-tab)
augroup END

" RLS config
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'nightly', 'rls'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'typescript': ['~/.nvm/versions/node/v14.4.0/bin/typescript-language-server', '--stdio'],
    \ 'javascript': ['~/.nvm/versions/node/v14.4.0/bin/typescript-language-server', '--stdio'],
    \ }

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Run Black on save.
autocmd BufWritePre *.py execute ':Black'

" Doesn't work on jinja templates
"autocmd BufWritePre *.html,*.js,*.ts execute ':PrettierAsync'
"
let g:python3_host_prog = '/Users/chocrates/.pyenv/versions/py3nvim/bin/python'

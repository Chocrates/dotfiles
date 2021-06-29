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
  call dein#add('prettier/vim-prettier', {'build': 'npm install' })

  call dein#add('nvim-lua/popup.nvim')
  call dein#add('nvim-lua/plenary.nvim')
  call dein#add('nvim-treesitter/nvim-treesitter')
  call dein#add('kyazdani42/nvim-web-devicons')
  call dein#add('nvim-telescope/telescope.nvim')
  call dein#add('pwntester/octo.nvim')

  call dein#add('tpope/vim-commentary')
  call dein#add('neoclide/coc.nvim', { 'rev': 'release' })
  call dein#add('APZelos/blamer.nvim')
    
  call dein#add('tpope/vim-fugitive')
  call dein#add('junegunn/gv.vim')

  call dein#add('fatih/vim-go')

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
let g:vista_sidebar_open_cmd = 'rightbelow30vsplit'
let g:vista#render#enable_icon = 1
"let g:vista_log_file = './vista.log'

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

" COC Config
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-tsserver', 'coc-html', 'coc-css', 'coc-jedi', 'coc-rls', 'coc-go', 'coc-solargraph', 'coc-java']

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" End COC Config

" Run Black on save.
autocmd BufWritePre *.py execute ':Black'

" Doesn't work on jinja templates
autocmd BufWritePre *.js,*.ts execute ':PrettierAsync'
"
" Run python json tool on save
autocmd FileType json autocmd BufWritePre <buffer> %!python -m json.tool

" Format Go files
autocmd FileType *.go Fmt

let g:python3_host_prog = '/Users/chocrates/.pyenv/versions/py3nvim/bin/python'

" blamer config
let g:blamer_template = '<committer>, <committer-time> <commit-short> • <summary>'
let g:blamer_date_format = '%y-%m-%d'

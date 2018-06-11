" Filetype support
filetype plugin indent on
syntax on

runtime macros/matchit.vim
colorscheme gruvbox
set background=dark

set lazyredraw
set tabstop=4      "Tab indentation levels every four columns
set shiftwidth=4   "Indent/outdent by four columns
set expandtab      "Convert all tabs that are typed into spaces
set shiftround     "Always indent/outdent to nearest tabstop
set smarttab       "Use shiftwidths at left margin, tabstops everywhere else
set laststatus=2
set nonumber
set backspace=indent,eol,start
set hlsearch
set incsearch ignorecase
set noswapfile
set smartcase
set showcmd
set ruler
set hidden
set path=.,**,/usr/include
set wildmenu wildmode=full
set undofile undodir=~/.vim/tmp/undo/
set tags+=~/.vim/systags
set splitbelow splitright
set list listchars=eol:$ listchars+=tab:│\  fillchars+=vert:│,fold:=
set foldenable foldmethod=marker
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" Ergonomics
inoremap <C-H> (
inoremap <C-J> )
inoremap <C-K> [
inoremap <C-L> ]
inoremap <C-D> *
noremap ; :
noremap : ;
nnoremap ' `
nnoremap c* *``cgn

" Juggling with buffers
nnoremap ,b         :buffer *
nnoremap ,B         :sbuffer *
nnoremap <PageUp>   :bprevious<CR>
nnoremap <PageDown> :bnext<CR>
nnoremap <BS>       :buffer#<CR>

" File navigation
nnoremap ,f :find *
nnoremap ,s :sfind *
nnoremap ,v :vert sfind *
nnoremap ,F :find <C-R>=fnameescape(expand('%:p:h')).'/**/*'<CR>
nnoremap ,S :sfind <C-R>=fnameescape(expand('%:p:h')).'/**/*'<CR>
nnoremap ,V :vert sfind <C-R>=fnameescape(expand('%:p:h')).'/**/*'<CR>
nnoremap gb :ls<CR>:buffer<Space>

" commands for adjusting indentation rules manually
command! -nargs=1 Spaces execute "setlocal tabstop=" . <args> . " shiftwidth=" . <args> . " softtabstop=" . <args> . " expandtab" | setlocal ts? sw? sts? et?
command! -nargs=1 Tabs   execute "setlocal tabstop=" . <args> . " shiftwidth=" . <args> . " softtabstop=" . <args> . " noexpandtab" | setlocal ts? sw? sts? et?

" better completion menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap        ,,      <C-n><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>\<lt>C-p>" : ""<CR>
inoremap        ,:      <C-x><C-f><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>\<lt>C-p>" : ""<CR>

" Share text
command! -range=% IX  <line1>,<line2>w !curl -F 'f:1=<-' ix.io | tr -d '\n' | xclip -i -selection clipboard
" AutoCMD's {{{
if has('autocmd')
	augroup Prolog_Files
		autocmd!
		autocmd BufRead,BufNewFile,BufWritePost *.pl set filetype=prolog
	augroup END

	" Return to last edit position when opening files (You want this!)
	augroup Remember_cursor_position
		autocmd!
		autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
	augroup END

	" Automatic Open Quick Fix window
	augroup AutoQuickfix
		autocmd!
		" automatic location/quickfix window
		autocmd QuickFixCmdPost [^l]* cwindow
		autocmd QuickFixCmdPost    l* lwindow
		autocmd VimEnter            * cwindow
		" Git-specific settings
		autocmd FileType gitcommit nnoremap <buffer> { ?^@@<CR>|nnoremap <buffer> } /^@@<CR>|setlocal iskeyword+=-
	augroup END

	" Show spaces as red if there's nothing after it (from Greg Hurrel)
	augroup TrailWhiteSpaces
		highlight ColorColumn ctermbg=1
		autocmd BufWinEnter <buffer> match Error /\s\+$/
		autocmd InsertEnter <buffer> match Error /\s\+\%#\@<!$/
		autocmd InsertLeave <buffer> match Error /\s\+$/
		autocmd BufWinLeave <buffer> call clearmatches()
	augroup END
endif
" }}}
" Grep {{{
command! -nargs=+ -complete=file_in_path -bar Grep  silent! grep! <args> | redraw!
command! -nargs=+ -complete=file_in_path -bar LGrep silent! lgrep! <args> | redraw!

nnoremap <silent> ,G :Grep <C-r><C-w><CR>
xnoremap <silent> ,G :<C-u>let cmd = "Grep " . visual#GetSelection() <bar>
                        \ call histadd("cmd", cmd) <bar>
                        \ execute cmd<CR>

if executable("ag")
    set grepprg=ag\ --vimgrep
    set grepformat^=%f:%l:%c:%m
endif
" }}}
" Statusline {{{
let g:currentmode={
    \ 'n'  : 'NORMAL ',
    \ 'no' : 'N·OPERATOR PENDING ',
    \ 'v'  : 'VISUAL ',
    \ 'V'  : 'V·LINE ',
    \ '' : 'V·BLOCK ',
    \ 's'  : 'SELECT ',
    \ 'S'  : 'S·LINE ',
    \ '' : 'S·BLOCK ',
    \ 'i'  : 'INSERT ',
    \ 'R'  : 'REPLACE ',
    \ 'Rv' : 'V·REPLACE ',
    \ 'c'  : 'COMMAND ',
    \ 'cv' : 'VIM EX ',
    \ 'ce' : 'EX ',
    \ 'r'  : 'PROMPT ',
    \ 'rm' : 'MORE ',
    \ 'r?' : 'CONFIRM ',
    \ '!'  : 'SHELL ',
    \ 't'  : 'TERMINAL '}

set statusline=
set statusline+=%1*
set statusline+=\ %{g:currentmode[mode()]}
set statusline+=%*
set statusline+=%2*
set statusline+=\ %t\  
set statusline+=%(%m%)
set statusline+=%=
set statusline+=%*
set statusline+=%3*
set statusline+=\ %l,
set statusline+=%c\  
set statusline+=%*
set statusline+=\ %Y\  
set statusline+=%4*
set statusline+=\ %P\  
set statusline+=%*
" }}}
" Highlights config {{{
highlight User1 ctermbg=35 ctermfg=0
highlight User2 ctermbg=0 ctermfg=195
highlight User4 ctermbg=30 ctermfg=195
highlight MatchParen ctermbg=4 ctermfg=195
highlight clear Search
highlight       Search    ctermfg=White  ctermbg=Red    cterm=bold
highlight    IncSearch    ctermfg=White  ctermbg=Red    cterm=bold
" }}}
" Netrw {{{
let g:netrw_sort_by        = 'time'
let g:netrw_sort_direction = 'reverse'
let g:netrw_banner         = 0
let g:netrw_liststyle      = 3
let g:netrw_browse_split   = 3
let g:netrw_fastbrowse     = 1
let g:netrw_sort_by        = 'name'
let g:netrw_sort_direction = 'normal'
let g:netrw_winsize = -28
" }}}

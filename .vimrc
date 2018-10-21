" My old vim configuration: http://ix.io/1f88   (It is here only by reference, it's a super bloat config!!)

call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'morhetz/gruvbox'
Plug 'maralla/completor.vim'
call plug#end()
" General settings {{{

" Filetype support
runtime macros/matchit.vim
colorscheme gruvbox                     " Use the gruvbox colorscheme: https://github.com/morhetz/gruvbox
set background=dark                     " Use a dark background
set scrolloff=5                         " Keep at least 3 lines above/below when scrolling
set lazyredraw                          " Don't update the display while executing macros
set tabstop=4                           " Tab indentation levels every four columns
set shiftwidth=4                        " Indent/outdent by four columns (when pressing >>)
set expandtab                           " Convert all tabs that are typed into spaces (it has a better compatibility with other computers)
set shiftround                          " Always indent/outdent to nearest tabstop
set smarttab                            " Use shiftwidths at left margin, tabstops everywhere else
set laststatus=2                        " Always show the statusline
set nonumber                            " Don't display line numbers
set relativenumber
set cursorline
set backspace=indent,eol,start          " Fix backspace
set hlsearch                            " Highlight search
set incsearch ignorecase                " Increase search
set noswapfile                          " Don't use swap file
set smartcase                           " Override the 'ignorecase' option if the search pattern contains upper case characters.
set showcmd                             " Show commands at bottom
set hidden                              " Switch buffers without the need of saving them
set path=.,**                           " Set path to the current and children directories
set wildmenu wildmode=full              " Display all matching files when we tab complete
set undofile undodir=~/.vim/tmp/undo/   " Set undofiles (undo files even if you exited the file)
set splitbelow splitright               " Split belor and/or right when opening new buffers
set list listchars=eol:$,trail:∙ listchars+=tab:│\  fillchars+=vert:│,fold:\  
set foldenable foldmethod=marker
 " }}}
" Mappings {{{

" Ergonomics
inoremap <C-H> (
inoremap <C-J> )
inoremap <C-K> [
inoremap <C-L> ]
inoremap <C-D> *
" http://items.sjbach.com/319/configuring-vim-right
noremap ; :
noremap : ;
nnoremap ' `
inoremap " ""<Left>
inoremap ( ()<Left>
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>""""""")))
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")""""""")))

" Make 0 go to the first character rather than the beginning
" " of the line. When we're programming, we're almost always
" " interested in working with text rather than empty space. If
" " you want the traditional beginning of line, use ^
nnoremap 0 ^
nnoremap ^ 0

" Supercharge dot formula
nnoremap c* *``cgn

" Delete trailing spaces
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" Juggling with buffers
nnoremap ,b         :buffer *
nnoremap ,B         :sbuffer *
nnoremap <PageUp>   :bprevious<CR>
nnoremap <PageDown> :bnext<CR>
nnoremap <BS>       :buffer#<CR>

" Juggling with matches
nnoremap ,i :ilist /
nnoremap [I [I:ijump<Space><Space><Space><C-r><C-w><S-Left><Left><Left>
nnoremap ]I ]I:ijump<Space><Space><Space><C-r><C-w><S-Left><Left><Left>

" Move to other buffers
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" Visual select inside a whole function
xnoremap if /^\s*}<CR><Esc>V%

" File navigation
nnoremap ,f :find *
nnoremap ,e :e %:h/
nnoremap ,s :sfind *
nnoremap ,v :vert sfind *
nnoremap ,F :find <C-R>=fnameescape(expand('%:p:h')).'/**/*'<CR>
nnoremap ,S :sfind <C-R>=fnameescape(expand('%:p:h')).'/**/*'<CR>
nnoremap ,V :vert sfind <C-R>=fnameescape(expand('%:p:h')).'/**/*'<CR>
nnoremap gb :ls<CR>:buffer<Space>

" Smooth listing
cnoremap <expr> <CR> <SID>CCR()
function! s:CCR()
    command! -bar Z silent set more|delcommand Z
    if getcmdtype() == ":"
        let cmdline = getcmdline()
        if cmdline =~ '\v\C^(dli|il)' | return "\<CR>:" . cmdline[0] . "jump   " . split(cmdline, " ")[1] . "\<S-Left>\<Left>\<Left>"
        elseif cmdline =~ '\v\C^(cli|lli)' | return "\<CR>:silent " . repeat(cmdline[0], 2) . "\<Space>"
        elseif cmdline =~ '\C^changes' | set nomore | return "\<CR>:Z|norm! g;\<S-Left>"
        elseif cmdline =~ '\C^ju' | set nomore | return "\<CR>:Z|norm! \<C-o>\<S-Left>"
        elseif cmdline =~ '\v\C(#|nu|num|numb|numbe|number)$' | return "\<CR>:"
        elseif cmdline =~ '\C^ol' | set nomore | return "\<CR>:Z|e #<"
        elseif cmdline =~ '\v\C^(ls|files|buffers)' | return "\<CR>:b"
        elseif cmdline =~ '\C^marks' | return "\<CR>:norm! `"
        elseif cmdline =~ '\C^undol' | return "\<CR>:u "
        else | return "\<CR>" | endif
    else | return "\<CR>" | endif
endfunction

" Commands for adjusting indentation rules manually
command! -nargs=1 Spaces execute "setlocal tabstop=" . <args> . " shiftwidth=" . <args> . " softtabstop=" . <args> . " expandtab" | setlocal ts? sw? sts? et?
command! -nargs=1 Tabs   execute "setlocal tabstop=" . <args> . " shiftwidth=" . <args> . " softtabstop=" . <args> . " noexpandtab" | setlocal ts? sw? sts? et?

" Share text on ix.io (visual select something, type :IX, and it will upload to ix.io)
command! -range=% IX  <line1>,<line2>w !curl -F 'f:1=<-' ix.io | tr -d '\n' | xclip -i -selection clipboard

" Clear all the registers available: https://stackoverflow.com/a/41003241
command! ClearReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

" Fix the go to next line if wrap is enabled
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" }}}
" AutoCMD's {{{
if has('autocmd')
    augroup Set_FileTypes
        autocmd!
        "autocmd BufRead,BufNewFile,BufWritePost *.md set filetype=markdown
        autocmd FileType gitcommit setlocal spell
        autocmd FileType qf wincmd J | setlocal wrap
        autocmd FileType yaml set shiftwidth=2 tabstop=2
    augroup END

    highlight CursorLine ctermbg=239 cterm=none

    " Return to last edit position when opening files (You want this!)
    augroup Remember_cursor_position
        autocmd!
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
    augroup END

    " Show spaces as red if there's nothing after it (stole Greg Hurrel)
    augroup TrailWhiteSpaces
        highlight ColorColumn ctermbg=1
        autocmd BufWinEnter <buffer> match Error /\s\+$/
        autocmd InsertEnter <buffer> match Error /\s\+\%#\@<!$/
        autocmd InsertLeave <buffer> match Error /\s\+$/
        autocmd BufWinLeave <buffer> call clearmatches()
    augroup END
endif
" }}}
" Plugins {{{

let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'filetype'] ]
      \ },
      \ }

nnoremap <Tab> :NERDTreeToggle<CR>

let g:completor_auto_trigger = 0

" }}}

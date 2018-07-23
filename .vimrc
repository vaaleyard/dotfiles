" My old vim configuration: http://ix.io/1f88   (It is here only by reference, it's a super bloat config!!)

call plug#begin('~/.vim/plugged')
" Plugins for notetaking only:
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
Plug 'suan/vim-instant-markdown', { 'on' : 'InstantMarkdownPreview' }
Plug 'junegunn/goyo.vim', { 'on' : 'Goyo' }
call plug#end()

" General settings {{{

" Filetype support
filetype plugin indent on
syntax on

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
set backspace=indent,eol,start          " Fix backspace
set hlsearch                            " Highlight search
set incsearch ignorecase                " Increase search
set noswapfile                          " Don't use swap file
set smartcase                           " Override the 'ignorecase' option if the search pattern contains upper case characters.
set showcmd                             " Show commands at bottom
set hidden                              " Switch buffers without the need of saving them
set clipboard=unnamedplus               " Copy to clipboard when yanking text with yy/dd etc.
set path=.,**                           " Set path to the current and children directories
set wildmenu wildmode=full              " Display all matching files when we tab complete
set undofile undodir=~/.vim/tmp/undo/   " Set undofiles (undo files even if you exited the file)
set splitbelow splitright               " Split belor and/or right when opening new buffers
set list listchars=eol:$,trail:∙ listchars+=tab:│\  fillchars+=vert:│,fold:\  
set foldenable foldmethod=marker
set shell=bash\ -i
" Set up statusline
set statusline=\ %f\ %y\ %m%=%l,%c\ \ \ \ \ \ \ \ \ \ \ \ %P\ |
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

nnoremap <Esc> :nohl<CR>
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
nnoremap ,s :sfind *
nnoremap ,v :vert sfind *
nnoremap ,F :find <C-R>=fnameescape(expand('%:p:h')).'/**/*'<CR>
nnoremap ,S :sfind <C-R>=fnameescape(expand('%:p:h')).'/**/*'<CR>
nnoremap ,V :vert sfind <C-R>=fnameescape(expand('%:p:h')).'/**/*'<CR>
nnoremap gb :ls<CR>:buffer<Space>

" better completion menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

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
        autocmd FileType vimwiki map <leader>d <Plug>VimwikiToggleListItem
        autocmd BufRead,BufNewFile,BufWritePost *.pl set filetype=prolog
        autocmd FileType gitcommit setlocal spell
        autocmd FileType qf wincmd J | setlocal wrap
        autocmd FileType mail
                    \ if expand('%:p') =~ '^/tmp/mutt/\(neo\)\?mutt-' |
                    \     set ft=pandoc                               |
                    \ else                                            |
                    \     setlocal spell                              |
                    \ endif
    augroup END


    " Return to last edit position when opening files (You want this!)
    augroup Remember_cursor_position
        autocmd!
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
    augroup END

    augroup VimSettings
        autocmd!
        " automatic location/quickfix window
        autocmd QuickFixCmdPost [^l]* cwindow
        autocmd QuickFixCmdPost    l* lwindow
        autocmd VimEnter            * cwindow
        " various adjustments of the default colorscheme
        highlight ModeMsg         ctermbg=Red       ctermfg=White    cterm=bold
        highlight Search          ctermfg=White     ctermbg=Red      cterm=bold
        highlight IncSearch       ctermfg=White     ctermbg=Red      cterm=bold
        highlight StatusLine      ctermfg=35        ctermbg=8
        highlight StatusLineNC    ctermfg=8         ctermbg=35
        highlight Visual          ctermbg=247       ctermfg=black    cterm=bold
        " Tabline color settings
        highlight TabLine      ctermfg=White  ctermbg=Black     cterm=NONE
        highlight TabLineFill  ctermfg=White  ctermbg=Black     cterm=NONE
        highlight TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=NONE
        " Spell color settings
        highlight SpellBad     term=underline cterm=underline ctermfg=Red
        highlight SpellCap     term=underline cterm=underline
        highlight SpellRare    term=underline cterm=underline
        highlight SpellLocal   term=underline cterm=underline

        " Git-specific settings
        autocmd FileType gitcommit nnoremap <buffer> { ?^@@<CR>|nnoremap <buffer> } /^@@<CR>|setlocal iskeyword+=-
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

function! ToggleExplore()
    if &ft ==# "netrw"
         Rexplore
    else
         Explore
    endif
endfunction
map <F2> <Esc><Esc>:call ToggleExplore()<CR>
" }}}
" vimwiki ;(
let g:vimwiki_ext2syntax = {'.md': 'markdown'}

" Instant Markdown Preview ;(
let g:instant_markdown_autostart = 0    " disable autostart
let g:instant_markdown_slow = 1
nnoremap <leader>md :InstantMarkdownPreview<CR>

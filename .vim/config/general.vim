
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
set path=.,**                           " Set path to the current and children directories
set wildmenu wildmode=full              " Display all matching files when we tab complete
set undofile undodir=~/.vim/tmp/undo/   " Set undofiles (undo files even if you exited the file)
set splitbelow splitright               " Split belor and/or right when opening new buffers
set list listchars=eol:$,trail:∙ listchars+=tab:│\  fillchars+=vert:│,fold:\  
set foldenable foldmethod=marker
" Set up statusline
set statusline=\ %f\ %y\ %m%=%l,%c\ \ \ \ \ \ \ \ \ \ \ \ %P\ |


if has('autocmd')
    augroup Set_FileTypes
        autocmd!
        "autocmd BufRead,BufNewFile,BufWritePost *.md set filetype=markdown
        autocmd FileType vimwiki map <leader>d <Plug>VimwikiToggleListItem
        autocmd BufRead,BufNewFile,BufWritePost *.pl set filetype=prolog

        " Git-specific settings
        autocmd FileType gitcommit setlocal spell
        autocmd FileType gitcommit nnoremap <buffer> { ?^@@<CR>|nnoremap <buffer> } /^@@<CR>|setlocal iskeyword+=-

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
        highlight ModeMsg         ctermbg=1         ctermfg=White    cterm=bold
        highlight Search          ctermfg=White     ctermbg=Red      cterm=bold
        highlight IncSearch       ctermfg=White     ctermbg=Red      cterm=bold
        highlight StatusLine      ctermfg=1        ctermbg=0
        highlight StatusLineNC    ctermfg=8         ctermbg=1
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


" Grep
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


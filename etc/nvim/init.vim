" Plugins inicialization ==================={{{

call plug#begin('~/.local/share/nvim/plugged')

" Themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tyrannicaltoucan/vim-quantum'
"Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'

" Languages
"Plug 'elzr/vim-json', { 'for': 'json' }
"Plug 'othree/html5.vim', { 'for': 'html' }
"Plug 'gregsexton/MatchTag', { 'for': 'html' }
"Plug 'kshenoy/vim-signature'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', {'build': {'unix': 'make'}}

"Plug 'ervandew/supertab'
Plug 'Chiel92/vim-autoformat'
if executable('python')
    Plug 'davidhalter/jedi-vim'
    Plug 'w0rp/ale'
endif

if executable('terraform')
    Plug 'Shougo/deoplete.nvim'
    Plug 'hashivim/vim-terraform'
    Plug 'vim-syntastic/syntastic', { 'for': 'tf' }
    Plug 'juliosueiras/vim-terraform-completion'
endif
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

"Plug 'tpope/vim-fugitive'
if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
endif

" Others
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
"Plug 'sheerun/vim-polyglot'
Plug 'yuttie/comfortable-motion.vim'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

"Markdown
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

call plug#end()

" }}}
" Global stuff ============================={{{
set runtimepath+=~/.fzf
let g:quantum_italics=1
set mouse=a
set termguicolors
colorscheme quantum                     " Use the gruvbox colorscheme: https://github.com/morhetz/gruvbox
set background=dark                     " Use a dark background
set scrolloff=5                         " Keep at least 3 lines above/below when scrolling
set lazyredraw                          " Don't update the display while executing macros
set tabstop=4                           " Tab indentation levels every four columns
set shiftwidth=4                        " Indent/outdent by four columns (when pressing >>)
set expandtab                           " Convert all tabs that are typed into spaces (it has a better compatibility with other computers)
set shiftround                          " Always indent/outdent to nearest tabstop
set smarttab                            " Use shiftwidths at left margin, tabstops everywhere else
set laststatus=2                        " Always show the statusline
set number                              " Don't display line numbers
set numberwidth=4
set relativenumber
set clipboard=unnamedplus               " O registrador * vira unnamed, permite que os textos copiados pelo vim vão para o clipboard
set backspace=indent,eol,start          " Fix backspace
set hlsearch                            " Highlight search
set incsearch ignorecase                " Increase search
set noswapfile                          " Don't use swap file
set smartcase                           " Override the 'ignorecase' option if the search pattern contains upper case characters.
set showcmd                             " Show commands at bottom
set hidden                              " Switch buffers without the need of saving them
set path=.,**                           " Set path to the current and children directories
set splitbelow splitright               " Split belor and/or right when opening new buffers
set list listchars=eol:$,trail:∙ listchars+=tab:│\  fillchars+=vert:│,fold:\
set foldenable foldmethod=marker
set cursorline
set colorcolumn=80
set shortmess+=c                        " don't give |ins-completion-menu| messages.
set updatetime=300                      " Smaller updatetime for CursorHold & CursorHoldI
set cmdheight=2                         " Better display for messages
set signcolumn=yes                      " always show signcolumns
" }}}
" General mappings ========================={{{

" Opens an edit command with the path of the currently edited file filled in
nnoremap ,e :e <C-R>=expand("%:p:h") . "/" <CR>

" Find faster
nnoremap ,f :find <C-R>=fnameescape(expand('%:p:h')). '/'<CR>

"Change directory to the dir of the current buffer
noremap ,cd :cd %:p:h<CR>

" Window buffer navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Make ; works like a : in normal mode, then i don't have to press <S-;> to go to the command line
nnoremap ; :
nnoremap : ;

" Fix the go to next line if wrap is enabled
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Quickly search
nnoremap ,s :g//#<Left><Left>

" A better search (search for the letters under cursor)
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>
nnoremap * *``
nnoremap g* g*``

" Change the word under cursor, highlight the others in the file, and you can repeat the change pressing dot
nnoremap c*  *Ncgn
nnoremap c*c #``cgN
vnoremap c*  *Ncgn

" Remove all trailing whitespace by pressing F5
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" Keep selection after indenting
vnoremap < <gv
vnoremap > >gv

" Remove the Windows ^M - when the encodings gets messed up
nnoremap ,m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Allow saving of files as sudo
command! W silent w !sudo tee > /dev/null %

" Fix indentation, changed the map, so that if i have the mark 'm', this map won't destroy it
"nnoremap g= mmgg=G`m
nnoremap g= gg=G``

" A cool mapping that insert current time info
inoremap <silent> <C-G><C-T> <C-R>=repeat(complete(col('.'),map(["%Y-%m-%d %H:%M:%S","%a, %d %b %Y %H:%M:%S %z","%Y %b %d","%d-%b-%y","%a %b %d %T %Z %Y","%Y-%m-%d %a %I:%M %p"],'strftime(v:val)')+[localtime()]),0)<CR>

" Insert new line, but stay in normal mode
" Ref: https://www.reddit.com/r/vim/comments/7yzblt/what_was_your_best_vimrc_addition/dumcoya/?utm_content=permalink&utm_medium=front&utm_source=reddit&utm_name=vim
nnoremap <silent> [<space>  :<c-u>put!=repeat([''],v:count)<bar>']+1<cr>
nnoremap <silent> ]<space>  :<c-u>put =repeat([''],v:count)<bar>'[-1<cr>

" Make 0 go to the first character rather than the beginning
" of the line. When we're programming, we're almost always
" interested in working with text rather than empty space. If
" you want the traditional beginning of line, use ^
nnoremap 0 ^
nnoremap ^ 0

" These are very similar keys. Typing 'a will jump to the line in the current
" file marked with ma. However, `a will jump to the line and column marked
" with ma.  It’s more useful in any case I can imagine, but it’s located way
" off in the corner of the keyboard. The best way to handle this is just to
" swap them: http://items.sjbach.com/319/configuring-vim-right
nnoremap ' `
nnoremap ` '

" Resize windows with arrow keys
nnoremap <C-Left> :vertical resize +2<CR>
nnoremap <C-Right> :vertical resize -2<CR>
nnoremap <C-Up> :resize -2<CR>
nnoremap <C-Down> :resize +2<CR>

" Switch buffer
nnoremap <bs> <c-^>

" copy current 'filename into system clipboard - mnemonic:' (c)urrent(f)ilename
" this is helpful to paste someone the path you're looking at
" ~/.c-vimrc
nnoremap <silent> ,cf :let @* = expand("%:~")<CR>
" /home/leonardo/.c-vimrc
nnoremap <silent> ,cr :let @* = expand("%")<CR>
" .c-vimrc
nnoremap <silent> ,cn :let @* = expand("%:t")<CR>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Source this line, place your cursor on ), press zl and you'll understand
"    println()foo
nnoremap zl :let @z=@"<cr>x$p:let @"=@z<cr>

" }}}
" Functions ================================{{{

" map '<CR>' in command-line mode to execute the function below
cnoremap <expr> <CR> CCR()
function! CCR()       " See https://gist.github.com/romainl/047aca21e338df7ccf771f96858edb86
    " grab the current command-line
    let cmdline = getcmdline()

    " does it end with '#' or 'number' or one of its abbreviations?
    if cmdline =~ '\v\C/(#|nu|num|numb|numbe|number)$'
        " press '<CR>' then ':' to enter command-line mode
        return "\<CR>:"
    else
        " press '<CR>'
        return "\<CR>"
    endif
endfunction

" Search by the word visual selected, see: http://got-ravings.blogspot.com.br/2008/07/vim-pr0n-visual-search-mappings.html
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction

" It lets '%' works for other things, like if/endif, tags, etc
" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
    runtime! macros/matchit.vim
endif

" Enable undo changes to a file after closing and reopening
if has('persistent_undo')
    silent call system('mkdir -p ~/.vim/tmp/undo')
    set undofile
    set undodir=~/.vim/tmp/undo/
endif

" }}}
" AutoCMD's ================================{{{
if has('autocmd')
    " Show spaces as red if there's nothing after it (from Greg Hurrel)
    augroup TrailWhiteSpaces
        highlight ColorColumn ctermbg=1
        autocmd BufWinEnter <buffer> match Error /\s\+$/
        autocmd InsertEnter <buffer> match Error /\s\+\%#\@<!$/
        autocmd InsertLeave <buffer> match Error /\s\+$/
        autocmd BufWinLeave <buffer> call clearmatches()
    augroup END

    " Ref: https://github.com/thoughtbot/dotfiles/blob/master/vimrc#L35
    " When editing a file, always jump to the last known cursor position.
    " Don't do it for commit messages, when the position is invalid, or when
    " inside an event handler (happens when dropping a file on gvim).
    augroup vimrc-remember-cursor-position
        autocmd BufReadPost *
                    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal g`\"" |
                    \ endif
    augroup END

endif

" }}}
" Plugins {{{

" Nerdtree
" Toggle NERDTree with F6
nnoremap <tab> :NERDTreeToggle<CR>

" Close NERDTree with Shift-TAB
nnoremap <S-Tab> :NERDTreeClose<CR>

" Show the bookmarks table on startup
let NERDTreeShowBookmarks = 1

" Autoclose nerdtree if it is the only open buffer
augroup nerdtree_close
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END


" fzf.vim

" Mapping selecting mappings
" Show avaliable mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
"imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-m> fzf#vim#complete#word({'left': '15%'})

command! Plugs call fzf#run({
            \ 'source':  map(sort(keys(g:plugs)), 'g:plug_home."/".v:val'),
            \ 'options': '--delimiter / --nth -1',
            \ 'down':    '~20%',
            \ 'sink':    'Explore'})

let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

let g:fzf_action = {
            \ 'ctrl-s': 'split',
            \ 'ctrl-v': 'vsplit'
            \ }

nnoremap <space>ff  :Files<CR>
nnoremap <space>fl  :Lines<CR>
nnoremap <space>fbl :BLines<CR>
nnoremap <space>fh  :Files<CR>
nnoremap <space>gb  :Buffers<CR>
nnoremap <space>p   :History<CR>

set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
"let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
"let $FZF_DEFAULT_COMMAND = 'rg --hidden -l ""'

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"
let g:comfortable_motion_no_default_key_mappings = 1


" Coc.vim

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<S-Tab>'

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)




" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

let g:python3_host_prog = '/bin/python3'
let g:python_host_prog = '/bin/python'

let g:indentLine_char_list = ['|', '¦', '┆', '┊']


" Syntastic Config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" (Optional)Remove Info(Preview) window
set completeopt-=preview

" (Optional)Hide Info(Preview) window after completions
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" (Optional) Enable terraform plan to be include in filter
let g:syntastic_terraform_tffilter_plan = 1

" (Optional) Default: 0, enable(1)/disable(0) plugin's keymapping
let g:terraform_completion_keys = 1

" (Optional) Default: 1, enable(1)/disable(0) terraform module registry completion
let g:terraform_registry_module_completion = 0

let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.terraform = '[^ *\t"{=$]\w*'
let g:deoplete#enable_at_startup = 1




" all lists will be of type quickfix
let g:deoplete#sources#go#gocode_binary = '$HOME/go/bin/gocode'
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_list_type = "quickfix"
let g:go_test_timeout = '10s'
let g:go_fmt_command = "$HOME/go/bin/goimports"
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_jump_to_error = 0
let g:go_metalinter_autosave = 0
let g:go_metalinter_enabled = []
let g:go_metalinter_autosave_enabled = []
let g:go_gocode_unimported_packages = 1
let g:go_decls_mode = 'fzf'
let g:go_auto_sameids = 1


" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
" }}}


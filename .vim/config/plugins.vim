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
map ,ne <Esc><Esc>:call ToggleExplore()<CR>


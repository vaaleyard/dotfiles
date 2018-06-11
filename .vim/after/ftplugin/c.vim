"autocmd BufNewFile *.c 0r ~/.vim/snippets/skeleton.c | call cursor(8,17) " Call the skeleton.c for every new .c file
" Just some shit to show the file creation time
"autocmd BufNewFile *.c :r!date "+\%d/\%m/\%Y \%H:\%M"
"autocmd BufNewFile *.c :norm kJ | call cursor(13,1)
" When typing ';' marks a undo point, so when hit u, it won't undo the whole thing that you did in insert mode (nice when programming), and always save when press ;
inoremap ; ;<c-g>u
inoremap {<CR> <CR>{<CR>}<Esc>O
inoremap /*<space> /*  */<Esc>2<Left>i
"inoremap ; :w<CR>
set colorcolumn=72


"autocmd BufNewFile *.c 0r ~/.vim/snippets/skeleton.c | call cursor(8,17) " Call the skeleton.c for every new .c file
" Just some shit to show the file creation time
"autocmd BufNewFile *.c :r!date "+\%d/\%m/\%Y \%H:\%M"
"autocmd BufNewFile *.c :norm kJ | call cursor(13,1)
" When typing ';' marks a undo point, so when hit u, it won't undo the whole thing that you did in insert mode (nice when programming), and always save when press ;
inoremap ; ;<c-g>u
"inoremap ; :w<CR>
inoremap {<CR> <space>{<CR>}<Esc>O
inoremap /*<space> /*  */<Esc>2<Left>i
"iabbrev #i #include
"iabbrev #d #define
set colorcolumn=72
setlocal comments^=:///
setlocal commentstring=///\ %s

" ------
" Cpp abbreviations
" Source: http://vim.wikia.com/wiki/C/C%2B%2B_function_abbreviations
" Help delete character if it is 'empty space'
" stolen from Vim manual
function! Eatchar()
  let c = nr2char(getchar())
  return (c =~ '\s') ? '' : c
endfunction

" Replace abbreviation if we're not in comment or other unwanted places
" stolen from Luc Hermitte's excellent http://hermitte.free.fr/vim/
function! MapNoContext(key, seq)
  let syn = synIDattr(synID(line('.'),col('.')-1,1),'name')
  if syn =~? 'comment\|string\|character\|doxygen'
    return a:key
  else
    exe 'return "' .
    \ substitute( a:seq, '\\<\(.\{-}\)\\>', '"."\\<\1>"."', 'g' ) . '"'
  endif
endfunction

" Create abbreviation suitable for MapNoContext
function! Iab (ab, full)
  exe "iab <silent> <buffer> ".a:ab." <C-R>=MapNoContext('".
    \ a:ab."', '".escape (a:full.'<C-R>=Eatchar()<CR>', '<>\"').
    \"')<CR>"
endfunction

call Iab('psvm', 'public static void main(String[] args) {<CR>}<C-O>O')
call Iab('sout', 'System.out.println("");<C-O>?"<CR>:nohl<CR>')

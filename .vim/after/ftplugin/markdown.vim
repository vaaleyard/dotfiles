" [B]old text
inoremap ;b **<Esc>i

" Under[s]cored text
inoremap ;s __<Esc>i

" [n]ew underscore line
inoremap ;n <Enter><Enter>---<Enter><Enter>

" Not sure what is it
inoremap ;l --------<Enter>

" [C]ode
inoremap ;c ```<CR>```<CR><CR><esc>2kO

" Header [1]
inoremap ;1 #<Space>

" Header [2]
inoremap ;2 ##<Space>

" Header [3]
inoremap ;3 ###<Space>

" Insert [u]rls
inoremap ;u []()<Esc>F[a
noremap  ;w yiWi[<esc>Ea](<esc>pa)

" Insert [i]mages
inoremap ;i ![]()<Esc>F[a

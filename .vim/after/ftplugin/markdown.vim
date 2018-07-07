noremap ,w yiWi[<esc>Ea](<esc>pa)
inoremap ,n ---<Enter><Enter>
inoremap ,i ![](<++>)<++><Esc>F[a
inoremap ,a [](<++>)<++><Esc>F[a
inoremap ,l --------<Enter>

" [B]old text
inoremap ,b **<Esc>F*i

" Under[s]cored text
inoremap ,s __<Esc>F_hi

" New underscore line
inoremap ,n ---<Enter><Enter>

" [C]ode
inoremap ,c ```<CR>```<CR><CR><esc>2kO

" Header [1]
inoremap ,1 #<Space><Enter><Esc>kA

" Header [2]
inoremap ,2 ##<Space><Enter><Esc>kA

" Header [3]
inoremap ,3 ###<Space><Enter><Esc>kA

" Set spell for markdown files
setlocal spell

" [B]old text
inoremap ,b **<Esc>i

" I[t]alic text
inoremap ,t __<Esc>i

" [R]isk text
inoremap ,r ~~~~<Esc>hi

" [n]ew underscore line
inoremap ,n <Enter><Enter>---<Enter><Enter>

" Not sure what is it
inoremap ,l <Enter>--------<Enter>

" [C]ode
inoremap ,c ```<CR>```<CR><CR><esc>2kO

" Header [1]
inoremap ,1 #<Space>

" Header [2]
inoremap ,2 ##<Space>

" Header [3]
inoremap ,3 ###<Space>

" Insert [u]rls
inoremap ,u []()<Esc>F[a
noremap  ,w yiWi[<esc>Ea](<esc>pa)

" Insert [i]mages
inoremap ,i ![]()<Esc>F[a

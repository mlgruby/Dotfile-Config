" NERDCommenter
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv

" NERDTree
let NERDTreeQuitOnOpen=1
let g:NERDTreeMinimalUI=1
nmap <F2> :NERDTreeToggle<CR>

" Open buffer movement
nmap <M-Left> :bp<CR>
nmap <M-Right> :bn<CR>
nmap <M-w> :bd<CR>

" Spotify
nmap <F7> :SpToggle<CR>
nmap <F6> :SpPrevious<CR>
nmap <F8> :SpNext<CR>


" General
nmap <C-s> :w<CR>

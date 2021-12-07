if !exists('g:EasyMotion_loaded') " && !exists('g:vscode')
  finish
endif

let g:EasyMotion_do_mapping = 0     " デフォルトキーマッピングの無効化
let g:EasyMotion_smartcase = 1      " 小文字の時は大文字にもヒットさせる
let g:EasyMotion_use_migemo = 1     " Migemo 検索を有効化

nmap f <Plug>(easymotion-sl)
nmap F <Plug>(easymotion-s2)
vmap f <Plug>(easymotion-sl)
vmap F <Plug>(easymotion-s2)
nmap ; <Plug>(easymotion-next)
nmap , <Plug>(easymotion-prev)
vmap ; <Plug>(easymotion-next)
vmap , <Plug>(easymotion-prev)

omap f <Plug>(easymotion-fl)
omap F <Plug>(easymotion-Fl)
omap t <Plug>(easymotion-tl)
omap T <Plug>(easymotion-Tl)

map m <Nop>
map mw <Plug>(easymotion-w)
map mW <Plug>(easymotion-W)
map mb <Plug>(easymotion-b)
map mB <Plug>(easymotion-B)
map me <Plug>(easymotion-e)
map mE <Plug>(easymotion-E)
map mg <Plug>(easymotion-ge)
map mG <Plug>(easymotion-gE)
map mj <Plug>(easymotion-j)
map mk <Plug>(easymotion-k)
map mh <Plug>(easymotion-linebackward)
map ml <Plug>(easymotion-lineforward)
map mm <Plug>(easymotion-lineanywhere)
map mf <Plug>(easymotion-s)
map mt <Plug>(easymotion-bd-t)
map ms <Plug>(easymotion-bd-W)

" key binding
" Ctrl+j, Ctrl+k で 10行上下へ移動
map <C-j> 10j
map <C-k> 10k

" Ctrl+h, Ctrl+l をそれぞれ g^, g$ に割当
nnoremap <C-h> g^
nnoremap <C-l> g$

" Visual モードやオペレータ待機モードでは ^, $ に割当
vmap <C-h> ^
vmap <C-l> $

omap <C-h> ^
omap <C-l> $

" Y で行末までヤンク (C, D と同じ挙動)
nnoremap Y y$

" 本来の A の機能は gA に変更し、A は末尾の空白を無視して挿入モードへ
nnoremap gA A
nnoremap A g_a

" xで削除する時はヤンクしない (代わりに dl を使う)
noremap x "_x
noremap X "_X

" gV で最後にプットした範囲を Visual 選択
nmap gV `[v`]

" Visual モードでインデント変更後に選択範囲を解放しない
vnoremap > >gv
vnoremap < <gv

nmap <Tab> gt
nmap <S-Tab> gT

nnoremap t <NOP>
nmap te :<C-u>tabedit<SPACE>
nmap <silent> tq :<C-u>tabclose<CR>

nnoremap s <NOP>
nmap ss <C-w>s
nmap sv <C-w>v
nmap se <C-w>n
nmap sq <C-w>q

nmap sh <C-w>h
nmap sj <C-w>j
nmap sk <C-w>k
nmap sl <C-w>l

nmap sH <C-w>H
nmap sJ <C-w>J
nmap sK <C-w>K
nmap sL <C-w>L

nmap s+ <C-w>+
nmap s- <C-w>-
nmap s< <C-w><
nmap s> <C-w>>
nmap s= <C-w>=

" 左クリックでカーソルが移動しないように
nmap <LeftMouse> <Nop>

" Insert
inoremap <C-a> <HOME>
inoremap <C-e> <END>

" Command
cnoremap <C-a> <HOME>
cnoremap <C-e> <END>

cnoremap <C-k> <Up>
cnoremap <C-j> <Down>

" %% で現在開いているファイルパスのディレクトリまでを展開
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h') . '/' : '%%'


" Terminal mode
tnoremap <C-[> <C-\><C-n>
tnoremap <Esc> <C-\><C-n>

tnoremap <C-k> <Up>
tnoremap <C-j> <Down>

" Leader key
let mapleader = "\<SPACE>"

" n ハイライトを解除
map <silent> <Leader>n :noh<CR>

" c,d,p,y についてはシステムのクリップボードを使用するようにする
map <Leader>y "+y
map <Leader>Y "+Y
map <Leader>d "+d
map <Leader>D "+D
map <Leader>c "+c
map <Leader>C "+C
map <Leader>p "+p
map <Leader>P "+P

" a で全選択
nmap <Leader>a ggVG

" r で設定リロード
nmap <silent> <Leader>r :<C-u>source ~/.config/nvim/init.vim<CR>

" easymotion 系の設定
" let g:EasyMotion_do_mapping = 0     " デフォルトキーマッピングの無効化
"
" map  <Leader>f <Plug>(easymotion-bd-f)
" map  <Leader>s <Plug>(easymotion-s2)
"
" map  <Leader>w <Plug>(easymotion-w)
" map  <Leader>b <Plug>(easymotion-b)
" map  <Leader>W <Plug>(easymotion-W)
" map  <Leader>B <Plug>(easymotion-B)
" map  <Leader>j <Plug>(easymotion-bd-jk)
" map  <Leader>k <Plug>(easymotion-bd-jk)
" map  <Leader>h <Plug>(easymotion-sol-bd-jk)
" map  <Leader>l <Plug>(easymotion-eol-bd-jk)
"
" map  <Leader>/ <Plug>(easymotion-vim-n)
" map  <Leader><S-/> <Plug>(easymotion-vim-N)

if !exists('g:vscode')
  " jk を見えている単位で移動する
  noremap j gj
  noremap k gk
  noremap gj j
  noremap gk k

  " ウィンドウサイズ変更
  nnoremap s+ 5<C-w>+
  nnoremap s- 5<C-w>-
  nnoremap s< 5<C-w><
  nnoremap s> 5<C-w>>

  " カレントウィンドウを新しいタブページへ移動
  nnoremap st <C-w>T

  " z で wrap を切り替え
  noremap <silent> <Leader>z :set invwrap<CR>

  " tab
  nnoremap t1 1gt
  nnoremap t2 2gt
  nnoremap t3 3gt
  nnoremap t4 4gt
  nnoremap t5 5gt
  nnoremap t6 6gt
  nnoremap t7 7gt
  nnoremap t8 8gt
  nnoremap t9 9gt
  nnoremap <silent> t0 :<C-u>tablast<CR>

  nnoremap <silent> tt :<C-u>tabedit<CR>
  nnoremap <silent> ts :<C-u>tabs<CR>

  nnoremap <silent> th :<C-u>tabmove-1<CR>
  nnoremap <silent> tl :<C-u>tabmove+1<CR>
endif
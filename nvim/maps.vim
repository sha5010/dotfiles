" key binding
" VSCode でも使用されるキーマップは nore を使わない
" それ以外は基本的に noremap を使う

" jk を見えている単位で移動、gj,gk を行単位で移動
noremap j gj
noremap k gk
noremap gj j
noremap gk k

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
nnoremap gA g_a

" xで削除する時はヤンクしない (代わりに dl を使う)
nnoremap x "_x
nnoremap X "_X
vnoremap x "_x
vnoremap X "_X

" c で変更するときもレジスタに保存しないようにする (代わりに d を使う)
nnoremap c "_c
nnoremap C "_C
vnoremap c "_c
vnoremap C "_C

" gV で最後にプットした範囲を Visual 選択
nmap gV `[v`]

" Visual モードでインデント変更後に選択範囲を解放しない
vnoremap > >gv
vnoremap < <gv

" Tab と Shift+Tab でタブ移動
nmap <Tab> gt
nmap <S-Tab> gT

" t をタブ操作関連に割当
nnoremap t <NOP>

" te で :tabedit をコマンド入力 (ファイル名入力待ち状態へ)
nnoremap te :<C-u>tabedit<SPACE>

" tq でタブを閉じる
nmap <silent> tq :<C-u>tabclose<CR>

" t1 - t9 で n番目のタブへ移動
nnoremap t1 1gt
nnoremap t2 2gt
nnoremap t3 3gt
nnoremap t4 4gt
nnoremap t5 5gt
nnoremap t6 6gt
nnoremap t7 7gt
nnoremap t8 8gt
nnoremap t9 9gt

" t0 で最後のタブへ移動
nnoremap <silent> t0 <Cmd>tablast<CR>

" tt で新規タブ(無題)を作成
nnoremap <silent> tt <Cmd>tabedit<CR>

" ts でタブ一覧を表示
nnoremap <silent> ts <Cmd>tabs<CR>

" th, tl で現在タブを左右に移動
nnoremap <silent> th <Cmd>tabmove-1<CR>
nnoremap <silent> tl <Cmd>tabmove+1<CR>

" ウィンドウ操作系 (<C-w>) を s に割当
nnoremap s <NOP>

" ウィンドウサイズ変更
nnoremap s+ 5<C-w>+
nnoremap s- 5<C-w>-
nnoremap s< 5<C-w><
nnoremap s> 5<C-w>>

" ウィンドウサイズの均一化 (VSCode でも使用)
nmap s= <C-w>=

" ss で横分割、sv で縦分割
nmap ss <C-w>s
nmap sv <C-w>v

" se で新規ファイルを横分割で作成
nmap se <C-w>n

" sq でウィンドウを閉じる
nmap sq <C-w>q

" st でカレントウィンドウを新しいタブページへ移動
nnoremap st <C-w>T

" s+hjkl でウィンドウ移動
nmap sh <C-w>h
nmap sj <C-w>j
nmap sk <C-w>k
nmap sl <C-w>l

" s+HJKL で各方向へ最大サイズで再配置
nmap sH <C-w>H
nmap sJ <C-w>J
nmap sK <C-w>K
nmap sL <C-w>L

" 左クリックでカーソルが移動しないように
nmap <LeftMouse> <Nop>

" オペーレーター待機モードでカッコや引用符をShiftなしで
onoremap i8 i(
onoremap i9 i)
onoremap i2 i"
onoremap i7 i'
onoremap i@ i`
onoremap i, i<
onoremap i. i>
onoremap a8 a(
onoremap a9 a)
onoremap a2 a"
onoremap a7 a'
onoremap a@ a`
onoremap a, a<
onoremap a. a>

" Visualモードでも同様にShiftなしで
vnoremap i8 i(
vnoremap i9 i)
vnoremap i2 i"
vnoremap i7 i'
vnoremap i@ i`
vnoremap i, i<
vnoremap i. i>
vnoremap a8 a(
vnoremap a9 a)
vnoremap a2 a"
vnoremap a7 a'
vnoremap a@ a`
vnoremap a, a<
vnoremap a. a>

" Insert mode
" Ctrl+a、Ctrl+e で行頭、行末移動
inoremap <C-a> <HOME>
inoremap <C-e> <END>

" Command mode
" Ctrl+a、Ctrl+e で行頭、行末移動
cnoremap <C-a> <HOME>
cnoremap <C-e> <END>

" Ctrl+k,j でヒストリを遡る
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>

" Ctrl+h,l で左右にカーソル移動
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>

" %% で現在開いているファイルパスのディレクトリまでを展開
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h') . '/' : '%%'


" Terminal mode
" Escape キーで挿入モードからノーマルモードへ
tnoremap <C-[> <C-\><C-n>

" Ctrl+k,j でヒストリを遡る
tnoremap <C-k> <Up>
tnoremap <C-j> <Down>


" Leader key
let mapleader = "\<SPACE>"

" n ハイライトを解除
map <silent> <Leader>n <Cmd>nohlsearch<CR>

" c,d,p,y についてはシステムのクリップボードを使用するようにする
map <Leader>y "+y
map <Leader>Y "+Y
map <Leader>d "+d
map <Leader>D "+D
map <Leader>p "+p
map <Leader>P "+P

" a で全選択
nmap <Leader>a ggVG

" r で設定リロード
nmap <silent> <Leader>r <Cmd>source ~/.config/nvim/init.vim<CR>

" z で wrap を切り替え
noremap <silent> <Leader>z <Cmd>set invwrap<CR>

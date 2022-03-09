" init autocmd
autocmd!

" nvim global setting
" 行番号系
set number            " 行番号を表示
set relativenumber    " 行番号を相対行で表示

" インデント系
set expandtab         " タブを半角スペースに変換 (残りは下の方で書いてある)
set tabstop=2         " default tab size
set softtabstop=2     " default tab size (if softtab)
set shiftwidth=2      " autoindent tab size

" 検索系
set ignorecase        " 検索時、大文字小文字を区別しない
set smartcase         " ただし大文字が入力された場合は区別する

if has('nvim')
  set inccommand=nosplit
endif

" エンコーディング系
set fileencodings=ucs-bom,utf-8,cp932,euc-jp,latin    " 読み込む場合のデフォルトエンコーディング
set encoding=utf-8    " 保存時のデフォルトエンコードディング
set nofixeol          " <EOL>がないファイルの場合、自動的に付与しない

" タイトル系
set title             " タイトル表示 (よくわかってない)

" 表示系
set scrolloff=5       " スクロールに余裕をもたせる
set lazyredraw        " マクロ実行時に画面描画しない (パフォーマンス向上)
set cursorline        " 現在行をハイライト
set showtabline=2     " タブラインを常時表示
set updatetime=500    " 反映時間を短くする
set pumheight=12      " 検索候補の最大表示数

" ウィンドウ系
set splitright        " 縦に画面分割時、右に開く
set splitbelow        " 横に画面分割時、下に開く

" マウスの有効化
set mouse=a

" Imports {{{
" --------------------------------------------------
runtime ./plug.vim
" }}}

" Key map and Leader key settings
runtime ./maps.vim
runtime ./abbrev.vim

" VSCode の設定と分ける
if exists('g:vscode')
  " Enable in VScode only
  runtime ./vscode.vim
else
  " set ambiwidth=double  " あいまいな文字は全角表示にする

  " 表示カラー系
  if !exists('g:initialized')
    syntax on
    set background=dark

    colorscheme gruvbox

    let g:initialized = 1
  endif

  if exists("&termguicolors")
    set termguicolors
  endif
endif

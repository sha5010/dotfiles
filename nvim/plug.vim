" vim-plug がインストールされていない場合は、自動でインストール
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  if executable('curl')
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  else
    echo "Cannot install vim-plug"
    finish
  endif
endif

if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

" VSCode 用 easymotion
if exists('g:vscode')
  Plug 'asvetliakov/vim-easymotion', { 'as': 'vscode-easymotion' }
endif

Plug 'machakann/vim-sandwich'           " 囲む系の処理を簡単にできるようになる
Plug 'machakann/vim-highlightedyank'    " ヤンクした箇所を一瞬ハイライト
Plug 'terryma/vim-expand-region'        " Visual モードで選択範囲をいい感じに拡張
Plug 'brglng/vim-im-select'             " Normal モードに戻るときに IME を切る
Plug 'kana/vim-operator-user'           " vim-operator-replace を使うのに必要
Plug 'kana/vim-operator-replace'        " 置換時にオペレータが使えるようになる
Plug 'thinca/vim-visualstar'            " Visual モードで選択中に * 等で検索

if has("nvim")
  Plug 'winston0410/cmd-parser.nvim'    " range-highlight を使うのに必要
  Plug 'winston0410/range-highlight.nvim'  " コマンドラインで範囲指定時にハイライト
  Plug 'monaqa/dial.nvim'               " Increase(<C-a>) Decrease(<C-x>) の拡張
endif

if !exists('g:vscode')
  Plug 'mbbill/undotree'                " Undo の履歴をツリー状に表示
  Plug 'Shougo/vimproc.vim'             " Quickrun を非同期でできるように
  Plug 'thinca/vim-quickrun'            " バッファ上にあるコードを簡易実行
endif

if has("nvim") && !exists('g:vscode')
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}   " 構文解析の補助
  Plug 'windwp/nvim-autopairs'          " カッコや引用符などの自動追加
  Plug 'norcalli/nvim-colorizer.lua'    " カラーコードを可視化

  Plug 'nathom/filetype.nvim'           " filetype の読み込みを高速化

  Plug 'rktjmp/lush.nvim'               " gruvbox.nvim に必要
  Plug 'ellisonleao/gruvbox.nvim'       " カラースキーム

  Plug 'nvim-lualine/lualine.nvim'      " ステータスバーを見やすくする
  Plug 'seblj/nvim-tabline'             " タブラインをカスタマイズ
  Plug 'kyazdani42/nvim-web-devicons'   " カラー付きのアイコンを表示
  Plug 'kyazdani42/nvim-tree.lua'       " ファイルツリーを表示
  Plug 'akinsho/toggleterm.nvim'        " ターミナルを使いやすく拡張

  Plug 'nvim-lua/popup.nvim'            " telescope.nvim で必要
  Plug 'nvim-lua/plenary.nvim'          " telescope.nvim で必要
  Plug 'nvim-telescope/telescope.nvim'  " ファイルやコマンドのファジーサーチ

  " Plug 'phaazon/hop.nvim'               " 単語ジャンプの簡易化
  Plug 'easymotion/vim-easymotion'      " 単語ジャンプの簡易化
  Plug 'numToStr/Comment.nvim'          " コメントアウト
  Plug 'cappyzawa/trim.nvim'            " 保存時に行末スペースを削除
  Plug 'lukas-reineke/indent-blankline.nvim'  " インデントガイド

  Plug 'neovim/nvim-lspconfig'          " LSP を使用するための設定を行う
  Plug 'williamboman/nvim-lsp-installer'  " Language Server の管理
  Plug 'tami5/lspsaga.nvim', { 'branch': 'nvim6.0' }   " LSP の構文情報をポップアップ表示
  Plug 'folke/lsp-colors.nvim'          " 構文解析の結果に色を付ける (うまく動かない…)
  Plug 'hrsh7th/cmp-nvim-lsp'           " nvim-cmp 用：LSPの結果を候補に表示
  Plug 'hrsh7th/cmp-buffer'             " nvim-cmp 用：バッファから候補に表示
  Plug 'hrsh7th/cmp-path'               " nvim-cmp 用：パスから候補に表示
  Plug 'hrsh7th/cmp-cmdline'            " nvim-cmp 用：コマンドを候補に表示
  Plug 'hrsh7th/nvim-cmp'               " LSP を利用した自動補完を提供
  Plug 'onsails/lspkind-nvim'           " nvim-cmp で表示される補完でアイコンを使用

  Plug 'lewis6991/gitsigns.nvim'        " Git の差分有無を左に表示
  Plug 'tpope/vim-fugitive'             " Git 操作を Vim 上で
endif

call plug#end()

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Easymotion の設定
let g:EasyMotion_do_mapping = 0     " デフォルトキーマッピングの無効化

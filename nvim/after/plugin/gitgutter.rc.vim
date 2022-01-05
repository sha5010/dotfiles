" plug.vim から呼ばれる際、未読み込みなら変数の設定だけ行う
if !exists('g:loaded_gitgutter')
  " git コマンド (パスを通していないときはフルパス)
  let g:gitgutter_git_executable = 'git'

  " デフォルトのキーマッピングを無効化
  let g:gitgutter_map_keys = 0

  " grep コマンドを変更
  let g:gitgutter_grep = 'rg'

  " 表示されるサイン
  let g:gitgutter_sign_added = ''
  let g:gitgutter_sign_modified = ''
  let g:gitgutter_sign_removed = ''
  let g:gitgutter_sign_removed_first_line = ''
  let g:gitgutter_sign_removed_above_and_below = ''
  let g:gitgutter_sign_modified_removed = ''

else

  " インストールされているときのみ実行

  " ]c [c で hunk 移動
  nmap ]c <Plug>(GitGutterNextHunk)
  nmap [c <Plug>(GitGutterPrevHunk)

  " gz を Git 系のコマンドに割り当てる
  nmap gzs <Plug>(GitGutterStageHunk)
  nmap gzu <Plug>(GitGutterUndoHunk)
  nmap gzp <Plug>(GitGutterPreviewHunk)

  omap ih <Plug>(GitGutterTextObjectInnerPending)
  omap ah <Plug>(GitGutterTextObjectOuterPending)
  omap ih <Plug>(GitGutterTextObjectInnerVisual)
  omap ah <Plug>(GitGutterTextObjectOuterVisual)

endif


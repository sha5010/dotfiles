" Default function from GitHub repo
function! VSCodeNotifyVisual(cmd, leaveSelection, ...)
    let mode = mode()
    if mode ==# 'V'
        let startLine = line('v')
        let endLine = line('.')
        call VSCodeNotifyRange(a:cmd, startLine, endLine, a:leaveSelection, a:000)
    elseif mode ==# 'v' || mode ==# "\<C-v>"
        let startPos = getpos('v')
        let endPos = getpos('.')
        call VSCodeNotifyRangePos(a:cmd, startPos[1], endPos[1], startPos[2], endPos[2] + 1, a:leaveSelection, a:000)
    else
        call VSCodeNotify(a:cmd, a:000)
    endif
endfunction

" Default setting from GitHub repo
xnoremap <C-S-P> <Cmd>call VSCodeNotifyVisual('workbench.action.showCommands', 1)<CR>

" Pressed Cmd+C and Cmd+X in visual mode
xnoremap <silent> <C-c> <Cmd>call VSCodeNotifyVisual('editor.action.clipboardCopyAction', 1)<CR>
xnoremap <silent> <C-x> <Cmd>call VSCodeNotifyVisual('editor.action.clipboardCutAction', 1)<CR>
xnoremap <silent> <C-_> <Cmd>call VSCodeNotifyVisual('editor.action.commentLine', 1)<CR>

" Toggle explorer visibility
nnoremap <silent> <Leader>e <Cmd>call VSCodeNotify('workbench.view.explorer')<CR>

" z で wrap を切り替え
noremap <silent> <Leader>z <Cmd>call VSCodeNotify('editor.action.toggleWordWrap')<CR>

" m で ミニマップ切り替え
noremap <silent> <Leader>m <Cmd>call VSCodeNotify('editor.action.toggleMinimap')<CR>

" st ですべての分割ウィンドウを結合 (タブ化)
nnoremap <silent> st <Cmd>call VSCodeNotify('workbench.action.joinAllGroups')<CR>

" Tab Change
nnoremap <silent> te <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>
nnoremap <silent> tt <Cmd>call VSCodeNotify('workbench.action.files.newUntitledFile')<CR>
nnoremap <silent> t1 <Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex1')<CR>
nnoremap <silent> t2 <Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex2')<CR>
nnoremap <silent> t3 <Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex3')<CR>
nnoremap <silent> t4 <Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex4')<CR>
nnoremap <silent> t5 <Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex5')<CR>
nnoremap <silent> t6 <Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex6')<CR>
nnoremap <silent> t7 <Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex7')<CR>
nnoremap <silent> t8 <Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex8')<CR>
nnoremap <silent> t9 <Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex9')<CR>

nnoremap <silent> th <Cmd>call VSCodeNotify('workbench.action.moveEditorLeftInGroup')<CR>
nnoremap <silent> tl <Cmd>call VSCodeNotify('workbench.action.moveEditorRightInGroup')<CR>

" Fold
noremap <silent> za <Cmd>call VSCodeNotify('editor.toggleFold')<CR>
noremap <silent> zo <Cmd>call VSCodeNotify('editor.unfold')<CR>
noremap <silent> zO <Cmd>call VSCodeNotify('editor.unfoldRecursively')<CR>
noremap <silent> zc <Cmd>call VSCodeNotify('editor.fold')<CR>
noremap <silent> zC <Cmd>call VSCodeNotify('editor.foldRecursively')<CR>

noremap <silent> zR <Cmd>call VSCodeNotify('editor.unfoldAll')<CR>
noremap <silent> zM <Cmd>call VSCodeNotify('editor.foldAll')<CR>

" k, j を見えている行で移動する (gj, gk を行移動)
nnoremap j <Cmd>call VSCodeNotify('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>
nnoremap k <Cmd>call VSCodeNotify('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>
nnoremap gj <Cmd>call VSCodeNotify('cursorMove', { 'to': 'down', 'by': 'line', 'value': v:count ? v:count : 1 })<CR>
nnoremap gk <Cmd>call VSCodeNotify('cursorMove', { 'to': 'up', 'by': 'line', 'value': v:count ? v:count : 1 })<CR>

" VSCode だと g^ がうまく動かず代わりに g0 がうまく動くので変更しておく
nmap <C-h> g0
nmap <C-l> g$

" QuickScope setting
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=213 cterm=underline

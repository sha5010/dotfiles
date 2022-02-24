if !exists('g:loaded_fugitive')
  finish
endif

" Status
nnoremap <silent> gs <Cmd>Git<CR><C-w>K

" Log
nnoremap <silent> gzl <Cmd>Gclog!<CR>
nnoremap <silent> gzL <Cmd>Gclog --graph --all --pretty=format:'%h -%d %s (%cr)' --abbrev-commit --date=relative<CR>

" Commit
nnoremap <silent> gzc <Cmd>Git commit<CR>
nnoremap <silent> gzC <Cmd>Git commit --amend<CR>

" Stage and Unstage buffer
nnoremap <silent> gzA <Cmd>Gwrite<CR>
nnoremap <silent> gzU <Cmd>Git restore --staged %<CR>

" Restore (reset --hard)
nnoremap <silent> gzR <Cmd>Git restore %<CR>

" Stash
nnoremap <silent> gzs <Cmd>Git stash push<CR>
nnoremap <silent> gzS <Cmd>Git stash pop<CR>

" Revert
nnoremap gzv :Git revert<SPACE>

" Merge diff (solve conflict)
nnoremap <silent> gz, <Cmd>diffget //2<CR>
nnoremap <silent> gz< <Cmd>diffget //2<CR>
nnoremap <silent> gz. <Cmd>diffget //3<CR>
nnoremap <silent> gz> <Cmd>diffget //3<CR>
xnoremap <silent> gz, :diffget //2<CR>
xnoremap <silent> gz< :diffget //2<CR>
xnoremap <silent> gz. :diffget //3<CR>
xnoremap <silent> gz> :diffget //3<CR>

" Merge
nnoremap gzm :Git merge<SPACE>
nnoremap gzM :Git merge --squash<SPACE>

" Fetch
nnoremap gzf <Cmd>Git fetch<CR>

" Difftool
nmap <silent><expr> gzd ('<Cmd>' . (&diff ? (bufname('fugitive://') !=# '' ? 'bwipeout! fugitive://' :
      \ (bufname('//2') !=# '' && bufname('//3') !=# '' ? 'bwipeout! //2 <Bar> bwipeout! //3' : ''))
      \ : 'Gvdiffsplit!') . '<CR>')
nnoremap <silent> gzD <Cmd>Gvdiffsplit! HEAD<CR>

" Diff
" Worktree and Index
nnoremap <silent> gzi <Cmd>Git diff --staged<CR>

" Worktree and latest commit
nnoremap <silent> gz0 <Cmd>Git diff HEAD<CR>

" commit latest and n-th generation ago
nnoremap <silent> gz1 <Cmd>Git diff HEAD~1 HEAD<CR>
nnoremap <silent> gz2 <Cmd>Git diff HEAD~2 HEAD<CR>
nnoremap <silent> gz3 <Cmd>Git diff HEAD~3 HEAD<CR>
nnoremap <silent> gz4 <Cmd>Git diff HEAD~4 HEAD<CR>
nnoremap <silent> gz5 <Cmd>Git diff HEAD~5 HEAD<CR>
nnoremap <silent> gz6 <Cmd>Git diff HEAD~6 HEAD<CR>
nnoremap <silent> gz7 <Cmd>Git diff HEAD~7 HEAD<CR>
nnoremap <silent> gz8 <Cmd>Git diff HEAD~8 HEAD<CR>
nnoremap <silent> gz9 <Cmd>Git diff HEAD~9 HEAD<CR>

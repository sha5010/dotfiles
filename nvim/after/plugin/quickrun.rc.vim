if !exists('g:loaded_quickrun')
  finish
endif

let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \ 'runner'    : 'vimproc',
      \ 'runner/vimproc/updatetime' : 60,
      \ 'outputter/buffer/opener' : ':rightbelow 8sp',
      \ 'outputter/buffer/close_on_empty' : 1,
      \ 'outputter/buffer/into': 0,
      \ 'hook/time/enable': 1,
      \ }
let g:quickrun_config.python = {
      \ 'command': 'python3',
      \ 'cmdopt': '-u',
      \ 'input': '%{filereadable("input") ? "input" : "="}',
      \ }
let g:quickrun_config.go = {
      \ 'command': 'go',
      \ 'exec': ['%c run %s'],
      \ 'type': 'go',
      \ 'input': '%{filereadable("input") ? "input" : "="}',
      \ 'runner': 'system',
      \ }
let g:quickrun_config.cpp = {
      \ 'command': 'g++',
      \ 'input': '%{filereadable("input") ? "input" : "="}',
      \ 'runner': 'system',
      \ }

" デフォルトのキーマップを無効化
let g:quickrun_no_default_key_mappings = 1

" Quickfix を q で閉じられるようにする
augroup quickfix_close
  autocmd!
  autocmd FileType quickrun nnoremap <silent><buffer>q :quit<CR>
  autocmd FileType qf nnoremap <silent><buffer>q :quit<CR>
augroup END

" Ctrl + Q で Quickrun を実行
nnoremap <C-q> :QuickRun -mode n<CR>

" Ctrl + C で Quickrun を停止
func! s:Sweep()
  call quickrun#sweep_sessions()
  echo 'QuickRun: Process Stopped.'
endfunc
nnoremap <expr><silent> <C-c> quickrun#is_running() ? <SID>Sweep() : "\<C-c>"
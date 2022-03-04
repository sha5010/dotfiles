if !exists('g:spzenhan')
  finish
endif

" Update spzenhan path
if exists('g:plug_home')
  let g:spzenhan#executable = g:plug_home . '/spzenhan.vim/zenhan/spzenhan.exe'
elseif has('nvim')
  let g:spzenhan#executable = stdpath('data') . 'plugged/spzenhan.vim/zenhan/spzenhan.exe'
endif

" Replace \ to /
let g:spzenhan#executable = substitute(g:spzenhan#executable, '\\', '/', 'g')

" Define default status
" let g:spzenhan#default = 0

" Re-define autocmd
if exists('#zenhan')
  autocmd! zenhan
endif

augroup zenhan
  autocmd!
  autocmd CmdlineEnter * call system(g:spzenhan#executable . ' 0')
  if exists('g:loaded_vimproc')
    autocmd BufEnter * call vimproc#system_bg(g:spzenhan#executable)
        \ | let b:zenhan_ime_status = exists('g:spzenhan#default') ? g:spzenhan#default : 0
    autocmd InsertLeave * call vimproc#system_bg(g:spzenhan#executable . ' 0')
        \ | let b:zenhan_ime_status = exists('g:spzenhan#default') ? g:spzenhan#default : vimproc#get_last_status()
    autocmd InsertEnter * if b:zenhan_ime_status == 1 | call vimproc#system_bg(g:spzenhan#executable . ' 1') | endif
    autocmd CmdlineLeave * call vimproc#system_bg(g:spzenhan#executable . ' 0')
  else
    autocmd BufEnter * call system(g:spzenhan#executable)
        \ | let b:zenhan_ime_status = exists('g:spzenhan#default') ? g:spzenhan#default : 0
    autocmd InsertLeave * call system(g:spzenhan#executable . ' 0')
        \ | let b:zenhan_ime_status = exists('g:spzenhan#default') ? g:spzenhan#default : v:shell_error
    autocmd InsertEnter * if b:zenhan_ime_status == 1 | call system(g:spzenhan#executable . ' 1') | endif
    autocmd CmdlineLeave * call system(g:spzenhan#executable . ' 0')
  endif
augroup END

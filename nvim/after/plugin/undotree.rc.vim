if !exists('g:loaded_undotree')
  finish
endif

nmap <silent> U <Cmd>UndotreeToggle\|UndotreeFocus<CR>

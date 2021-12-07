if !exists('g:loaded_undotree')
  finish
endif

nmap <silent> U :<C-u>UndotreeToggle\|UndotreeFocus<CR>


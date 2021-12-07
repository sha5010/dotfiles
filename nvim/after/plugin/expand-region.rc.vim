if !exists('g:expand_region_init')
  finish
endif

" vim-expand-region setting
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

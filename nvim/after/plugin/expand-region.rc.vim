if !exists('g:expand_region_init')
  finish
endif

" vim-expand-region setting
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

let g:expand_region_text_objects = {
      \ 'iw'  :0,
      \ 'iW'  :0,
      \ 'aw'  :0,
      \ 'aW'  :0,
      \ 'i"'  :0,
      \ 'i''' :0,
      \ 'i`' :0,
      \ 'a"'  :0,
      \ 'a''' :0,
      \ 'a`' :0,
      \ 'i]'  :1,
      \ 'ib'  :1,
      \ 'iB'  :1,
      \ 'a]'  :1,
      \ 'ab'  :1,
      \ 'aB'  :1,
      \ 'ip'  :0,
      \ 'ap'  :0,
      \ }

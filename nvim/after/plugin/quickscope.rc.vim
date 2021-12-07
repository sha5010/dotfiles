if !exists('g:loaded_quick_scope')
  finish
endif

augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=213 cterm=underline
augroup END

let g:qs_filetype_blacklist = ['NvimTree', 'terminal', 'undotree', 'peek', 'vim-plug']

if exists('g:colors_name')
  exec 'colorscheme ' . g:colors_name
endif

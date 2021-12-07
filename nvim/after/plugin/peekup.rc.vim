if !exists('g:loaded_peekup')
  finish
endif

lua << EOF

local config = require('nvim-peekup.config')
config.geometry = {
   width = 0.8,
   height = 0.8,
   title = 'Registers',
   name = 'peekup',
   wrap = false,
}
config.on_keystroke = {
   delay = '300ms',
   autoclose = true,
   padding = 2,
   paste_reg = '"'
}

EOF

nmap <expr> <Leader>l
    \ (&ft != "peek") ? ':lua require("nvim-peekup").peekup_open()<CR>' : ''

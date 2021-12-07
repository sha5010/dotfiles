if !exists('g:loaded_telescope')
  finish
endif

nnoremap <silent> <Leader>t <Cmd>Telescope find_files<CR>
nnoremap <silent> <Leader>o <Cmd>Telescope oldfiles<CR>
nnoremap <silent> <Leader>b <Cmd>Telescope buffers<CR>
nnoremap <silent> <Leader>j <Cmd>Telescope current_buffer_fuzzy_find<CR>
nnoremap <silent> <Leader>c <Cmd>Telescope command_history<CR>
nnoremap <silent> <Leader>s <Cmd>Telescope search_history<CR>

lua << EOF
local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,

				["<C-[>"] = actions.close,

				["<C-o>"] = actions.select_tab,

        ["<C-f>"] = actions.results_scrolling_up,
        ["<C-b>"] = actions.results_scrolling_down,

			},
      n = {
        ["q"] = actions.close,
      }
    },
    layout_config = {
      horizontal = {
        width = 0.9,
        height = 0.9,
        preview_cutoff = 40,
      },
    },
  }
}

EOF

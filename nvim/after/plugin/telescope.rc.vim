if !exists('g:loaded_telescope')
  finish
endif

nnoremap <Leader>t <Cmd>Telescope find_files<CR>
nnoremap <Leader>o <Cmd>Telescope oldfiles<CR>
nnoremap <Leader>b <Cmd>Telescope buffers<CR>
nnoremap <Leader>/ <Cmd>Telescope current_buffer_fuzzy_find<CR>
nnoremap <Leader>* <Cmd>Telescope grep_string<CR>
nnoremap <Leader>c <Cmd>Telescope command_history<CR>
nnoremap <Leader>s <Cmd>Telescope search_history<CR>
nnoremap <Leader>l <Cmd>Telescope registers<CR>
nnoremap <Leader>g <Cmd>Telescope live_grep<CR>
nnoremap gzw <Cmd>Telescope git_branches<CR>
nnoremap gze <Cmd>Telescope git_files<CR>

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

        ["<C-f>"] = actions.results_scrolling_down,
        ["<C-b>"] = actions.results_scrolling_up,

			},
      n = {
        ["q"] = actions.close,
      }
    },
    sorting_strategy = 'ascending',
    layout_config = {
      horizontal = {
        width = 0.9,
        height = 0.9,
        preview_cutoff = 40,
        prompt_position = 'top',
      },
    },
  }
}

EOF

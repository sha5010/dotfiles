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
        ["<C-j>"]   = actions.move_selection_next,
        ["<C-k>"]   = actions.move_selection_previous,
        ["<C-n>"]   = actions.move_selection_next,
        ["<C-p>"]   = actions.move_selection_previous,

        ["<C-[>"]   = actions.close,

        ["<CR>"]    = actions.select_default,
        ["<C-x>"]   = actions.select_horizontal,
        ["<C-v>"]   = actions.select_vertical,
        ["<C-o>"]   = actions.select_tab,
        ["<C-t>"]   = actions.select_tab,

        ["<C-f>"]   = actions.results_scrolling_down,
        ["<C-b>"]   = actions.results_scrolling_up,

        ["<C-u>"]   = { "<C-u>", type = "command"},

        ["<C-d>"]   = actions.preview_scrolling_down,
        ["<C-y>"]   = actions.preview_scrolling_up,

        ["<Tab>"]   = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"]   = actions.send_to_qflist + actions.open_qflist,
        ["<C-S-Q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"]   = actions.complete_tag,
        ["<C-_>"]   = actions.which_key, -- keys from pressing <C-/>
        ["<C-w>"]   = { "<C-w>", type = "command" },

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

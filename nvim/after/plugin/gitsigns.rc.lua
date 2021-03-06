local status, gitsigns = pcall(require, "gitsigns")
if (not status) then return end

gitsigns.setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '▍', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitsignsChange', text = '▍', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, lhs, rhs, opts)
        opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end

    -- Navigation
    map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
    map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

    -- Actions
    map('n', 'gza', '<cmd>Gitsigns stage_hunk<CR>')
    map('x', 'gza', ':Gitsigns stage_hunk<CR>')
    map('n', 'gzr', '<cmd>Gitsigns reset_hunk<CR>')
    map('x', 'gzr', ':Gitsigns reset_hunk<CR>')
    -- map('n', 'gzA', '<cmd>Gitsigns stage_buffer<CR>')
    map('n', 'gzu', '<cmd>Gitsigns undo_stage_hunk<CR>')
    -- map('n', 'gzR', '<cmd>Gitsigns reset_buffer<CR>')
    map('n', 'gzp', '<cmd>Gitsigns preview_hunk<CR>')
    map('n', 'gzb', '<cmd>Gitsigns blame_line<CR>')
    map('n', 'gzB', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
    -- map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
    -- map('n', 'gzd', '<cmd>Gitsigns diffthis<CR>')
    -- map('n', 'gzD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
    -- map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')


    -- Text object
    map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

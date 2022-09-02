local status, lspsaga = pcall(require, 'lspsaga')
if (not status) then return end

lspsaga.init_lsp_saga{
  diagnostic_header = { " ", " ", " ", "ﴞ " },
  code_action_icon = "",
  code_action_keys = {
    quit = "q",
    exec = "<CR>",
  },
  finder_action_keys = {
    open = "<CR>",
    vsplit = "v",
    split = "w",
    tabe = "t",
    quit = { "q", "<Esc>" },
    scroll_down = { "<C-f>", "<C-d>" },
    scroll_up = { "<C-b>", "<C-u>" },
  }
}

local keymap = vim.keymap
local opts = { noremap=true, silent=true }
keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
keymap.set("i", "<C-k>", "<cmd>Lspsaga signature_help<CR>", opts)
keymap.set("n", "gd", "<cmd>Lspsaga lsp_finder<CR>", opts)
keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>", opts)
keymap.set("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
keymap.set("n", "gh", "<cmd>Lspsaga code_action<CR>", opts)
keymap.set("n", "gD", "<cmd>Lspsaga preview_definition<CR>", opts)

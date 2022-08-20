local status, substitute = pcall(require, "substitute")
if (not status) then return end

substitute.setup({
  range = {
    prefix = "S",
    prompt_current_text = true,
  }
})

local opts = { noremap=true, silent=true }
local keymap = vim.keymap

-- Substitute
keymap.set("n", "S", "<cmd>lua require('substitute').operator()<CR>", opts)
keymap.set("n", "SS", "<cmd>lua require('substitute').line()<CR>", opts)
keymap.set("x", "S", "<cmd>lua require('substitute').visual()<CR>", opts)

-- Exchange
keymap.set("n", "sx", "<cmd>lua require('substitute.exchange').operator()<CR>", opts)
keymap.set("n", "sxx", "<cmd>lua require('substitute.exchange').line()<CR>", opts)
keymap.set("x", "X", "<cmd>lua require('substitute.exchange').visual()<CR>", opts)
keymap.set("n", "sxc", "<cmd>lua require('substitute.exchange').cancel()<CR>", opts)

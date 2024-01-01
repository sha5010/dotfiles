-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

augroup("CloseQuickFix", {})
autocmd("FileType", {
  group = "CloseQuickFix",
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "q", "<cmd>quit<CR>", {
      buffer = true,
      silent = true,
    })
  end,
})

augroup("FixConcealForJson", {})
autocmd("FileType", {
  pattern = { "json", "jsonc" },
  callback = function()
    vim.wo.spell = false
    vim.wo.conceallevel = 0
  end,
})

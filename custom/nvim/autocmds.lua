local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local M = {}

function M.setup()
  augroup('HighlightYank', {})
  autocmd('TextYankPost', {
    group = 'HighlightYank',
    callback = function() vim.highlight.on_yank{timeout=500} end
  })
end

return M

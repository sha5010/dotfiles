local M = {}

M.mappings = require("custom.mappings")
M.plugins = require("custom.plugins")
M.ui = require("custom.highlights")

if vim.g.vscode ~= nil then
  M.mappings = require("custom.vscode")
end

return M

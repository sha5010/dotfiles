local M = {}

M.mappings = require("custom.mappings")
M.ui = require("custom.ui")
M.plugins = "custom.plugins"

if vim.g.vscode ~= nil then
  local vscode = require("custom.vscode")
  for mode, tbl in pairs(vscode) do
    for k, v in pairs(tbl) do
      M.mappings.general[mode][k] = v
    end
  end
end

return M

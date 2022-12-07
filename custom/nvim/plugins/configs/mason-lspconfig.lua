-- load lspconfig
local status, lspconfig = pcall(require, "lspconfig")
if (not status) then return end

-- load mason-lspconfig
local status, mason_lspconfig = pcall(require, "mason-lspconfig")
if (not status) then return end

mason_lspconfig.setup_handlers({ function(server)
  local opts = require("custom.plugins.configs.lspconfig")
  lspconfig[server].setup(opts)
end })


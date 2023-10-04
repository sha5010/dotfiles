local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup_handlers({ function(server)
  local configs = require("plugins.configs.lspconfig")
  local on_attach = configs.on_attach
  local capabilities = configs.capabilities

  local opts = {
    on_attach = function(client, bufnr)
      -- on_attach(client, bufnr)

      local status, lsp_signature = pcall(require, "lsp_signature")
      if (status) then
        lsp_signature.on_attach({
          bind = true,
          handler_opts = {
            border = "rounded",
          },
          max_width = 80,
          max_height = 4,
          zindex = 40,
          timer_interval = 100,
          hint_prefix = " ",
        }, bufnr)
      end
    end,
    capabilities = capabilities,
  }
  lspconfig[server].setup(opts)
end })


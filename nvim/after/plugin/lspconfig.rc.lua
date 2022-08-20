-- load lspconfig
local status, lspconfig = pcall(require, "lspconfig")
if (not status) then return end

-- load mason
local status, mason = pcall(require, "mason")
if (not status) then return end

-- load mason-lspconfig
local status, mason_lspconfig = pcall(require, "mason-lspconfig")
if (not status) then return end

mason.setup()
mason_lspconfig.setup_handlers({ function(server)
  local opts = {}

  opts.on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)

    -- formatting
    if client.server_capabilities.document_formatting then
      vim.api.nvim_command [[augroup Format]]
      vim.api.nvim_command [[autocmd! * <buffer>]]
      vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
      vim.api.nvim_command [[augroup END]]
    end
  end

  local status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if (status) then
    opts.capabilities = cmp_nvim_lsp.update_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )
  end

  lspconfig[server].setup(opts)
end })

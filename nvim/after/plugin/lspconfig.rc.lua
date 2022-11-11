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
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)

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
    opts.capabilities = cmp_nvim_lsp.default_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )
  end

  lspconfig[server].setup(opts)
end })

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    update_in_insert = false,
    virtual_text = { spacing = 4 },
    severity_sort = true,
  }
)

-- Diagnostics symbols in the sign column (gutter)
local signs = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " ",
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = ""})
end

vim.diagnostic.config({
  virtual_text = {
    prefix = '●'
  },
  update_in_insert = true,
  float = {
    source = "always", -- Or "if_many"
  },
})

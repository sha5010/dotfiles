local status, null_ls = pcall(require, "null-ls")
if not status then
  return
end

require("mason-null-ls").setup({
  automatic_setup = true,
})
require("mason-null-ls").setup_handlers({})
null_ls.setup()

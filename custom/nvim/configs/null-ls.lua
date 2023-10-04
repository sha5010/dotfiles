local status, null_ls = pcall(require, "null-ls")
if not status then
  return
end

require("mason").setup()
require("mason-null-ls").setup({
  handlers = {},
})
null_ls.setup()

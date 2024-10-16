-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.clipboard = "" -- Do not sync with system clipboard
opt.fileencodings = "ucs-bom,utf-8,cp932,euc-jp,latin"
opt.fixendofline = false
opt.inccommand = "split"
opt.winhighlight = "Normal:ActiveWindow,NormalNC:InactiveWindow"
opt.spelllang:append("cjk")

-- win32yank config
if vim.fn.executable("win32yank") == 1 then
  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = "win32yank -i --crlf",
      ["*"] = "win32yank -i --crlf",
    },
    paste = {
      ["+"] = "win32yank -o --crlf",
      ["*"] = "win32yank -o --crlf",
    },
    cache_enabled = 0,
  }
end

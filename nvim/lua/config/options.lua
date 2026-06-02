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
opt.guifont = "PlemolJP Console NF,BIZ UDゴシック:h12"

-- win32yank config
local is_wsl = os.getenv("WSLENV") ~= nil or os.getenv("WSL_DISTRO_NAME") ~= nil or os.getenv("WSL_INTEROP") ~= nil
if is_wsl and vim.fn.executable("win32yank") == 1 then
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

-- Neovide config
if vim.g.neovide then
  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_short_animation_length = 0.0
  vim.g.neovide_scroll_animation_length = 0.1
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_remember_window_size = true

  -- IME setting
  local function set_ime(args)
    if args.event:match("Enter$") then
      vim.g.neovide_input_ime = true
    else
      vim.g.neovide_input_ime = false
    end
  end

  local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })

  vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
    group = ime_input,
    pattern = "*",
    callback = set_ime,
  })

  vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
    group = ime_input,
    pattern = "[/\\?]",
    callback = set_ime,
  })
end

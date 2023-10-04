local opt = vim.opt  -- for conciseness

-- line numbers
opt.number = true
opt.relativenumber = true

-- tabs & indentation
opt.expandtab = true
opt.autoindent = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

-- search settings
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"

-- encodings
opt.fileencodings = "ucs-bom,utf-8,cp932,euc-jp,latin"
opt.encoding = "utf-8"
opt.fixeol = false

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.scrolloff = 5
opt.lazyredraw = true
opt.cursorline = true
opt.updatetime = 500
opt.pumheight = 12
opt.winhighlight = "Normal:ActiveWindow,NormalNC:InactiveWindow"


-- split winodws
opt.splitright = true
opt.splitbelow = true

-- mouse
opt.mouse = "a"

-- clipboard
opt.clipboard = ""

-- key
opt.whichwrap = "b,s"
opt.timeoutlen = 1000


-- autocommands
require('custom.autocmds').setup()

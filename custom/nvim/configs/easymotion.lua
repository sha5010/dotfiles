-- global setting
vim.g.EasyMotion_do_mapping = 0
vim.g.EasyMotion_smartcase = 1
vim.g.EasyMotion_use_smartsign_jp = 1
vim.g.EasyMotion_use_migemo = 1
vim.g.EasyMotion_verbose = 0

require("core.utils").load_mappings("easymotion")

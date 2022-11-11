local status, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

treesitter_configs.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "python",
    "php",
    "html",
    "css",
    "c",
    "cpp",
    "lua",
    "go",
    "vim",
    "json",
    "yaml",
    "toml",
    "ruby",
    "rust",
    "regex",
    "comment",
    "markdown",
    "javascript",
    "dockerfile"
  },
  sync_install = true,
  auto_install = true,
  autotag = {
    enable = true,
  },
}

-- vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldenable = false

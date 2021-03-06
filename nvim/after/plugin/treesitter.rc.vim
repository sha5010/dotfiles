if !exists('g:loaded_nvim_treesitter')
  finish
endif

lua << EOF
local status, treesitter_configs = pcall(require, "nvim-treesitter.configs")
treesitter_configs.setup {
  -- ensure_installed = "maintained",
  -- sync_install = false,
  -- ignore_install = {},
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
  }
}
EOF

" folding setting
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

syntax enable

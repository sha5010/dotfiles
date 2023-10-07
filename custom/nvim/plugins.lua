-- windows environment
local is_wsl = os.getenv('WSLENV') ~= nil or os.getenv('WSL_DISTRO_NAME') ~= nil or os.getenv('WSL_INTEROP') ~= nil
local is_windows = vim.fn.has('win32') ~= 0 or vim.fn.has('win64') ~= 0 or is_wsl

-- fcitx-remote exists
local has_fcitx = vim.fn.executable("fcitx-remote") == 1

-- vscode judge
local cond_vscode = (function()
  if vim.g.vscode == nil then
    return true
  else
    return false
  end
end)

return {
  -- disable nvterm
  {
    "NvChad/nvterm",
    enabled = false,
  },

  -- lsp related stuff
  {
    "williamboman/mason.nvim",
    cond = cond_vscode,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      require("custom.configs.mason-lspconfig")
    end,
    cond = cond_vscode,
  },

  {
    "neovim/nvim-lspconfig",
    init = function()
      require("core.utils").lazy_load "nvim-lspconfig"
      if vim.g.vscode == nil then require("core.utils").load_mappings("lspconfig") end
    end,
    dependencies = "williamboman/mason-lspconfig.nvim",
    cond = cond_vscode,
  },

  -- lsp signature
  {
    "ray-x/lsp_signature.nvim",
    event = "LspAttach",
    cond = cond_vscode,
  },

  -- lsp ui
  {
    "glepnir/lspsaga.nvim",
    cmd = "Lspsaga",
    config = function()
      require("custom.configs.others").lspsaga()
    end,
    init = function()
      if vim.g.vscode == nil then require("core.utils").load_mappings("lspsaga") end
    end,
    cond = cond_vscode,
  },

  -- vscode like breadcrumbs
  {
    "utilyre/barbecue.nvim",
    event = "LspAttach",
    dependencies = {
      { "smiteshp/nvim-navic" },
    },
    config = function()
      require("barbecue").setup()
      require("barbecue.ui").update()
    end,
    init = function()
      require("core.utils").lazy_load "barbecue.nvim"
    end,
    cond = cond_vscode,
  },

  -- diagnostics result list
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleClose", "TroubleToggle", "TroubleRefresh" },
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("trouble").setup()
    end,
    init = function()
      if vim.g.vscode == nil then require("core.utils").load_mappings("trouble") end
    end,
    cond = cond_vscode,
  },

  -- lsp progress
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    tag = "legacy",
    config = function()
      require("fidget").setup()
    end,
    init = function()
      require("core.utils").lazy_load "fidget.nvim"
    end,
    cond = cond_vscode,
  },

  -- linter, formatter
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "jayp0521/mason-null-ls.nvim",
        dependencies = "williamboman/mason.nvim",
      },
    },
    config = function()
      require("custom.configs.null-ls")
    end,
    init = function()
      require("core.utils").lazy_load "null-ls.nvim"
    end,
    cond = cond_vscode,
  },

  -- more highlight
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      auto_install = true,
      ensure_installed = {
        "markdown",
        "markdown_inline",
      },
      indent = {
        enable = false,
      },
    },
    cond = cond_vscode
  },

  -- make quickfix better
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require('bqf').setup()
    end,
    cond = cond_vscode,
  },

  -- tabline
  {
    "akinsho/bufferline.nvim",
    event = { "VeryLazy" },
    config = function()
      require("custom.configs.bufferline")
    end,
    init = function()
      if vim.g.vscode == nil then require("core.utils").load_mappings("bufferline") end
    end,
    cond = cond_vscode,
  },

  -- git status signs
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add    = { text = "▎", },
        change = { text = "▎", },
      },
    },
    cond = cond_vscode,
  },

  -- git diff view
  {
    "sindrets/diffview.nvim",
    dependencies = "plenary.nvim",
    cmd = { "DiffviewOpen", "DiffviewToggleFiles", "DiffviewFileHistory"},
    config = function()
      require("diffview").setup({})
    end,
    init = function()
      if vim.g.vscode == nil then require("core.utils").load_mappings("diffview") end
    end,
    cond = cond_vscode,
  },

  -- git interface
  {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    config = function()
      require("neogit").setup()
    end,
    init = function()
      if vim.g.vscode == nil then require("core.utils").load_mappings("neogit") end
    end,
    cond = cond_vscode,
  },

  -- suggest
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      return require("custom.configs.cmp").setup()
    end,
    cond = cond_vscode,
  },

  -- suggest in cmdline
  {
    "hrsh7th/cmp-cmdline",
    event = "CmdlineEnter",
    dependencies = "hrsh7th/nvim-cmp",
    config = function()
      require("custom.configs.cmp").cmp_cmdline()
    end,
    cond = cond_vscode,
  },

  -- indentation style detection
  {
    "nmac427/guess-indent.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("guess-indent").setup({})
    end,
    cond = cond_vscode,
  },

  -- filer
  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      return require("custom.configs.nvim-tree")
    end,
    cond = cond_vscode,
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      return require("custom.configs.telescope")
    end,
    init = function()
      if vim.g.vscode == nil then require("core.utils").load_mappings("telescope") end
    end,
    cond = cond_vscode,
  },

  -- autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = function()
      require("custom.configs.others").autopairs()
    end,
    cond = cond_vscode,
  },

  -- tag autopairs
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "svelte",
      "vue",
      "tsx",
      "jsx",
      "rescript",
      "xml",
      "php",
      "markdown",
      "glimmer",
      "handlebars",
      "hbs",
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
    cond = cond_vscode,
  },

  -- colorizer
  {
    "NvChad/nvim-colorizer.lua",
    opts = function()
      return require("custom.configs.others").colorizer()
    end,
    init = function()
      require("core.utils").lazy_load "nvim-colorizer.lua"
    end,
    cond = cond_vscode,
  },

  -- terminal
  {
    "akinsho/toggleterm.nvim",
    keys = { "<C-t>" },
    cmd = { "ToggleTerm" },
    config = function()
      require("custom.configs.toggleterm")
    end,
    cond = cond_vscode,
  },

  -- incremental & decremental
  {
    "monaqa/dial.nvim",
    config = function()
      require("custom.configs.dial")
    end,
    init = function()
      require("core.utils").load_mappings("dial")
    end,
  },

  -- ime support for mac
  {
    "brglng/vim-im-select",
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      vim.g.im_select_default = "com.google.inputmethod.Japanese.Roman"
    end,
    enabled = not is_windows and not has_fcitx,
  },

  -- ime support for windows and wsl
  {
    "kaz399/spzenhan.vim",
    event = { "InsertEnter", "CmdlineEnter" },
    init = function()
      require('custom.configs.spzenhan')
    end,
    enabled = is_windows,
  },

  -- status line
  {
    "nvim-lualine/lualine.nvim",
    event = { "VeryLazy" },
    init = function()
      require("base46").load_all_highlights()
    end,
    config = function()
      require("custom.configs.lualine")
    end,
    cond = cond_vscode,
  },

  -- yank text and macro history
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      "nvim-telescope/telescope.nvim"
    },
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("custom.configs.others").neoclip()
    end,
    init = function()
      if vim.g.vscode == nil then require("core.utils").load_mappings("neoclip") end
    end,
    cond = cond_vscode,
  },

  -- operator for substitute
  {
    "gbprod/substitute.nvim",
    config = function()
      require("custom.configs.others").substitute()
    end,
    init = function()
      require("core.utils").load_mappings("substitute")
    end,
  },

  -- surround text object
  {
    "kylechui/nvim-surround",
    version = "*",
    keys = {
      { "sa" , mode = { "n", "x" } },
      { "sA" , mode = { "n", "x" } },
      { "sd" },
      { "sr" },
      { "<C-g>s", mode = "i" },
      { "<C-g>S", mode = "i" },
    },
    config = function()
      require("custom.configs.others").surround()
    end,
  },

  -- undo history graph
  {
    "mbbill/undotree",
    cmd = { "UndotreeToggle", "UndotreeShow" },
    init = function()
      if vim.g.vscode == nil then require("core.utils").load_mappings("undotree") end
    end,
    cond = cond_vscode,
  },

  -- fast motion
  {
    "easymotion/vim-easymotion",
    event = { "BufReadPre", "BufNewFile" },
    init = function()
      require("custom.configs.others").easymotion()
    end,
    cond = cond_vscode,
  },

  -- easymotion for vscode
  {
    "asvetliakov/vim-easymotion",
    name = "vscode-easymotion",
    cond = function()
      return vim.g.vscode ~= nil
    end,
  },

  -- smart words moving
  {
    "kana/vim-smartword",
    keys = {
      { "w", "<Plug>(smartword-w)", mode = {"n", "x"}, desc = "smartword-w" },
      { "e", "<Plug>(smartword-e)", mode = {"n", "x"}, desc = "smartword-e" },
      { "b", "<Plug>(smartword-b)", mode = {"n", "x"}, desc = "smartword-b" },
      { "ge","<Plug>(smartword-ge)",mode = {"n", "x"}, desc = "smartword-ge"},
    },
  },

  -- run program quickly
  {
    "thinca/vim-quickrun",
    cmd = { "QuickRun" },
    dependencies = "lambdalisue/vim-quickrun-neovim-job",
    init = function()
      require("custom.configs.quickrun").setup()
    end,
    config = function()
      require("custom.configs.quickrun").config()
    end,
    cond = cond_vscode,
  },

  -- disable in vscode
  { "rafamadriz/friendly-snippets", cond = cond_vscode },
  { "nvim-tree/nvim-web-devicons", cond = cond_vscode },
  { "numToStr/Comment.nvim", cond = cond_vscode },
  { "NvChad/base46", cond = cond_vscode },
  { "NvChad/ui", cond = cond_vscode },
  { "folke/which-key.nvim", cond = cond_vscode },
  { "lukas-reineke/indent-blankline.nvim", cond = cond_vscode },
}

-- windows environment
local is_wsl = os.getenv('WSLENV') ~= nil or os.getenv('WSL_DISTRO_NAME') ~= nil or os.getenv('WSL_INTEROP') ~= nil
local is_windows = vim.fn.has('win32') ~= 0 or vim.fn.has('win64') ~= 0 or is_wsl

-- fcitx-remote exists
local has_fcitx = vim.fn.executable("fcitx-remote") == 1

-- vscode judge
local cond_vscode = (function()
  if vim.g.vscode == nil then
    return nil
  else
    return false
  end
end)

return {
  -- remove from NvChad
  ["NvChad/nvterm"] = false,

  -- make base46 optional
  ["NvChad/base46"] = {
    module = "base46",
    cond = cond_vscode,
  },

  -- disable tabufline and statusline
  ["NvChad/ui"] = {
    module = "nvchad_ui",
    config = function() end,
    cond = cond_vscode,
  },

  -- enable which-key
  ["folke/which-key.nvim"] = {
    disable = false,
    cond = cond_vscode,
  },

  -- lsp related stuff
  ["williamboman/mason.nvim"] = {
    cmd = false,
    module = "mason",
    after = { "null-ls.nvim", "mason-lspconfig.nvim" },
    cond = cond_vscode,
  },

  ["williamboman/mason-lspconfig.nvim"] = {
    opt = true,
    wants = { "mason.nvim", "nvim-lspconfig" },
    module = "mason-lspconfig",
    config = function()
      require("custom.plugins.configs.mason-lspconfig")
    end,
    setup = function()
      require("custom.utils").packer_lazy_load("mason-lspconfig.nvim", 100)
    end,
    cond = cond_vscode,
  },

  ["neovim/nvim-lspconfig"] = {
    module = "lspconfig",
    config = function()
      require("custom.plugins.configs.lspconfig")
    end,
    cond = cond_vscode,
  },

  -- lsp signature
  ["ray-x/lsp_signature.nvim"] = {
    opt = true,
    module = "lsp_signature",
    wants = "nvim-lspconfig",
    cond = cond_vscode,
  },

  -- lsp ui
  ["glepnir/lspsaga.nvim"] = {
    opt = true,
    wants = "nvim-lspconfig",
    cmd = "Lspsaga",
    config = function()
      require("custom.plugins.configs.others").lspsaga()
    end,
    setup = function()
      if vim.g.vscode == nil then require("core.utils").load_mappings("lspsaga") end
    end,
    cond = cond_vscode,
  },

  -- vscode like breadcrumbs
  ["utilyre/barbecue.nvim"] = {
    opt = true,
    wants = {
      "nvim-lspconfig",
      "nvim-navic",
    },
    module = "barbecue",
    requires = {
      { "smiteshp/nvim-navic", opt = true },
    },
    config = function()
      require("barbecue").setup()
      require("barbecue.ui").update()
    end,
    setup = function()
      require("custom.utils").packer_lazy_load("barbecue.nvim", 250)
    end,
    cond = cond_vscode,
  },

  -- diagnostics result list
  ["folke/trouble.nvim"] = {
    opt = true,
    cmd = { "Trouble", "TroubleClose", "TroubleToggle", "TroubleRefresh" },
    wants = "nvim-web-devicons",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require("trouble").setup()
    end,
    setup = function()
      if vim.g.vscode == nil then require("core.utils").load_mappings("trouble") end
    end,
    cond = cond_vscode,
  },

  -- lsp progress
  ["j-hui/fidget.nvim"] = {
    opt = true,
    wants = "nvim-lspconfig",
    module = "fidget",
    config = function()
      require("fidget").setup()
    end,
    setup = function()
      require("custom.utils").packer_lazy_load("fidget.nvim", 200)
    end,
    cond = cond_vscode,
  },

  -- linter, formatter
  ["jose-elias-alvarez/null-ls.nvim"] = {
    opt = true,
    wants = {
      "mason.nvim",
      "mason-null-ls.nvim",
    },
    requires = {
      { "jayp0521/mason-null-ls.nvim", opt = true, module = "mason-null-ls" },
    },
    module = "null-ls",
    config = function()
      require("custom.plugins.configs.null-ls")
    end,
    setup = function()
      require("custom.utils").packer_lazy_load("null-ls.nvim", 150)
    end,
    cond = cond_vscode,
  },

  -- more highlight
  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = {
      auto_install = true,
    },
    cond = cond_vscode
  },

  -- make quickfix better
  ["kevinhwang91/nvim-bqf"] = {
    opt = true,
    ft = "qf",
    config = function()
      require('bqf').setup()
    end,
    cond = cond_vscode,
  },

  -- tabline
  ["akinsho/bufferline.nvim"] = {
    opt = true,
    wants = "base46",
    module = "bufferline",
    config = function()
      require("custom.plugins.configs.bufferline")
    end,
    setup = function()
      require("custom.utils").packer_lazy_load("bufferline.nvim", 50)
      if vim.g.vscode == nil then require("core.utils").load_mappings("bufferline") end
    end,
    cond = cond_vscode,
  },

  -- git status signs
  ["lewis6991/gitsigns.nvim"] = {
    override_options = {
      signs = {
        add    = { text = "▍", },
        change = { text = "▍", },
      },
    },
    cond = cond_vscode
  },

  -- git diff view
  ["sindrets/diffview.nvim"] = {
    opt = true,
    requires = "plenary.nvim",
    cmd = { "DiffviewOpen", "DiffviewToggleFiles", "DiffviewFileHistory"},
    config = function()
      require("diffview").setup({})
    end,
    setup = function()
      if vim.g.vscode == nil then require("core.utils").load_mappings("diffview") end
    end,
    cond = cond_vscode,
  },

  -- suggest
  ["hrsh7th/nvim-cmp"] = {
    module = "cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    override_options = function()
      return require("custom.plugins.configs.cmp").setup()
    end,
    cond = cond_vscode,
  },

  -- suggest in cmdline
  ["hrsh7th/cmp-cmdline"] = {
    opt = true,
    event = "CmdlineEnter",
    wants = "nvim-cmp",
    config = function()
      require("custom.plugins.configs.cmp").cmp_cmdline()
    end,
    cond = cond_vscode,
  },

  -- indentation style detection
  ["nmac427/guess-indent.nvim"] = {
    opt = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("guess-indent").setup({})
    end,
    cond = cond_vscode,
  },

  -- filer
  ["kyazdani42/nvim-tree.lua"] = {
    override_options = function()
      return require("custom.plugins.configs.others").nvimtree()
    end,
    cond = cond_vscode,
  },

  -- fuzzy finder
  ["nvim-telescope/telescope.nvim"] = {
    override_options = function()
      return require("custom.plugins.configs.telescope")
    end,
    setup = function()
      if vim.g.vscode == nil then require("core.utils").load_mappings("telescope") end
    end,
    cond = cond_vscode,
  },

  -- autopairs
  ["windwp/nvim-autopairs"] = {
    event = "InsertEnter",
    override_options = function()
      require("custom.plugins.configs.others").autopairs()
    end,
    cond = cond_vscode,
  },

  -- indent guide
  ["lukas-reineke/indent-blankline.nvim"] = {
    module = "indent_blankline",
    cond = cond_vscode
  },

  -- tag autopairs
  ["windwp/nvim-ts-autotag"] = {
    opt = true,
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
  ["NvChad/nvim-colorizer.lua"] = {
    module = "colorizer",
    override_options = function()
      return require("custom.plugins.configs.others").colorizer()
    end,
    setup = function()
      require("custom.utils").packer_lazy_load("nvim-colorizer.lua", 300)
    end,
    cond = cond_vscode,
  },

  -- highlight search
  ["kevinhwang91/nvim-hlslens"] = {
    opt = true,
    module = "hlslens",
    event = "CmdlineEnter",
    keys = { {"n", "/"}, {"n", "?"}, },
    setup = function()
      if vim.g.vscode == nil then require("core.utils").load_mappings("hlslens") end
    end,
    config = function()
      require("custom.plugins.configs.others").hlslens()
    end,
    cond = cond_vscode,
  },

  -- scrollbar
  ["petertriho/nvim-scrollbar"] = {
    opt = true,
    event = {
      "BufWinEnter",
      "TabEnter",
      "TermEnter",
      "WinEnter",
      "CmdwinLeave",
      "TextChanged",
      "VimResized",
      "WinScrolled",
      "BufWinLeave",
      "TabLeave",
      "TermLeave",
      "WinLeave",
    },
    requires = { "lewis6991/gitsigns.nvim", opt = true },
    wants = { "gitsigns.nvim", "base46" },
    config = function()
      require("custom.plugins.configs.others").scrollbar()
    end,
    cond = cond_vscode,
  },

  -- find & replace
  ["VonHeikemen/searchbox.nvim"] = {
    opt = true,
    module = "searchbox",
    command = "SearchBox",
    requires = { "MunifTanjim/nui.nvim" },
    setup = function()
      if vim.g.vscode == nil then require("core.utils").load_mappings("searchbox") end
    end,
    cond = cond_vscode,
  },

  -- terminal
  ["akinsho/toggleterm.nvim"] = {
    opt = true,
    module = "toggleterm",
    keys = { "<C-t>" },
    config = function()
      require("custom.plugins.configs.toggleterm")
    end,
    cond = cond_vscode,
  },

  -- incremental & decremental
  ["monaqa/dial.nvim"] = {
    opt = true,
    module = "dial",
    config = function()
      require("custom.plugins.configs.dial")
    end,
    setup = function()
      require("core.utils").load_mappings("dial")
    end,
  },

  -- ime support for mac
  ["brglng/vim-im-select"] = {
    opt = true,
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      vim.g.im_select_default = "com.google.inputmethod.Japanese.Roman"
    end,
    disable = is_windows or has_fcitx,
  },

  -- ime suppoert for windows and wsl
  ["kaz399/spzenhan.vim"] = {
    opt = true,
    setup = function()
      require('custom.plugins.configs.spzenhan')
    end,
    disable = not is_windows,
  },

  -- status line
  ["nvim-lualine/lualine.nvim"] = {
    opt = true,
    wants = "base46",
    config = function()
      require("custom.plugins.configs.lualine")
    end,
    cond = cond_vscode,
  },

  -- yank text and macro history
  ["AckslD/nvim-neoclip.lua"] = {
    opt = true,
    requires = { "nvim-telescope/telescope.nvim", opt = true },
    event = { "CursorMoved", "CursorHold" },
    config = function()
      require("custom.plugins.configs.others").neoclip()
    end,
    setup = function()
      if vim.g.vscode == nil then require("core.utils").load_mappings("neoclip") end
    end,
    cond = cond_vscode,
  },

  -- operator for substitute
  ["gbprod/substitute.nvim"] = {
    opt = true,
    module = "substitute",
    config = function()
      require("custom.plugins.configs.others").substitute()
    end,
    setup = function()
      require("core.utils").load_mappings("substitute")
    end,
  },

  -- surround text object
  ["kylechui/nvim-surround"] = {
    opt = true,
    keys = {
      { "n", "sa" },
      { "n", "sA" },
      { "n", "sd" },
      { "n", "sr" },
      { "i", "<C-g>s" },
      { "i", "<C-g>S" },
      { "x", "sa" },
      { "x", "sA" },
    },
    config = function()
      require("custom.plugins.configs.others").surround()
    end,
  },

  -- undo history graph
  ["mbbill/undotree"] = {
    opt = true,
    cmd = { "UndotreeToggle", "UndotreeShow" },
    setup = function()
      if vim.g.vscode == nil then require("core.utils").load_mappings("undotree") end
    end,
    cond = cond_vscode,
  },

  -- fast motion
  ["easymotion/vim-easymotion"] = {
    opt = true,
    event = { "CursorMoved", "CursorHold" },
    setup = function()
      require("custom.plugins.configs.others").easymotion()
    end,
    cond = cond_vscode,
  },

  -- easymotion for vscode
  ["asvetliakov/vim-easymotion"] = {
    opt = true,
    as = "vscode-easymotion",
    cond = function()
      return vim.g.vscode ~= nil
    end,
  },

  -- run program quickly
  ["thinca/vim-quickrun"] = {
    opt = true,
    cmd = { "QuickRun" },
    requires = "lambdalisue/vim-quickrun-neovim-job",
    setup = function()
      require("custom.plugins.configs.quickrun").setup()
    end,
    config = function()
      require("custom.plugins.configs.quickrun").config()
    end,
    cond = cond_vscode,
  },

  -- disable default plugins in vscode
  ["NvChad/extensions"] = { cond = cond_vscode },
  ["rafamadriz/friendly-snippets"] = { cond = cond_vscode },
  ["kyazdani42/nvim-web-devicons"] = { after = false, cond = cond_vscode },
  ["numToStr/Comment.nvim"] = { cond = cond_vscode },
}

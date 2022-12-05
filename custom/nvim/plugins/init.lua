-- windows environment
local is_wsl = os.getenv('WSLENV') ~= nil or os.getenv('WSL_DISTRO_NAME') ~= nil or os.getenv('WSL_INTEROP') ~= nil
local is_windows = vim.fn.has('win32') ~= 0 or vim.fn.has('win64') ~= 0 or is_wsl

-- vscode judge
local cond_vscode = (function()
  if vim.g.vscode == nil then
    return nil
  else
    return false
  end
end)

-- easymotion setting
local easymotion_setting = function()
  vim.g.EasyMotion_do_mapping = 0
  vim.g.EasyMotion_smartcase = 1
  vim.g.EasyMotion_use_smartsign_jp = 1
  vim.g.EasyMotion_use_migemo = 1
  vim.g.EasyMotion_verbose = 0

  require("core.utils").load_mappings("easymotion")
end

return {
  -- remove from NvChad
  ["NvChad/nvterm"] = false,

  -- disable tabufline and statusline
  ["NvChad/ui"] = {
    after = false,
    override_options = {
      tabufline = { enabled = false },
      statusline = {
        separator_style = "block",
        overriden_modules = function()
          return require("custom.plugins.configs.ui")
        end,
      },
    },
  },

  -- enable which-key
  ["folke/which-key.nvim"] = {
    disable = false,
    cond = cond_vscode,
  },

  -- lsp related stuff
  ["williamboman/mason.nvim"] = {
    opt = true,
    config = function()
      require("mason").setup()
    end,
    setup = function()
      require("custom.utils").packer_lazy_load("mason.nvim", 1000)
      -- reload the current file so lsp actually starts for it
      vim.defer_fn(function()
        vim.cmd('if &ft == "packer" | echo "" | else | silent! e %')
      end, 0)
    end,
    cond = cond_vscode,
  },

  ["williamboman/mason-lspconfig.nvim"] = {
    opt = true,
    after = "mason.nvim",
    module = "mason-lspconfig",
    config = function()
      require("custom.plugins.configs.mason-lspconfig")
    end,
  },

  ["neovim/nvim-lspconfig"] = {
    after = "mason.nvim",
  },

  ["ray-x/lsp_signature.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require("lsp_signature").setup({
        bind = false,
        handler_opts = {
          border = "rounded",
        },
        max_width = 80,
        max_height = 4,
        zindex = 40,
        timer_interval = 100,
        hint_prefix = " ",
      })
    end,
  },

  ["glepnir/lspsaga.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require("lspsaga").init_lsp_saga({
        max_preview_lines = 50,
        code_action_keys = {
          quit = "q",
          exec = "<CR>",
        },
        finder_action_keys = {
          open = "<CR>",
          vsplit = "v",
          split = "w",
          tabe = "t",
          quit = { "q", "<Esc>" },
          scroll_down = { "<C-f>", "<C-d>" },
          scroll_up = { "<C-b>", "<C-u>" },
        },
      })
    end,
    setup = function()
      if vim.g.vscode == nil then require("core.utils").load_mappings("lspsaga") end
    end,
  },

  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = {
      "mason.nvim",
    },
    requires = {
      { "jayp0521/mason-null-ls.nvim" },
    },
    config = function()
      require("mason-null-ls").setup({
        automatic_setup = true,
      })
      require("mason-null-ls").setup_handlers({})
      require("null-ls").setup()
    end,
  },

  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = {
      auto_install = true,
    },
    cond = cond_vscode
  },

  ["akinsho/bufferline.nvim"] = {
    after = "base46",
    config = function()
      require("custom.plugins.configs.bufferline")
    end,
    setup = function()
      if vim.g.vscode == nil then require("core.utils").load_mappings("bufferline") end
    end,
  },

  ["lewis6991/gitsigns.nvim"] = {
    override_options = {
      signs = {
        add = {
          text = "▍",
        },
        change = {
          text = "▍",
        },
      },
    },
    cond = cond_vscode
  },

  -- update cmp key mapping
  ["hrsh7th/nvim-cmp"] = {
    override_options = function()
      local cmp = require("cmp")
      return {
        mapping = {
          ["<CR>"] = cmp.mapping(
            cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = false,
            }),
            { "i", "c" }
          ),
        },
        sources = {
          { name = "luasnip" },
          { name = "nvim_lsp" },
          {
            name = "buffer", 
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end
            }
          },
          { name = "nvim_lua" },
          { name = "path" },
        }
      }
    end,
    setup = function()
      if vim.g.vscode == nil then require("custom.utils").packer_lazy_load("nvim-cmp", 0) end
    end,
  },

  ["hrsh7th/cmp-cmdline"] = {
    after = "cmp-path",
    config = function()
      require("custom.plugins.configs.cmp_cmdline")
    end,
  },

  ["nmac427/guess-indent.nvim"] = {
    config = function()
      require("guess-indent").setup({})
    end,
  },

  ["windwp/nvim-autopairs"] = {
    override_options = {
      disable_filetype = { "TelescopePrompt" },
      check_ts = true, -- use treesitter to check for a pair
      fast_wrap = {
        map = "<C-q>",
        chars = { "{", "[", "(", '"', "'", "`" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,%s] ]], "%s+", ""),
        offset = -1, -- Offset from pattern match
        end_key = ";",
        keys = "asdghklqwertyuiopzxcvbnmfj",
        check_comma = true,
        highlight = "Search",
        highlight_grey = "Comment",
      },
    },
  },

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

  ["NvChad/nvim-colorizer.lua"] = {
    override_options = {
      filetypes = {
        "*",
        css = { css = true },
        html = { css = true, tailwind = true },
        php = { css = true, tailwind = true },
      },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue or blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = false, -- CSS rgb() and rgba() functions
        hsl_fn = false, -- CSS hsl() and hsla() functions
        css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "background", -- Set the display mode.
        -- Available methods are false / true / "normal" / "lsp" / "both"
        -- True is same as normal
        tailwind = false, -- Enable tailwind colors
        virtualtext = "■",
      },
      -- all the sub-options of filetypes apply to buftypes
      buftypes = {
        "*",
        "!prompt",
        "!popup",
        "!terminal",
        "!nofile",
      },
    },
    cond = cond_vscode,
  },

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

  ["akinsho/toggleterm.nvim"] = {
    opt = true,
    module = "toggleterm",
    keys = { "<C-t>" },
    config = function()
      require("custom.plugins.configs.toggleterm")
    end,
    cond = cond_vscode,
  },

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

  ["brglng/vim-im-select"] = {
    opt = true,
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      vim.g.im_select_default = "com.google.inputmethod.Japanese.Roman"
    end,
    disable = true,
  },

  ["kaz399/spzenhan.vim"] = {
    opt = true,
    setup = function()
      require('custom.plugins.configs.spzenhan')
    end,
    disable = not is_windows,
  },

  ["nvim-lualine/lualine.nvim"] = {
    opt = true,
    after = "ui",
    config = function()
      require("custom.plugins.configs.lualine")
    end,
    cond = cond_vscode,
  },

  ["gbprod/substitute.nvim"] = {
    opt = true,
    module = "substitute",
    config = function()
      require("substitute").setup({
        range = {
          prefix = "",
        },
      })
    end,
    setup = function()
      require("core.utils").load_mappings("substitute")
    end,
  },

  ["kylechui/nvim-surround"] = {
    opt = true,
    module = "nvim-surround",
    keys = {
      { "n", "sa" },
      { "n", "sa" },
      { "n", "sA" },
      { "n", "sd" },
      { "n", "sr" },
      { "i", "<C-g>s" },
      { "i", "<C-g>S" },
    },
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          normal = "sa",
          normal_cur = "saa",
          normal_line = "sA",
          normal_cur_line = "sAA",
          visual = "sa",
          visual_line = "sA",
          delete = "sd",
          change = "sr",
        },
      })
    end,
  },

  ["mbbill/undotree"] = {
    opt = true,
    cmd = { "UndotreeToggle", "UndotreeShow" },
    setup = function()
      if vim.g.vscode == nil then require("core.utils").load_mappings("undotree") end
    end,
    cond = cond_vscode,
  },

  ["easymotion/vim-easymotion"] = {
    opt = true,
    after = "ui",
    setup = easymotion_setting,
    cond = cond_vscode,
  },

  ["asvetliakov/vim-easymotion"] = {
    opt = true,
    after = "ui",
    as = "vscode-easymotion",
    cond = function()
      return vim.g.vscode ~= nil
    end,
  },

  ["thinca/vim-quickrun"] = {
    opt = true,
    cmd = { "QuickRun" },
    requires = "lambdalisue/vim-quickrun-neovim-job",
    setup = function()
      -- disable default keymaps
      vim.g.quickrun_no_default_key_mappings = 1

      vim.g.quickrun_config = {
        -- default config
        _ = {
          runner = "neovim_job",
        },
        python = {
          command = "python3",
          cmdopt = { "-u" },
          input = '%{filereadable("input") ? "input" : "="}',
        },
      }

      if vim.g.vscode == nil then require("core.utils").load_mappings("quickrun") end
    end,
    cond = cond_vscode,
  },

  -- disable default plugins in vscode
  ["NvChad/extensions"] = { cond = cond_vscode },
  ["kyazdani42/nvim-web-devicons"] = { cond = cond_vscode },
  ["lukas-reineke/indent-blankline.nvim"] = { cond = cond_vscode },
  ["numToStr/Comment.nvim"] = { cond = cond_vscode },
  ["kyazdani42/nvim-tree.lua"] = { cond = cond_vscode },
}

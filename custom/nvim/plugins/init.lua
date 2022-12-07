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
  ["NvChad/base46"] = {
    module = "base46",
    cond = cond_vscode,
  },

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
    event = { "BufReadPost", "BufNewFile" },
    after = { "null-ls.nvim", "mason-lspconfig.nvim" },
    cond = cond_vscode,
  },

  ["williamboman/mason-lspconfig.nvim"] = {
    opt = true,
    event = { "BufReadPost", "BufNewFile" },
    wants = { "mason.nvim", "nvim-lspconfig" },
    config = function()
      require("custom.plugins.configs.mason-lspconfig")
    end,
    cond = cond_vscode,
  },

  ["neovim/nvim-lspconfig"] = {
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("custom.plugins.configs.lspconfig")
    end,
    cond = cond_vscode,
  },

  ["ray-x/lsp_signature.nvim"] = {
    opt = true,
    module = "lsp_signature",
    wants = "nvim-lspconfig",
    cond = cond_vscode,
  },

  ["glepnir/lspsaga.nvim"] = {
    opt = true,
    wants = "nvim-lspconfig",
    cmd = "Lspsaga",
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
    cond = cond_vscode,
  },

  ["utilyre/barbecue.nvim"] = {
    opt = true,
    wants = {
      "nvim-lspconfig",
      "nvim-navic",
    },
    event = { "BufReadPost", "BufNewFile" },
    requires = {
      { "smiteshp/nvim-navic", opt = true },
    },
    config = function()
      require("barbecue").setup()
    end,
    cond = cond_vscode,
  },

  ["j-hui/fidget.nvim"] = {
    opt = true,
    wants = "nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("fidget").setup()
    end,
    cond = cond_vscode,
  },

  ["jose-elias-alvarez/null-ls.nvim"] = {
    opt = true,
    wants = {
      "mason.nvim",
      "mason-null-ls.nvim",
    },
    requires = {
      { "jayp0521/mason-null-ls.nvim", opt = true, module = "mason-null-ls" },
    },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("mason-null-ls").setup({
        automatic_setup = true,
      })
      require("mason-null-ls").setup_handlers({})
      require("null-ls").setup()
    end,
    cond = cond_vscode,
  },

  ["nvim-treesitter/nvim-treesitter"] = {
    event = { "BufReadPost", "BufNewFile" },
    override_options = {
      auto_install = true,
    },
    cond = cond_vscode
  },

  ["kevinhwang91/nvim-bqf"] = {
    opt = true,
    ft = "qf",
    config = function()
      require('bqf').setup()
    end,
    cond = cond_vscode,
  },

  ["akinsho/bufferline.nvim"] = {
    opt = true,
    wants = "base46",
    event = "VimEnter",
    config = function()
      require("custom.plugins.configs.bufferline")
    end,
    setup = function()
      if vim.g.vscode == nil then require("core.utils").load_mappings("bufferline") end
    end,
    cond = cond_vscode,
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

  -- update cmp key mapping
  ["hrsh7th/nvim-cmp"] = {
    module = "cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    override_options = function()
      local cmp = require("cmp")
      return {
        mapping = {
          ["<C-p>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item()
            else
              cmp.complete()
            end
          end, { "i", "c" }),
          ["<C-n>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_next_item()
            else
              cmp.complete()
            end
          end, { "i", "c" }),
          ["<CR>"] = cmp.mapping(cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          }), { "i", "c" }),
          ["<C-e>"] = cmp.mapping(function(fallback) fallback() end, { "i", "c" }),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-c>"] = cmp.mapping(cmp.mapping.abort(), { "i", "c" }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
              })
            elseif require("luasnip").expand_or_jumpable() then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            else
              fallback()
            end
          end, { "i", "c" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback) fallback() end, { "i", "c" }),
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
    cond = cond_vscode,
  },

  ["hrsh7th/cmp-cmdline"] = {
    opt = true,
    event = "CmdlineEnter",
    wants = "nvim-cmp",
    config = function()
      require("custom.plugins.configs.cmp_cmdline")
    end,
    cond = cond_vscode,
  },

  ["nmac427/guess-indent.nvim"] = {
    opt = true,
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("guess-indent").setup({})
    end,
    cond = cond_vscode,
  },

  ["kyazdani42/nvim-tree.lua"] = {
    override_options = {
      renderer = {
        highlight_git = true,
        group_empty = true,
      },
      git = {
        enable = true,
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      view = {
        mappings = {
          list = {
            { key = "l",  action = "edit" },
            { key = "h",  action = "close_node" },
            { key = "Y",  action = "copy_absolute_path" },
            { key = "gy", action = "copy_path" },
            { key = "[d", action = "prev_diag_item" },
            { key = "[g", action = "prev_git_item" },
            { key = "]d", action = "next_diag_item" },
            { key = "]g", action = "next_git_item" },
            { key = "o",  action = "system_open" },

            -- disable default mapping
            {
              key = { "s", "[e", "]e", "[c", "]c" },
              action = ""
            },
          },
        },
      },
    },
    cond = cond_vscode,
  },

  ["nvim-telescope/telescope.nvim"] = {
    override_options = function()
      local actions = require("telescope.actions")
      return {
        defaults = {
          prompt_prefix = "   ",
          layout_config = {
            width = 0.90,
            height = 0.85,
            preview_cutoff = 100,
          },
          mappings = {
            i = {
              ["<C-[>"] = actions.close,
              ["<C-f>"] = actions.results_scrolling_down,
              ["<C-b>"] = actions.results_scrolling_up,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-e>"] = actions.preview_scrolling_down,
              ["<C-y>"] = actions.preview_scrolling_up,

              -- disable default mapping
              ["<C-u>"] = false,
            },
          },
        },
      }
    end,
    setup = function()
      if vim.g.vscode == nil then require("core.utils").load_mappings("telescope") end
    end,
    cond = cond_vscode,
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
    event = { "CursorMoved", "CursorHold" },
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
    disable = is_windows,
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
    wants = "base46",
    event = "BufEnter",
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
    event = { "CursorMoved", "CursorHold" },
    setup = easymotion_setting,
    cond = cond_vscode,
  },

  ["asvetliakov/vim-easymotion"] = {
    opt = true,
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
          ["outputter/buffer/opener"] = "rightbelow 8sp",
          ["outputter/buffer/close_on_empty"] = 1,
          ["outputter/buffer/into"] = 0,
          ["hook/time/enable"] = 1,
        },
        python = {
          command = "python3",
          cmdopt = "-u",
          input = '%{filereadable("input") ? "input" : "="}',
        },
      }

      if vim.g.vscode == nil then require("core.utils").load_mappings("quickrun") end
    end,
    config = function()
      vim.api.nvim_create_augroup('QuickRunClose', {})
      vim.api.nvim_create_autocmd('FileType', {
        group = 'QuickRunClose',
        pattern = 'quickrun',
        callback = function()
          vim.keymap.set('n', 'q', '<cmd>quit<CR>', {
            buffer = true,
            silent = true,
          })
        end,
      })
    end,
    cond = cond_vscode,
  },

  -- disable default plugins in vscode
  ["NvChad/extensions"] = { cond = cond_vscode },
  ["rafamadriz/friendly-snippets"] = { cond = cond_vscode },
  ["kyazdani42/nvim-web-devicons"] = { after = false, cond = cond_vscode },
  ["lukas-reineke/indent-blankline.nvim"] = { event = { "BufReadPost", "BufNewFile", "CursorHold" } , cond = cond_vscode },
  ["numToStr/Comment.nvim"] = { cond = cond_vscode },
}

return {
  -- filer
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      default_component_configs = {
        modified = {
          symbol = "●",
        },
      },
      window = {
        mappings = {
          ["s"] = "",
          ["h"] = "close_node",
          ["l"] = "open",
          ["L"] = "focus_preview",
          ["w"] = "open_split",
          ["v"] = "open_vsplit",
        },
      },
      event_handlers = {
        {
          -- add event for auto-close
          event = "file_opened",
          handler = function(_)
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
    },
  },

  -- vscode like breadcrumbs
  {
    "utilyre/barbecue.nvim",
    event = "LazyFile",
    dependencies = {
      { "smiteshp/nvim-navic" },
    },
    config = function()
      require("barbecue").setup()
      require("barbecue.ui").update()
    end,
  },

  -- make quickfix better
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    opts = {
      func_map = {
        split = "ss",
        vsplit = "sv",
      },
    },
  },

  -- make quickfix editable
  {
    "stevearc/quicker.nvim",
    ft = "qf",
    opts = {},
  },

  -- git diff view
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "DiffviewOpen", "DiffviewToggleFiles", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<Cmd>DiffviewOpen<CR>", desc = "open diffview" },
      { "<leader>gD", "<Cmd>DiffviewFileHistory<CR>", desc = "open file history" },
    },
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local actions = require("telescope.actions")
      opts.defaults.layout_config = {
        width = 0.90,
        height = 0.85,
        preview_cutoff = 100,
      }
      opts.defaults.mappings = {
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
          ["<C-d>"] = false,
        },
      }
    end,
  },

  -- key binding helper
  {
    "folke/which-key.nvim",
    keys = {
      {
        "s",
        function()
          require("which-key").show({ keys = "s" })
        end,
        desc = "surround/window",
      },
    },
    opts = {
      spec = {
        {
          mode = { "n", "v" },
          { "s", group = "surround/window" },
        },
      },
    },
  },

  -- terminal
  {
    "akinsho/toggleterm.nvim",
    keys = { "<C-t>" },
    cmd = { "ToggleTerm", "ToggleTermToggleAll", "TermExec" },
    opts = {
      open_mapping = [[<C-t>]],
      insert_mappings = false,
      direction = "horizontal",
    },
  },

  -- improve word motions
  {
    "backdround/neowords.nvim",
    vscode = true,
    keys = {
      { "w", mode = { "n", "x", "o" } },
      { "e", mode = { "n", "x", "o" } },
      { "b", mode = { "n", "x", "o" } },
      { "ge", mode = { "n", "x", "o" } },
    },
    config = function()
      local neowords = require("neowords")
      local presets = neowords.pattern_presets
      local patterns = {
        presets.snake_case,
        presets.camel_case,
        presets.upper_case,
        presets.number,
        [=[\m\<[^\x00-\x7e]\{-1,}\>]=], -- treat non-ascii text
        [=[\m\%(\s\|^\)\zs[!#%&*+./:;=?\\^_|~-]\ze\%(\s\|$\)]=], -- symbols only orphans
      }

      local hops = neowords.get_word_hops(unpack(patterns))
      local map = vim.keymap.set

      map({ "n", "x", "o" }, "w", hops.forward_start)
      map({ "n", "x", "o" }, "e", hops.forward_end)
      map({ "n", "x", "o" }, "b", hops.backward_start)
      map({ "n", "x", "o" }, "ge", hops.backward_end)
    end,
  },

  -- run program quickly
  {
    "thinca/vim-quickrun",
    cmd = { "QuickRun" },
    dependencies = "lambdalisue/vim-quickrun-neovim-job",
    keys = {
      { "<C-q>", "<Cmd>QuickRun<CR>", desc = "QuickRun" },
      {
        "<C-c>",
        function()
          if vim.fn.exists("*quickrun#session#exists") == 1 and vim.fn["quickrun#session#exists"]() ~= 0 then
            vim.fn["quickrun#sweep_sessions"]()
            vim.notify("Process Stopped", vim.log.levels.INFO, {
              title = "QuickRun",
            })
            return ""
          else
            return "<C-c>"
          end
        end,
        desc = "Cancel QuickRun Process",
        expr = true,
      },
      { "<C-q>", "<Cmd>QuickRun -mode v<CR>", mode = "x", desc = "QuickRun" },
    },
    init = function()
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
    end,
    config = function()
      vim.api.nvim_create_augroup("QuickRunClose", {})
      vim.api.nvim_create_autocmd("FileType", {
        group = "QuickRunClose",
        pattern = "quickrun",
        callback = function()
          vim.keymap.set("n", "q", "<cmd>quit<CR>", {
            buffer = true,
            silent = true,
          })
        end,
      })
    end,
  },
}

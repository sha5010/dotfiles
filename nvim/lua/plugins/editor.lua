return {
  -- vscode like breadcrumbs
  {
    "Bekaboo/dropbar.nvim",
    event = "LazyFile",
    keys = {
      {
        "<leader>;",
        function()
          require("dropbar.api").pick()
        end,
        { desc = "Pick symbols in winbar" },
      },
      {
        "[;",
        function()
          require("dropbar.api").goto_context_start()
        end,
        { desc = "Go to start of current context" },
      },
      {
        "];",
        function()
          require("dropbar.api").select_next_context()
        end,
        { desc = "Select next context" },
      },
    },
    opts = {},
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

  -- improve word motions
  {
    "s-show/extend_word_motion.nvim",
    vscode = true,
    event = "LazyFile",
    opts = {},
    dependencies = {
      "sirasagi62/tinysegmenter.nvim",
    },
  },
  {
    "qq3g7bad/sentence-jp.nvim",
    vscode = true,
    event = "LazyFile",
    opts = {},
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

return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        accept = { auto_brackets = { enabled = true } },
        list = { selection = { preselect = false, auto_insert = true } },
        menu = {
          border = "rounded",
          scrollbar = false,
        },
        documentation = {
          window = { border = "rounded" },
        },
      },
      keymap = {
        preset = "super-tab",
        ["<C-e>"] = {},
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-c>"] = { "cancel", "fallback" },
      },
    },
  },

  -- disable mini.pairs
  {
    "echasnovski/mini.pairs",
    enabled = false,
  },

  -- add nvim-insx for autopairs
  {
    "hrsh7th/nvim-insx",
    event = "InsertEnter",
    vscode = true,
    config = function()
      require("insx.preset.standard").setup()
    end,
  },

  -- add mini.surround
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "sa",
        delete = "sd",
        find = "sf",
        find_left = "sF",
        highlight = "si",
        replace = "sr",
        update_n_lines = "sn",
      },
    },
  },

  -- operator for substitute
  {
    "gbprod/substitute.nvim",
    vscode = true,
    keys = {
      { "<leader>S", '"+S', mode = { "n", "x" }, desc = "substitute from clipboard", remap = true },
      {
        "S",
        function()
          require("substitute").operator()
        end,
        desc = "Substitute",
      },
      {
        "SS",
        function()
          require("substitute").line()
        end,
        desc = "Substitute Line",
      },
      {
        "sx",
        function()
          require("substitute.exchange").operator()
        end,
        desc = "Exchange",
      },
      {
        "sxx",
        function()
          require("substitute.exchange").line()
        end,
        desc = "Exchange Line",
      },
      {
        "sxc",
        function()
          require("substitute.exchange").cancel()
        end,
        desc = "Cancel Exchange",
      },
      {
        "S",
        function()
          require("substitute").visual()
        end,
        mode = "x",
        desc = "Substitute",
      },
      {
        "sx",
        function()
          require("substitute.exchange").visual()
        end,
        mode = "x",
        desc = "Exchange",
      },
    },
    opts = function()
      return {
        range = {
          prefix = "S",
        },
        on_substitute = require("yanky.integration").substitute(),
      }
    end,
  },

  -- extend % navigation
  {
    "andymass/vim-matchup",
    vscode = true,
    event = "LazyFile",
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  -- better yank/paste
  {
    "gbprod/yanky.nvim",
    keys = function(_, keys)
      -- change keymap for Open Yank History
      keys[1] = {
        "<leader>sy",
        keys[1][2],
        desc = keys[1].desc,
        mode = keys[1].mode,
      }
      return keys
    end,
  },

  -- handling images effectively
  {
    "hakonHarnes/img-clip.nvim",
    cmd = {
      "PasteImage",
      "ImgClipDebug",
      "ImgClipConfig",
    },
    keys = {
      { "<leader>ip", "<cmd>PasteImage<cr>", desc = "Paste image from clipboard" },
      {
        "<leader>if",
        function()
          local telescope = require("telescope.builtin")
          local actions = require("telescope.actions")
          local action_state = require("telescope.actions.state")

          telescope.find_files({
            attach_mappings = function(_, map)
              local function embed_image(prompt_bufnr)
                local entry = action_state.get_selected_entry()
                local filepath = entry[1]
                actions.close(prompt_bufnr)

                local img_clip = require("img-clip")
                img_clip.paste_image(nil, filepath)
              end

              map("i", "<CR>", embed_image)
              map("n", "<CR>", embed_image)

              return true
            end,
            find_command = function(opts)
              if vim.fn.executable("fd") then
                local extensions = { "png", "jpg", "jpeg" }
                local command = { "fd", "--type", "f", "--color", "never" }
                for _, ext in ipairs(extensions) do
                  table.insert(command, "-e")
                  table.insert(command, ext)
                end
                return command
              end
              local org_find_command = opts.find_command
              opts.find_command = nil
              return org_find_command(opts)
            end,
          })
        end,
        desc = "Insert image from local file",
      },
    },
    opts = {},
  },
}

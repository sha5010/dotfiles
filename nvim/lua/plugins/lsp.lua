return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      require("vim.lsp._watchfiles")._watchfunc = function()
        return function() end
      end
    end,
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable a default keymap
      keys[#keys + 1] = { "gd", false }
      keys[#keys + 1] = { "gr", false }
      keys[#keys + 1] = { "gy", false }
    end,
  },

  -- improve lsp experience
  {
    "nvimdev/lspsaga.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Lspsaga",
    keys = {
      { "gd", "<Cmd>Lspsaga peek_definition<CR>", desc = "Peek Definition" },
      { "gr", "<Cmd>Lspsaga finder<CR>", desc = "Find References" },
      { "gy", "<Cmd>Lspsaga peek_type_definition<CR>", desc = "Peek Type Definition" },
      { "gs", "<Cmd>Lspsaga show_line_diagnostics<CR>", desc = "Current Line Diagnostics" },
      { "gh", "<Cmd>Lspsaga code_action<CR>", desc = "Current Line Diagnostics" },
      { "gO", "<Cmd>Lspsaga outline<CR>", desc = "Show Outline" },
      { "gR", "<Cmd>Lspsaga rename<CR>", desc = "Rename" },
      { "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Prev Diagnostic" },
      { "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Next Diagnostic" },
    },
    opts = {
      finder = {
        keys = {
          shuttle = "<Tab>",
          vsplit = "v",
          split = "s",
          close = "q",
        },
      },
      definition = {
        width = 0.8,
        keys = {
          edit = "o",
          vsplit = "v",
          split = "s",
          tabe = "t",
          close = "<C-c>",
        },
      },
      rename = {
        keys = {
          quit = "<C-[>",
        },
      },
      ui = {
        code_action = "",
      },
      symbol_in_winbar = {
        enable = false,
      },
    },
  },

  -- make better cursor diagnostics
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    opts = function()
      -- disable default lsp diagnostic text
      vim.diagnostic.config({ virtual_text = false })

      return {
        signs = {
          left = " ",
          right = " ",
          arrow = "   ",
          up_arrow = "   ",
        },
        options = {
          multiple_diag_under_cursor = true,
          multilines = true,
          show_all_diags_on_cursorline = true,
          virt_texts = {
            priority = 8192,
          },
        },
      }
    end,
  },
}

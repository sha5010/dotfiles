return {
  -- colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },

  -- better ui
  {
    "folke/noice.nvim",
    opts = {
      routes = {
        {
          filter = { event = "notify", find = "No information available" },
          opts = { skip = true },
        },
      },
      presets = {
        lsp_doc_border = true,
      },
      views = {
        hover = {
          size = {
            max_width = 80,
          },
        },
      },
    },
  },

  -- notices
  {
    "rcarriga/nvim-notify",
    opts = {
      render = "compact",
    },
  },

  -- bufferline (tabline)
  {
    "akinsho/bufferline.nvim",
    keys = function()
      return {
        { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
        { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
        { "<leader><Tab>p", "<Cmd>BufferLinePick<CR>", desc = "Pick tab" },
      }
    end,
    opts = {
      options = {
        mode = "tabs",
        numbers = "ordinal",
        tab_size = 12,
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = "thin",
        always_show_bufferline = true,
      },
    },
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local function short_mode()
        local mode_to_short = {
          ["NORMAL"] = "N",
          ["VISUAL"] = "V",
          ["V-BLOCK"] = "V-B",
          ["V-LINE"] = "V-L",
          ["SELECT"] = "S",
          ["S-LINE"] = "S-L",
          ["S-BLOCK"] = "S-B",
          ["REPLACE"] = "R",
          ["V-REPLACE"] = "V-R",
          ["INSERT"] = "I",
          ["COMMAND"] = "C",
          ["EX"] = "X",
          ["TERMINAL"] = "T",
          ["CONFIRM"] = "?",
          ["MORE"] = "M",
          ["O-PENDING"] = "O",
          ["SHELL"] = "$",
        }

        local mode = require("lualine.utils.mode").get_mode()
        return (mode_to_short[mode] or mode)
      end

      local function tab_shiftwidth()
        local is_expandtab = vim.o.expandtab
        local shiftwidth = vim.o.shiftwidth

        if is_expandtab then
          return " " .. shiftwidth
        else
          return " " .. shiftwidth
        end
      end

      opts.options = vim.tbl_extend("force", opts.options, {
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      })
      opts.sections = vim.tbl_extend("force", opts.sections, {
        lualine_a = { short_mode },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      })
      table.insert(opts.sections.lualine_x, { tab_shiftwidth })
      opts.extensions[#opts.extensions + 1] = "quickfix"
      opts.extensions[#opts.extensions + 1] = "toggleterm"
      opts.extensions[#opts.extensions + 1] = "fzf"
      opts.extensions[#opts.extensions + 1] = "mason"
      opts.extensions[#opts.extensions + 1] = "nvim-dap-ui"
      opts.extensions[#opts.extensions + 1] = "trouble"
    end,
  },

  -- indent guide
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      indent = {
        char = "▏",
        tab_char = "▏",
      },
    },
  },

  -- active indent guide
  {
    "echasnovski/mini.indentscope",
    opts = {
      draw = {
        animation = function()
          return 0
        end,
      },
      symbol = "▏",
    },
  },
}

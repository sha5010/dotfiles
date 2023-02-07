local M = {}

function M.lspsaga()
  require("lspsaga").setup({
    finder = {
      keys = {
        vsplit = "v",
        split = "s",
      },
    },
    symbol_in_winbar = {
      enable = false,
    },
  })
end

function M.nvimtree()
  return {
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
  }
end

function M.autopairs()
  return {
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
  }
end

function M.colorizer()
  return {
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
  }
end

function M.hlslens()
  vim.opt.shortmess:append("S")
  local opts = {
    calm_down = true,
  }

  local status, handler = pcall(require, "scrollbar.handlers.search")
  if status then
    handler.setup(opts)
  else
    require("hlslens").setup(opts)
  end
end

function M.scrollbar()
  local status, colors = pcall(require, "base46.themes." .. vim.g.nvchad_theme)
  local opts = {}
  if status then
    opts = {
      Search = { color = colors.base_30.yellow },
      GitAdd = { color = colors.base_30.green },
      GitChange = { color = colors.base_30.blue },
      GitDelete = { color = colors.base_30.red },
    }
  end
  require("scrollbar").setup({
    set_highlights = true,
    marks = opts
  })
  require("scrollbar.handlers.gitsigns").setup()
end

function M.neoclip()
  require("neoclip").setup({
    keys = {
      telescope = {
        i = {
          paste = "<c-o>",
          paste_behind = "<c-i>",
          delete = "<c-x>",
        },
      },
    },
  })

  local status, telescope = pcall(require, "telescope")
  if status then
    telescope.load_extension("neoclip")
    telescope.load_extension("macroscope")
  end
end

function M.substitute()
  require("substitute").setup({
    range = {
      prefix = "",
    },
  })
end

function M.surround()
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
end

function M.easymotion()
  vim.g.EasyMotion_do_mapping = 0
  vim.g.EasyMotion_smartcase = 1
  vim.g.EasyMotion_use_smartsign_jp = 1
  vim.g.EasyMotion_use_migemo = 1
  vim.g.EasyMotion_verbose = 0

  require("core.utils").load_mappings("easymotion")
end

return M

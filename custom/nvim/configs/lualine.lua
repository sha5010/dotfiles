local status, lualine = pcall(require, "lualine")
if (not status) then return end

local M = {}

-- base46 theme
local function get_base46_theme()
  local function theme_setup(colors)
    local theme = {
      normal = {
        a = { fg = colors.bg, bg = colors.normal },
        b = { fg = colors.light_fg, bg = colors.alt_bg },
        c = { fg = colors.light_fg, bg = colors.bg },
      },
      replace = {
        a = { fg = colors.bg, bg = colors.replace },
        b = { fg = colors.light_fg, bg = colors.alt_bg },
      },
      insert = {
        a = { fg = colors.bg, bg = colors.insert },
        b = { fg = colors.light_fg, bg = colors.alt_bg },
      },
      visual = {
        a = { fg = colors.bg, bg = colors.visual },
        b = { fg = colors.light_fg, bg = colors.alt_bg },
      },
      command = {
        a = { fg = colors.bg, bg = colors.command },
        b = { fg = colors.light_fg, bg = colors.alt_bg },
      },
      inactive = {
        a = { fg = colors.dark_fg, bg = colors.bg },
        b = { fg = colors.dark_fg, bg = colors.bg },
        c = { fg = colors.dark_fg, bg = colors.bg },
      },
    }

    theme.terminal = theme.insert

    return theme
  end

  local get_theme_tb = require("base46").get_theme_tb
  local base_30 = get_theme_tb("base_30")
  local base_16 = get_theme_tb("base_16")

  local theme = theme_setup {
    bg = base_16.base01,
    alt_bg = base_16.base02,
    dark_fg = base_16.base03,
    fg = base_16.base06,
    light_fg = base_16.base05,
    normal = base_16.base05,
    insert = base_16.base0D,
    visual = base_16.base09,
    replace = base_16.base08,
    command = base_16.base0B,
  }

  local diff_color = {
    added = { fg = base_30.green },
    modified = { fg = base_30.blue },
    removed = { fg = base_30.red },
  }

  return theme, diff_color
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local function short_mode()
  local mode_to_short = {
    ['NORMAL'] = 'N',
    ['VISUAL'] = 'V',
    ['V-BLOCK'] = 'V-B',
    ['V-LINE'] = 'V-L',
    ['SELECT'] = 'S',
    ['S-LINE'] = 'S-L',
    ['S-BLOCK'] = 'S-B',
    ['REPLACE'] = 'R',
    ['V-REPLACE'] = 'V-R',
    ['INSERT'] = 'I',
    ['COMMAND'] = 'C',
    ['EX'] = 'X',
    ['TERMINAL'] = 'T',
    ['CONFIRM'] = '?',
    ['MORE'] = 'M',
    ['O-PENDING'] = 'O',
    ['SHELL'] = '$',
  }

  local mode = require('lualine.utils.mode').get_mode()
  return (mode_to_short[mode] or mode)
end

local function tab_shiftwidth()
  local is_expandtab = vim.o.expandtab
  local shiftwidth = vim.o.shiftwidth

  if is_expandtab then
    return ' ' .. shiftwidth
  else
    return ' ' .. shiftwidth
  end
end

function M.setup()
  local theme, diff_color = get_base46_theme()
  lualine.setup {
    options = {
      icons_enabled = true,
      theme = theme,
      section_separators = {left = '', right = ''},
      component_separators = {left = '', right = ''},
      disabled_filetypes = {},
      globalstatus = true,
    },
    sections = {
      -- lualine_a = {'mode'},
      lualine_a = {short_mode},
      lualine_b = {'branch'},
      lualine_c = {
        { 'filename',
          file_status = true, -- displays file status (readonly status, modified status)
          path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
          symbols = {
            modified = '●',
            readonly = ''
          },
        },
        { 'diff',
          symbols = {
            added = ' ',
            modified = ' ',
            removed = ' ',
          },
          diff_color = diff_color,
          source = diff_source,
        }
      },
      lualine_x = {
        { 'diagnostics',
          sources = {"nvim_diagnostic"},
          symbols = {
            error = ' ', warn = ' ', info = ' ', hint = ' '
          }
        },
        tab_shiftwidth,
        { 'fileformat',
          -- symbols = {
          --   unix = 'unix',
          --   dos  = 'dos',
          --   mac  = 'mac',
          -- }
        },
        'encoding',
        'filetype'
      },
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {{
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
      }},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    extensions = {
      'quickfix',
      'fugitive',
      'nvim-tree',
      'toggleterm',
    }
  }
end

M.setup()

return M

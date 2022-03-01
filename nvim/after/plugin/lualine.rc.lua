local status, lualine = pcall(require, "lualine")
if (not status) then return end

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
  }

  local mode = require('lualine.utils.mode').get_mode()
  return (mode_to_short[mode] or mode)
end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    section_separators = {left = '', right = ''},
    component_separators = {left = '￨', right = '￨'},
    disabled_filetypes = {}
  },
  sections = {
    -- lualine_a = {'mode'},
    lualine_a = {short_mode},
    lualine_b = {'branch'},
    lualine_c = {{
      'filename',
      file_status = true, -- displays file status (readonly status, modified status)
      path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
      symbols = {
        modified = ' ￨ +',
        readonly = ' ￨ '
      }
    }},
    lualine_x = {
      { 'diagnostics',
        sources = {"nvim_diagnostic"},
        symbols = {
          error = ' ', warn = ' ', info = ' ', hint = ' '
        }
      },
      {
        'fileformat',
        symbols = {
          unix = 'unix',
          dos  = 'dos',
          mac  = 'mac',
        }
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

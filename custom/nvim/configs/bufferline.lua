local status, bufferline = pcall(require, 'bufferline')
if (not status) then return end

local config = require("bufferline.config")

local M = {}

function M.setup()
  local opts = {
    highlights = nil,
    options = {
      mode = 'tabs',
      numbers = 'ordinal',
      tab_size = 12,
      offsets = {
        {
          filetype = 'undotree',
          text = 'Undotree',
          highlight = 'PanelHeading',
          padding = 1,
        },
        {
          filetype = 'NvimTree',
          text = 'NvimTree',
          highlight = 'PanelHeading',
          padding = 1,
        },
        {
          filetype = 'DiffviewFiles',
          text = 'Diff View',
          highlight = 'PanelHeading',
          padding = 1,
        },
        {
          filetype = 'flutterToolsOutline',
          text = 'Flutter Outline',
          highlight = 'PanelHeading',
        },
        {
          filetype = 'lazy',
          text = 'lazy',
          highlight = 'PanelHeading',
          padding = 1,
        },
      },
      color_icons = true,
      show_buffer_close_icon = false,
      show_close_icon = false,
      separator_style = 'thin',
      alway_show_bufferline = true,
    },
  }

  local current_config = config.get()
  if current_config.options ~= nil then
    local PREFIX = "BufferLine"
    for hl in pairs(vim.api.nvim_get_hl(0, {})) do
      if string.sub(hl, 1, #PREFIX) == PREFIX then
        vim.cmd('highlight clear ' .. hl)
      end
    end
  end
  bufferline.setup(opts)
end

M.setup()

return M

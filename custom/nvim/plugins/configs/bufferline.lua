local status, bufferline = pcall(require, 'bufferline')
if (not status) then return end

bufferline.setup({
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
        filetype = 'packer',
        text = 'Packer',
        highlight = 'PanelHeading',
        padding = 1,
      },
    },
    color_icons = true,
    show_buffer_close_icon = false,
    show_close_icon = false,
    separator_style = 'thin',
    alway_show_bufferline = true,
  }
})

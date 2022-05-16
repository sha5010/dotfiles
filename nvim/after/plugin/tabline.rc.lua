local status, tabline = pcall(require, "tabline")
if (not status) then return end

local hi = function(colors)
    for name, opts in pairs(colors) do
        vim.api.nvim_set_hl(0, name, opts)
    end
end

local hl = require("tabline.highlights")

-- from ~/.local/share/nvim/plugged/nvim-tabline/lua/tabline/highlights.lua
hl.c = {
    active_bg = hl.get_color('TabLineSel', 'bg'),
    inactive_bg = hl.get_color('TabLineFill', 'bg'),
    active_text = '#eeeeee',
    inactive_text = '#7f8490',
    active_sep = hl.get_color('lualine_a_normal', 'bg'),
}

local hls = {
     TabLineSeparatorSel = { fg = hl.c.active_sep,     bg = hl.c.active_bg } ,
     TabLineSeparator    = { fg = hl.c.inactive_text,  bg = hl.c.inactive_bg } ,
     TabLineModifiedSel  = { fg = hl.c.active_sep,     bg = hl.c.active_bg } ,
     TabLineModified     = { fg = hl.c.inactive_text,  bg = hl.c.inactive_bg } ,
     TabLineCloseSel     = { fg = hl.c.inactive_text,  bg = hl.c.inactive_bg } ,
     TabLineClose        = { fg = hl.c.inactive_text,  bg = hl.c.inactive_bg } ,
     TabLinePaddingSel   = { link = 'TabLineSel' },
     TabLinePadding      = { link = 'TabLineFill' },
}

tabline.setup{
    no_name = '[No Name]',    -- Name for buffers with no name
    modified_icon = '',      -- Icon for showing modified buffer
    close_icon = '',         -- Icon for closing tab with mouse
    separator = "▌",          -- Separator icon on the left side
    padding = 1,              -- Prefix and suffix space
    color_all_icons = true,   -- Color devicons in active and inactive tabs
    always_show_tabs = true,  -- Always show tabline
    right_separator = false,  -- Show right separator on the last tab
    show_index = true ,       -- Shows the index of tab before filename
    show_icon = true,         -- Shows the devicon
}

hi(hls)

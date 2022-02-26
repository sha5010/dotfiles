local status, tabline = pcall(require, "tabline")
if (not status) then return end

local clear_highlights = function(hls)
    for _, hl in ipairs(hls) do
        local name, _ = unpack(hl)
        vim.cmd('highlight clear ' .. name)
    end
end

local hl = require("tabline.highlights")

-- from ~/.local/share/nvim/plugged/nvim-tabline/lua/tabline/highlights.lua
hl.c = {
    active_bg = hl.get_color('TabLineSel', 'bg'),
    inactive_bg = hl.get_color('TabLineFill', 'bg'),
    active_text = '#eeeeee',
    inactive_text = '#7f8490',
    active_sep = '#a89984',             -- lualine_a_normal
    modified_active_sep = '#fe8019',    -- lualine_a_visual
}

local hls = {
    { 'TabLineSeparatorActive',             { guifg = hl.c.active_sep,           guibg = hl.c.active_bg } },
    { 'TabLineSeparatorInactive',           { guifg = hl.c.inactive_text,        guibg = hl.c.inactive_bg } },
    { 'TabLineModifiedSeparatorActive',     { guifg = hl.c.modified_active_sep,  guibg = hl.c.active_bg } },
    { 'TabLineModifiedSeparatorInactive',   { guifg = hl.c.inactive_text,        guibg = hl.c.inactive_bg } },
    { 'TabLinePaddingActive',               { guifg = hl.c.active_bg,            guibg = hl.c.active_bg } },
    { 'TabLinePaddingInactive',             { guifg = hl.c.inactive_bg,          guibg = hl.c.inactive_bg } },
    { 'TabLineModifiedActive',              { guifg = hl.c.active_text,          guibg = hl.c.active_bg } },
    { 'TabLineModifiedInactive',            { guifg = hl.c.inactive_text,        guibg = hl.c.inactive_bg } },
    { 'TabLineCloseActive',                 { guifg = hl.c.active_text,          guibg = hl.c.active_bg } },
    { 'TabLineCloseInactive',               { guifg = hl.c.inactive_text,        guibg = hl.c.inactive_bg } },
}

-- re-configure highlights
clear_highlights(hls)
hl.highlight_all(hls)


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

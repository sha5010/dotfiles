local fn = vim.fn
local sep_style = vim.g.statusline_sep_style
local separators = (type(sep_style) == "table" and sep_style)
  or require("nvchad_ui.icons").statusline_separators[sep_style]
local sep_l = separators["left"]

return {
  cwd = function()
    return ''
  end,
  cursor_position = function()
    local left_sep = "%#St_pos_sep#" .. sep_l .. "%#St_pos_icon#" .. " "

    local current_line = fn.line "."
    local current_col = fn.col "."
    local total_line = fn.line "$"
    local perc = string.format("%2d", math.modf((current_line / total_line) * 100)) .. tostring "%%"

    perc = (current_line == 1 and "Top") or perc
    perc = (current_line == total_line and "Bot") or perc

    local text = string.format("%2s:%-2s", current_line, current_col)

    return left_sep .. "%#St_file_info#" .. " " .. perc .. " " .. "%#St_pos_text#" .. " " .. text .. " "
  end,
}

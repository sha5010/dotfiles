local status, indent_blankline = pcall(require, "indent_blankline")
if (not status) then return end

indent_blankline.setup {
  char = "│",
  char_list = { "│", "¦", "┆", "┊" },
  char_highlight_list = {},
  use_treesitter = true,
  indent_level = 10,  -- the maximum indent level to display
  max_indent_increase = 1,
  show_first_indent_level = false,
  show_trailing_blankline_indent = true,
  show_end_of_line = false,
  show_foldtext = true,
  enabled = true,  -- turns this plugin on or off
  disable_with_nolist = false,  -- disable when nolist is set
  filetype = {},  -- a list of filetype values for which this plugin is enabled
  filetype_exclude = {  -- a list of filtype values for which this plugin is not enabled
    "lspinfo",
    "packer",
    "checkhealth",
    "help",
    "",
    "NvimTree",
    "TelescopePrompt",
    "undotree",
    "toggleterm",
    "fugitive",
    "quickrun",
  },
  buftype_exclude = {  -- a list of buftype values for which this plugin is not enabled
    "help",
    "terminal",
  },
  bufname_exclude = {}, -- a list of buffer names for which this plugin is not enabled
  blankline_strict_tabs = false,
  show_current_context = true,
  show_current_context_start = false,
  show_current_context_start_on_current_line = false,
  context_char = "┃",
  context_char_list = {},
  context_highlight_list = {"IndentBlanklineChar"},
  -- context_patterns = { ** USE DEFAULT ** },
  context_pattern_highlight = {},
  viewport_buffer = 10,
  disable_warning_message = false,
  debug = false,
}

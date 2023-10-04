local M = {}

M.theme = "tomorrow_night"

M.hl_add = {
  ActiveWindow = {
    bg = "black"
  },
  InactiveWindow = {
    bg = "darker_black"
  },

  -- hlslens
  HlSearchLens = { bg = "one_bg", fg = "light_grey", },
}

M.hl_override = {
  PmenuSel = {
    bg = "blue",
    fg = "black",
  },
  DiffAdd = { bg = "NONE", fg = "green", },
  DiffAdded = { bg = "NONE", fg = "green", },
  DiffChange = { bg = "NONE", fg = "blue", },
  DiffModified = { bg = "NONE", fg = "blue", },
  DiffDelete = { bg = "NONE", fg = "red", },
  DiffRemoved = { bg = "NONE", fg = "red", },
  DiffChangeDelete = { bg = "NONE", fg = "orange", },
}

M.statusline = {
  theme = "vscode_colored",
  separator_style = "block",
}

M.tabufline = {
  enabled = false,
}

return M

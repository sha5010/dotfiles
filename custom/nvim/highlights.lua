local M = {}

M.hl_add = {
  ActiveWindow = {
    bg = "black"
  },
  InactiveWindow = {
    bg = "#101214"
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

return M

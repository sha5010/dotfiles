local status, augend = pcall(require, "dial.augend")
if (not status) then return end

local JA_WEEKDAYS = { "月", "火", "水", "木", "金", "土", "日" }

require("dial.config").augends:register_group{
  default = {
    augend.integer.alias.decimal_int,
    augend.integer.alias.hex,
    augend.integer.alias.octal,
    augend.integer.alias.binary,
    augend.date.alias["%Y/%m/%d"],
    augend.date.alias["%Y-%m-%d"],
    augend.date.alias["%Y年%-m月%-d日"],
    augend.date.alias["%Y年%-m月%-d日(%ja)"],
    augend.date.alias["%m/%d"],
    augend.date.new{  -- "%m/%d(%ja)"
      pattern = "%m/%d(%J)",
      default_kind = "day",
      only_valid = false,
    },
    augend.date.alias["%-m/%-d"],
    augend.date.new{  -- "%-m/%-d(%ja)"
      pattern = "%-m/%-d(%J)",
      default_kind = "day",
      only_valid = false,
    },
    augend.date.alias["%H:%M:%S"],
    augend.date.alias["%H:%M"],
    augend.constant.alias.ja_weekday,
    augend.constant.alias.ja_weekday_full,
    augend.constant.alias.bool,
    augend.constant.new{
      elements = { "True", "False" },
      word = true,
    },
    augend.constant.new{
      elements = { "and", "or" },
      word = true,
    },
    augend.constant.new{
      elements = { "&&", "||" },
      word = false,
    },
    augend.constant.new{
      elements = { "==", "!=" },
      word = true,
    },
    augend.constant.new{
      elements = { "===", "!==" },
      word = true,
    },
  },
}

vim.api.nvim_set_keymap("n", "<C-a>", require("dial.map").inc_normal(), {noremap = true})
vim.api.nvim_set_keymap("n", "<C-x>", require("dial.map").dec_normal(), {noremap = true})
vim.api.nvim_set_keymap("v", "<C-a>", require("dial.map").inc_visual(), {noremap = true})
vim.api.nvim_set_keymap("v", "<C-x>", require("dial.map").dec_visual(), {noremap = true})
vim.api.nvim_set_keymap("v", "g<C-a>", require("dial.map").inc_gvisual(), {noremap = true})
vim.api.nvim_set_keymap("v", "g<C-x>", require("dial.map").dec_gvisual(), {noremap = true})

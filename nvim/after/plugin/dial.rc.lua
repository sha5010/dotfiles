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
      pattern = {
        regex = [[(\d{2})/(\d{2})\((月|火|水|木|金|土|日)\)]],
        capture = { "%m", "%d" },
      },
      format = function(datetime)
        local text_date = os.date("%m/%d", datetime)
        local week_idx = tonumber(os.date("%u", datetime))
        return ("%s(%s)"):format(text_date, JA_WEEKDAYS[week_idx])
      end,
      judge_datekind = function(_, curpos)
        if curpos == nil or curpos <= 0 or curpos >= 3 then
          return "day"
        else
          return "month"
        end
      end,
      calc_curpos = function(text, kind)
        if kind == "month" then
          return 2
        else
          return #text
        end
      end,
      only_valid = false,
    },
    augend.date.alias["%-m/%-d"],
    augend.date.new{  -- "%-m/%-d(%ja)"
      pattern = {
        regex = [[(\d{1,2})/(\d{1,2})\((月|火|水|木|金|土|日)\)]],
        capture = { "%m", "%d" },
      },
      format = function(datetime)
        local text_date = os.date("%-m/%-d", datetime)
        local week_idx = tonumber(os.date("%u", datetime))
        return ("%s(%s)"):format(text_date, JA_WEEKDAYS[week_idx])
      end,
      judge_datekind = function(text, curpos)
        local idx_slash = text:find("/")
        if curpos == nil or curpos <= 0 or curpos >= idx_slash then
          return "day"
        else
          return "month"
        end
      end,
      calc_curpos = function(text, kind)
        local idx_slash = text:find("/")
        if kind == "month" then
          return idx_slash - 1
        else
          return #text
        end
      end,
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

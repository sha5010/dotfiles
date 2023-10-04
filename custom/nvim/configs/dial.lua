local status, augend = pcall(require, "dial.augend")
if (not status) then return end

local function array_extend(t1, t2)
  for i = 1, #t2 do
    t1[#t1+1] = t2[i]
  end
  return t1
end

local default = {
  -- integer
  augend.integer.alias.decimal_int,
  augend.integer.alias.hex,
  augend.integer.alias.octal,
  augend.integer.alias.binary,

  -- date
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
  augend.date.new{  -- "%-m月%-日"
    pattern = "%-m月%-d日",
    default_kind = "day",
    only_valid = false,
  },
  augend.date.new{  -- "%-m月%-日(%ja)"
    pattern = "%-m月%-d日(%J)",
    default_kind = "day",
    only_valid = false,
  },
  augend.date.alias["%H:%M:%S"],
  augend.date.alias["%H:%M"],

  -- constant
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

  -- semver
  augend.semver.alias.semver,
}

local lang_specific = {
  markdown = {
    augend.misc.alias.markdown_header,
  },
  typescript = {
    augend.constant.new{ elements = { "const", "let" }, word = true },
  },
  javascript = {
    augend.constant.new{ elements = { "const", "let", "var" }, word = true },
  },
}

local mode_specific = {
  visual = {
    augend.constant.alias.alpha,
    augend.constant.alias.Alpha,
  },
  gvisual = {
    augend.constant.alias.alpha,
    augend.constant.alias.Alpha,
  },
}

-- fallback default
for lang, arr in pairs(lang_specific) do
  lang_specific[lang] = array_extend(arr, default)
end
for mode, arr in pairs(mode_specific) do
  mode_specific[mode] = array_extend(arr, default)
end

-- merge all
local function merge(t1, t2)
  for k, v in pairs(t2) do
    t1[k] = v
  end
  return t1
end
local augends = merge(lang_specific, mode_specific)
augends.default = default

require("dial.config").augends:register_group(augends)

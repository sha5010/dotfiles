return {
  -- add dial for extend <C-a> and <C-x>
  {
    "monaqa/dial.nvim",
    vscode = true,
    keys = function()
      local function dial_wrapper(mode, augend)
        if augend == "normal" then
          local status = require("dial.config").augends:get(vim.bo.filetype)
          if status ~= nil then
            if mode == "inc" then
              return require("dial.map").inc_normal(vim.bo.filetype)
            else
              return require("dial.map").dec_normal(vim.bo.filetype)
            end
          else
            if mode == "inc" then
              return require("dial.map").inc_normal("default")
            else
              return require("dial.map").dec_normal("default")
            end
          end
        elseif augend == "visual" then
          if mode == "inc" then
            return require("dial.map").inc_visual("visual")
          else
            return require("dial.map").dec_visual("visual")
          end
        elseif augend == "gvisual" then
          if mode == "inc" then
            return require("dial.map").inc_gvisual("gvisual")
          else
            return require("dial.map").dec_gvisual("gvisual")
          end
        end
        return ""
      end

      return {
        {
          "<C-a>",
          function()
            return dial_wrapper("inc", "normal")
          end,
          desc = "Increase",
          expr = true,
        },
        {
          "<C-x>",
          function()
            return dial_wrapper("dec", "normal")
          end,
          desc = "Decrease",
          expr = true,
        },
        {
          "<C-a>",
          function()
            return dial_wrapper("inc", "visual")
          end,
          mode = "x",
          desc = "Increase",
          expr = true,
        },
        {
          "<C-x>",
          function()
            return dial_wrapper("dec", "visual")
          end,
          mode = "x",
          desc = "Decrease",
          expr = true,
        },
        {
          "g<C-a>",
          function()
            return dial_wrapper("inc", "gvisual")
          end,
          mode = "x",
          desc = "Increase by an additional",
          expr = true,
        },
        {
          "g<C-x>",
          function()
            return dial_wrapper("dec", "gvisual")
          end,
          mode = "x",
          desc = "Decrease by an additional",
          expr = true,
        },
      }
    end,
    config = function()
      local augend = require("dial.augend")

      local function array_extend(t1, t2)
        for i = 1, #t2 do
          t1[#t1 + 1] = t2[i]
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
        augend.date.new({ -- "%m/%d(%ja)"
          pattern = "%m/%d(%J)",
          default_kind = "day",
          only_valid = false,
        }),
        augend.date.alias["%-m/%-d"],
        augend.date.new({ -- "%-m/%-d(%ja)"
          pattern = "%-m/%-d(%J)",
          default_kind = "day",
          only_valid = false,
        }),
        augend.date.new({ -- "%-m月%-日"
          pattern = "%-m月%-d日",
          default_kind = "day",
          only_valid = false,
        }),
        augend.date.new({ -- "%-m月%-日(%ja)"
          pattern = "%-m月%-d日(%J)",
          default_kind = "day",
          only_valid = false,
        }),
        augend.date.alias["%H:%M:%S"],
        augend.date.alias["%H:%M"],

        -- constant
        augend.constant.alias.ja_weekday,
        augend.constant.alias.ja_weekday_full,
        augend.constant.alias.bool,
        augend.constant.new({
          elements = { "True", "False" },
          word = true,
        }),
        augend.constant.new({
          elements = { "and", "or" },
          word = true,
        }),
        augend.constant.new({
          elements = { "&&", "||" },
          word = false,
        }),
        augend.constant.new({
          elements = { "==", "!=" },
          word = true,
        }),
        augend.constant.new({
          elements = { "===", "!==" },
          word = true,
        }),

        -- semver
        augend.semver.alias.semver,
      }

      local lang_specific = {
        markdown = {
          augend.misc.alias.markdown_header,
        },
        typescript = {
          augend.constant.new({ elements = { "const", "let" }, word = true }),
        },
        javascript = {
          augend.constant.new({ elements = { "const", "let", "var" }, word = true }),
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
    end,
  },
}

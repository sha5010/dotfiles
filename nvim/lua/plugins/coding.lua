return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        accept = { auto_brackets = { enabled = true } },
        list = { selection = { preselect = false, auto_insert = true } },
        menu = {
          border = "rounded",
          scrollbar = false,
        },
        documentation = {
          window = { border = "rounded" },
        },
      },
      keymap = {
        preset = "super-tab",
        ["<C-e>"] = {},
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-c>"] = { "cancel", "fallback" },
      },
    },
  },

  -- disable mini.pairs
  {
    "echasnovski/mini.pairs",
    enabled = false,
  },

  -- add nvim-insx for autopairs
  {
    "hrsh7th/nvim-insx",
    event = "InsertEnter",
    vscode = true,
    config = function()
      require("insx.preset.standard").setup()
    end,
  },

  -- add mini.surround
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "sa",
        delete = "sd",
        find = "sf",
        find_left = "sF",
        highlight = "si",
        replace = "sr",
        update_n_lines = "sn",
      },
    },
  },

  -- operator for substitute
  {
    "gbprod/substitute.nvim",
    vscode = true,
    keys = {
      { "<leader>S", '"+S', mode = { "n", "x" }, desc = "substitute from clipboard", remap = true },
      {
        "S",
        function()
          require("substitute").operator()
        end,
        desc = "Substitute",
      },
      {
        "SS",
        function()
          require("substitute").line()
        end,
        desc = "Substitute Line",
      },
      {
        "sx",
        function()
          require("substitute.exchange").operator()
        end,
        desc = "Exchange",
      },
      {
        "sxx",
        function()
          require("substitute.exchange").line()
        end,
        desc = "Exchange Line",
      },
      {
        "sxc",
        function()
          require("substitute.exchange").cancel()
        end,
        desc = "Cancel Exchange",
      },
      {
        "S",
        function()
          require("substitute").visual()
        end,
        mode = "x",
        desc = "Substitute",
      },
      {
        "sx",
        function()
          require("substitute.exchange").visual()
        end,
        mode = "x",
        desc = "Exchange",
      },
    },
    opts = function()
      return {
        range = {
          prefix = "S",
        },
        on_substitute = require("yanky.integration").substitute(),
      }
    end,
  },

  -- extend % navigation
  {
    "andymass/vim-matchup",
    vscode = true,
    event = "LazyFile",
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  -- better yank/paste
  {
    "gbprod/yanky.nvim",
    keys = function(_, keys)
      -- change keymap for Open Yank History
      keys[1] = {
        "<leader>sy",
        function()
          if LazyVim.pick.picker.name == "snacks" then
            local items = {} ---@type snacks.picker.finder.Item[]
            for i, value in ipairs(require("yanky.history").all()) do
              if value ~= nil then
                local text = value.regcontents
                table.insert(items, {
                  text = ("%d. %s"):format(i, text:gsub("\n", "\\n")),
                  data = value,
                  preview = {
                    text = text,
                    ft = "text",
                  },
                })
              end
            end

            Snacks.picker({
              title = "Yank ring history",
              items = items,
              format = "text",
              preview = "preview",
              confirm = {
                function(picker, item)
                  picker:close()
                  require("yanky.picker").actions.put("p", false)(item.data)
                end,
              },
            })
          elseif type(keys[1][2]) == "function" then
            keys[1][2]()
          else
            return keys[1][2]
          end
        end,
        desc = keys[1].desc,
        mode = keys[1].mode,
      }
      return keys
    end,
  },

  -- handling images effectively
  {
    "hakonHarnes/img-clip.nvim",
    cmd = {
      "PasteImage",
      "ImgClipDebug",
      "ImgClipConfig",
    },
    keys = {
      { "<leader>ip", "<cmd>PasteImage<cr>", desc = "Paste image from clipboard" },
      {
        "<leader>if",
        function()
          Snacks.picker.files({
            ft = { "png", "jpg", "jpeg" },
            ignored = true,
            confirm = {
              function(picker, item)
                picker:close()
                if item then
                  local img_clip = require("img-clip")
                  img_clip.paste_image(nil, "./" .. item.file)
                end
              end,
            },
          })
        end,
        desc = "Insert image from local file",
      },
    },
    opts = {},
  },
}

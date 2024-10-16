return {
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      local complete_or_do = function(func)
        if cmp.visible() then
          func()
        else
          cmp.complete()
        end
      end
      opts.window = {
        completion = {
          border = "rounded",
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:TablineSel,Search:None",
          scrollbar = false,
        },
        documentation = {
          border = "rounded",
        },
      }

      opts.completion.completeopt = "menu,menuone,preview,noselect"
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.confirm({
              behavior = cmp.ConfirmBehavior.Insert,
              select = true,
            })
          elseif not vim.snippet.active() and has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-n>"] = function()
          complete_or_do(cmp.select_next_item)
        end,
        ["<C-p>"] = function()
          complete_or_do(cmp.select_prev_item)
        end,
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }),
        ["<C-c>"] = cmp.mapping.abort(),
        ["<C-E>"] = cmp.mapping(function(fallback)
          fallback()
        end, { "i", "s" }),
        ["<C-Y>"] = cmp.mapping(function(fallback)
          fallback()
        end, { "i", "s" }),
      })
      for i, v in pairs(opts.sources) do
        if v.name == "buffer" then
          opts.sources[i].option = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end,
            -- adjust for japanese words
            keyword_pattern = [[\<\%(-\?\d\{1,100\}\%(\%(\.\d\|\w\)\{1,10\}\)\?\|\%(\w\|\-\)\{1,100\}\)\>\|\%([にをはのが]\|\<\)\@<=\%([^\x00-\xff　、。]\)\{-2,}\([にをはのが]\+\|\ze[\x00-\xff　、。]\|$\)]],
          }
          break
        end
      end
    end,
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
        keys[1][2],
        desc = keys[1].desc,
        mode = keys[1].mode,
      }
      return keys
    end,
    opts = function(_, opts)
      local mapping = require("yanky.telescope.mapping")
      local utils = require("yanky.utils")
      opts = vim.tbl_extend("force", opts, {
        picker = {
          telescope = {
            use_default_mappings = false,
            mappings = {
              default = mapping.put("p"),
              i = {
                ["<C-g>"] = mapping.put("P"),
                ["<C-x>"] = mapping.delete(),
                ["<C-r>"] = mapping.set_register(utils.get_default_register()),
              },
            },
          },
        },
      })
      return opts
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
          local telescope = require("telescope.builtin")
          local actions = require("telescope.actions")
          local action_state = require("telescope.actions.state")

          telescope.find_files({
            attach_mappings = function(_, map)
              local function embed_image(prompt_bufnr)
                local entry = action_state.get_selected_entry()
                local filepath = entry[1]
                actions.close(prompt_bufnr)

                local img_clip = require("img-clip")
                img_clip.paste_image(nil, filepath)
              end

              map("i", "<CR>", embed_image)
              map("n", "<CR>", embed_image)

              return true
            end,
            find_command = function(opts)
              if vim.fn.executable("fd") then
                local extensions = { "png", "jpg", "jpeg" }
                local command = { "fd", "--type", "f", "--color", "never" }
                for _, ext in ipairs(extensions) do
                  table.insert(command, "-e")
                  table.insert(command, ext)
                end
                return command
              end
              local org_find_command = opts.find_command
              opts.find_command = nil
              return org_find_command(opts)
            end,
          })
        end,
        desc = "Insert image from local file",
      },
    },
    opts = {},
  },
}

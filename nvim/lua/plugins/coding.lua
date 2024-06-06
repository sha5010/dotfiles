return {
  -- change cmp behavior
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      -- disable default <tab>  and <s-tab> keymap
      return {}
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local luasnip = require("luasnip")
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
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          fallback()
        end, { "i", "s" }),
        ["<C-n>"] = complete_or_do(cmp.select_next_item),
        ["<C-p>"] = complete_or_do(cmp.select_prev_item),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }),
        ["<C-c>"] = cmp.mapping.abort(),
        ["<C-e>"] = cmp.mapping(function(fallback)
          fallback()
        end, { "i", "s" }),
      })
      opts.sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
      }, {
        {
          name = "buffer",
          option = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end,
            -- adjust for japanese words
            keyword_pattern = [[\<\%(-\?\d\{1,100\}\%(\%(\.\d\|\w\)\{1,10\}\)\?\|\%(\w\|\-\)\{1,100\}\)\>\|\%([にをはのが]\|\<\)\@<=\%([^\x00-\xff　、。]\)\{-2,}\([にをはのが]\+\|\ze[\x00-\xff　、。]\|$\)]],
          },
        },
      })
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
    event = "VeryLazy",
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
}

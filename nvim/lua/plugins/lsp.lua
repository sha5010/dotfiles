return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      require("vim.lsp._watchfiles")._watchfunc = function()
        return function() end
      end
    end,
    opts = function(_, opts)
      local keys = opts.servers["*"].keys

      -- remove only gd / gr / gy
      for i = #keys, 1, -1 do
        if keys[i][1] == "gd" or keys[i][1] == "gr" or keys[i][1] == "gy" then
          table.remove(keys, i)
        end
      end
    end,
  },

  -- improve lsp experience
  {
    "nvimdev/lspsaga.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Lspsaga",
    keys = {
      { "gd", "<Cmd>Lspsaga peek_definition<CR>", desc = "Peek Definition" },
      { "gr", "<Cmd>Lspsaga finder<CR>", desc = "Find References" },
      { "gy", "<Cmd>Lspsaga peek_type_definition<CR>", desc = "Peek Type Definition" },
      { "gs", "<Cmd>Lspsaga show_line_diagnostics<CR>", desc = "Current Line Diagnostics" },
      { "gh", "<Cmd>Lspsaga code_action<CR>", desc = "Current Line Diagnostics" },
      { "gO", "<Cmd>Lspsaga outline<CR>", desc = "Show Outline" },
      { "gR", "<Cmd>Lspsaga rename<CR>", desc = "Rename" },
      { "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Prev Diagnostic" },
      { "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Next Diagnostic" },
    },
    opts = {
      finder = {
        keys = {
          shuttle = "<Tab>",
          vsplit = "v",
          split = "s",
          close = "q",
        },
      },
      definition = {
        width = 0.8,
        keys = {
          edit = "o",
          vsplit = "v",
          split = "s",
          tabe = "t",
          close = "<C-c>",
        },
      },
      rename = {
        keys = {
          quit = "<C-[>",
        },
      },
      ui = {
        code_action = "",
      },
      symbol_in_winbar = {
        enable = false,
      },
    },
  },

  -- make better cursor diagnostics
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    opts = function()
      local priority = 4097

      -- disable default lsp diagnostic text
      local config = vim.diagnostic.config()
      config.virtual_text = false
      if config then
        config.signs.priority = priority
      end
      vim.diagnostic.config(config)

      return {
        signs = {
          left = " ",
          right = " ",
          diag = "⬥",
          arrow = "   ",
          up_arrow = "   ",
        },
        options = {
          multiple_diag_under_cursor = true,
          multilines = true,
          show_all_diags_on_cursorline = true,
          virt_texts = {
            priority = priority,
          },
        },
      }
    end,
  },

  {
    "jay-babu/mason-null-ls.nvim",
    event = "LazyFile",
    dependencies = "mason-org/mason.nvim",
    opts = {
      handlers = {
        textlint = function() end,
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = "jay-babu/mason-null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      local u = require("null-ls.utils")
      local h = require("null-ls.helpers")

      local textlint_conf_files = {
        -- https://textlint.github.io/docs/configuring.html
        ".textlintrc",
        ".textlintrc.js",
        ".textlintrc.json",
        ".textlintrc.yml",
        ".textlintrc.yaml",
      }

      -- search config file in a curret project
      local local_config = h.cache.by_bufnr(function(params)
        return u.root_pattern(unpack(textlint_conf_files))(params.bufname)
      end)

      -- search config file in global
      local global_config = function()
        local config_home = vim.fn.getenv("XDG_CONFIG_HOME") or "~/.config"
        local textlint_conf_dir = u.path.join(config_home, "textlint")

        for _, filename in ipairs(textlint_conf_files) do
          local check_path = u.path.join(textlint_conf_dir, filename)
          if u.path.exists(check_path) then
            return check_path
          end
        end
        return nil
      end

      -- resolve textlint command path
      local resolve_textlint = function(params)
        params.command = params.command or "textlint"
        local project_root = u.root_pattern("node_modules")(params.bufname)
        if project_root then
          local local_cmd = u.path.join(project_root, "node_modules", ".bin", params.command)
          if u.path.exists(local_cmd) then
            return local_cmd
          end
        end
        return vim.fn.executable(params.command) == 1 and vim.fn.exepath(params.command) or nil
      end

      -- enable textlint when the command is available
      local condition = function(params)
        return resolve_textlint(params) ~= nil
      end

      -- use local config when available
      local extra_args = function(params)
        if local_config(params) then
          return {}
        end
        local conf = global_config()
        return conf and { "-c", conf } or {}
      end

      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.diagnostics.textlint.with({
          filetypes = { "markdown", "text" },
          extra_args = extra_args,
          runtime_condition = condition,
        }),
        nls.builtins.code_actions.textlint.with({
          extra_args = extra_args,
          runtime_condition = condition,
        }),
      })

      return opts
    end,
  },
}

local M = {}

function M.setup()
  local cmp = require("cmp")
  local config = require("plugins.configs.cmp")

  config.completion = {
    completeopt = "menu,preview,noselect"
  }
  config.mapping = {
    ["<C-p>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      else
        cmp.complete()
      end
    end, { "i", "c" }),
    ["<C-n>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item()
      else
        cmp.complete()
      end
    end, { "i", "c" }),
    ["<CR>"] = cmp.mapping(cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }), { "i", "c" }),
    ["<C-e>"] = cmp.mapping(function(fallback) fallback() end, { "i", "c" }),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-c>"] = cmp.mapping(cmp.mapping.abort(), { "i", "c" }),
    ["<Tab>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() then
          cmp.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          })
        elseif require("luasnip").expand_or_jumpable() then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
        else
          fallback()
        end
      end,
      c = function(fallback)
        if cmp.visible() then
          cmp.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          })
        elseif not cmp.complete_common_string() then
          cmp.complete()
        end
        fallback()
      end
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback) fallback() end, { "i", "c" }),
  }

  config.sources = {
    { name = "luasnip" },
    { name = "nvim_lsp" },
    {
      name = "buffer",
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
        keyword_pattern = [[\<\%(-\?\d\{1,100\}\%(\%(\.\d\|\w\)\{1,10\}\)\?\|\%(\w\|\-\)\{1,100\}\)\>\|\%([^\x00-\xff　、。]\)\+]]
      }
    },
    { name = "nvim_lua" },
    { name = "path" },
  }

  return config
end

function M.cmp_cmdline()
  local formatting = {
    format = function(_, vim_item)
      vim_item.kind = ""
      return vim_item
    end,
  }

  local cmp = require "cmp"
  cmp.setup.cmdline("/", {
    formatting = formatting,
    sources = {
      { name = "buffer" },
    },
  })

  cmp.setup.cmdline(":", {
    formatting = formatting,
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      -- { name = "cmdline", keyword_pattern=[=[[^[:blank:]\!]\{3,\}]=] },
      { name = "cmdline" },
    }),
  })
end

return M

if !exists('g:loaded_cmp')
  finish
endif

set completeopt=menuone,noinsert,noselect
" set completeopt=menu,menuone,noselect

lua <<EOF
  local cmp = require'cmp'
  local lspkind = require'lspkind'

  cmp.setup({
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-l>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i' }),
      ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i' }),
      ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
      ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
      ['<C-c>'] = cmp.mapping(cmp.mapping.abort(), { 'i', 'c' }),
      ['<Tab>'] = cmp.mapping(cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }), { 'i', 'c' }),
      ['<CR>'] = cmp.mapping(cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
        }), { 'i', 'c' }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
    }, {
      { name = 'path' },
    }),
    formatting = {
      format = lspkind.cmp_format({
        mode = 'symbol_text',
        maxwidth = 50
      })
    }
  })

  cmp.setup.cmdline('/', {
    sources = cmp.config.sources({
      { name = 'buffer' }
    })
  })

  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  local status, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
  if status then
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({
      map_char = {
        tex = '',
      }
    }))
  end
EOF

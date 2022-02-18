local status, autopairs = pcall(require, "nvim-autopairs")
if (not status) then return end

autopairs.setup({
  disable_filetype = { "TelescopePrompt" },
  check_ts = true, -- use treesitter to check for a pair
  fast_wrap = {
    map = '<C-q>',
    chars = { '{', '[', '(', '"', "'", '`' },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,%s] ]], '%s+', ''),
    offset = -1, -- Offset from pattern match
    end_key = ';',
    keys = 'asdghklqwertyuiopzxcvbnmfj',
    check_comma = true,
    highlight = 'Search',
    highlight_grey = 'Comment',
  }
})

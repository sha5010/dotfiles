local M = {}

M.disabled = {
  i = {
    ["<C-h>"] = "",
    ["<C-j>"] = "",
    ["<C-k>"] = "",
    ["<C-l>"] = "",
  },
  n = {
    ["<ESC>"] = "",
    ["<C-s>"] = "",
    ["<C-c>"] = "",
    ["<leader>rn"] = "",
    ["<leader>uu"] = "",
    ["<leader>tt"] = "",
    ["<leader>b"] = "",

    -- lspconfig
    ["gi"] = "",
    ["<leader>ra"] = "",
    ["<leader>f"] = "",
    ["<leader>q"] = "",
    ["<leader>fm"] = "",
    ["<leader>wa"] = "",
    ["<leader>wr"] = "",
    ["<leader>wl"] = "",

    -- nvimtree
    ["<C-n>"] = "",

    -- telescope
    ["<leader>tk"] = "",
    ["<leader>cm"] = "",
    ["<leader>pt"] = "",
    ["<leader>th"] = "",

    -- gitsigns
    ["<leader>rh"] = "",
    ["<leader>ph"] = "",
    ["<leader>td"] = "",
  },
  t = {
    ["<C-x>"] = "",
  }
}

M.general = {
  i = {
    ["<C-a>"] = { "<Home>" },
    ["<C-e>"] = { "<End>" },
    ["<C-b>"] = { "<Left>" },
    ["<C-f>"] = { "<Right>" },
  },
  n = {
    ["<C-j>"] = { "10j", opts = { noremap = false } },
    ["<C-k>"] = { "10k", opts = { noremap = false } },

    ["<C-h>"] = { "g^" },
    ["<C-l>"] = { "g$" },

    ["Y"] = { "y$" },

    ["x"] = { '"_x' },
    ["X"] = { '"_X' },
    ["c"] = { '"_c' },
    ["C"] = { '"_C' },

    ["gV"] = { "`[v`]", { noremap = false } },

    ["<Bslash>"] = { '<Cmd>call append(line(".")-1, "")<CR>' },
    ["_"] = { '<Cmd>call append(line(".")-1, "")<CR>' },

    ["<TAB>"] = { "gt", { noremap = false } },
    ["<S-Tab>"] = { "gT", { noremap = false } },

    ["t"] = { "<Nop>" },
    ["te"] = { ":<C-u>tabedit " },
    ["tq"] = { "<Cmd>tabclose<CR>", { noremap = false } },

    ["t0"] = { "<Cmd>tablast<CR>" },
    ["tt"] = { "<Cmd>tabedit<CR>" },
    ["ts"] = { "<Cmd>tabs<CR>" },
    ["th"] = { "<Cmd>tabmove-1<CR>" },
    ["tl"] = { "<Cmd>tabmove+1<CR>" },

    ["s"] = { "<Nop>" },
    ["s+"] = { "5<C-w>+" },
    ["s-"] = { "5<C-w>-" },
    ["s<"] = { "5<C-w><" },
    ["s>"] = { "5<C-w>>" },

    ["s="] = { "<C-w>=", { noremap = false } },

    ["ss"] = { "<C-w>s", { noremap = false } },
    ["sv"] = { "<C-w>v", { noremap = false } },

    ["se"] = { "<C-w>n", { noremap = false } },
    ["sq"] = { "<C-w>q", { noremap = false } },

    ["st"] = { "<C-w>T" },

    ["sh"] = { "<C-w>h" },
    ["sj"] = { "<C-w>j" },
    ["sk"] = { "<C-w>k" },
    ["sl"] = { "<C-w>l" },

    ["sH"] = { "<C-w>H" },
    ["sJ"] = { "<C-w>J" },
    ["sK"] = { "<C-w>K" },
    ["sL"] = { "<C-w>L" },

    ["<leader>n"] = { "<Cmd>nohlsearch<CR>" },

    ["<leader>y"] = { '"+y', { noremap = false } },
    ["<leader>Y"] = { '"+Y', { noremap = false } },
    ["<leader>d"] = { '"+d', { noremap = false } },
    ["<leader>D"] = { '"+D', { noremap = false } },
    ["<leader>p"] = { '"+p', { noremap = false } },
    ["<leader>P"] = { '"+P', { noremap = false } },

    ["<leader>a"] = { "gg0vG$" },
    ["<leader>r"] = { "<Cmd>set relativenumber!<CR>" },
    ["<leader>z"] = { "<Cmd>set wrap!<CR>" },
  },
  x = {
    ["<C-j>"] = { "10j", opts = { noremap = false } },
    ["<C-k>"] = { "10k", opts = { noremap = false } },

    ["<C-h>"] = { "^" },
    ["<C-l>"] = { "$" },

    ["x"] = { '"_x' },
    ["c"] = { '"_c' },
    ["C"] = { '"_C' },

    [">"] = { ">gv" },
    ["<"] = { "<gv" },

    ["s"] = { "<Nop>" },

    ["<leader>n"] = { "<Cmd>nohlsearch<CR>" },

    ["<leader>y"] = { '"+y', { noremap = false } },
    ["<leader>Y"] = { '"+Y', { noremap = false } },
    ["<leader>d"] = { '"+d', { noremap = false } },
    ["<leader>D"] = { '"+D', { noremap = false } },
    ["<leader>p"] = { '"+p', { noremap = false } },
    ["<leader>P"] = { '"+P', { noremap = false } },

    ["<leader>r"] = { "<Cmd>set relativenumber!<CR>" },
    ["<leader>z"] = { "<Cmd>set wrap!<CR>" },
  },
  o = {
    ["<C-h>"] = { "^" },
    ["<C-l>"] = { "$" },
  },
  c = {
    ["<C-a>"] = { "<Home>" },
    ["<C-e>"] = { "<End>" },
    ["<C-k>"] = { "<Up>" },
    ["<C-j>"] = { "<Down>" },
    ["<C-b>"] = { "<Left>" },
    ["<C-f>"] = { "<Right>" },

    ["%%"] = {
      function ()
        return vim.fn.getcmdtype() == ":" and vim.fn.expand("%:h") .. "/" or "%%"
      end, opts = { expr = true }
    },
  },
  t = {
    ["<Esc>"] = { "<C-\\><C-n>" },

    ["<C-k>"] = { "<Up>" },
    ["<C-j>"] = { "<Down>" },
  },
}

for i = 1, 9 do
  M.general.n["t"..i] = { i.. "gt" }
end

for _, v in pairs({"o", "x"}) do
  M.general[v]["i8"] = { "i(" }
  M.general[v]["i9"] = { "i)" }
  M.general[v]["i2"] = { 'i"' }
  M.general[v]["i7"] = { "i'" }
  M.general[v]["i@"] = { "i`" }
  M.general[v]["i,"] = { "i<" }
  M.general[v]["i."] = { "i>" }
  M.general[v]["a8"] = { "a(" }
  M.general[v]["a9"] = { "a)" }
  M.general[v]["a2"] = { 'a"' }
  M.general[v]["a7"] = { "a'" }
  M.general[v]["a@"] = { "a`" }
  M.general[v]["a,"] = { "a<" }
  M.general[v]["a."] = { "a>" }
end

-- change default mappings
M.lspconfig = {
  plugin = true,
  n = {
    ["gl"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "diagnostic setloclist",
    },
    ["<leader>F"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "lsp formatting",
    },
  },
}

M.nvimtree = {
  plugin = true,
  n = {
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree"},
  },
}

M.telescope = {
  plugin = true,
  n = {
    -- find
    ["<leader>fk"] = { "<cmd> Telescope keymaps <CR>", "show keys" },
    ["<leader>fm"] = { "<cmd> Telescope marks <CR>", "find marks" },
    ["<leader>ft"] = { "<cmd> Telescope themes <CR>", "nvchad themes" },
    ["<leader>fr"] = { "<cmd> Telescope registers <CR>", "find registers" },
    ["<leader>f/"] = { "<cmd> Telescope search_history <CR>", "search history" },
    ["<leader>f:"] = { "<cmd> Telescope command_history <CR>", "command history" },

    -- jump
    ["<leader>b"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "fuzzy jump" },

    -- git
    ["<leader>gl"] = { "<cmd> Telescope git_commits <CR>", "git commits" },
    ["<leader>gf"] = { "<cmd> Telescope git_files <CR>", "git files" },
    ["<leader>gh"] = { "<cmd> Telescope git_branches <CR>", "git branches" },
    ["<leader>gs"] = { "<cmd> Telescope git_stash <CR>", "git stash" },
  },
}

M.gitsigns = {
  plugin = true,
  n = {
    ["<leader>gr"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },
    ["<leader>gR"] = {
      function()
        require("gitsigns").reset_buffer()
      end,
      "Reset buffer",
    },
    ["<leader>gp"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "preview hunk",
    },
    ["<leader>gm"] = {
      function()
        require("gitsigns").toggle_deleted()
      end,
      "Toggle deleted",
    },
    ["<leader>ga"] = {
      function()
        require("gitsigns").stage_hunk()
      end,
      "Stage hunk",
    },
    ["<leader>gA"] = {
      function()
        require("gitsigns").stage_buffer()
      end,
      "Stage buffer",
    },
    ["<leader>gu"] = {
      function()
        require("gitsigns").undo_stage_hunk()
      end,
      "Reset hunk",
    },
    ["<leader>gU"] = {
      function()
        require("gitsigns").reset_buffer_index()
      end,
      "Reset buffer index",
    },
    ["<leader>gq"] = {
      function()
        require("gitsigns").setqflist()
      end,
      "Reset hunk",
    },
    ["<leader>gw"] = {
      function()
        require("gitsigns").toggle_word_diff()
      end,
      "Reset hunk",
    },
  },
}

M.lspsaga = {
  plugin = true,
  n = {
    ["K"] = { "<cmd>Lspsaga hover_doc<CR>" },
    ["gd"] = { "<cmd>Lspsaga peek_definition<CR>" },
    ["[d"] = { "<cmd>Lspsaga diagnostic_jump_prev<CR>" },
    ["]d"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>" },
    ["gr"] = { "<cmd>Lspsaga rename<CR>" },
    ["gs"] = { "<cmd>Lspsaga show_line_diagnostics<CR>" },
    ["gh"] = { "<cmd>Lspsaga code_action<CR>" },
    ["gD"] = { "<cmd>Lspsaga preview_definition<CR>" },
  },
}

M.bufferline = {
  plugin = true,
  n = {
    ["tp"] = { "<Cmd>BufferLinePick<CR>" },
  },
}

M.searchbox = {
  plugin = true,
  n = {
    ["<leader>s"] = {
      function()
        require("searchbox").replace { confirm = "menu", default_value = vim.fn.expand "<cword>" }
      end, "Find and Replace [ Current Buffer ]"
    },
  },
  x = {
    ["<leader>s"] = {
      function()
        -- grab the old value of a register
        local a_content = vim.fn.getreg "a"
        -- copy the current visual selection to "a" register
        vim.cmd 'noau normal! "ay"'
        -- grab content
        local content, v_mode = vim.fn.getreg "a", false
        -- restore the "a" register
        vim.fn.setreg("a", a_content)

        if content:match "\n" then
          content, v_mode = "", true
        end
        require("searchbox").replace { confirm = "menu", default_value = content, visual_mode = v_mode }
      end, "Find and Replace [ Current Buffer ]"
    },
  },
}

M.dial = {
  plugin = true,
  n = {
    ["<C-a>"] = {
      function()
        return require("dial.map").inc_normal()
      end, opts = { expr = true }
    },
    ["<C-x>"] = {
      function()
        return require("dial.map").dec_normal()
      end, opts = { expr = true }
    },
  },
  x = {
    ["<C-a>"] = {
      function()
        return require("dial.map").inc_visual()
      end, opts = { expr = true }
    },
    ["<C-x>"] = {
      function()
        return require("dial.map").dec_visual()
      end, opts = { expr = true }
    },
    ["g<C-a>"] = {
      function()
        return require("dial.map").inc_gvisual()
      end, opts = { expr = true }
    },
    ["g<C-x>"] = {
      function()
        return require("dial.map").dec_gvisual()
      end, opts = { expr = true }
    },
  },
}

M.substitute = {
  plugin = true,
  n = {
    ["S"] = {
      function()
        require("substitute").operator()
      end
    },
    ["SS"] = {
      function()
        require("substitute").line()
      end
    },
    ["sx"] = {
      function()
        require("substitute.exchange").operator()
      end
    },
    ["sxx"] = {
      function()
        require("substitute.exchange").line()
      end
    },
    ["sxc"] = {
      function()
        require("substitute.exchange").cancel()
      end
    },
  },
  x = {
    ["S"] = {
      function()
        require("substitute").visual()
      end
    },
    ["sx"] = {
      function()
        require("substitute.exchange").visual()
      end
    }
  }
}

M.undotree = {
  plugin = true,
  n = {
    ["U"] = { '<cmd>UndotreeToggle|UndotreeFocus<CR>', 'Toggle Undotree' },
  }
}

local avoid_macro = function(key, cmd)
  if vim.g.EasyMotion_loaded == nil then
    return key
  end
  return (vim.fn.reg_recording() == '' and vim.fn.reg_executing() == '') and cmd or key
end

local easymotion_keys = {
  n = {
    ["f"] = '<Plug>(easymotion-sl)',
    ["F"] = '<Plug>(easymotion-lineanywhere)',
    [";"] = '<Plug>(easymotion-next)',
    [","] = '<Plug>(easymotion-prev)',
    ["m"] = '<Plug>(easymotion-bd-W)',
  },
  x = {
    ["f"] = '<Plug>(easymotion-sl)',
    ["F"] = '<Plug>(easymotion-lineanywhere)',
    [";"] = '<Plug>(easymotion-next)',
    [","] = '<Plug>(easymotion-prev)',
    ["m"] = '<Plug>(easymotion-bd-W)',
  },
  o = {
    ["f"] = '<Plug>(easymotion-fl)',
    ["F"] = '<Plug>(easymotion-Fl)',
    ["t"] = '<Plug>(easymotion-tl)',
    ["T"] = '<Plug>(easymotion-Tl)',
  }
}

M.easymotion = {
  plugin = true,
}

for m, v in pairs(easymotion_keys) do
  M.easymotion[m] = M.easymotion[m] or {}
  for k, c in pairs(v) do
    M.easymotion[m][k] = {
      function()
        return avoid_macro(k, c)
      end, opts = { noremap = false, expr = true }
    }
  end
end

M.quickrun = {
  plugin = true,
  n = {
    ["<C-q>"] = { "<Cmd>QuickRun<CR>"},
    ["<C-c>"] = {
      function()
        if vim.fn["quickrun#session#exists"]() then
          vim.fn["quickrun#sweep_sessions"]()
          print('QuickRun: Process Stopped.')
          return ""
        else
          return "<C-c>"
        end
      end, opts = { expr = true }
    },
  },
  x = {
    ["<C-q>"] = { "<Cmd>QuickRun -mode v<CR>"},
  },
}

return M

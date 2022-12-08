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
    ["<C-a>"] = { "<C-o>^", "beginning of line" },
    ["<C-e>"] = { "<End>", "end of line" },
    ["<C-b>"] = { "<Left>", "move left" },
    ["<C-f>"] = { "<Right>", "move right" },
  },
  n = {
    ["<C-j>"] = { "10j", opts = { noremap = false }, "10 up" },
    ["<C-k>"] = { "10k", opts = { noremap = false }, "10 down" },

    ["<C-h>"] = { "g^", "beginning of window" },
    ["<C-l>"] = { "g$", "end of window" },

    ["Y"] = { "y$", "yank to end of line" },

    ["x"] = { '"_x', "" },
    ["X"] = { '"_X', "" },
    ["c"] = { '"_c', "" },
    ["C"] = { '"_C', "" },

    ["gV"] = { "`[v`]", { noremap = false }, "select put text" },

    ["<Bslash>"] = { '<Cmd>call append(line(".")-1, "")<CR>', "insert blank line" },
    ["_"] = { '<Cmd>call append(line(".")-1, "")<CR>', "insert blank line" },

    ["<TAB>"] = { "gt", { noremap = false }, "next tab" },
    ["<S-Tab>"] = { "gT", { noremap = false }, "previous tab" },

    ["t"] = { "<Nop>" },
    ["te"] = { ":<C-u>tabedit ", "tabedit" },
    ["tq"] = { "<Cmd>tabclose<CR>", { noremap = false }, "close tab" },

    ["t0"] = { "<Cmd>tablast<CR>", "select last tab" },
    ["tt"] = { "<Cmd>tabedit<CR>", "add blank tab" },
    ["ts"] = { "<Cmd>tabs<CR>", "show tabs" },
    ["th"] = { "<Cmd>tabmove-1<CR>", "move tab to left" },
    ["tl"] = { "<Cmd>tabmove+1<CR>", "move tab to right" },

    ["s"] = { "<Nop>" },
    ["s+"] = { "5<C-w>+", "wider window vertically" },
    ["s-"] = { "5<C-w>-", "narrow window vertically" },
    ["s<"] = { "5<C-w><", "narrow window horizontally" },
    ["s>"] = { "5<C-w>>", "wider window horizontally" },

    ["s="] = { "<C-w>=", { noremap = false }, "make all window equally" },

    ["ss"] = { "<C-w>s", { noremap = false }, "split horizontally" },
    ["sv"] = { "<C-w>v", { noremap = false }, "split vertically" },

    ["se"] = { "<C-w>n", { noremap = false }, "split new file" },
    ["sq"] = { "<C-w>q", { noremap = false }, "close window" },

    ["st"] = { "<C-w>T", "move window to tab" },

    ["sh"] = { "<C-w>h", "window left" },
    ["sj"] = { "<C-w>j", "window down" },
    ["sk"] = { "<C-w>k", "window up" },
    ["sl"] = { "<C-w>l", "window right" },

    ["sH"] = { "<C-w>H", "move window to left" },
    ["sJ"] = { "<C-w>J", "move window to bottom" },
    ["sK"] = { "<C-w>K", "move window to top" },
    ["sL"] = { "<C-w>L", "mvoe window to right" },

    ["<leader>n"] = { "<Cmd>nohlsearch<CR>", "stop highlighting" },

    ["<leader>y"] = { '"+y', { noremap = false }, "yank to clipboard" },
    ["<leader>Y"] = { '"+Y', { noremap = false }, "yank to clipboard" },
    ["<leader>d"] = { '"+d', { noremap = false }, "cut to clipboard" },
    ["<leader>D"] = { '"+D', { noremap = false }, "cut to clipboard" },
    ["<leader>p"] = { '"+p', { noremap = false }, "put from clipboard" },
    ["<leader>P"] = { '"+P', { noremap = false }, "put from clipboard" },

    ["<leader>a"] = { "gg0vG$", "select entire buffer" },
    ["<leader>r"] = { "<Cmd>set relativenumber!<CR>", "toggle relativenumber" },
    ["<leader>z"] = { "<Cmd>set wrap!<CR>", "toggle wrap" },
  },
  x = {
    ["<C-j>"] = { "10j", opts = { noremap = false }, "10 down" },
    ["<C-k>"] = { "10k", opts = { noremap = false }, "10 up" },

    ["<C-h>"] = { "^", "beginning of line" },
    ["<C-l>"] = { "$", "end of line" },

    ["x"] = { '"_x', "" },
    ["X"] = { '"_X', "" },
    ["c"] = { '"_c', "" },
    ["C"] = { '"_C', "" },

    [">"] = { ">gv", "increase indent" },
    ["<"] = { "<gv", "decrease indent" },

    ["s"] = { "<Nop>" },

    ["<leader>n"] = { "<Cmd>nohlsearch<CR>", "stop highlighting" },

    ["<leader>y"] = { '"+y', { noremap = false }, "yank to clipboard" },
    ["<leader>Y"] = { '"+Y', { noremap = false }, "yank to clipboard" },
    ["<leader>d"] = { '"+d', { noremap = false }, "cut to clipboard" },
    ["<leader>D"] = { '"+D', { noremap = false }, "cut to clipboard" },
    ["<leader>p"] = { '"+p', { noremap = false }, "put from clipboard" },
    ["<leader>P"] = { '"+P', { noremap = false }, "put from clipboard" },

    ["<leader>r"] = { "<Cmd>set relativenumber!<CR>", "toggle relativenumber" },
    ["<leader>z"] = { "<Cmd>set wrap!<CR>", "toggle wrap" },
  },
  o = {
    ["<C-h>"] = { "^", "beginning of line" },
    ["<C-l>"] = { "$", "end of line" },
  },
  c = {
    ["<C-a>"] = { "<Home>", "beginning of line" },
    ["<C-e>"] = { "<End>", "end of line" },
    ["<C-k>"] = { "<Up>", "up" },
    ["<C-j>"] = { "<Down>", "down" },
    ["<C-b>"] = { "<Left>", "left" },
    ["<C-f>"] = { "<Right>", "right" },

    ["%%"] = {
      function()
        return vim.fn.getcmdtype() == ":" and vim.fn.expand("%:h") .. "/" or "%%"
      end,
      opts = { expr = true },
      "expand cwd path",
    },
  },
  t = {
    ["<Esc>"] = { "<C-\\><C-n>", "normal mode" },

    ["<C-k>"] = { "<Up>", "up" },
    ["<C-j>"] = { "<Down>", "down" },
  },
}

for i = 1, 9 do
  M.general.n["t" .. i] = { i .. "gt", "select tab " .. i }
end

for _, v in pairs({ "o", "x" }) do
  M.general[v]["i8"] = { "i(", "" }
  M.general[v]["i9"] = { "i)", "" }
  M.general[v]["i2"] = { 'i"', "" }
  M.general[v]["i7"] = { "i'", "" }
  M.general[v]["i@"] = { "i`", "" }
  M.general[v]["i,"] = { "i<", "" }
  M.general[v]["i."] = { "i>", "" }
  M.general[v]["a8"] = { "a(", "" }
  M.general[v]["a9"] = { "a)", "" }
  M.general[v]["a2"] = { 'a"', "" }
  M.general[v]["a7"] = { "a'", "" }
  M.general[v]["a@"] = { "a`", "" }
  M.general[v]["a,"] = { "a<", "" }
  M.general[v]["a."] = { "a>", "" }
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

-- custom plugins
M.diffview = {
  plugin = true,
  n = {
    ["<leader>gd"] = { "<cmd> DiffviewOpen <CR>", "diffview" },
    ["<leader>gD"] = { "<cmd> DiffviewFileHistory <CR>", "diffview file history" },
  }
}

M.lspsaga = {
  plugin = true,
  n = {
    ["K"] = { "<cmd>Lspsaga hover_doc<CR>", "hover doc" },
    ["gd"] = { "<cmd>Lspsaga peek_definition<CR>", "peek definition" },
    ["[d"] = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "next diagnostic result" },
    ["]d"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "previous diagnostic result" },
    ["gr"] = { "<cmd>Lspsaga rename<CR>", "rename" },
    ["gs"] = { "<cmd>Lspsaga show_line_diagnostics<CR>", "show line diagnostics" },
    ["gh"] = { "<cmd>Lspsaga code_action<CR>", "show code action" },
    ["gD"] = { "<cmd>Lspsaga preview_definition<CR>", "preview definition" },
  },
}

M.trouble = {
  plugin = true,
  n = {
    ["<leader>x"] = { "<cmd>TroubleToggle<CR>", "toggle trouble" }
  }
}

M.bufferline = {
  plugin = true,
  n = {
    ["tp"] = { "<Cmd>BufferLinePick<CR>", "pick tab" },
  },
}

M.searchbox = {
  plugin = true,
  n = {
    ["<leader>s"] = {
      function()
        require("searchbox").replace({ confirm = "menu", default_value = vim.fn.expand("<cword>") })
      end,
      "Find and Replace [ Current Buffer ]",
    },
  },
  x = {
    ["<leader>s"] = {
      function()
        -- grab the old value of a register
        local a_content = vim.fn.getreg("a")
        -- copy the current visual selection to "a" register
        vim.cmd('noau normal! "ay"')
        -- grab content
        local content, v_mode = vim.fn.getreg("a"), false
        -- restore the "a" register
        vim.fn.setreg("a", a_content)

        if content:match("\n") then
          content, v_mode = "", true
        end
        require("searchbox").replace({ confirm = "menu", default_value = content, visual_mode = v_mode })
      end,
      "Find and Replace [ Current Buffer ]",
    },
  },
}

M.dial = {
  plugin = true,
  n = {
    ["<C-a>"] = {
      function()
        return require("dial.map").inc_normal()
      end,
      opts = { expr = true },
      "increase",
    },
    ["<C-x>"] = {
      function()
        return require("dial.map").dec_normal()
      end,
      opts = { expr = true },
      "decrease",
    },
  },
  x = {
    ["<C-a>"] = {
      function()
        return require("dial.map").inc_visual()
      end,
      opts = { expr = true },
      "increase",
    },
    ["<C-x>"] = {
      function()
        return require("dial.map").dec_visual()
      end,
      opts = { expr = true },
      "decrease",
    },
    ["g<C-a>"] = {
      function()
        return require("dial.map").inc_gvisual()
      end,
      opts = { expr = true },
      "increase by an additional",
    },
    ["g<C-x>"] = {
      function()
        return require("dial.map").dec_gvisual()
      end,
      opts = { expr = true },
      "decrease by an additional",
    },
  },
}

M.neoclip = {
  plugin = true,
  n = {
    ["<leader>h"] = { "<cmd>Telescope neoclip<CR>", "neoclip history" },
    ["<leader>q"] = { "<cmd>Telescope macroscope<CR>", "macro history" },
  },
}

M.substitute = {
  plugin = true,
  n = {
    ["S"] = {
      function()
        require("substitute").operator()
      end,
      "substitute",
    },
    ["SS"] = {
      function()
        require("substitute").line()
      end,
      "substitute line",
    },
    ["sx"] = {
      function()
        require("substitute.exchange").operator()
      end,
      "exchange",
    },
    ["sxx"] = {
      function()
        require("substitute.exchange").line()
      end,
      "exchange line",
    },
    ["sxc"] = {
      function()
        require("substitute.exchange").cancel()
      end,
      "cancel exchange",
    },
  },
  x = {
    ["S"] = {
      function()
        require("substitute").visual()
      end,
      "substitute",
    },
    ["sx"] = {
      function()
        require("substitute.exchange").visual()
      end,
      "exchange",
    },
  },
}

M.undotree = {
  plugin = true,
  n = {
    ["U"] = { "<cmd>UndotreeToggle|UndotreeFocus<CR>", "Toggle Undotree" },
  },
}

local avoid_macro = function(key, cmd)
  if vim.g.EasyMotion_loaded == nil then
    return key
  end
  return (vim.fn.reg_recording() == "" and vim.fn.reg_executing() == "") and cmd or key
end

local easymotion_keys = {
  n = {
    ["f"] = "<Plug>(easymotion-sl)",
    ["F"] = "<Plug>(easymotion-lineanywhere)",
    [";"] = "<Plug>(easymotion-next)",
    [","] = "<Plug>(easymotion-prev)",
    ["m"] = "<Plug>(easymotion-bd-W)",
  },
  x = {
    ["f"] = "<Plug>(easymotion-sl)",
    ["F"] = "<Plug>(easymotion-lineanywhere)",
    [";"] = "<Plug>(easymotion-next)",
    [","] = "<Plug>(easymotion-prev)",
    ["m"] = "<Plug>(easymotion-bd-W)",
  },
  o = {
    ["f"] = "<Plug>(easymotion-fl)",
    ["F"] = "<Plug>(easymotion-Fl)",
    ["t"] = "<Plug>(easymotion-tl)",
    ["T"] = "<Plug>(easymotion-Tl)",
  },
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
      end,
      opts = { noremap = false, expr = true },
    }
  end
end

M.quickrun = {
  plugin = true,
  n = {
    ["<C-q>"] = { "<Cmd>QuickRun<CR>", "QuickRun" },
    ["<C-c>"] = {
      function()
        if vim.fn.exists("*quickrun#session#exists") == 1
          and vim.fn["quickrun#session#exists"]() ~= 0 then

          vim.fn["quickrun#sweep_sessions"]()
          print("QuickRun: Process Stopped.")
          return ""
        else
          return "<C-c>"
        end
      end,
      opts = { expr = true },
      "cancel QuickRun process",
    },
  },
  x = {
    ["<C-q>"] = { "<Cmd>QuickRun -mode v<CR>", "QuickRun" },
  },
}

return M

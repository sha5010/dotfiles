-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local del = vim.keymap.del

-- disable default configurated keymap
del("n", "<S-h>")
del("n", "<S-l>")

map({ "n", "x" }, "<C-j>", "5j", { desc = "5 up", remap = true })
map({ "n", "x" }, "<C-k>", "5k", { desc = "5 down", remap = true })
map({ "n", "x", "o" }, "<C-h>", "g^", { desc = "Beginning of window" })
map({ "n", "x", "o" }, "<C-l>", "g$", { desc = "End of window" })

map({ "n", "x" }, "x", '"_x', { desc = "Delete characters after cursor" })
map({ "n", "x" }, "X", '"_X', { desc = "Delete characters before cursor" })
map({ "n", "x" }, "c", '"_c', { desc = "Change" })
map({ "n", "x" }, "C", '"_C', { desc = "Change line" })

map("n", "gV", "`[v`]", { desc = "Select put text", remap = true })

-- map({ "n", "x" }, "s", "<Nop>")
map("n", "s+", "5<C-w>+", { desc = "Wider window vertically" })
map("n", "s-", "5<C-w>-", { desc = "Narrow window vertically" })
map("n", "s<", "5<C-w><", { desc = "Narrow window horizontally" })
map("n", "s>", "5<C-w>>", { desc = "Wider window horizontally" })
map("n", "s;", "s+", { desc = "Wider window vertically", remap = true })
map("n", "s,", "s<", { desc = "Narrow window horizontally", remap = true })
map("n", "s.", "s>", { desc = "Wider window horizontally", remap = true })

map("n", "s=", "<C-w>=", { desc = "Make all window equally", remap = true })

map("n", "ss", "<C-w>s", { desc = "Split horizontally", remap = true })
map("n", "sv", "<C-w>v", { desc = "Split vertically", remap = true })

map("n", "se", "<C-w>n", { desc = "Split new file", remap = true })
map("n", "sq", "<C-w>q", { desc = "Close window", remap = true })

map("n", "st", "<C-w>T", { desc = "Move window to tab" })

map("n", "sh", "<C-w>h", { desc = "Window left", remap = true })
map("n", "sj", "<C-w>j", { desc = "Window down", remap = true })
map("n", "sk", "<C-w>k", { desc = "Window up", remap = true })
map("n", "sl", "<C-w>l", { desc = "Window right", remap = true })

map("n", "sH", "<C-w>H", { desc = "Move window to left", remap = true })
map("n", "sJ", "<C-w>J", { desc = "Move window to bottom", remap = true })
map("n", "sK", "<C-w>K", { desc = "Move window to top", remap = true })
map("n", "sL", "<C-w>L", { desc = "Mvoe window to right", remap = true })

map("n", "<C-m>", "<C-i>", { desc = "Newer jump list" })

map({ "n", "x" }, "<leader>n", "<Cmd>nohlsearch<CR>", { desc = "Stop highlighting" })

map({ "n", "x" }, "<leader>y", '"+y', { desc = "Yank to clipboard", remap = true })
map({ "n", "x" }, "<leader>Y", '"+Y', { desc = "Yank to clipboard", remap = true })
map({ "n", "x" }, "<leader>d", '"+d', { desc = "Cut to clipboard", remap = true })
map({ "n", "x" }, "<leader>D", '"+D', { desc = "Cut to clipboard", remap = true })
map({ "n", "x" }, "<leader>p", '"+p', { desc = "Put from clipboard", remap = true })
map({ "n", "x" }, "<leader>P", '"+P', { desc = "Put from clipboard", remap = true })

map("n", "<leader>a", "gg0vG$", { desc = "Select entire buffer" })
map("n", "<leader><Tab>e", ":tabedit ", { desc = "Tab Edit" })
map("n", "<leader><Tab>q", "<Cmd>tabclose<CR>", { desc = "Close Tab" })

map("i", "<C-a>", "<C-o>^", { desc = "Beginning of line" })
map("i", "<C-e>", "<End>", { desc = "End of line" })
map("i", "<C-b>", "<Left>", { desc = "Move left" })
map("i", "<C-f>", "<Right>", { desc = "Move right" })
map("i", "<C-@>", "<C-[>", { desc = "Esc" })

map("c", "<C-a>", "<Home>", { desc = "Beginning of line" })
map("c", "<C-e>", "<End>", { desc = "End of line" })
map({ "c", "t" }, "<C-k>", "<Up>", { desc = "Up" })
map({ "c", "t" }, "<C-j>", "<Down>", { desc = "Down" })
map("c", "<C-b>", "<Left>", { desc = "Left" })
map("c", "<C-f>", "<Right>", { desc = "Right" })

map("c", "%%", function()
  return vim.fn.getcmdtype() == ":" and vim.fn.expand("%:h") .. "/" or "%%"
end, { desc = "Expand cwd path", expr = true })

map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Normal Mode" })

if vim.g.vscode then
  map("n", "<leader>e", "<Cmd>call VSCodeNotify('workbench.view.explorer')<CR>", { desc = "Explorer" })
  map("n", "<leader>uw", "<Cmd>call VSCodeNotify('editor.action.toggleWordWrap')<CR>", { desc = "Toggle Word Wrap" })
  map("n", "<leader>um", "<Cmd>call VSCodeNotify('editor.action.toggleMinimap')<CR>", { desc = "Toggle Minimap" })

  map("n", "st", "<Cmd>call VSCodeNotify('workbench.action.joinAllGroups')<CR>", { desc = "Move window to tab" })
  map("n", "s+", "<C-w>+", { desc = "Wider window vertically", remap = true })
  map("n", "s-", "<C-w>-", { desc = "Narrow window vertically", remap = true })
  map("n", "s<", "<C-w><", { desc = "Narrow window horizontally", remap = true })
  map("n", "s>", "<C-w>>", { desc = "Wider window horizontally", remap = true })

  map("n", "<leader><tab>e", "<Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>", { desc = "Tab Edit" })
  map(
    "n",
    "<leader><tab><tab>",
    "<Cmd>call VSCodeNotify('workbench.action.files.newUntitledFile')<CR>",
    { desc = "New Tab" }
  )

  -- map("n", "<leader><tab>h", "<Cmd>call VSCodeNotify('workbench.action.moveEditorLeftInGroup')<CR>")
  -- map("n", "<leader><tab>l", "<Cmd>call VSCodeNotify('workbench.action.moveEditorRightInGroup')<CR>")

  map({ "n", "x" }, "za", "<Cmd>call VSCodeNotify('editor.toggleFold')<CR>", { desc = "Toggle fold under cursor" })
  map({ "n", "x" }, "zo", "<Cmd>call VSCodeNotify('editor.unfold')<CR>", { desc = "Open fold under cursor" })
  map(
    { "n", "x" },
    "zO",
    "<Cmd>call VSCodeNotify('editor.unfoldRecursively')<CR>",
    { desc = "Open all folds under cursor" }
  )
  map({ "n", "x" }, "zc", "<Cmd>call VSCodeNotify('editor.fold')<CR>", { desc = "Close fold under cursor" })
  map(
    { "n", "x" },
    "zC",
    "<Cmd>call VSCodeNotify('editor.foldRecursively')<CR>",
    { desc = "Close all folds under cursor" }
  )

  map({ "n", "x" }, "zR", "<Cmd>call VSCodeNotify('editor.unfoldAll')<CR>", { desc = "Open all folds" })
  map({ "n", "x" }, "zM", "<Cmd>call VSCodeNotify('editor.foldAll')<CR>", { desc = "Close all folds" })

  map(
    "n",
    "j",
    "<Cmd>call VSCodeNotify('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>",
    { desc = "Move down" }
  )
  map(
    "n",
    "k",
    "<Cmd>call VSCodeNotify('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>",
    { desc = "Move up" }
  )
  map(
    "n",
    "gj",
    "<Cmd>call VSCodeNotify('cursorMove', { 'to': 'down', 'by': 'line', 'value': v:count ? v:count : 1 })<CR>",
    { desc = "Move down" }
  )
  map(
    "n",
    "gk",
    "<Cmd>call VSCodeNotify('cursorMove', { 'to': 'up', 'by': 'line', 'value': v:count ? v:count : 1 })<CR>",
    { desc = "Move up" }
  )

  map("n", "<C-h>", "g0", { desc = "Beginning of line", remap = true })
  map("n", "<C-l>", "g$", { desc = "End of line", remap = true })

  map(
    { "n", "x" },
    "<leader>g,",
    "<Cmd>call VSCodeNotify('merge-conflict.accept.current')<CR>",
    { desc = "Accept current change under cursor" }
  )
  map(
    { "n", "x" },
    "<leader>g.",
    "<Cmd>call VSCodeNotify('merge-conflict.accept.incoming')<CR>",
    { desc = "Accept incoming change under cursor" }
  )
  map(
    { "n", "x" },
    "<leader>g-",
    "<Cmd>call VSCodeNotify('merge-conflict.accept.both')<CR>",
    { desc = "Accept both changes under cursor" }
  )
  map(
    { "n", "x" },
    "<leader>g<",
    "<Cmd>call VSCodeNotify('merge-conflict.accept.all-current')<CR>",
    { desc = "Accept all current changes" }
  )
  map(
    { "n", "x" },
    "<leader>g>",
    "<Cmd>call VSCodeNotify('merge-conflict.accept.all-incoming')<CR>",
    { desc = "Accept all incoming changes" }
  )
  map(
    { "n", "x" },
    "<leader>g=",
    "<Cmd>call VSCodeNotify('merge-conflict.accept.all-both')<CR>",
    { desc = "Acccpet all both changes" }
  )

  map("n", "[c", "<Cmd>call VSCodeNotify('merge-conflict.previous')<CR>", { desc = "Previous conflict" })
  map("n", "]c", "<Cmd>call VSCodeNotify('merge-conflict.next')<CR>", { desc = "" })
end

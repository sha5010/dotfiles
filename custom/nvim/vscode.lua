local M = {}

M = require("custom.mappings")

M.vscode = {
	n = {
		["<leader>e"] = { "<Cmd>call VSCodeNotify('workbench.view.explorer')<CR>" },
		["<leader>z"] = { "<Cmd>call VSCodeNotify('editor.action.toggleWordWrap')<CR>" },
		["<leader>m"] = { "<Cmd>call VSCodeNotify('editor.action.toggleMinimap')<CR>" },

		["st"] = { "<Cmd>call VSCodeNotify('workbench.action.joinAllGroups')<CR>" },
		["s+"] = { "<C-w>+", opts = { noremap = false } },
		["s-"] = { "<C-w>-", opts = { noremap = false } },
		["s<"] = { "<C-w><", opts = { noremap = false } },
		["s>"] = { "<C-w>>", opts = { noremap = false } },

		["te"] = { "<Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>" },
		["tt"] = { "<Cmd>call VSCodeNotify('workbench.action.files.newUntitledFile')<CR>" },
		["t0"] = { "<Cmd>call VSCodeNotify('workbench.action.lastEditorInGroup')<CR>" },

		["th"] = { "<Cmd>call VSCodeNotify('workbench.action.moveEditorLeftInGroup')<CR>" },
		["tl"] = { "<Cmd>call VSCodeNotify('workbench.action.moveEditorRightInGroup')<CR>" },

		["za"] = { "<Cmd>call VSCodeNotify('editor.toggleFold')<CR>" },
		["zo"] = { "<Cmd>call VSCodeNotify('editor.unfold')<CR>" },
		["zO"] = { "<Cmd>call VSCodeNotify('editor.unfoldRecursively')<CR>" },
		["zc"] = { "<Cmd>call VSCodeNotify('editor.fold')<CR>" },
		["zC"] = { "<Cmd>call VSCodeNotify('editor.foldRecursively')<CR>" },

		["zR"] = { "<Cmd>call VSCodeNotify('editor.unfoldAll')<CR>" },
		["zM"] = { "<Cmd>call VSCodeNotify('editor.foldAll')<CR>" },

		["j"] = {
			"<Cmd>call VSCodeNotify('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>",
		},
		["k"] = {
			"<Cmd>call VSCodeNotify('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>",
		},
		["gj"] = {
			"<Cmd>call VSCodeNotify('cursorMove', { 'to': 'down', 'by': 'line', 'value': v:count ? v:count : 1 })<CR>",
		},
		["gk"] = {
			"<Cmd>call VSCodeNotify('cursorMove', { 'to': 'up', 'by': 'line', 'value': v:count ? v:count : 1 })<CR>",
		},

		["<C-h>"] = { "g0", opts = { noremap = false } },
		["<C-l>"] = { "g$", opts = { noremap = false } },

		["gz,"] = { "<Cmd>call VSCodeNotify('merge-conflict.accept.current')<CR>" },
		["gz."] = { "<Cmd>call VSCodeNotify('merge-conflict.accept.incoming')<CR>" },
		["gz-"] = { "<Cmd>call VSCodeNotify('merge-conflict.accept.both')<CR>" },
		["gz<"] = { "<Cmd>call VSCodeNotify('merge-conflict.accept.all-current')<CR>" },
		["gz>"] = { "<Cmd>call VSCodeNotify('merge-conflict.accept.all-incoming')<CR>" },
		["gz="] = { "<Cmd>call VSCodeNotify('merge-conflict.accept.all-both')<CR>" },

		["[c"] = { "<Cmd>call VSCodeNotify('merge-conflict.previous')<CR>" },
		["]c"] = { "<Cmd>call VSCodeNotify('merge-conflict.next')<CR>" },
	},
	x = {
		["<C-S-P>"] = { "<Cmd>call VSCodeNotifyVisual('workbench.action.showCommands', 1)<CR>" },
		["<leader>z"] = { "<Cmd>call VSCodeNotify('editor.action.toggleWordWrap')<CR>" },
		["<leader>m"] = { "<Cmd>call VSCodeNotify('editor.action.toggleMinimap')<CR>" },

		["za"] = { "<Cmd>call VSCodeNotify('editor.toggleFold')<CR>" },
		["zo"] = { "<Cmd>call VSCodeNotify('editor.unfold')<CR>" },
		["zO"] = { "<Cmd>call VSCodeNotify('editor.unfoldRecursively')<CR>" },
		["zc"] = { "<Cmd>call VSCodeNotify('editor.fold')<CR>" },
		["zC"] = { "<Cmd>call VSCodeNotify('editor.foldRecursively')<CR>" },

		["zR"] = { "<Cmd>call VSCodeNotify('editor.unfoldAll')<CR>" },
		["zM"] = { "<Cmd>call VSCodeNotify('editor.foldAll')<CR>" },
	},
}

for i = 1, 9 do
	M.vscode.n["t" .. i] = { "<Cmd>call VSCodeNotify('workbench.action.openEditorAtIndex" .. i .. "')<CR>" }
end

return M

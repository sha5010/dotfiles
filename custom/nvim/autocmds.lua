local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local M = {}

local has_fcitx = vim.fn.executable("fcitx-remote") == 1

function M.setup()
  local function disable_ime()
    vim.g.fcitx_last_status = tonumber(vim.fn.system('fcitx-remote'))
    vim.fn.system('fcitx-remote -c')
  end

  augroup('HighlightYank', {})
  autocmd('TextYankPost', {
    group = 'HighlightYank',
    callback = function() vim.highlight.on_yank{timeout=500} end
  })

  if has_fcitx then
    vim.g.fcitx_last_status = 1

    augroup('ControlIME', {})
    autocmd('InsertLeave', {
      group = 'ControlIME',
      callback = disable_ime,
    })
    autocmd('CmdlineEnter', {
      group = 'ControlIME',
      callback = disable_ime,
    })
    autocmd('CmdlineLeave', {
      group = 'ControlIME',
      callback = disable_ime,
    })
    autocmd('InsertEnter', {
      group = 'ControlIME',
      callback = function()
        if vim.g.fcitx_last_status == 2 then
          vim.fn.system('fcitx-remote -o')
       end
      end,
    })
  end

  augroup('CloseQuickFix', {})
  autocmd('FileType', {
    group = 'CloseQuickFix',
    pattern = 'qf',
    callback = function()
      vim.keymap.set('n', 'q', '<cmd>quit<CR>', {
        buffer = true,
        silent = true,
      })
    end,
  })

  autocmd('User', {
    pattern = "NvChadThemeReload",
    callback = function()
      require("custom.configs.lualine").setup()
      require("custom.configs.bufferline").setup()
      vim.api.nvim_exec_autocmds("ColorScheme", {})
    end,
  })
end

return M

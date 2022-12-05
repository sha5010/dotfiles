local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local M = {}

vim.g.fcitx_last_status = 1

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

return M

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local group_name = 'zenhan'
local spzenhan_executable = vim.fn.stdpath('data') .. '/lazy/spzenhan.vim/zenhan/spzenhan.exe'
spzenhan_executable = string.gsub(spzenhan_executable, '\\', '/')

if (not vim.fn.executable(spzenhan_executable)) then return end

local switch_ime = function(status)
  local code = status ~= 0 and '1' or '0'
  vim.fn.system(spzenhan_executable .. ' ' .. code)
end

augroup(group_name, {})
autocmd('BufEnter', {
  group = group_name,
  callback = function()
    vim.b.zenhan_ime_status = 0
  end
})
autocmd('CmdlineLeave', {
  group = group_name,
  callback = function()
    switch_ime(0)
  end
})
autocmd('InsertLeave', {
  group = group_name,
  callback = function()
    switch_ime(0)
    vim.b.zenhan_ime_status = vim.v.shell_error
  end
})

autocmd('InsertEnter', {
  group = group_name,
  callback = function()
    local status = vim.b.zenhan_ime_status
    if status == nil then status = 0 end
    switch_ime(status)
  end
})


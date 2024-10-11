-- windows environment
local is_wsl = os.getenv("WSLENV") ~= nil or os.getenv("WSL_DISTRO_NAME") ~= nil or os.getenv("WSL_INTEROP") ~= nil
local is_windows = vim.fn.has("win32") ~= 0 or vim.fn.has("win64") ~= 0 or is_wsl

return {
  -- ime support for mac
  {
    "brglng/vim-im-select",
    vscode = true,
    event = { "InsertEnter", "CmdlineEnter" },
    enabled = not is_windows,
  },

  -- ime support for windows and wsl
  {
    "kaz399/spzenhan.vim",
    vscode = true,
    event = { "InsertEnter", "CmdlineEnter" },
    init = function()
      local autocmd = vim.api.nvim_create_autocmd
      local augroup = vim.api.nvim_create_augroup

      local group_name = "zenhan"
      local spzenhan_executable = vim.fn.stdpath("data") .. "/lazy/spzenhan.vim/zenhan/spzenhan.exe"
      spzenhan_executable = string.gsub(spzenhan_executable, "\\", "/")

      if not vim.fn.executable(spzenhan_executable) then
        return
      end

      vim.g["spzenhan#executable"] = spzenhan_executable
      local switch_ime = function(status)
        local code = status ~= 0 and "1" or "0"
        vim.fn.system(spzenhan_executable .. " " .. code)
      end

      augroup(group_name, {})
      autocmd("BufEnter", {
        group = group_name,
        callback = function()
          vim.b.zenhan_ime_status = 0
        end,
      })
      autocmd("CmdlineLeave", {
        group = group_name,
        callback = function()
          switch_ime(0)
        end,
      })
      autocmd("InsertLeave", {
        group = group_name,
        callback = function()
          switch_ime(0)
          vim.b.zenhan_ime_status = vim.v.shell_error
        end,
      })

      autocmd("InsertEnter", {
        group = group_name,
        callback = function()
          local status = vim.b["zenhan_ime_status"]
          if status == nil then
            status = 0
          end
          switch_ime(status)
        end,
      })
    end,
    enabled = is_windows,
  },
}

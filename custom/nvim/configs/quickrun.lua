local M = {}

function M.setup()
  -- disable default keymaps
  vim.g.quickrun_no_default_key_mappings = 1

  vim.g.quickrun_config = {
    -- default config
    _ = {
      runner = "neovim_job",
      ["outputter/buffer/opener"] = "rightbelow 8sp",
      ["outputter/buffer/close_on_empty"] = 1,
      ["outputter/buffer/into"] = 0,
      ["hook/time/enable"] = 1,
    },
    python = {
      command = "python3",
      cmdopt = "-u",
      input = '%{filereadable("input") ? "input" : "="}',
    },
  }

  if vim.g.vscode == nil then require("core.utils").load_mappings("quickrun") end
end

function M.config()
  vim.api.nvim_create_augroup('QuickRunClose', {})
  vim.api.nvim_create_autocmd('FileType', {
    group = 'QuickRunClose',
    pattern = 'quickrun',
    callback = function()
      vim.keymap.set('n', 'q', '<cmd>quit<CR>', {
        buffer = true,
        silent = true,
      })
    end,
  })
end

return M

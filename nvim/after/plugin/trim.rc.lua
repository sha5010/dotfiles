local status, trim = pcall(require, "trim")
if (not status) then return end

-- default config
local config = {
  disable = {},
  patterns = {
    [[%s/\s\+$//e]],
    [[%s/\($\n\s*\)\+\%$//]],
    [[%s/\%^\n\+//]],
    [[%s/\(\n\n\n\)\n\+/\1/]],
  },
}

trim.setup(config)

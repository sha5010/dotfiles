local actions = require("telescope.actions")
local config = require("plugins.configs.telescope")

config.defaults.layout_config = {
  width = 0.90,
  height = 0.85,
  preview_cutoff = 100,
}
config.defaults.mappings = {
  i = {
    ["<C-[>"] = actions.close,
    ["<C-f>"] = actions.results_scrolling_down,
    ["<C-b>"] = actions.results_scrolling_up,
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-e>"] = actions.preview_scrolling_down,
    ["<C-y>"] = actions.preview_scrolling_up,

    -- disable default mapping
    ["<C-u>"] = false,
  },
}

return config

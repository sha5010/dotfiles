local status, toggleterm = pcall(require, "toggleterm")
if (not status) then return end

toggleterm.setup{
  open_mapping = [[<C-t>]],
  hide_numbers = true,
  shade_terminals = true,
  shading_factor = 1,
  start_in_insert = true,
  insert_mappings = false,
  terminal_mappings = true,
  persist_size = true,
  direction = 'horizontal',
  close_on_exit = true,
}

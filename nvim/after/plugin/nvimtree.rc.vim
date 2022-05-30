lua << EOF
local status, nvimtree = pcall(require, "nvim-tree")
if (not status) then return end

vim.g.loaded_nvimtree = 1

local list = {
  { key = { "<CR>", "l", "<2-LeftMouse>" }, action = "edit" },
  { key = "e",                              action = "edit_in_place" },
  { key = "O",                              action = "edit_no_picker" },
  { key = { "<C-]>", "o" },                 action = "cd" },
  { key = "v",                              action = "vsplit" },
  { key = "w",                              action = "split" },
  { key = "t",                              action = "tabnew" },
  { key = "<",                              action = "prev_sibling" },
  { key = ">",                              action = "next_sibling" },
  { key = "P",                              action = "parent_node" },
  { key = { "<BS>", "h" },                  action = "close_node" },
  { key = "<Tab>",                          action = "preview" },
  { key = "K",                              action = "first_sibling" },
  { key = "J",                              action = "last_sibling" },
  { key = "I",                              action = "toggle_git_ignored" },
  { key = "H",                              action = "toggle_dotfiles" },
  { key = "U",                              action = "toggle_custom" },
  { key = "R",                              action = "refresh" },
  { key = "a",                              action = "create" },
  { key = "d",                              action = "remove" },
  { key = "D",                              action = "trash" },
  { key = "r",                              action = "rename" },
  { key = "<C-r>",                          action = "full_rename" },
  { key = "x",                              action = "cut" },
  { key = "c",                              action = "copy" },
  { key = "p",                              action = "paste" },
  { key = "y",                              action = "copy_name" },
  { key = "Y",                              action = "copy_path" },
  { key = "gy",                             action = "copy_absolute_path" },
  { key = "[c",                             action = "prev_git_item" },
  { key = "]c",                             action = "next_git_item" },
  { key = "-",                              action = "dir_up" },
  { key = "S",                              action = "system_open" },
  { key = "f",                              action = "live_filter" },
  { key = "F",                              action = "clear_live_filter" },
  { key = "q",                              action = "close" },
  { key = "W",                              action = "collapse_all" },
  { key = "E",                              action = "expand_all" },
  { key = "?",                              action = "search_node" },
  { key = ".",                              action = "run_file_command" },
  { key = "i",                              action = "toggle_file_info" },
  { key = "g?",                             action = "toggle_help" },
}

nvimtree.setup {
  auto_reload_on_write = true,
  create_in_closed_folder = false,
  disable_netrw = true,
  hijack_cursor = false,
  hijack_netrw  = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_buffer_on_setup = false,
  open_on_setup = false,
  open_on_setup_file = false,
  open_on_tab = false,
  sort_by = "name",
  update_cwd = true,
  reload_on_bufenter = false,
  respect_buf_cwd = false,
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = true,
      list = list
    }
  },
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = true,
    highlight_opened_files = "none",
    root_folder_modifier = ":~",
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "Dockerfile" },
  },
  hijack_directories  = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = false,
    update_cwd  = false,
    ignore_list = {}
  },
  ignore_ft_on_setup  = {},
  diagnostics = {
    enable = false,
    show_on_dirs = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 300,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    expand_all = {
      max_folder_discovery = 300,
    },
    open_file = {
      quit_on_open = true,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame", "undotree" },
          buftype = { "nofile", "terminal", "help", "prompt" },
        },
      },
    },
    remove_file = {
      close_window = true,
    },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      diagnostics = false,
      git = false,
      profile = false,
    },
  },
}

EOF

if !exists("g:loaded_nvimtree")
  finish
endif

" nnoremap <silent> <leader>e :NvimTreeToggle<CR>
" nnoremap <leader>r :NvimTreeRefresh<CR>
" nnoremap <leader>n :NvimTreeFindFile<CR>
nnoremap <silent> <leader>e :NvimTreeFindFileToggle<CR>
" NvimTreeOpen, NvimTreeClose, NvimTreeFocus, NvimTreeFindFileToggle, and NvimTreeResize are also available if you need them

set termguicolors " this variable must be enabled for colors to be applied properly

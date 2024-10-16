return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = "RRethy/nvim-treesitter-textsubjects",
    opts = {
      textsubjects = {
        enable = true,
        prev_selection = ",",
        keymaps = {
          ["."] = { "textsubjects-smart", desc = "Next textsubjects selection" },
        },
      },
    },
  },

  {
    "Wansmer/treesj",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cmd = {
      "TSJToggle",
      "TSJSplit",
      "TSJJoin",
    },
    keys = {
      {
        "<leader>cj",
        function()
          require("treesj").toggle()
        end,
        desc = "Toggle split/join",
      },
    },
    opts = {
      use_deafult_keymaps = false,
    },
  },
}

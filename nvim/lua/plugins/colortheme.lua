return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = false,
        term_colors = true,
        color_overrides = {
          mocha = {
            base = "#0d0e0e",
            mantle = "#0d0e0e",
            crust = "#0d0e0e",
          },
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          treesitter = true,
          notify = false,
          mini = false,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}

return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = {
      "bash", "c", "diff", "lua", "luadoc", "vim", "vimdoc", "query",
      "html", "css", "scss", "javascript", "typescript", "tsx", "json", "prisma", "graphql", "svelte",
      "php", "go", "python", "sql",
      "markdown", "markdown_inline",
      "blade", "dockerfile", "yaml", "toml", "gitignore", "git_config",
    },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { "ruby" },
    },
    indent = {
      enable = true,
      disable = { "ruby" },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
  },
  config = function(_, opts)
    -- Register tsx parser for typescriptreact filetype
    vim.treesitter.language.register("tsx", "typescriptreact")
    
    -- Setup treesitter
    require("nvim-treesitter.configs").setup(opts)
    
    -- Setup autotag separately
    require("nvim-ts-autotag").setup({
      opts = {
        -- Defaults
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = false -- Auto close on trailing </
      },
      -- Also override individual filetype configs, these take priority.
      -- Empty by default, useful if one of the "opts" global settings
      -- doesn't work well in a specific filetype
      per_filetype = {
        ["html"] = {
          enable_close = false
        }
      }
    })
  end,
}

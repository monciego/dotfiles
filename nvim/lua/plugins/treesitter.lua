return {
    -- Treesitter for better syntax highlighting and indentation
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
    ensure_installed = {
      -- General scripting / system
      'bash', 'c', 'diff', 'lua', 'luadoc', 'vim', 'vimdoc', 'query',

      -- Web dev
      'html', 'css', 'scss', 'javascript', 'typescript', 'tsx', 'json',

      -- Backend
      'php', 'go', 'python', 'sql',

      -- Markdown and docs
      'markdown', 'markdown_inline',

      -- Frameworks & tools
      'blade',         -- Laravel Blade templates
      'dockerfile',    -- For container setups
      'yaml',          -- Config files
      'toml',          -- Another config format
      'gitignore',     -- Common git config
      'git_config',
    },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = {
        enable = true,
        disable = { 'ruby' },
      },
    },
}


# A Blazingly Bad Neovim Config

## Structure

```text
nvim/
├── init.lua                  -- Entry point
├── lua/
│   ├── config/
│   │   └── lazy.lua          -- Bootstraps lazy.nvim
│   ├── core/
│   │   ├── options.lua       -- Editor settings
│   │   └── keymaps.lua       -- Keybindings
│   └── plugins/
│       ├── treesitter.lua    -- Syntax highlighting
│       ├── colortheme.lua    -- Catppuccin (mocha)
│       ├── lsp.lua           -- LSP + Mason
│       ├── telescope.lua     -- Fuzzy finder
│       ├── autocomplete.lua  -- nvim-cmp completion
│       ├── neotree.lua       -- File explorer
│       ├── bufferline.lua    -- Buffer tabs #unused
│       ├── lualine.lua       -- Statusline
│       ├── formatting.lua    -- Conform (prettier, stylua, black)
│       ├── linting.lua       -- nvim-lint
│       ├── gitsigns.lua      -- Git signs in gutter
│       ├── trouble.lua       -- diagnostics panel
│       ├── whichkey.lua      -- keymap hints popup
│       ├── alpha.lua         -- Start screen
│       ├── autosession.lua   -- Auto session restore
│       ├── comment.lua       -- Toggle comments (gcc)
│       ├── surround.lua      -- Surround text (ys, ds, cs)
│       ├── autopairs.lua     -- Auto-close brackets
│       ├── todo-comments.lua -- Highlight TODO/FIXME
│       ├── indent-blankline.lua -- Indent guides
│       ├── dressing.lua      -- Better UI inputs
│       └── lazygit.lua       -- LazyGit integration
└── lazy-lock.json            -- Plugin version lockfile
```

## Requirements

- Neovim >= 0.10
- Git
- [Nerd Font](https://www.nerdfonts.com/) (for icons)
- [LazyGit](https://github.com/jesseduffield/lazygit) (optional)

Not managed by Mason:

- **Laravel:** `laravel-lsp` (install with Composer)

### Laravel LSP

Install Laravel LSP globally:

```bash
composer global require laravel/lsp
```

Make sure Composer's global `vendor/bin` is in your `PATH`:

```bash
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
```

Verify:

```bash
which laravel-lsp
```

## Key Bindings

Leader key is `<Space>`.

| Key                       | Mode   | Action                    |
| ------------------------- | ------ | ------------------------- |
| `jk` / `kj`               | Insert | Exit insert mode          |
| `Ctrl+s`                  | Normal | Save file                 |
| `Ctrl+h/j/k/l`            | Normal | Navigate splits           |
| `Tab` / `Shift-Tab`       | Normal | Next/prev buffer          |
| `<leader>v` / `<leader>h` | Normal | Vertical/horizontal split |
| `<leader>c`               | Normal | Close buffer              |
| `<leader>e`               | Normal | Toggle file explorer      |
| `<leader>sf`              | Normal | Find files                |
| `<leader>sg`              | Normal | Live grep                 |
| `<leader>lg`              | Normal | Open LazyGit              |
| `gcc`                     | Normal | Toggle line comment       |
| `gc`                      | Visual | Toggle comment selection  |

## Install

Clone to your Neovim config directory:

```bash
git clone <repo-url> ~/.config/nvim
```

Plugins install automatically on first launch via lazy.nvim.

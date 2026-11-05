# A Blazingly Bad Neovim Config

## Structure

```text
nvim/
├── init.lua                     -- Entry point (auto-imports lua/plugins/)
├── lua/
│   ├── config/
│   │   └── lazy.lua             -- Bootstraps lazy.nvim
│   ├── core/
│   │   ├── options.lua          -- Editor settings
│   │   ├── keymaps.lua          -- Keybindings
│   │   └── autocmds.lua         -- Autocommands
│   └── plugins/                 -- One file per plugin, loaded automatically
│       ├── alpha.lua            -- Start screen
│       ├── autocomplete.lua     -- nvim-cmp completion
│       ├── autopairs.lua        -- Auto-close brackets
│       ├── autosession.lua      -- Session save/restore
│       ├── breadcrumbs.lua      -- Code context in winbar
│       ├── code-runner.lua      -- <leader>rr compile & run C/Go/Rust in a tmux pane
│       ├── colorizer.lua        -- Color swatches before color codes
│       ├── colortheme.lua       -- Catppuccin with gruvbox colors
│       ├── comment.lua          -- Toggle comments (gcc)
│       ├── dressing.lua         -- Better UI inputs
│       ├── diffview.lua         -- Side-by-side git diffs and file history
│       ├── flash.lua            -- Jump anywhere with s + 2 chars
│       ├── formatting.lua       -- Conform (prettier, stylua, pint, ...)
│       ├── gitsigns.lua         -- Git signs in gutter
│       ├── indent-blankline.lua -- Indent guides
│       ├── grug-far.lua         -- Project-wide search and replace
│       ├── lazygit.lua          -- LazyGit integration
│       ├── linting.lua          -- nvim-lint
│       ├── lsp.lua              -- LSP + Mason
│       ├── lualine.lua          -- Statusline
│       ├── neotree.lua          -- File explorer
│       ├── noice.lua            -- Cmdline and popup UI
│       ├── nvim-tmux-navigation.lua -- Ctrl+h/j/k/l across nvim and tmux
│       ├── opencode.lua         -- OpenCode integration
│       ├── render-markdown.lua  -- Render markdown in the buffer
│       ├── snacks.lua           -- Image preview (snacks.image)
│       ├── surround.lua         -- Surround text (ys, ds, cs)
│       ├── telescope.lua        -- Fuzzy finder
│       ├── todo-comments.lua    -- Highlight TODO/FIXME
│       ├── treesitter.lua       -- Syntax highlighting
│       ├── treesitter-textobjects.lua -- af/if, ac/ic, aa/ia, ]f/[f
│       ├── trouble.lua          -- Diagnostics panel
│       ├── vim-test.lua         -- Run tests in a tmux pane
│       └── whichkey.lua         -- Keymap hints popup
├── snippets/                    -- Your own snippets (SnipMate .snippets format, see below)
└── lazy-lock.json               -- Plugin version lockfile
```

## Requirements

- Neovim >= 0.11
- Git
- [Nerd Font](https://www.nerdfonts.com/) (for icons)
- [LazyGit](https://github.com/jesseduffield/lazygit) (optional)
- Image preview: a terminal with the Kitty graphics protocol (Ghostty, Kitty, WezTerm), ImageMagick, and `allow-passthrough on` when inside tmux

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

| Key                                        | Mode          | Action                                                               |
| ------------------------------------------ | ------------- | -------------------------------------------------------------------- |
| `jk` / `kj`                                | Insert        | Exit insert mode                                                     |
| `Ctrl+s`                                   | Normal        | Save file                                                            |
| `Ctrl+h/j/k/l`                             | Normal        | Navigate splits                                                      |
| `Tab` / `Shift-Tab`                        | Normal        | Next/prev buffer                                                     |
| `<leader>v` / `<leader>h`                  | Normal        | Vertical/horizontal split                                            |
| `<leader>c`                                | Normal        | Close buffer                                                         |
| `<leader>e`                                | Normal        | Toggle file explorer                                                 |
| `<leader>sf`                               | Normal        | Find files                                                           |
| `<leader>sg`                               | Normal        | Live grep                                                            |
| `<leader>lg`                               | Normal        | Open LazyGit                                                         |
| `<leader>tt` / `<leader>tf`                | Normal        | Test nearest / test file                                             |
| `<leader>rr` / `<leader>rq`                | Normal        | Compile & run current file (C, Go, Rust) / close runner pane         |
| `<leader>do`                               | Normal        | Toggle diagnostics                                                   |
| `<leader>ip`                               | Normal        | Preview image under cursor                                           |
| `s` / `S`                                  | Normal        | Flash jump / select treesitter node                                  |
| `vaf` `dif` `cia` `yac`                    | Normal        | Function, argument and class text objects                            |
| `]f` / `[f`, `]k` / `[k`                   | Normal        | Next/prev function, next/prev class                                  |
| `<leader>sR` / `<leader>sW`                | Normal/Visual | Project search & replace (grug-far) / replace word under cursor      |
| `<leader>gd` / `<leader>gh` / `<leader>gH` | Normal        | Diffview changes / file history / repo history (`<leader>gq` closes) |
| `<leader>mr`                               | Normal        | Toggle markdown rendering                                            |
| `gcc`                                      | Normal        | Toggle line comment                                                  |
| `gc`                                       | Visual        | Toggle comment selection                                             |

## Snippets

Snippets come from [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) plus your own in `snippets/`. Type the trigger, pick it in the completion menu (`Tab`/`C-j`, then `Enter`), then `Tab` / `S-Tab` to jump between the blanks.

| File | Used in | Triggers |
| --- | --- | --- |
| `php/php.snippets` | php | `phpclass` `pubf` `prif` `prof` `ctor` `strict` `fnn` `match` |
| `php/laravel.snippets` | php | `lctrl` `lmodel` `lmig` `lrel` `lroute` `lroutef` `lval` `ltest` `ltestu` `lfactory` |
| `blade.snippets` | blade | `bx` `bform` `berror` `bold` |
| `go.snippets` | go | `iferr` `iferrw` `meth` `st` `jf` `hfunc` `ttest` |
| `rust.snippets` | rust | `mainr` `st` `implnew` `fnr` `tmod` `mres` `pd` |
| `c.snippets` | c | `mainc` `guard` `pf` `mallocc` `tstruct` `forn` |
| `javascript.snippets` | js, ts, jsx, tsx | `cl` `afn` `aafn` `fetchj` `desc` `itt` |
| `typescript.snippets` | ts, tsx | `intf` `typ` `asyncfn` |
| `javascriptreact.snippets` | jsx, tsx | `rfc` `us` `ue` `uref` `umemo` `ucb` |
| `typescriptreact.snippets` | tsx | `rfcp` |

A file is named after the filetype it's for (`go.snippets`), or sits in a folder named after it (`php/*.snippets`). `extends` at the top of a file pulls in another filetype's snippets: `typescriptreact.snippets` extends `typescript` and `javascriptreact`. Restart Neovim after editing.

Format: a `snippet <trigger> <description>` line, then the code indented by one tab. `$1`, `$2` are the blanks in `Tab` order, `${1:default}` gives a blank a default, `${1|a,b|}` is a pick-list, and `$0` is where the cursor ends. Escape a literal `$` as `\$` and a backtick as `` \` `` (unescaped backticks run Vim code).

```snippets
snippet pubf public function
	public function ${1:name}(${2}): ${3:void}
	{
		$0
	}
```

Emmet only suggests real HTML tags or Emmet syntax (`div.card`, `ul>li*3`), so plain words don't turn into `<word></word>` tags.

## Install

This config is part of the [dotfiles](../README.md) repo. Clone it and run `setup.sh`, which symlinks `nvim/` to `~/.config/nvim`:

```bash
git clone https://github.com/monciego/dotfiles ~/dotfiles
~/dotfiles/setup.sh
```

Plugins install automatically on first launch via lazy.nvim. To add a plugin, drop a new file in `lua/plugins/` that returns a lazy.nvim spec.

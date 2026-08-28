# dotfiles

Personal dotfiles and configs fueled by nicotine and caffeine. Managed with symlinks via [setup.sh](./setup.sh).

## Contents

| Path              | Tool                          | Symlink target                   |
| ----------------- | ----------------------------- | -------------------------------- |
| `.bashrc`         | Bash shell                    | `~/.bashrc`                      |
| `.profile`        | Login shell env               | `~/.profile`                     |
| `.gitconfig`      | Git                           | `~/.gitconfig`                   |
| `nvim/`           | Neovim (lazy.nvim, LSP, etc.) | `~/.config/nvim`                 |
| `ghostty/`        | Ghostty terminal + themes     | `~/.config/ghostty`              |
| `tmux/.tmux.conf` | tmux                          | `~/.tmux.conf`                   |
| `zed/`            | Zed editor (settings/keymaps) | `~/.config/zed`                  |
| `obsidian/`       | Obsidian vault config         | copy into your vault (see below) |

## Setup on a new machine

1. Clone into `~/dotfiles`:

   ```bash
   git clone https://github.com/monciego/dotfiles ~/dotfiles
   ```

2. Run the installer to create symlinks:

   ```bash
   ~/dotfiles/setup.sh
   ```

   This installs TPM if needed and symlinks .bashrc, .profile, .gitconfig, tmux, and the nvim/ghostty/zed config dirs into place.

3. Reload your shell: `source ~/.bashrc`.

### Obsidian

The repo's `obsidian/` holds vault-level settings (`.obsidian/`) and `.obsidian.vimrc`. `setup.sh` deliberately skips it — `~/.config/obsidian` is app data, not config. Copy it into each vault you want to use it in instead:

```bash
cp -r ~/dotfiles/obsidian/.obsidian ~/path/to/vault/
cp ~/dotfiles/obsidian/.obsidian.vimrc ~/path/to/vault/
```

## Requirements

- **Neovim** `>= 0.10` — see [nvim/README.md](./nvim/README.md) for plugins, keybindings, and Laravel LSP setup.
- **Nerd Font** for icons, **Git**, and optionally **LazyGit**.
- Toolchains referenced in `.bashrc`: Node/nvm, pnpm, bun, PHP (herd-lite), Java 17, Android SDK, Rust (cargo), Go, Composer.

## How it works

Real files live in this repo; `setup.sh` creates symlinks so your configs are version-controlled in one place while apps read their standard config paths. Edit here, commit, and pull on other machines.

Secrets (SSH keys, `.env`, certs) are ignored via [`.gitignore`](./.gitignore) — never commit them.

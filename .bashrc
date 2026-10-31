# Node.js

export NVM_DIR="$HOME/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# Package Managers

export PNPM_HOME="$HOME/.local/share/pnpm"

case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export BUN_INSTALL="$HOME/.bun"

# PHP

export PHP_INI_SCAN_DIR="$HOME/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

# Java

export JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"

# Android

export ANDROID_HOME="$HOME/Android"

# Development

export VCPKG_ROOT="$HOME/vcpkg"

# PATH
# path_prepend/path_append add a directory only if it exists and isn't already in PATH.
path_prepend() { [ -d "$1" ] && case ":$PATH:" in *":$1:"*) ;; *) PATH="$1:$PATH" ;; esac; }
path_append() { [ -d "$1" ] && case ":$PATH:" in *":$1:"*) ;; *) PATH="$PATH:$1" ;; esac; }

# Lowest priority first: each prepend goes in front of the previous one.
path_prepend "$HOME/.console-ninja/.bin"
path_prepend "$HOME/.config/herd-lite/bin"
path_prepend "$ANDROID_HOME/emulator"
path_prepend "$ANDROID_HOME/platform-tools"
path_prepend "$ANDROID_HOME/cmdline-tools/latest/bin"
path_prepend "$JAVA_HOME/bin"
path_prepend "$BUN_INSTALL/bin"
path_prepend "$HOME/.local/bin"
path_prepend "$HOME/.opencode/bin"
path_prepend "$PNPM_HOME/bin"
path_prepend "$HOME/.config/composer/vendor/bin"

path_append "/opt/nvim-linux-x86_64/bin"
path_append "/usr/local/go/bin"
path_append "$HOME/go/bin"

export PATH

# rust
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

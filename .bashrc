# nvim
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

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

export ANDROID_HOME="$HOME/Android/Sdk"

# Development

export VCPKG_ROOT="$HOME/vcpkg"

# PATH

export PATH="
$HOME/.console-ninja/.bin:
$HOME/.config/composer/vendor/bin:
$HOME/.local/bin:
$HOME/.config/herd-lite/bin:
$ANDROID_HOME/emulator:
$ANDROID_HOME/platform-tools:
$ANDROID_HOME/cmdline-tools/latest/bin:
$JAVA_HOME/bin:
$BUN_INSTALL/bin:
$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# rust
. "$HOME/.cargo/env"

# opencode
export PATH=/home/monciego/.opencode/bin:$PATH

# pnpm
export PNPM_HOME="/home/monciego/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
export PATH=$PATH:/usr/local/go/bin

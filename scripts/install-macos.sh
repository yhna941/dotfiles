#!/bin/sh
set -eu
repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
if ! command -v zsh >/dev/null 2>&1; then
  if ! command -v brew >/dev/null 2>&1; then
    printf 'Install zsh or Homebrew before running this installer.\n' >&2
    exit 1
  fi
  brew install zsh
fi
omz_dir=${ZSH:-$HOME/.oh-my-zsh}
if [ ! -e "$omz_dir" ]; then
  git clone https://github.com/ohmyzsh/ohmyzsh.git "$omz_dir"
elif [ ! -r "$omz_dir/oh-my-zsh.sh" ]; then
  printf 'Oh My Zsh directory exists but is invalid: %s\n' "$omz_dir" >&2
  exit 1
fi
mkdir -p "$HOME/.config"
link_config() {
  source_path=$1
  target_path=$2
  if [ -L "$target_path" ] && [ "$(readlink "$target_path")" = "$source_path" ]; then
    printf 'Already linked: %s\n' "$target_path"
    return
  fi
  if [ -e "$target_path" ] || [ -L "$target_path" ]; then
    backup_path="${target_path}.backup.$(date +%Y%m%d%H%M%S)"
    if [ -e "$backup_path" ] || [ -L "$backup_path" ]; then
      printf 'Backup already exists: %s\n' "$backup_path" >&2
      exit 1
    fi
    mv "$target_path" "$backup_path"
    printf 'Backed up: %s\n' "$backup_path"
  fi
  ln -s "$source_path" "$target_path"
  printf 'Linked: %s\n' "$target_path"
}
link_config "$repo_dir/nvim" "$HOME/.config/nvim"
link_config "$repo_dir/wezterm" "$HOME/.config/wezterm"
link_config "$repo_dir/shell" "$HOME/.config/dotfiles-shell"
zshrc="$HOME/.zshrc"
hook='# dotfiles shell configuration'
if ! [ -f "$zshrc" ] || ! grep -Fqx "$hook" "$zshrc"; then
  printf '\n%s\n%s\n' "$hook" '[ -r "$HOME/.config/dotfiles-shell/zsh/config.zsh" ] && source "$HOME/.config/dotfiles-shell/zsh/config.zsh"' >> "$zshrc"
  printf 'Added shell configuration to: %s\n' "$zshrc"
fi
if [ ! -r /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && [ ! -r /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  printf 'Install suggestions with: brew install zsh-autosuggestions\n'
fi

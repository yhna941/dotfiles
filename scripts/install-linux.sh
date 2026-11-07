#!/bin/sh
set -eu
repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
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
if [ ! -r /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && [ ! -r /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && [ ! -r /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  printf 'Install zsh-autosuggestions using your distribution package manager.\n'
fi

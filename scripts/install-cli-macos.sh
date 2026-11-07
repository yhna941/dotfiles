#!/bin/sh
set -eu
if ! command -v brew >/dev/null 2>&1; then
  printf 'Homebrew is required: https://brew.sh/\n' >&2
  exit 1
fi
for formula in fzf zoxide ripgrep fd bat lazygit; do
  if brew list --formula "$formula" >/dev/null 2>&1; then
    printf 'Already installed: %s\n' "$formula"
  else
    brew install "$formula"
  fi
done

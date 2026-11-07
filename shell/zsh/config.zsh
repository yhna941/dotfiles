# Shared interactive zsh settings.
autoload -Uz compinit
compinit
setopt AUTO_MENU AUTO_LIST COMPLETE_IN_WORD
setopt HIST_IGNORE_DUPS SHARE_HISTORY
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=${HISTFILE:-$HOME/.zsh_history}

# Load zsh-autosuggestions when installed.
for plugin in /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh; do
  if [[ -r $plugin ]]; then
    source "$plugin"
    break
  fi
done
unset plugin

# Optional CLI integrations.
if (( $+commands[fzf] )); then
  if fzf --zsh >/dev/null 2>&1; then
    source <(fzf --zsh)
  elif [[ -r /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
    source /usr/share/doc/fzf/examples/key-bindings.zsh
  elif [[ -r /usr/share/fzf/key-bindings.zsh ]]; then
    source /usr/share/fzf/key-bindings.zsh
  fi
fi
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi

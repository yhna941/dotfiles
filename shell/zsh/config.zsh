# Shared interactive zsh settings.
autoload -Uz compinit
compinit
setopt AUTO_MENU AUTO_LIST COMPLETE_IN_WORD
setopt HIST_IGNORE_DUPS SHARE_HISTORY
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=${HISTFILE:-$HOME/.zsh_history}

# Install with: brew install zsh-autosuggestions
for plugin in /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh; do
  if [[ -r $plugin ]]; then
    source "$plugin"
    break
  fi
done
unset plugin

# ~ Backstage Gossip ~
if [[ -n "$ZSH_DEBUGRC" ]]; then
  zmodload zsh/zprof
fi

# ~ House magic ~
source ~/zsh-defer/zsh-defer.plugin.zsh

# ~ Cue the prompt ~
eval "$(starship init zsh)"

# ~ Party Tricks ~
zsh-defer source ~/.dotfiles/zsh/plugins.zshrc
zsh-defer source ~/.dotfiles/zsh/aliases.zshrc
zsh-defer source ~/.dotfiles/zsh/utils.zshrc
zsh-defer source ~/.dotfiles/zsh/hooks.zshrc
zsh-defer source ~/.dotfiles/zsh/tooling.zshrc

# ~ Backstage Gossip ~
if [[ -n "$ZSH_DEBUGRC" ]]; then
  zprof
fi

# mise
eval "$(/Users/henri/.local/bin/mise activate zsh)"

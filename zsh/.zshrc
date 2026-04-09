# ~ Backstage Gossip ~
if [[ -n "$ZSH_DEBUGRC" ]]; then
  zmodload zsh/zprof
fi

source ~/zsh-defer/zsh-defer.plugin.zsh

# ~ Cue the prompt ~
eval "$(starship init zsh)"

# ~ House magic ~
zsh-defer source ~/.dotfiles/zsh/helpers.zshrc
zsh-defer ~/.dotfiles/zsh/hooks.zshrc

# ~ Atmosphere builds up behind the scenes ~
zsh-defer source ~/.dotfiles/zsh/env.zshrc
zsh-defer source ~/.dotfiles/secrets.env

# ~ Party Tricks ~
zsh-defer source ~/.dotfiles/zsh/aliases.zshrc

# ~ Backstage Gossip ~
if [[ -n "$ZSH_DEBUGRC" ]]; then
  zprof
fi

# ~ Backstage Gossip ~
if [[ -n "$ZSH_DEBUGRC" ]]; then
  zmodload zsh/zprof
fi

# ~ Cue the prompt ~
eval "$(starship init zsh)"

# ~ House magic ~
source ~/.dotfiles/zsh/helpers.zshrc

# ~ Atmosphere builds up behind the scenes ~
ease ~/.dotfiles/zsh/env.zshrc
ease ~/.dotfiles/secrets.env

# ~ Party Tricks ~
ease ~/.dotfiles/zsh/aliases.zshrc

# ~ Backstage Gossip ~
if [[ -n "$ZSH_DEBUGRC" ]]; then
  zprof
fi

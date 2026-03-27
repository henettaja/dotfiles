# ~ House tricks ~
if [[ -o interactive ]]; then
  source ~/zsh-defer/zsh-defer.plugin.zsh

  ease() {
    zsh-defer source "$1"
  }
else
  ease() {
    source "$1"
  }
fi

add_alias() {
    echo "Adding alias: $1"
    echo "alias $1=$2" >> ~/.dotfiles/zsh/aliases.zshrc
    source ~/.dotfiles/zsh/aliases.zshrc
}

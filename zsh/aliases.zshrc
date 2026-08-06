# ~ Party Tricks ~
alias zsh_zprof="time ZSH_DEBUGRC=1 zsh -i -c exit"
if command -v eza >/dev/null 2>&1; then
  alias ll="eza -la --group-directories-first --icons --header"
  alias ls="eza -l --group-directories-first --icons --header"
else
  alias ll="ls -lahG"
fi
lt() {
  eza --tree --level "${1:-2}" --icons
}
ltd() {
  eza --tree --level "${1:-2}" --icons --only-dirs
}
alias gcam="git commit -a -m"
alias gca="git commit -a"
alias gcm="git commit -m"

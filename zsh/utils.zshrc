add_alias() {
    echo "Adding alias: $1"
    echo "alias $1=\"$2\"" >> ~/.dotfiles/zsh/aliases.zshrc
    source ~/.dotfiles/zsh/aliases.zshrc
}

notify_success() {
    afplay /System/Library/Sounds/Glass.aiff
    osascript -e 'display notification "Done!" with title "Command Complete"'
}

notify_failure() {
    afplay /System/Library/Sounds/Basso.aiff
    osascript -e 'display notification "Error!" with title "Command failed"'
}

notify() {
  "$@" && notify_success || notify_failure
}

retry() {
  local times=$1
  shift  # Remove the first arg so $@ is now the command

  local success=0
  local failure=0

  for ((i = 1; i <= times; i++)); do
    printf "\r[Run %d/%d] Success: %d | Failure: %d\n" "$i" "$times" "$success" "$failure"
    if "$@"; then
      ((success++))
    else
      ((failure++))
    fi
  done

  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "Results: $success success, $failure failure"
  echo "Success rate: $(( success * 100 / times ))%"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━"

  [ $failure -eq 0 ]
}

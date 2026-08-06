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

# PROXY is set in secrets.env
proxy_on() {
  export HTTP_PROXY="$PROXY"
  export HTTPS_PROXY="$PROXY"
  export ALL_PROXY="$PROXY"

  git config --global http.proxy "$PROXY"
  git config --global https.proxy "$PROXY"
}

proxy_off() {
  unset HTTP_PROXY
  unset HTTPS_PROXY
  unset ALL_PROXY

  git config --global --unset http.proxy 2>/dev/null || true
  git config --global --unset https.proxy 2>/dev/null || true

  if command -v npm >/dev/null 2>&1; then
    command npm config delete proxy
    command npm config delete https-proxy
  fi
}

# Conditionally enable client proxy when VPN is on
update_proxy() {
  if route get default 2>/dev/null | awk '/interface:/{print $2}' | grep -q '^utun'; then
    proxy_on
  else
    proxy_off
  fi
}

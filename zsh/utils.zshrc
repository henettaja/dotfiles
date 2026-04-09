add_alias() {
    echo "Adding alias: $1"
    echo "alias $1=\"$2\"" >> ~/.dotfiles/zsh/aliases.zshrc
    source ~/.dotfiles/zsh/aliases.zshrc
}

# PROXY is set in secrets.env
proxy_on() {
  export HTTP_PROXY="$PROXY"
  export HTTPS_PROXY="$PROXY"
  export ALL_PROXY="$PROXY"

  git config --global http.proxy "$PROXY"
  git config --global https.proxy "$PROXY"

  if command -v npm >/dev/null 2>&1; then
    command npm config set proxy "$PROXY"
    command npm config set https-proxy "$PROXY"
  fi
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

export NVM_DIR="$HOME/.nvm"

export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export JAVA_HOME=$(/usr/libexec/java_home -v 17.0.13)

export EDITOR="micro"
export VISUAL="micro"
export GIT_EDITOR="micro"

# Henri's dotfiles

Small personal shell setup, currently centered around `zsh` and `mise`.

## Layout

- `zsh/.zshrc` Main entrypoint for the zsh config.
- `zsh/.zprofile` Shell startup behavior for non-interactive shells.
- `zsh/.zshenv` Environment exports and shell-wide variables.
- `zsh/utils.zshrc` Small helper functions and shell startup behavior.
- `zsh/tooling.zshrc` Toolchain setup shell integrations.
- `zsh/hooks.zshrc` Zsh hook functions.
- `zsh/aliases.zshrc` Aliases and small conveniences.
- `secrets.env` Local-only secrets loaded by the shell startup flow.

## Startup flow

The shell startup is staged so the prompt appears instantly while the rest of the environment gets wired up behind the scenes.

In `zsh/.zshrc`:

1. Cue the ([starship](https://starship.rs/)) prompt.
2. Environment exports are loaded from `zsh/.zshenv`.
3. Helpers are loaded.
4. Secrets, tooling setup and aliases are staged in the background in interactive shells with `zsh-defer`.

## Setup

Bootstrap your Mac with:
```sh
mise -E work bootstrap --from git@github.com:henettaja/dotfiles.git --update --force-dotfiles --yes
```

This script does the following:
- Links .zprofile, .zshrc, and .zshenv files as symlinks treating the files in `zsh/` as the source.
- Sets some MacOS default settings
- Enables TouchID for sudo

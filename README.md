# Henri's dotfiles

Small personal shell setup, currently centered around `zsh`.

## Layout

- `zsh/.zshrc` Main entrypoint for the zsh config.
- `zsh/utils.zshrc` Small helper functions and shell startup behavior.
- `zsh/.zshenv` Environment exports and shell-wide variables.
- `zsh/tooling.zshrc` Toolchain setup shell integrations.
- `zsh/aliases.zshrc` Aliases and small conveniences.
- `Brewfile` Homebrew-managed dependencies used by the shell setup.
- `scripts/ensure-deps.sh` Installs and updates the tracked dependencies.
- `secrets.env` Local-only secrets loaded by the shell startup flow.

## Startup flow

The shell startup is staged so the prompt appears instantly while the rest of the environment gets wired up behind the scenes.

In `zsh/.zshrc`:

1. Cue the ([starship](https://starship.rs/)) prompt.
2. Environment exports are loaded from `zsh/.zshenv`.
3. Helpers are loaded.
4. Secrets, tooling setup and aliases are staged in the background in interactive shells with `ease`.

## What `ease` does

`ease` lives in `zsh/utils.zshrc`.

- In interactive shells, it uses `zsh-defer` so non-essential setup loads behind the scenes after the prompt is visible.
- In non-interactive shells, it falls back to synchronous `source` so agents can use the terminal.

This keeps startup feeling fast without causing issues with agents, scripts or other non-interactive shell usage.

## Notes

- The repo assumes `~/.zshrc` sources `~/.dotfiles/zsh/.zshrc`.
- `add_alias` appends new aliases to `zsh/aliases.zshrc`.

## Dependencies

Selected non-standard command-line dependencies are tracked in `Brewfile`.

To install or update them:

```sh
./scripts/ensure-deps.sh
```

That script:

- installs anything listed in `Brewfile` through Homebrew
- updates or clones `zsh-defer` into `~/zsh-defer`
- leaves the shell config usable even before `eza` is installed by falling back to `ls -lahG`

Right now that tracked set covers shell-facing tools such as `starship`, `eza`, `micro`, `nvm`, and Java.

## Setup

Link the shell entrypoint with:

```sh
./scripts/link.sh
```

That script only manages one thing:

- creates `~/.zshrc` as a symlink to `~/.dotfiles/zsh/.zshrc`
- does nothing if that symlink is already correct
- stops instead of overwriting an existing `~/.zshrc`

# Henri's dotfiles

Small personal shell setup, currently centered around `zsh`.

## Layout

- `zsh/.zshrc` Main entrypoint for the zsh config.
- `zsh/helpers.zshrc` Small helper functions and shell startup behavior.
- `zsh/env.zshrc` Environment and toolchain setup.
- `zsh/aliases.zshrc` Aliases and small conveniences.
- `Brewfile` Homebrew-managed dependencies used by the shell setup.
- `scripts/ensure-deps.sh` Installs and updates the tracked dependencies.
- `secrets.env` Local-only secrets loaded by the shell startup flow.

## Startup flow

The shell startup is staged so the prompt appears instantly while the rest of the environment gets wired up behind the scenes.

In `zsh/.zshrc`:

1. Cue the ([starship](https://starship.rs/)) prompt.
2. Helpers are loaded.
3. Environment files and aliases are staged in the background in interactive shells with `ease`.

## What `ease` does

`ease` lives in `zsh/helpers.zshrc`.

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

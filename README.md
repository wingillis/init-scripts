# init-scripts

Personal shell, Rex, and Neovim configuration, alongside older setup scripts.

## Current configuration

Install the current configurations from these paths in the repository:

| Configuration | Repository path | Install location |
| --- | --- | --- |
| Zsh | `.zshrc` | `~/.zshrc` |
| Neovim | `.config/nvim/` | `~/.config/nvim/` |
| Rex | `.config/rex/` | `~/.config/rex/` |
| Rex Typst preview helper | `bin/typst-pager` | `~/.local/bin/typst-pager` |

Back up any existing files or directories at those locations first, then link
the current files from a checkout:

```sh
repo="$HOME/dev/init-scripts" # adjust to the checkout location
mkdir -p "$HOME/.config" "$HOME/.local/bin"
ln -s "$repo/.zshrc" "$HOME/.zshrc"
ln -s "$repo/.config/rex" "$HOME/.config/rex"
ln -s "$repo/.config/nvim" "$HOME/.config/nvim"
ln -s "$repo/bin/typst-pager" "$HOME/.local/bin/typst-pager"
```

The shell configuration expects Oh My Zsh, its `zsh-autosuggestions` and
`zsh-syntax-highlighting` plugins, and Atuin; it also sources
`~/.atuin/bin/env` and `~/.local/bin/env`. Neovim bootstraps lazy.nvim and
its plugins on first launch. Telescope's live grep requires `rg`.

The Rex Typst preview (`Cmd-Shift-Y`) requires `typst` and the pager. The
pager uses `uv` if available, or Python 3 as a fallback. Its terminal must
support the Kitty graphics protocol.

## Legacy setup

The remaining scripts and settings reflect older environments; review them
before use. For the legacy Vim configuration, open vim and run
`:CocInstall coc-python` to enable async Python linting.

In order to run port-forwarding and proxy-jump to a compute node on o2, you need to add the following to `~/.ssh/config`:

```bash
Host compute*o2.rc.hms.harvard.edu
	ProxyJump ${USERNAME}@login02.o2.rc.hms.harvard.edu
	User ${USERNAME}
```



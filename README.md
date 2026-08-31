# dotfiles

Personal configuration managed with [chezmoi](https://www.chezmoi.io/), with
toolchains managed by [mise](https://mise.jdx.dev/).

The split is deliberate:

- **chezmoi** owns config files — templating for per-machine differences,
  external repos (oh-my-zsh, tpm), and the scripts that run on apply.
- **mise** owns language runtimes and CLI tools, declared in
  `dot_config/mise/config.toml`.

## Quickstart

New machine, from nothing:

```sh
curl -fsSL https://raw.githubusercontent.com/Chocrates/dotfiles/main/bootstrap.sh | bash
```

Already have chezmoi:

```sh
chezmoi init --apply Chocrates
```

On first init chezmoi prompts for the machine type (`personal` / `work`), git
name and email, and stores them in `~/.config/chezmoi/chezmoi.toml`.

## Layout

| Path | Purpose |
| --- | --- |
| `.chezmoi.toml.tmpl` | First-run prompts; defines `.machine`, `.name`, `.email` |
| `.chezmoiexternal.toml` | oh-my-zsh, zsh plugins, the agnosterzak theme, tpm |
| `.chezmoiignore` | Repo-only files that must never land in `$HOME` |
| `.chezmoiscripts/` | Apply-time hooks (apt packages, `mise install`, tpm plugins) |
| `dot_zshrc.tmpl` | Thin loader — oh-my-zsh, then `~/.config/zsh/*.zsh` |
| `dot_config/zsh/` | The actual shell config, split by concern |
| `dot_config/mise/config.toml` | Global tool versions |
| `dot_gitconfig.tmpl` | Git config; identity comes from the prompts |
| `dot_config/nvim/` | Neovim config (still on packer — rewrite pending) |
| `dot_tmux.conf` | tmux config |
| `private_dot_claude/` | Claude Code: templated `settings.json`, hooks, custom agents |
| `dot_pi/agent/skills/` | Skills for the `pi` coding agent |
| `scripts/` | Small helper scripts installed to `~/scripts` |

## AI agent config

Two agents are configured here, and in both cases only the *declarative* half
is versioned:

**Claude Code** (`private_dot_claude/`)
- `settings.json.tmpl` — hooks, statusline, enabled plugins, marketplaces.
  The absolute paths it contains are templated on `.chezmoi.homeDir`, and the
  node interpreter resolves to the system node with a `lookPath` fallback, so
  the file is portable across machines.
- `hooks/` — the caveman hook scripts. These are byte-identical copies of what
  the caveman plugin ships. They are versioned anyway because `settings.json`
  references them by absolute path, so `chezmoi apply` alone produces a working
  setup with no plugin-installer step. The cost is that they must be refreshed
  by hand when the plugin updates.
- `agents/` — custom agent definitions.
- `skills/` — user-level skills, available in every project.

Deliberately **not** versioned: `.credentials.json` (live OAuth token),
`settings.local.json` (per-machine permission allowlist), and every runtime
directory Claude rewrites during a session. See `.chezmoiignore`.

**pi** (`dot_pi/agent/skills/`)
- Only skills. pi discovers them at `~/.pi/agent/skills/`; a directory
  containing `SKILL.md` is a skill root, otherwise bare `.md` children are
  loaded. Frontmatter: `name`, `description`, `disable-model-invocation`.
- `auth.json`, `settings.json`, sessions and model catalogs are ignored — the
  first holds an API credential and the rest are rewritten by pi at runtime.

## Machine variance

Anything that differs between boxes is templated on `.machine`:

- `personal` gets the llama.cpp / pi-node / fastfetch block.
- `work` sources `~/.fico.zshrc` and defines the `load-gh` / `load-art`
  Bitwarden helpers.

Anything that must not be versioned at all goes in files that are sourced if
present and ignored if not:

- `~/.zshrc.local`
- `~/.gitconfig.local`

## Day-to-day

```sh
chezmoi edit ~/.zshrc      # edit the source, not the target
chezmoi diff               # what would change
chezmoi apply              # apply it
chezmoi update             # git pull + apply
chezmoi cd                 # drop into the source repo

chezmoi --refresh-externals apply   # force-refresh oh-my-zsh, tpm, etc.
mise install                        # install/update declared toolchains
```

## Known rough edges

- **Neovim is still on `packer.nvim`**, which is unmaintained. `lsp-zero` and
  `nvim-cmp` are also a generation behind what Neovim 0.11+ offers natively.
  A full rewrite onto `lazy.nvim` is planned as a separate change; the config
  is carried over here as-is.
- **pyenv and mise overlap.** mise is activated before pyenv so pyenv still
  wins for Python; mise handles everything else. Consolidating onto mise is a
  deliberate future step, not an accident.

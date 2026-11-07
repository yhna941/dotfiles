# Dotfiles

A shared LazyVim, WezTerm, zsh, and PowerShell configuration for macOS and Windows. It uses LazyVim defaults, the Catppuccin Latte terminal and editor theme, and JetBrains Mono.

## What's included

- **Python:** LazyVim's Python extra, including Python language server support and Ruff integration.
- **C/C++:** the clangd extra for completion, diagnostics, and navigation.
- **Docker:** Dockerfile and Docker Compose language support.
- **YAML:** language server and schema support for files such as Kubernetes manifests. Schema detection depends on the file and project configuration.
- **WezTerm:** a readable font, Catppuccin Latte colors, and the default terminal shortcuts.
- **zsh and PowerShell:** tab completion and history-based inline suggestions.

LazyVim also provides file search, project search, Git integration, completion, and diagnostics. Language servers and related tools may need to be installed on each machine through `:Mason`. Docker, kubectl, compilers, Python, and other runtime tools are installed separately.

## Requirements

Install Git, Neovim, WezTerm, curl, ripgrep, fd, a C compiler, and tree-sitter CLI. A Nerd Font is recommended for icons. See the [LazyVim requirements](https://www.lazyvim.org/) for current details.

## Setup

Clone this repository to a stable location. The scripts back up existing configuration before linking it to this repository. Moving or deleting the repository breaks the links.

macOS:

```sh
git clone <repository-url> ~/dev/dotfiles
cd ~/dev/dotfiles
./scripts/install-macos.sh
```

Windows PowerShell (native Neovim):

```powershell
git clone <repository-url> "$HOME\dev\dotfiles"
cd "$HOME\dev\dotfiles"
.\scripts\install-windows.ps1
```

The Windows script uses directory junctions. WezTerm may read a different configuration file if a higher-priority file exists. WSL is a separate Linux environment: configure Neovim and install its tools inside WSL separately.

On macOS, install suggestions with `brew install zsh-autosuggestions`. Open a new WezTerm tab to load the zsh settings. Press Tab to complete and Right Arrow to accept a history suggestion. Existing zsh settings are preserved.

On Windows, the installer adds a hook to the current host profile; run it from the PowerShell version you use in WezTerm. PowerShell 7 with PSReadLine is recommended. Open a new terminal after installation. Existing profile content is preserved.

Restart WezTerm and run `nvim`. Plugins may be installed on first launch. Run `:LazyHealth` to check the environment and `:Mason` to inspect language tools. Commit the generated `nvim/lazy-lock.json` to share plugin versions.

For CMake projects, generate compile commands with `cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON` so clangd can understand project settings. Python projects can use their own virtual environment.

## Common shortcuts

The leader key is Space. Press it and pause to explore available commands.

- `Space Space`: find files
- `Space /`: search project contents
- `Space e`: file explorer
- `gd`: go to definition; `Ctrl-o`: go back
- `K`: documentation
- `Space ca`: code actions
- `Space cr`: rename
- `Space cf`: format
- `:Lazy`, `:LazyExtras`, `:Mason`: manage plugins, extras, and tools

## Maintenance

Edit `nvim/` or `wezterm/wezterm.lua`, then commit and push your changes. Pull them on your other machine. Do not commit passwords, tokens, or private keys.

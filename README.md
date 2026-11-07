# Dotfiles

LazyVim, WezTerm, zsh, and PowerShell configuration for macOS, Linux, and Windows. The editor and terminal use Catppuccin Latte and JetBrains Mono.

## Requirements

Git, Neovim, WezTerm, curl, ripgrep, fd, a C compiler, and tree-sitter CLI. A Nerd Font is recommended. See [LazyVim requirements](https://www.lazyvim.org/) for details.

## Installation

Clone the repository to a permanent location. Installers back up existing configuration and create links to the repository.

macOS:

```sh
git clone <repository-url> ~/dev/dotfiles
cd ~/dev/dotfiles
./scripts/install-macos.sh
```

Linux, including WSL:

```sh
git clone <repository-url> ~/dev/dotfiles
cd ~/dev/dotfiles
./scripts/install-linux.sh
```

Windows PowerShell, for native Neovim:

```powershell
git clone <repository-url> "$HOME\dev\dotfiles"
cd "$HOME\dev\dotfiles"
.\scripts\install-windows.ps1
```

The Windows installer uses directory junctions and updates the current host's PowerShell profile. Run it in the PowerShell version used by WezTerm. PowerShell 7 and PSReadLine are recommended. A higher-priority WezTerm configuration may override the installed file.

Install `zsh-autosuggestions` for zsh history suggestions (`brew install zsh-autosuggestions` on macOS). On Linux, install dependencies through the distribution package manager. WSL requires its own Neovim and tools; WezTerm can run on Windows and connect to WSL.

Restart the terminal and run `nvim`. Use `:LazyHealth` to check dependencies and `:Mason` to inspect language tools. Commit `nvim/lazy-lock.json` to share plugin versions.

## Editor

LazyVim extras configure Python, clangd, Docker, and YAML support. Install runtimes, compilers, Docker, kubectl, and other project tools separately. YAML schema detection depends on the project.

For CMake projects, generate compile commands with:

```sh
cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
```

The leader key is Space:

- `Space Space`: find files
- `Space /`: search project contents
- `Space e`: file explorer
- `gd`: definition; `Ctrl-o`: back
- `K`: documentation
- `Space ca`: code actions
- `Space cr`: rename
- `Space cf`: format
- `:Lazy`, `:LazyExtras`, `:Mason`: manage plugins and tools

## CLI tools

Optional installers for macOS and Windows:

```sh
./scripts/install-cli-macos.sh
```

```powershell
.\scripts\install-cli-windows.ps1
```

They install fzf, zoxide, ripgrep, fd, bat, and lazygit. On Linux, use the distribution package manager. Restart the terminal after installation.

When available, fzf provides `Ctrl-R` and `Ctrl-T` bindings in zsh, and zoxide provides `z` and `zi` in zsh and PowerShell. PowerShell fzf bindings are not configured.

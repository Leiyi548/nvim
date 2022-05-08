<p align="center">
  <a href="https://github.com/Leiyi548/nvim"><img src="./img/logo.png" width="200" height="200" alt="my_neovim"></a>
</p>

<div align="center">

# Neovim

_✨ neovim lua config ✨_

</div>

## Install

<details>
  <summary><strong>Prerequisites</strong> <small><i>(🔎 Click to expand/collapse)</i></small></summary>

- [Neovim](https://github.com/neovim/neovim) >= 0.6.0
  ```shell
  brew install neovim --HEAD
  ```
- [ripgrep](https://github.com/BurntSushi/ripgrep)
  ```shell
  brew install ripgrep
  ```
- [fd](https://github.com/sharkdp/fd)
  ```shell
  brew install fd
  ```
- [NodeJS](nodejs-install) >= v16.13.0 most language servers need this
  ```shell
  brew install node
  ```
- [Lazygit](https://github.com/jesseduffield/lazygit)

  ```shell
  brew install lazygit
  ```

  </details>

<details>
  <summary><strong>Recommend</strong> <small><i>(🔎 Click to expand/collapse)</i></small></summary>

### Recommended Font

- [FiraCode Nerd Font](https://github.com/tonsky/FiraCode/blob/master/README_CN.md): My preferred font
- Any of the [Nerd Fonts]

On macOS with Homebrew, choose one of the [Nerd Fonts],
for example, here are some popular fonts:

```shell
brew tap homebrew/cask-fonts
brew search nerd-font
brew install --cask font-fira-code-nerd-font
brew install --cask font-victor-mono-nerd-font
brew install --cask font-iosevka-nerd-font-mono
brew install --cask font-hack-nerd-font
```

### Recommended Linters

```shell
### cpp
# For .cpp file check linter error
brew install cppcheck
# For .cpp file format
brew install clang-format

### python
# For .py file check linter error
brew install flake8
# For .py file format
brew install black

### lua
# For .lua file format
brew install stylua

### markdown and html
sudo npm install -g prettier
sudo npm install -g ls_emmet

### go
brew install golangci-lint
```

</details>

```shell
mv ~/.config/nvim ~/.config/nvim_bakcup
git clone https://github.com/Leiyi548/nvim.git ~/.config/nvim
nvim # run :PackerSync
```

## Overview

<details>
  <summary>
    <strong>Screenshots</strong>
    <small><i>(🔎 Click to expand/collapse)</i></small>
  </summary>

- Alpha (Dashboard)
  ![](img/2022-02-10-17-51-58.png)
  ![](img/2022-02-10-17-53-15.png)
- Lazygit
  ![](img/2022-02-10-17-54-36.png)
  ![](img/2022-02-10-17-54-57.png)

</details>

## TODO

### CONFIG SETUP

- [x] removed unused plugins
- [x] add format and linting
- [ ] Debug
- [x] fast tab/buffer navigation
- [x] use vscode icon for nvim-cmp
- [x] session management
- [x] project management
- [x] file management
- [x] lazy load plugins
- [x] Treesitter Setup

### plugins

- [x] [telescope-file-browser.nvim](https://github.com/nvim-telescope/telescope-file-browser.nvim)
- [x] [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)
- [x] [github/copilot.vim](https://github.com/github/copilot.vim)
- [x] [stevearc/aerial.nvim](https://github.com/stevearc/aerial.nvim)

### language development

- [ ] go
  - [x] lsp
  - [x] format
  - [x] diagnostic
  - [x] autoimport
  - [ ] debug
- [ ] HTML
  - [ ] lsp
  - [x] format
  - [x] diagnostic
- [ ] Javascript
  - [ ] lsp
  - [ ] format
  - [ ] diagnostic
- [ ] Typescript
  - [ ] lsp
  - [ ] format
  - [ ] diagnostic
- [x] Python
  - [x] lsp
  - [x] format
  - [x] diagnostic
  - [x] debug

## Other Neovim configurations

- [LunarVim](https://github.com/LunarVim/LunarVim)
- [Nvchad](https://github.com/NvChad/NvChad)
- [Allen191819/neovim](https://github.com/Allen191819/neovim)
- [denstiny/nvim-nanny](https://github.com/denstiny/nvim-nanny)
- [philopence/nvim](https://github.com/philopence/nvim)
- [ChristianChiarulli/nvim](https://github.com/ChristianChiarulli/nvim)
- [ayamir/nvimdots](https://github.com/ayamir/nvimdots)
- [DoomVim](https://github.com/NTBBloodbath/doom-nvim)
- [SpaceVim](https://github.com/SpaceVim/SpaceVim)
- [ravenxrz/dotfiles](https://github.com/ravenxrz/dotfiles)

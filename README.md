# Cosyvim - coc

## Prerequisites

- pyx

```sh
pip3 install -i https://mirrors.aliyun.com/pypi/simple neovim
```

## language

- [x] lua
- [x] vue
- [ ] go


## some issues

- tab 键等于 C-i 键

区分 tab 和 C-i 键(**目前好像无用**)

```lua
vim.cmd([[
  let &t_TI = "\<Esc>[>4;2m"
  let &t_TE = "\<Esc>[>4;m"
]])
```

## Tips

- Improve key repeat

```
mac os need restart
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

linux
xset r rate 210 40
```

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
- [glepnir/nvim](https://github.com/glepnir/nvim)

## Donate

[![](https://img.shields.io/badge/PayPal-00457C?style=for-the-badge&logo=paypal&logoColor=white)](https://paypal.me/bobbyhub)

If you'd like to support my work financially, buy me a drink through [paypal](https://paypal.me/bobbyhub)

## Licenese MIT

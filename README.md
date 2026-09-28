# Ambxst Neovim

A focused Neovim configuration built on NvChad, with a warm translucent Ambxst theme and practical coding tools.

## Included

- VS Code-style completion with LSP, snippets, buffer words, and file paths
- `<Tab>` / `<S-Tab>` completion and snippet navigation
- `<C-Space>` to trigger completion manually
- LuaSnip and friendly-snippets support
- HTML and CSS language servers, plus NvChad's Lua LSP setup
- Always-visible indentation guides with current-scope highlighting
- Treesitter, Telescope, NvimTree, Gitsigns, Mason, and Conform
- Autopairs and Lua formatting support
- A clean editor layout without the top tab bar or bottom statusline

## Requirements

- Neovim 0.10 or newer
- Git
- A Nerd Font for icons
- `stylua` if Lua formatting is needed

Language servers can be installed from inside Neovim with `:Mason`.

## Installation

Back up the existing configuration, then clone this repository as Neovim's config directory:

```bash
mv ~/.config/nvim ~/.config/nvim.backup
git clone https://github.com/YOUR-USERNAME/ambxst-nvim.git ~/.config/nvim
```

Start Neovim. `lazy.nvim` will install the plugins automatically.

## Useful keys

| Key | Action |
| --- | --- |
| `<Space>ff` | Find files |
| `<Space>fw` | Search project text |
| `<Space>e` | Toggle file tree |
| `<C-Space>` | Open completion |
| `<Tab>` | Next completion item or jump in snippet |
| `<S-Tab>` | Previous completion item or jump backward |
| `<Enter>` | Confirm completion |

The leader key is `<Space>`.

## Theme

The configuration reads the Ambxst palette from:

```text
~/.cache/ambxst/colors.json
```

If that file is unavailable, safe fallback colors are used.

## License

Personal configuration. NvChad and its plugins retain their respective licenses.

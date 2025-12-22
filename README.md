# My Neovim Configuration on WSL2 (I'm now using it on a shiny M1Max Macbook)

## Purpose

This is a neovim configuration as a js/golang dev's daily driver.

## Neovim Configuration Location on Mac/WSL

`~/.config/nvim`

## Usage

1. Install the latest Neovim (0.9+) and make sure `git` is available.

2. Clone this repo into `~/.config/nvim`.

3. Open Neovim once; [lazy.nvim](https://github.com/folke/lazy.nvim) bootstraps itself. Run `:Lazy sync` to install/update plugins.

4. You may need extra tooling: LSP servers (`gopls`, `tsserver`, `efm-language-server`, `rust-analyzer`), `eslint_d`, Tree-sitter parsers, nerd fonts for icons, `ctags`, and `bat` for fzf previews.

## Plugin Management

### NeoVim Plugin Location on Mac

`~/.local/share/nvim/plugged`

### Plugin Manager

Plugins are managed with [lazy.nvim](https://github.com/folke/lazy.nvim) in `lua/plugins/init.lua`. Core options live in `lua/config/*` and everything else sits in `lua/my-lua-configs/`.

Common commands:

* `:Lazy sync` - install or update plugins
* `:Lazy clean` - remove unused plugins
* `:Lazy profile` - inspect startup cost

## Autocomplete

### Plugin

~~After a long time usage of [YouCompleteMe](https://github.com/Valloric/YouCompleteMe), I switched to [coc.nvim](https://github.com/neoclide/coc.nvim). With the great async feature of neovim, it works like a charm especially when most mainstream languages have great [language server protocol](https://microsoft.github.io/language-server-protocol/) supports(__Thank you Microsoft, sincerely__).~~

I'm using [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) now, which works out nicely but as the author said, it's still in active development.


### Language support 

#### Golang 

You might need to install additional go packages to use full feature of [vim-go](https://github.com/fatih/vim-go). Please refer to the instructions.

A few useful shortcuts I use every day:

```
* <F12>: Show definition in a float window

* <gd>: go to definition

* >>/<<: Go to next function

* :GoImports: make import a bit more straightforward

* :GoAddTags json bson: you will love this
```

#### JavaScript/JSX(React)

In my work we use two spaces as indentation, so feel free to change it if you prefer other indentation.

Not all plugins I installed are required for JS development but I found it works for me.

Sometimes syntax highlighting has issues with complicated string templates.

The TS/JS LSP works like a charm, the only shortcuts I use in my daily development is
```
* <F12>: Show definition in a float window

* <gd>: go to definition
```

One hassle I find after switching to native lsp is linting on jsx, it seems to me that [efm](https://github.com/mattn/efm-langserver) + [eslint_d](https://github.com/mantoni/eslint_d.js/) works alright, at least almost the same good as vscode.

## General Settings

### Leader Key

I use `<space>` as leader key. The handy position makes it easy to reach and encourages me to use it more.

### Esc

I map `jj` as `<esc>`. Not only because of the stupid touchbar (Apple gave it back now), but make normal mode more accessible for me, which I think is a good practice for every vimmer.

### Fuzzy search

#### fzf

I use `fzf` as native app and install the `fzf-vim` plugin wrapping it by vim. Also I installed [bat](https://github.com/sharkdp/bat) to provide file preview with syntax highlighting.

P.S. to use `bat` in ubuntu, because it's `batcat` in repo so you need to relink it somewhere and export it, what I did is like this:
```bash
ln -s /usr/bin/batcat ~/bin/bat
```
and append `~/bin` to PATH

Text fuzzy search requires [ripgrep](https://github.com/BurntSushi/ripgrep)

Functions:

```
1. <leader>f: text fuzzy search 
```

Now I only use telescope for fuzzy global text search.

#### Telescope

The new fav of the community, probaly one of the best plugins you can have for nvim. I use [Telescope](https://github.com/nvim-telescope/telescope.nvim) and [Telescope-fzf-native](https://github.com/nvim-telescope/telescope-fzf-native.nvim) to work together on sorting, which will make telescope supports fuzzy search on a lot of things. But not all of them. So I still keep fzf for text fuzzy search in a project.

Some useful ones I use daily

```
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-g> <cmd>Telescope git_status<cr>
nnoremap <C-e> <cmd>Telescope buffers<cr>
nnoremap <C-t> <cmd>Telescope tags<cr>
```

Another one I'll use alongside with `<leader>f` is `:Telescope live_grep` which is precise search, like vscode one everyone likes.

For js/jsx/tsx development, sometimes I find it handy to do `:Telescope diagnostics`. It's nice to have it all at one single place and you can check.

### Git

I'm used to work with git in commandline. But I found it handy to access some git info/actions within the editor.

```
1. :GDiff - diff the current file (fugitive)

2. :GStatus - extended interactive ui of git status (fugitive)

3. ~~<leader>gm - show git message of the current line (git-messenger)~~ (UPDATE: I use `:GV`/`:GV!`/`:GV?` now)

4. <right><right>/<left><left> - next/previous git hunk (fugitive)

5. GBrowse/GBrowse! - it will open remote origin in your browser or copy the link to your clipboard

6. GBlame - time to blame your colleagues!
```

the status in gutter is provided by `vim-gitgutter`.

### Buffer, Pane, Tab, etc.

~~Since I use `fzf`/`fzf-vim` for most of my navigation, the configuration is part of the `fzf-vim`.~~ I use Telescope now for buffer, files etc., but this still works.

```
1. <ctrl>-v: vertical split open from fzf/telescope window

2. <ctrl>-x: horizontal split open from fzf/telescope window

3. <ctrl>-t: open from fzf/telescope window in another tab
```

For navigation:

```
" tab move
nnoremap H gT
nnoremap L gt
" easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
```

And pane resize:
```
" easier split vertical resize
nnoremap <S-Up> <C-w>+
nnoremap <S-Down> <C-w>-
nnoremap <S-Right> <C-w>>
nnoremap <S-Left> <C-w><
```

Also I use ~~`NerdTree`~~[nvim-tree](https://github.com/kyazdani42/nvim-tree.lua)  as file explorer, I use `<ctrl>-n` to toggle it and keep default key bindings.

### Terminal

~~Sometimes, just sometimes, I use terminal in neovim. `<C-t>` to toggle it. (P.S. `:q` will close the buffer and make the terminal not reusable)~~

[Floaterm](https://github.com/voldikss/vim-floaterm) is simply better and faster. It's really good when you want to change code and run watcher at the same time, just like vscode built-in terminal.

### Copy Paste with global clip board on WSL (Windows only)

I configured according to here: https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl

### Treesitter

Just use [it](https://github.com/nvim-treesitter/nvim-treesitter)! This is just how good nvim is, isn't it?

### Fancy AI enhancements

#### tabnine V.S. Copilot

~~Since I'm using nvim-cmp so I just use the tabnine source provider for it. I also tried GitHub Copilot - it's really impressive but I don't like the lag. Sometimes I just want to tab indent and then it autocomplete a bunch code - tho the result is impressive but it's not really needed when I know what I'm gonna do. Tabnine is good enough.~~

I'm using Copilot now.

### Lua V.S. Vimscript

Lua is just faster. The config now runs fully from `init.lua` with lazy-loaded plugins managed by `lazy.nvim`.

## License
MIT

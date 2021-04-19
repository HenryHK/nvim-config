# My Neovim Configuration (prob. Vim as well)

## Neovim Configuration Location on Mac

`~/.config/nvim`

## Plugin Management

### NeoVim Plugin Location on Mac

`~/.local/share/nvim/plugged`

### Plugin Manager

Use [Vim-Plug](https://github.com/junegunn/vim-plug) as plugin manager. Install Vim-Plug first following instructions by the author of Vim-Plug.

Copy the config into your `.vimrc` or `init.vim` (I didn't test this with Vim but most of the settings should be the same). Save it and reopen a vim instance (or :so %) to run `:PlugInstall` or `<leader>pi` to install all plugins.

To remove useless plugins, run `:PlugClean`.

## Autocomplete

### Plugin

After a long time usage of [YouCompleteMe](https://github.com/Valloric/YouCompleteMe), I switched to [coc.nvim](https://github.com/neoclide/coc.nvim). With the great async feature of neovim, it works like a charm especially when most mainstream languages have great [language server protocol](https://microsoft.github.io/language-server-protocol/) supports(__Thank you Microsoft, sincerely__).

### Language support 

#### Golang 

You might need to install additional go packages to use full feature of [vim-go](https://github.com/fatih/vim-go). Please refer to the instructions. I use this simply as an addition to `coc.nvim`.

A few useful shortcuts I use every day:

```
* <F12>: Go to definition

* >>/<<: Go to next function

* :GoImports: make import a bit more straightforward
```

#### JavaScript/JSX(React)

In my work we use two spaces as indentation, so feel free to change it if you prefer other indentation.

Not all plugins I installed are required for JS development but I found it works for me.

Sometimes syntax highlighting has issues with complicated string templates.

The TS/JS LSP works like a charm, the only shortcuts I use in my daily development is
```
* <F12>: Go to definition
```

#### Python

Still WIP but it feels ok. I use nvim now to develop our in-house ETL using Apache Airflow.

#### CoffeeScript

Syntax highlighting and simple lint.

#### Rust

I just started learning Rust. Not sure about complicated projects, but `Hello-Rust` works.

## General Settings

### Leader Key

I use `<space>` as leader key. The easy position makes it easy and encourages me to use it more.

### Esc

I map `jj` as `<esc>`. Not only because of the stupid touchbar (Apple gave it back now), but make normal mode more accessible for me, which I think is a good practice for every vimmer.

### Fuzzy search

I use `fzf` as native app and install the `fzf-vim` plugin wrapping it by vim. Also I installed [bat](https://github.com/sharkdp/bat) to provide file preview with syntax highlighting.

Text fuzzy search requires [ripgrep](https://github.com/BurntSushi/ripgrep)

Functions:

```
1. <ctrl>-p: project file fuzzy search

2. <ctrl>-e: buffer file fuzzy search

3. <leader>f: text fuzzy search 
```

### Git

I'm used to work with git in commandline. But I found it handy to access some git info/actions within the editor.

```
1. :Gdiff - diff the current file (fugitive)

2. :Gstatus - extended interactive ui of git status (fugitive)

3. <leader>gm - show git message of the current line (git-messenger)

4. <right><right>/<left><left> - next/previous git hunk (fugitive)
```

the status in gutter is provided by `vim-gitgutter`.

### Buffer, Pane, Tab, etc.

Since I use `fzf`/`fzf-vim` for most of my navigation, the configuration is part of the `fzf-vim`.

```
1. <ctrl>-v: vertical split open from fzf window

2. <ctrl>-x: horizontal split open from fzf window

3. <ctrl>-t: open from fzf window in another tab
```

Also I use `NerdTree` as file explorer, I use `<ctrl>-n` to toggle it and keep default key bindings.

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

### Terminal

Sometimes, just sometimes, I use terminal in neovim. `<C-t>` to toggle it. (P.S. `:q` will close the buffer and make the terminal not reusable)

## License
MIT

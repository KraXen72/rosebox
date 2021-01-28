# Usage

Move the `rosebox.vim` file into your `{vim_runtime_dir}/colors` directory located in `~/.config/nvim/colors` for neovim and ensure the following lines are present in your vimrc or init.vim:

```python
syntax on
set termguicolors
colorscheme rosebox

# this line for relative line numbers
hi CursorLineNr term=bold ctermfg=2 gui=bold guifg=terminal_color_2
```


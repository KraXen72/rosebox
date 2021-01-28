# Editors

![vim preview](https://cdn.discordapp.com/attachments/803974055485112350/804282038441738300/end_result.png)

## Vim

**Usage**

Move the ``rosebox.vim`` file into your ``{vim_runtime_dir}/colors`` directory located in ``~/.config/nvim/colors`` for neovim and ensure the following lines are present in your ``vimrc`` or ``init.vim``:

```
syntax on
set termguicolors
colorscheme rosebox

# this line for relative line numbers
hi CursorLineNr term=bold ctermfg=2 gui=bold guifg=terminal_color_2
```

vim theme made by: [*atidyshirt*](https://github.com/atidyshirt)
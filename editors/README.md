# Editors

![vim preview](https://cdn.discordapp.com/attachments/803974055485112350/869205081210380298/Screen_Shot_2021-07-27_at_1.09.53_AM.png)

## Vim

**Usage**

To install this, using your plug-in manager of choice

```python
# using vim-plug
Plug 'atidyshirt/rosebox.nvim'

# using dein
call dein#add('atidyshirt/rosebox.nvim')
```

Then we need to set the colorscheme

```python
colorscheme rosebox
```

Separate repository for neovim theme made by: [*atidyshirt*](https://github.com/atidyshirt/rosebox.nvim)

**Further configuration and plugin support**

There is further configuration that has been done to extend the functionality of the theme

```vimscript
if (has('termguicolors'))
 set termguicolors
endif

if &term == "screen-256color" || &term == "tmux-256color" || &term == "screen" || &term == "tmux"
    map <esc>[1;5D <C-Left>
    map! <esc>[1;5D <C-Left>
    map <esc>[1;5C <C-Right>
    map! <esc>[1;5C <C-Right>
endif

colorscheme rosebox
set background=dark

if &term == "screen-256color"
   set t_Co=256
endif

luafile $HOME/.config/nvim/themes/rosebox-extended.lua
```

And for further extension for treesitter, nvim-tree plugins using Lua.

```lua
local cmd = vim.cmd

local colors = {
    white = "#a3a5aa",
    darker_black = "#2b2b2b",
    black = "#282828", --  nvim bg
    black2 = "#2b2b2b",
    one_bg = "#2b2b2b",
    one_bg2 = "#2b2b2b",
    one_bg3 = "#2b2b2b",
    grey = "#46494a",
    grey_fg = "#5d6061",
    grey_fg2 = "#5b5e5f",
    light_grey = "#585b5c",
    red = "#D08770",
    baby_pink = "#ce8196",
    pink = "#ff75a0",
    line = "#2c2f30", -- for lines like vertsplit
    green = "#A3BE8C",
    vibrant_green = "#a9b665",
    nord_blue = "#6f8faf",
    blue = "#637A8A",
    yellow = "#EBCB8B",
    sun = "#d1b171",
    purple = "#B48EAD",
    dark_purple = "#cc7f94",
    teal = "#749689",
    orange = "#af3a03",
    cyan = "#8FBCBB",
    statusline_bg = "#252829",
    lightbg = "#2d3139",
    lightbg2 = "#262a32"
}

local white = colors.white
local darker_black = colors.darker_black
local black = colors.black
local black2 = colors.black2
local one_bg = colors.one_bg
local one_bg2 = colors.one_bg2
local one_bg3 = colors.one_bg3
local light_grey = colors.light_grey
local grey = colors.grey
local grey_fg = colors.grey_fg
local red = colors.red
local line = colors.line
local green = colors.green
local nord_blue = colors.nord_blue
local blue = colors.blue
local yellow = colors.yellow
local purple = colors.purple

-- for guifg , bg
local function fg(group, color)
    cmd("hi " .. group .. " guifg=" .. color)
end

local function bg(group, color)
    cmd("hi " .. group .. " guibg=" .. color)
end

local function fg_bg(group, fgcol, bgcol)
    cmd("hi " .. group .. " guifg=" .. fgcol .. " guibg=" .. bgcol)
end

-- blankline
fg("IndentBlanklineChar", line)

-- misc --
fg("LineNr", grey)
fg("Comment", grey)
fg("NvimInternalError", red)
fg("VertSplit", line)
fg("EndOfBuffer", black)

-- Pmenu
bg("Pmenu", one_bg)
bg("PmenuSbar", one_bg2)
bg("PmenuSel", green)
bg("PmenuThumb", nord_blue)

-- inactive statuslines as thin splitlines
-- cmd("hi! StatusLineNC gui=underline guifg=" .. line)

-- line n.o
cmd "hi clear CursorLine"
fg("cursorlinenr", white)

-- git signs ---
fg_bg("DiffAdd", nord_blue, "none")
fg_bg("DiffChange", one_bg2, "none")
fg_bg("DiffModified", nord_blue, "none")

-- NvimTree
fg("NvimTreeFolderIcon", blue)
fg("NvimTreeFolderName", blue)
fg("NvimTreeOpenedFolderName", blue)
fg("NvimTreeEmptyFolderName", blue)
fg("NvimTreeIndentMarker", one_bg2)
fg("NvimTreeVertSplit", darker_black)
bg("NvimTreeVertSplit", darker_black)
fg("NvimTreeEndOfBuffer", darker_black)

fg("NvimTreeRootFolder", darker_black)
bg("NvimTreeNormal", darker_black)
fg_bg("NvimTreeStatuslineNc", darker_black, darker_black)
fg_bg("NvimTreeWindowPicker", red, black2)

-- LspDiagnostics ---

-- error / warnings
fg("LspDiagnosticsSignError", red)
fg("LspDiagnosticsVirtualTextError", red)
fg("LspDiagnosticsSignWarning", yellow)
fg("LspDiagnosticsVirtualTextWarning", yellow)

-- info
fg("LspDiagnosticsSignInformation", green)
fg("LspDiagnosticsVirtualTextInformation", green)

-- hint
fg("LspDiagnosticsSignHint", purple)
fg("LspDiagnosticsVirtualTextHint", purple)

-- separators
fg_bg("BufferLineSeparator", black2, black2)
fg_bg("BufferLineSeparatorVisible", black2, black2)
fg_bg("BufferLineSeparatorSelected", black, black2)
```

This lua configuration is stolen from the [NVChad project](https://github.com/siduck76/NvChad)

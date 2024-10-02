-- Leader settings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Settings
vim.opt.backup = false        -- creates a backup file
vim.opt.showmode = false      -- we don't need to see things like -- INSERT -- anymore
vim.opt.cmdheight = 0         -- hide vim commandline
vim.opt.laststatus = 0        -- hide statusline
vim.opt.showtabline = 0       -- always show tabs
vim.opt.ignorecase = true     -- ignore case when searching
vim.opt.smartcase = true      -- unless capital letter in search
vim.opt.hlsearch = false      -- do not highlight all matches on previous search pattern
vim.opt.incsearch = true      -- incrementally highlight searches as you type
vim.opt.smartindent = true    -- make indenting smarter again
vim.opt.preserveindent = true -- keep the same indent level when you press enter 
vim.opt.swapfile = false      -- creates a swapfile
vim.opt.termguicolors = true  -- set term gui colors (most terminals support this)
vim.opt.undofile = true       -- enable persistent undo
vim.opt.expandtab = true      -- convert tabs to spaces
vim.opt.tabstop = 2           -- number of spaces tabs count for
vim.opt.softtabstop = 2       -- number of spaces tabs count for
vim.opt.shiftwidth = 2        -- the number of spaces inserted for each indentation
vim.opt.cursorline = true     -- highlight the current line
vim.opt.number = true         -- set numbered lines
vim.opt.breakindent = true    -- wrap lines with indent
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.numberwidth = 2       -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes"    -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false          -- display lines as one long line
vim.opt.scrolloff = 8         -- makes sure there are always eight lines of context
vim.opt.sidescrolloff = 8     -- makes sure there are always eight lines of context
vim.opt.title = true          -- set the title of window to the value of the titlestring
vim.opt.confirm = true        -- confirm to save changes before exiting modified buffer
vim.g.have_nerd_font = true   -- enable nerd font support

-- allows neovim to access the system clipboard
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Keep cursor centered when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Move selected line / block of text in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Fast saving
vim.keymap.set("n", "<leader>w", ":write!<CR>", { silent = true, desc = "Save file" })
vim.keymap.set("n", "<leader>c", ":bd<CR>", { silent = true, desc = "Close buffer" })
vim.keymap.set("n", "<leader>x", ":x<CR>", { silent = true, desc = "Save and Quit" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { silent = true, desc = "Quit" })

-- Better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Paste over currently selected text without yanking it
vim.keymap.set("v", "p", '"_dp')
vim.keymap.set("v", "P", '"_dP')

-- Prevent deleting from also copying
vim.keymap.set({'n', 'v'}, 'd', '"_d', { noremap = true })
vim.keymap.set('n', 'dd', '"_dd', { noremap = true })

-- Copy everything between { and } including the brackets
vim.keymap.set("n", "YY", "va{Vy")

-- Move line on the screen rather than by line in the file
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Move to start/end of line
vim.keymap.set({ "n", "x", "o" }, "H", "^")
vim.keymap.set({ "n", "x", "o" }, "L", "g_")

-- Navigate buffers
vim.keymap.set("n", "]b", ":bnext<CR>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "[b", ":bprevious<CR>", { silent = true, desc = "Previous buffer" })

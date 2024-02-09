local keymap = vim.keymap
local opts = { noremap = true, silent = true }
-- mimic nvchad nvterm behaviour with these keymaps
keymap.set("t", "<A-i>", "<C-\\><C-n>:lua require('nvterm.terminal').toggle('float')<CR>")
keymap.set("t", "<A-h>", "<C-\\><C-n>:lua require('nvterm.terminal').toggle('horizontal')<CR>")
keymap.set("t", "<A-v>", "<C-\\><C-n>:lua require('nvterm.terminal').toggle('vertical')<CR>")

keymap.set("n", "<A-i>", ":lua require('nvterm.terminal').toggle('float')<CR>")
keymap.set("n", "<A-h>", ":lua require('nvterm.terminal').toggle('horizontal')<CR>")
keymap.set("n", "<A-v>", ":lua require('nvterm.terminal').toggle('vertical')<CR>")

--- set keymaps for closing windows and tabs
keymap.set("n", "<Leader>q", ":q<CR>", opts)

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

vim.g.mapleader = " "
-- Replace netrw with NvimTree
--vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pv", vim.cmd.NvimTreeToggle)

-- Move highlighted text up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")

-- Keep cursor where it is when using J
vim.keymap.set("n", "J", "mzJ`z")

-- Keep view in center when C-u and C-d
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep view in center of screen when moving through search terms
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Keep item in copy in buffer when overwriting
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set({ "n", "x" }, "<leader>ya", 'ggVG"+y')

-- Remap escape to <C-c> for vertical edit
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end)

vim.keymap.set("n", "<C-j>", "<cmd>copilot#Accept(\"<CR>\")")


--   imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
--       let g:copilot_no_tab_map = v:true

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {
    desc = 'Open diagnostic Quickfix list'
})

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', {
    desc = 'Exit terminal mode'
})

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '')
vim.keymap.set('n', '<right>', '')
vim.keymap.set('n', '<up>', '')
vim.keymap.set('n', '<down>', '')

-- faster scrolling
vim.keymap.set("n", "<C-j>", "10j", {
    noremap = true
})
vim.keymap.set("n", "<C-k>", "10k", {
    noremap = true
})

vim.keymap.set('n', 'K', function()
    vim.lsp.buf.hover({
        border = 'single'
    })
end)

-- window management
-- helper
local map = vim.keymap.set
local opts = {
    noremap = true,
    silent = true
}

-- Move to other windows
map("n", "<leader>wh", "<C-w>h", opts)
map("n", "<leader>wj", "<C-w>j", opts)
map("n", "<leader>wk", "<C-w>k", opts)
map("n", "<leader>wl", "<C-w>l", opts)

-- Toggle between windows (cycles through)
map("n", "<leader>ww", "<C-w>w", opts)

-- Close current window
map("n", "<leader>wd", "<C-w>c", opts)

map("n", "<leader>wn", ":vsplit<CR>", opts)


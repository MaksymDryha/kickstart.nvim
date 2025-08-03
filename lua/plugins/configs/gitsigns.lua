return {
    'lewis6991/gitsigns.nvim',
    config = function()
        vim.keymap.set('n', '<leader>gb', ':Gitsigns blame<CR>')
        vim.keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk_inline<CR>')
        vim.keymap.set('n', '<leader>gu', ':Gitsigns reset_hunk<CR>')

        require("gitsigns").setup({
            signs = {
                delete = {
                    text = '▶'
                },
                topdelete = {
                    text = '▶'
                },
                changedelete = {
                    text = '▶'
                }
            }
        });
    end
}

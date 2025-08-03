return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup {
      config = function()
        vim.keymap.set('n', '<leader>gb', ':Gitsigns blame<CR>')
        vim.keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk_inline<CR>')
        vim.keymap.set('n', '<leader>gu', ':Gitsigns reset_hunk<CR>')
      end
    }
  end,
}

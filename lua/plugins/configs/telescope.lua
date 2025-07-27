return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',

      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
  },
  config = function()
    require('telescope').setup {
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Find files' }) -- todo: make dot files serchable
    vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Find buffers' })

    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Find by grep' })
    vim.keymap.set('n', '<leader>sc', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = 'Find in current file' })


    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Find help' })
  end,
}

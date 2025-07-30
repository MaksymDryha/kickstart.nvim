local file_ignores_for_focused_search = {
  "%.spec%.[jt]sx?$"
}

local function filenameFirst(_, path)
  local tail = vim.fs.basename(path)
  local parent = vim.fs.dirname(path)
  if parent == "." then return tail end
  return string.format("%s\t\t%s", tail, parent)
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopeResults",
  callback = function(ctx)
    vim.api.nvim_buf_call(ctx.buf, function()
      vim.fn.matchadd("TelescopeParent", "\t\t.*$")
      vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
    end)
  end,
})


return {
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
      defaults = {
        path_display = filenameFirst,
        mappings = {
          i = {
            ["<C-y>"] = require('telescope.actions').select_default
          },
          -- in normal mode navigation should be the same as in interactive
          n = {
            ["<C-y>"] = require('telescope.actions').select_default,
            ["<C-n>"] = require('telescope.actions').move_selection_next,
            ["<C-p>"] = require('telescope.actions').move_selection_previous
          }
        }
      },
    }
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>ff', function() -- focused search (non-essential files are ignores)
        builtin.find_files({ file_ignore_patterns = file_ignores_for_focused_search })
      end,
      { desc = 'Find files' })
    vim.keymap.set('n', '<leader>faf', function() -- sind ALL files (no ignores except build, dist, node_modules etc)
        builtin.find_files({ hidden = true })
      end,
      { desc = 'Find files' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })

    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Find by grep' })
    vim.keymap.set('n', '<leader>fc', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = 'Find in current file' })


    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find help' })
  end,
}

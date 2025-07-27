return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    delay = 500,
    icons = {
      mappings = vim.g.have_nerd_font,
      keys = {},
    },
  },
}

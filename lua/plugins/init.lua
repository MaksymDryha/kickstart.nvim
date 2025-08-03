local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system {'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath}
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end

local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require('lazy').setup({'NMAC427/guess-indent.nvim', require 'plugins.configs.which-key',
                       require 'plugins.configs.telescope', require 'plugins.configs.lsp',
                       require 'plugins.configs.autoformat', require 'plugins.configs.autocomplete',
                       require 'plugins.configs.color-scheme', require 'plugins.configs.mini',
                       require 'plugins.configs.treesitter', require 'plugins.configs.autoclose',
                       require 'plugins.configs.neo-tree', require 'plugins.configs.neogit',
                       require 'plugins.configs.gitsigns'})

-- vim: ts=2 sts=2 sw=2 et

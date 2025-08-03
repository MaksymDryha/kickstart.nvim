return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {"nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", "nvim-tree/nvim-web-devicons" -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    opts = {},
    config = function()
        vim.keymap.set('n', '<leader>pe', ':Neotree filesystem toggle<CR>')
        vim.keymap.set('n', '<leader>pf', ':Neotree filesystem reveal toggle<CR>')

        -- show file [p]review when typing P
        require("neo-tree").setup({
            window = {
                mappings = {
                    ["p"] = {
                        "toggle_preview",
                        config = {
                            use_float = false
                        }
                    }
                }
            }
        })
    end
}

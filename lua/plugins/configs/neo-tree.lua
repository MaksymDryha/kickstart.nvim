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
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = false
                }
            },
            window = {
                mappings = {
                    ["p"] = {
                        "toggle_preview",
                        config = {
                            use_float = false
                        }
                    },
                    ["h"] = function(state)
                        local node = state.tree:get_node()
                        if node.type == 'directory' and node:is_expanded() then
                            require'neo-tree.sources.filesystem'.toggle_directory(state, node)
                        else
                            require'neo-tree.ui.renderer'.focus_node(state, node:get_parent_id())
                        end
                    end,
                    ["l"] = function(state)
                        local node = state.tree:get_node()
                        if node.type == 'directory' then
                            if not node:is_expanded() then
                                require'neo-tree.sources.filesystem'.toggle_directory(state, node)
                            elseif node:has_children() then
                                require'neo-tree.ui.renderer'.focus_node(state, node:get_child_ids()[1])
                            end
                        end
                    end
                }
            }
        })
    end
}

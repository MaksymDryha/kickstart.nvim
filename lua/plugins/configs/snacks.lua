return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        -- enable the modules you actually want:
        dashboard = {
            enabled = true
        },
        input = {
            enabled = true
        },
        indent = {
            enabled = true
        },
        lazygit = {
            enabled = true
        }

    },
    keys = {{
        "<leader>lg",
        function()
            Snacks.lazygit()
        end,
        desc = "Lazygit"
    }}
}

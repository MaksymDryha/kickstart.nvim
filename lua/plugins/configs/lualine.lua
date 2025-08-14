return {
    'nvim-lualine/lualine.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function()
        local git_blame = require('gitblame')
        vim.g.gitblame_display_virtual_text = 0 -- disable inline git blame

        -- Bubbles config for lualine
        -- Author: lokesh-krishna
        -- MIT license, see LICENSE for more details.

        require('lualine').setup {
            options = {
                component_separators = '',
                section_separators = {
                    left = '',
                    right = ''
                }
            },
            sections = {
                lualine_a = {{
                    'mode',
                    separator = {
                        left = ''
                    },
                    right_padding = 2
                }},
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = { --[[ add your center components here in place of this comment ]] },
                lualine_x = {{
                    git_blame.get_current_blame_text,
                    cond = git_blame.is_blame_text_available
                }},
                lualine_y = {'filetype', 'filename', 'progress'},
                lualine_z = {{
                    'location',

                    separator = {
                        right = ''
                    },
                    left_padding = 2
                }}
            },
            inactive_sections = {
                lualine_a = {'filename'},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {'location'}
            },
            tabline = {},
            extensions = {}
        }
    end
}

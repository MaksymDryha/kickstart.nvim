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
                lualine_b = {'branch',{
                    'filename',
                    file_status = true, -- Displays file status (readonly status, modified status)
                    newfile_status = false, -- Display new file status (new file means no write after created)
                    path = 0, -- 0: Just the filename
                    -- 1: Relative path
                    -- 2: Absolute path
                    -- 3: Absolute path, with tilde as the home directory
                    -- 4: Filename and parent dir, with tilde as the home directory

                    symbols = {
                        modified = '[+]', -- Text to show when the file is modified.
                        readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
                        unnamed = '[No Name]', -- Text to show for unnamed buffers.
                        newfile = '[New]' -- Text to show for newly created file before first write
                    }
                }, {
                    'diff',
                    colored = true, -- Displays a colored diff status if set to true
                    symbols = {
                        added = '+',
                        modified = '~',
                        removed = '-'
                    } -- Changes the symbols used by the diff.
                }},
                lualine_c = {'%=', {
                    'diagnostics',

                    colored = true, -- Displays diagnostics status in color if set to true.
                    update_in_insert = true -- Update diagnostics in insert mode.
                }},
                lualine_x = {{
                    git_blame.get_current_blame_text,
                    cond = git_blame.is_blame_text_available
                }},
                lualine_y = {{
                    'datetime',
                    style = "%H:%M"
                }, 'progress'},
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

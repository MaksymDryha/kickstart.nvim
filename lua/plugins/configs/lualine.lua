return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local icons = require 'icons'

    local git_blame = require 'gitblame'
    vim.g.gitblame_display_virtual_text = 0 -- disable inline git blame

    -- Bubbles config for lualine
    -- Author: lokesh-krishna
    -- MIT license, see LICENSE for more details.\
    local colors = require('nightfox.palette').load 'nightfox'
    local mode_map = {
      ['n'] = icons.normal_mode,
      ['no'] = 'O-PENDING',
      ['nov'] = 'O-PENDING',
      ['noV'] = 'O-PENDING',
      ['no�'] = 'O-PENDING',
      ['niI'] = 'NORMAL',
      ['niR'] = 'NORMAL',
      ['niV'] = 'NORMAL',
      ['nt'] = 'NORMAL',
      ['v'] = icons.visual_mode,
      ['vs'] = 'VISUAL',
      ['V'] = 'V-LINE',
      ['Vs'] = 'V-LINE',
      ['�'] = 'V-BLOCK',
      ['�s'] = 'V-BLOCK',
      ['s'] = 'SELECT',
      ['S'] = 'S-LINE',
      ['�'] = 'S-BLOCK',
      ['i'] = icons.insert_mode,
      ['ic'] = 'INSERT',
      ['ix'] = 'INSERT',
      ['R'] = icons.replace_mode,
      ['Rc'] = icons.replace_mode,
      ['Rx'] = icons.replace_mode,
      ['Rv'] = 'V-REPLACE',
      ['Rvc'] = 'V-REPLACE',
      ['Rvx'] = 'V-REPLACE',
      ['c'] = icons.command_mode,
      ['cv'] = 'EX',
      ['ce'] = 'EX',
      ['r'] = icons.replace_mode,
      ['rm'] = 'MORE',
      ['r?'] = 'CONFIRM',
      ['!'] = 'SHELL',
      ['t'] = 'TERMINAL',
    }
    require('lualine').setup {
      options = {
        component_separators = '',
        section_separators = '',
        -- theme = {
        --     normal = {
        --         c = {
        --             fg = colors.fg,
        --             bg = colors.bg
        --         }
        --     },
        --     inactive = {
        --         c = {
        --             fg = colors.fg,
        --             bg = colors.bg
        --         }
        --     }
        -- }
      },
      sections = {
        lualine_a = {
          {
            function()
              return mode_map[vim.api.nvim_get_mode().mode] or '__'
            end,
            padding = {
              right = 3,
              left = 3,
            },
          },
        },
        lualine_b = {
          {
            'branch',
            icon = icons.git,
            color = {
              fg = colors.fg,
              bg = colors.bg,
              gui = 'bold',
            },
          },
          {
            'filetype',
            colored = true, -- Displays filetype icon in color if set to true
            icon_only = true, -- Display only an icon for filetype
            padding = {
              right = 0,
              left = 1,
            },
            icon = {
              align = 'right',
            }, -- Display filetype icon on the right hand side
            -- icon =    {'X', align='right'}
            -- Icon string ^ in table is ignored in filetype component
          },
          {
            padding = {
              left = 0,
              right = 1,
            },
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
              newfile = '[New]', -- Text to show for newly created file before first write
            },
          },
          {
            'diff',
            symbols = {
              added = icons.git_added,
              modified = icons.git_modified,
              removed = icons.git_removed,
            },
            diff_color = {
              added = {
                fg = colors.green.base,
              },
              modified = {
                fg = colors.orange.base,
              },
              removed = {
                fg = colors.red.base,
              },
            },
          },
        },
        lualine_c = {
          '%=',
          {
            'diagnostics',
            symbols = {
              error = icons.error,
              warn = icons.warn,
              info = icons.info,
              hint = icons.hint,
            },
            colored = true, -- Displays diagnostics status in color if set to true.

            update_in_insert = true, -- Update diagnostics in insert mode.
          },
        },
        lualine_x = { {
          git_blame.get_current_blame_text,
          cond = git_blame.is_blame_text_available,
        } },
        lualine_y = { {
          'datetime',
          icon = icons.clock,
          style = '%H:%M',
        }, 'progress' },
        lualine_z = {
          {
            'location',

            left_padding = 2,
          },
        },
      },
      inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
      },
      tabline = {},
      extensions = {},
    }
  end,
}

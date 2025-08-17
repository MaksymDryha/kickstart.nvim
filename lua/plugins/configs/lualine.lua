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

    local function get_branch_status()
      -- Are we in a git repo?
      local inside = vim.fn.systemlist('git rev-parse --is-inside-work-tree')[1]
      if inside ~= 'true' then
        return ''
      end

      -- Do we have an upstream?
      local upstream = vim.fn.systemlist('git rev-parse --abbrev-ref --symbolic-full-name @{upstream}')[1]
      if not upstream or upstream == '' then
        return '' -- no tracking branch
      end

      -- For @{upstream}...HEAD, the output order is: <behind> <ahead>
      local line = vim.fn.systemlist('git rev-list --left-right --count @{upstream}...HEAD')[1]
      if not line or line == '' then
        return ''
      end

      local behind, ahead = line:match '(%d+)%s+(%d+)'
      behind = tonumber(behind) or 0
      ahead = tonumber(ahead) or 0

      if ahead == 0 and behind == 0 then
        return ''
      end

      local parts = {}
      if ahead > 0 then
        table.insert(parts, icons.git_push .. ahead)
      end -- unpushed
      if behind > 0 then
        table.insert(parts, icons.git_pull .. behind)
      end -- unpulled
      return table.concat(parts, ' ')
    end
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
            padding = {
              left = 1,
              right = 2,
            },
            color = {
              fg = colors.fg,
              bg = colors.bg,
              gui = 'bold',
            },
            fmt = function(str)
              local branch_status = get_branch_status()
              return branch_status ~= '' and (str .. '(' .. branch_status .. ')') or str
            end,
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
            padding = { right = 2},
            color = function(section)
              return { fg = vim.bo.modified and colors.blue.base or colors.fg, gui = 'bold' }
            end,

            file_status = true, -- Displays file status (readonly status, modified status)
            newfile_status = false, -- Display new file status (new file means no write after created)
            path = 0, -- 0: Just the filename
            -- 1: Relative path
            -- 2: Absolute path
            -- 3: Absolute path, with tilde as the home directory
            -- 4: Filename and parent dir, with tilde as the home directory

            symbols = {
              modified = icons.file_modified, -- Text to show when the file is modified.
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
            padding = {
              left = 2,
              right = 2,
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
          {
            'diagnostics',
            padding = {
              left = 2,
              right = 2,
            },
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

        lualine_c = {

          '%=',
          {
            'datetime',
            icon = icons.clock,
            style = '%H:%M',
          },
        },
        lualine_x = {},
        lualine_y = {
          {
            git_blame.get_current_blame_text,
            cond = git_blame.is_blame_text_available,
          },
        },
        lualine_z = {
          {
            'location',

            left_padding = 2,
            padding = { right = 0 },
          },
          {
            'progress',
            padding = { right = 2, left = 0 },
            fmt = function(str)
              local value = str == 'Bot' and '100%%' or str
              return '(' .. value .. ')'
            end,
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

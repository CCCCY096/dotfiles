return {
  {
    {
      'ribru17/bamboo.nvim',
      lazy = false,
      priority = 1000,
      config = function()
        require('bamboo').setup {
          toggle_style_key = '<leader>tt',
          term_colors = false,
          highlights = {
            ['@comment'] = { fg = '$grey' },
          },
        }
        require('bamboo').load()
      end,
    },
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        component_separators = '',
        section_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        -- lualine_b = { 'filename', 'diagnostics' },
        lualine_b = {
          {
            'filename',
            path = 1, -- 1: show relative path
          },
          'diagnostics',
        },
        lualine_c = { 'branch', 'diff' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = { 'filename' },
        lualine_c = {},
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
    },
  },
}

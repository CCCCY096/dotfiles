return {
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    config = function()
      require('kanagawa').setup()
      vim.cmd 'colorscheme kanagawa'
    end,
  },

  {
    'ellisonleao/gruvbox.nvim',
    lazy = true,
    config = function()
      vim.cmd 'colorscheme gruvbox'
    end,
  },

  {
    'ribru17/bamboo.nvim',
    lazy = true,
    config = function()
      require('bamboo').setup {
        highlights = {
          ['@comment'] = { fg = '$grey' },
        },
      }
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        theme = 'auto',
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

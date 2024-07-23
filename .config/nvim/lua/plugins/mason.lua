ENSURE_INSTALLED = {}

return {
  { 'williamboman/mason.nvim', config = true },

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    event = 'VeryLazy',
    dependencies = {
      'williamboman/mason.nvim',

      -- list of plugins that might expand the ENSURE_INSTALLED list
      'neovim/nvim-lspconfig',
      'stevearc/conform.nvim',
      'mfussenegger/nvim-lint',
    },
    config = function()
      require('mason-tool-installer').setup { ensure_installed = ENSURE_INSTALLED }
    end,
  },
}

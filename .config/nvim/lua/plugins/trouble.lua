return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('trouble').setup()
    vim.keymap.set('n', '<leader>x', function()
      vim.cmd 'Trouble diagnostics toggle'
    end, { desc = 'toggle trouble' })
  end,
}

return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    vim.keymap.set('n', '<leader>x', function()
      require('trouble').toggle()
    end, { desc = 'toggle trouble' })
  end,
}

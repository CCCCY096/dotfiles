local lazyFile = require('utils').lazy_events

return {
  'folke/trouble.nvim',
  event = { lazyFile },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local curry = function(arg)
      return function()
        require('trouble').toggle(arg)
      end
    end
    vim.keymap.set('n', '<leader>xx', function()
      require('trouble').toggle()
    end, { desc = 'toggle trouble' })
    vim.keymap.set('n', '<leader>xw', function()
      curry 'workspace_diagnostics'
    end, { desc = 'toggle trouble workspace_diagnostics' })
    vim.keymap.set('n', '<leader>xd', function()
      curry 'document_diagnostics'
    end, { desc = 'toggle trouble document_diagnostics' })
    vim.keymap.set('n', '<leader>xq', function()
      curry 'quickfix'
    end, { desc = 'toggle trouble quickfix' })
    vim.keymap.set('n', '<leader>xl', function()
      curry 'loclist'
    end, { desc = 'toggle trouble loclist' })
    vim.keymap.set('n', 'gR', function()
      curry 'lsp_references'
    end, { desc = 'toggle trouble lsp_references' })
  end,
}

local lazyFile = require('utils').lazy_file_events

return {
  {
    'mfussenegger/nvim-lint',
    dependencies = { 'williamboman/mason.nvim' },
    event = { lazyFile },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        go = { 'golangcilint' },
        markdown = { 'markdownlint' },
      }

      vim.keymap.set('n', '<leader>l', lint.try_lint, { desc = '[l]int' })

      local autoLintGroup = vim.api.nvim_create_augroup('AutoLintGroup', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        group = autoLintGroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}

return {
  {
    'mfussenegger/nvim-lint',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        go = { 'golangcilint' },
        markdown = { 'markdownlint' },
      }

      vim.keymap.set('n', '<leader>l', lint.try_lint, { desc = '[l]int' })

      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        group = vim.api.nvim_create_augroup('AutoLintGroup', { clear = true }),
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}

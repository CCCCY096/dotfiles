return {
  'mfussenegger/nvim-lint',
  config = function()
    vim.list_extend(ENSURE_INSTALLED, {})

    local lint = require 'lint'
    lint.linters_by_ft = {
      go = { 'golangcilint' }, -- golangcilint is installed locally by myself instead of mason
    }

    vim.keymap.set('n', '<leader>l', lint.try_lint, { desc = '[l]int' })

    vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
      group = vim.api.nvim_create_augroup('AutoLintGroup', { clear = true }),
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}

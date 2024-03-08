return {
  'stevearc/conform.nvim',
  config = function()
    vim.list_extend(ENSURE_INSTALLED, {
      'stylua',
      'prettier',
      'codespell',
    })

    local conform = require 'conform'
    conform.setup {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        json = { 'prettier' },
        markdown = { 'prettier' },
        -- Use the "*" filetype to run formatters on all filetypes.
        ['*'] = { 'codespell' },
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ['_'] = { 'trim_whitespace' },
      },
    }

    local fmt = function()
      conform.format({ lsp_fallback = true }, nil)
    end
    vim.keymap.set('n', '<leader>F', fmt, { desc = '[F]ormat' })
  end,
}

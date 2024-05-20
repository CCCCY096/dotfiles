return {
  'stevearc/conform.nvim',
  config = function()
    vim.list_extend(ENSURE_INSTALLED, {
      'stylua',
      'prettier',
      'ocamlformat',
      -- 'codespell',
    })

    local conform = require 'conform'
    conform.setup {
      notify_on_error = false,
      format_on_save = function(_)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        json = { 'prettier' },
        markdown = { 'prettier' },
        ocaml = { 'ocamlformat' },
        -- Use the "*" filetype to run formatters on all filetypes.
        -- ['*'] = { 'codespell' },
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ['_'] = { 'trim_whitespace' },
      },
    }

    local fmt = function()
      conform.format({ lsp_fallback = true }, nil)
    end
    vim.keymap.set('n', '<leader>F', fmt, { desc = '[F]ormat' })

    local toggleFormatOnSave = function()
      vim.g.disable_autoformat = not vim.g.disable_autoformat
    end
    vim.keymap.set('n', '<leader>tf', toggleFormatOnSave, { desc = '[t]oggle auto [f]ormat' })
  end,
}

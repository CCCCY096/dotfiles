-- for Go Templ
vim.filetype.add { extension = { templ = 'templ' } }

return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',

    -- Useful status updates for LSP
    { 'j-hui/fidget.nvim', config = true },

    -- Additional lua configuration, makes nvim stuff amazing!
    {
      'folke/lazydev.nvim',
      ft = 'lua', -- only load on lua files
      config = true,
    },

    -- Adds LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',

    -- Need pickers when lsp attaches
    'ibhagwan/fzf-lua',
  },
  config = function()
    -- for highlighting curosr
    vim.opt.updatetime = 100

    local fzf = require 'fzf-lua'

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('Chengyu-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('gr', fzf.lsp_references, '[g]oto [r]eferences')
        map('gI', fzf.lsp_implementations, '[g]oto [I]mplementation')
        map('gd', vim.lsp.buf.definition, '[g]oto [d]efinition')
        map('gD', vim.lsp.buf.type_definition, '[g]oto type [D]efinition')

        map('<leader>s', fzf.lsp_document_symbols, '[s]ymbols')
        map('<leader>S', fzf.lsp_live_workspace_symbols, 'workspace [S]ymbols')
        map('<leader>k', fzf.lsp_finder, '[k]aboom!')
        map('<leader>r', vim.lsp.buf.rename, '[r]ename')
        map('<leader>c', vim.lsp.buf.code_action, '[c]ode action')

        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { buffer = event.buf, desc = 'show signature help' })

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method 'textDocument/documentHighlight' then
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    vim.keymap.set('n', '<leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { desc = '[t]oggle inlay [h]int' })

    vim.keymap.set('n', '<leader>lr', function()
      vim.cmd 'LspRestart'
    end, { desc = '[l]sp [r]estart' })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    local servers = {
      gopls = {},
      goalngci_lint_ls = {},
      lua_ls = {
        settings = {
          Lua = {
            hint = {
              enable = true,
            },
          },
        },
      },
      ocamllsp = {},
      elixirls = {},
      markdown_oxide = {},
      zls = {},
      clangd = {},
      pyright = {},
    }

    require('mason').setup()

    vim.list_extend(ENSURE_INSTALLED, vim.tbl_keys(servers))

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}

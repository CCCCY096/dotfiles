-- for Go Templ
vim.filetype.add { extension = { templ = 'templ' } }

return {
  'neovim/nvim-lspconfig',
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
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('Chengyu-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        local fzf = require 'fzf-lua'

        -- Find references for the word under your cursor.
        map('gr', fzf.lsp_references, '[g]oto [r]eferences')

        -- Jump to the implementation of the word under your cursor.
        map('gI', fzf.lsp_implementations, '[g]oto [I]mplementation')

        -- Fuzzy find all the symbols in your current document.
        map('<leader>fd', fzf.lsp_document_symbols, '[f]ind [d]ocument symbols')

        -- Fuzzy find all the symbols in your current workspace
        map('<leader>fs', fzf.lsp_live_workspace_symbols, '[f]ind [s]symbols in workspace')

        -- Jump to the definition of the word under your cursor.
        map('gd', vim.lsp.buf.definition, '[g]oto [d]efinition')

        -- Jump to the type of the word under your cursor.
        map('gD', vim.lsp.buf.type_definition, '[g]oto type [D]efinition')

        -- Rename the variable under your cursor
        --  Most Language Servers support renaming across files, etc.
        map('<leader>r', vim.lsp.buf.rename, '[r]ename')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('<leader>c', vim.lsp.buf.code_action, '[c]ode action')

        -- Show hovering during insert mode
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { desc = 'show signature help' })

        -- When you move your cursor, the highlights will be cleared (the second autocommand).
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
      zls = {},
      clangd = {},
      pyright = {},
      elixirls = {},
      yamlls = {},
      vale_ls = {},
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

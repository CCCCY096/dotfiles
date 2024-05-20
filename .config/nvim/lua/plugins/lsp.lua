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
    'folke/neodev.nvim',

    -- Adds LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',

    -- Need telescope picker lsp attaches
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('Chengyu-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-T>.
        map('gd', require('telescope.builtin').lsp_definitions, '[g]oto [d]efinition')

        -- Find references for the word under your cursor.
        map('gr', require('telescope.builtin').lsp_references, '[g]oto [r]eferences')

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map('gI', require('telescope.builtin').lsp_implementations, '[g]oto [I]mplementation')

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map('gD', require('telescope.builtin').lsp_type_definitions, '[g]oto type [D]efinition')

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map('<leader>fd', require('telescope.builtin').lsp_document_symbols, '[f]ind [d]ocument symbols')

        -- Fuzzy find all the symbols in your current workspace
        --  Similar to document symbols, except searches over your whole project.
        map('<leader>fs', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[f]ind [s]symbols in workspace')

        -- Rename the variable under your cursor
        --  Most Language Servers support renaming across files, etc.
        map('<leader>r', vim.lsp.buf.rename, '[r]ename')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('<leader>c', vim.lsp.buf.code_action, '[c]ode action')

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

        if client and client.supports_method 'textDocument/inlayHint' then
          vim.lsp.inlay_hint.enable(true)

          map('<leader>c', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, '[t]oggle inlay [h]int')
        end
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    local servers = {
      gopls = {},
      lua_ls = {},
      ocamllsp = {},
      zls = {},
      clangd = {},
      pyright = {},
      yamlls = {},
      vale_ls = {},
    }

    require('mason').setup()

    vim.list_extend(ENSURE_INSTALLED, vim.tbl_keys(servers))

    --- Setup neovim lua configuration before lspconfig.lua_ls.setup
    require('neodev').setup()

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

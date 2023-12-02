local lazyFile = require('utils').lazy_file_events

local servers = {
  -- Go
  gopls = {
    gofumpt = true,
  },

  -- lua
  lua_ls = {
    -- Lua = {
    --   workspace = { checkThirdParty = false },
    --   telemetry = { enable = false },
    -- },
  },

  clangd = {},
  pyright = {},
  yamlls = {},
  marksman = {},
}

return {
  {
    'williamboman/mason-lspconfig.nvim',
    event = { lazyFile },
    dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',

      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', config = true },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- need telescope picker lsp attaches
      'nvim-telescope/telescope-fzf-native.nvim',

      -- formatter; might need to override some parts of it
      'stevearc/conform.nvim'
    },
    config = function()
      -- the following mason-related setup order is enforced
      local mason_lspconfig = require 'mason-lspconfig'
      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      --- Setup neovim lua configuration before lspconfig.lua_ls.setup
      require('neodev').setup()

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      --  This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(client, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        -- [[ LSP keymaps ]]
        nmap('<leader>r', vim.lsp.buf.rename, '[r]ename')
        nmap('<leader>c', vim.lsp.buf.code_action, '[c]ode actions')
        nmap('<leader>fd', require('telescope.builtin').lsp_document_symbols, '[f]ind symbols in [d]ocument')
        nmap('<leader>fs', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[f]ind [s]ymbols in workspace')

        nmap('gd', require('telescope.builtin').lsp_definitions, '[g]oto [d]efinition')
        nmap('gr', require('telescope.builtin').lsp_references, '[g]oto [r]eferences')
        nmap('gI', require('telescope.builtin').lsp_implementations, '[g]oto [I]mplementation')
        nmap('gD', require('telescope.builtin').lsp_type_definitions, '[g]oto Type [D]efinition')

        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        if client.server_capabilities.documentFormattingProvider then
          if client.name == 'lua_ls' then -- don't use LSP format provider for lua_ls; we have stylua as a better formatter
          else -- for the others, prefer LSP over formatter!
            nmap('<leader>F', vim.lsp.buf.format, '[F]ormat current buffer')
          end
        end

        vim.api.nvim_create_augroup('LSPAutoFormat', { clear = true })
        local lspAutoFormatGroup = vim.api.nvim_create_augroup('LSPAutoFormat', { clear = false })

        -- Auto format for Go files
        if client.name == 'gopls' then
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = lspAutoFormatGroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format()
            end,
          })
        end
      end

      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          }
        end,
      }
    end,
  },
}

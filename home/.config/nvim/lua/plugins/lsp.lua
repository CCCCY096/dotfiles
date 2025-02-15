-- for Go Templ
vim.filetype.add { extension = { templ = 'templ' } }

return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    -- Useful status updates for LSP
    { 'j-hui/fidget.nvim', config = true },

    -- Additional lua configuration, makes nvim stuff amazing!
    {
      'folke/lazydev.nvim',
      ft = 'lua', -- only load on lua files
      config = true,
    },

    -- lsp completion capabilities
    'saghen/blink.cmp',

    -- need it for vim.ui.select
    'ibhagwan/fzf-lua',
  },
  config = function()
    vim.keymap.set('n', '<leader>oh', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { desc = 'inlay [h]int' })

    -- managed by homebrew by default
    local servers = {
      markdown_oxide = {},
      gopls = {}, -- go install golang.org/x/tools/gopls@latest
      golangci_lint_ls = {}, -- go install github.com/nametake/golangci-lint-langserver@latest
      lua_ls = {
        settings = {
          Lua = {
            hint = {
              enable = true,
            },
          },
        },
      },
      ocamllsp = {}, -- opam
      elixirls = {
        cmd = { 'elixir-ls' },
      }, -- opam
      clangd = {},
      pyright = {},
      ruff = {},
      tinymist = {
        offset_encoding = 'utf-8', -- https://github.com/Myriad-Dreamin/tinymist/issues/638#issuecomment-2395941103
        settings = {
          exportPdf = 'onSave',
          -- outputPath = '$root/target/$dir/$name',
        },
      },
      typos_lsp = {
        autostart = false,
        init_options = {
          -- How typos are rendered in the editor, can be one of an Error, Warning, Info or Hint.
          -- Defaults to error.
          diagnosticSeverity = 'Hint',
        },
      },
    }

    for server_name, config in pairs(servers) do
      -- This handles overriding only values explicitly passed
      -- by the server configuration above. Useful when disabling
      -- certain features of an LSP (for example, turning off formatting for tsserver)
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      require('lspconfig')[server_name].setup(config)
    end

    vim.keymap.set('n', '<leader>l', function()
      local lsp_names = {}

      local i = 1
      for k, _ in pairs(servers) do
        lsp_names[i] = k
        i = i + 1
      end

      vim.ui.select(lsp_names, {
        prompt = 'LSP> ',
      }, function(lsp_choice)
        if not lsp_choice then
          return
        end

        -- have to nest it because on_choice funcs are async??
        vim.ui.select({ 'Start', 'Stop', 'Restart' }, {
          prompt = 'Action> ',
        }, function(action_choice)
          if not action_choice then
            return
          end

          vim.cmd('Lsp' .. action_choice .. ' ' .. lsp_choice)
        end)
      end)
    end, { desc = '[l]sp start/stop/restart' })

    -- somehow this does not work anymore
    -- auto attach markdown_oxide when in project "journals"
    -- local proj_path = vim.fs.root(0, '.git')
    -- if proj_path and proj_path == vim.fs.root(0, 'daily') and vim.fs.basename(proj_path) == 'journals' then
    --   vim.cmd 'LspStart markdown_oxide'
    -- end
  end,
}

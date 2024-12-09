return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  event = 'VeryLazy',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-context',
  },
  build = ':TSUpdate',
  config = function()
    local disable = function(_, bufnr)
      return vim.api.nvim_buf_line_count(bufnr) > 50000
    end

    require('treesitter-context').setup {
      on_attach = function(bufnr)
        return not disable(nil, bufnr)
      end,
    }

    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup {
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        disable = disable,
      },
      indent = {
        enable = true,
        disable = disable,
      },
      incremental_selection = {
        enable = true,
        disable = disable,
        keymaps = {
          -- init_selection = '<C-n>',
          node_incremental = 'v',
          node_decremental = 'V',
        },
      },
    }

    vim.api.nvim_create_autocmd('BufReadPost', {
      callback = function(ev)
        if not disable(nil, ev.buf) then
          vim.opt.foldlevel = 99
          vim.opt.foldmethod = 'expr'
          vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        end
      end,
    })
  end,
}

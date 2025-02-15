return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local fzf = require 'fzf-lua'

    -- configure fzf-lua
    fzf.setup {
      winopts = {
        preview = {
          layout = 'vertical', -- horizontal|vertical|flex
          vertical = 'up:55%',
          delay = 0,
        },
      },
    }

    -- register fzf-lua as the UI selector
    fzf.register_ui_select()

    -- general fzf-lua commands
    local keymaps = {
      { '<leader>f', fzf.files, '[f]iles' },
      {
        '<leader>F',
        function()
          fzf.files { cwd = vim.fn.expand '%:p:h' }
        end,
        '[F]ile peers',
      },
      { '<leader>b', fzf.buffers, 'buffers' },
      { '<leader>d', fzf.diagnostics_document, '[d]iagnostics' },
      { '<leader>D', fzf.diagnostics_workspace, 'workspace [D]iagnostics' },
      { '<leader>/', fzf.live_grep, 'fuzzy search workspace' },
      { '<leader>?', fzf.lgrep_curbuf, 'fuzzy search current buffer' },
      { '<leader>j', fzf.jumps, '[j]ump list' },
    }

    -- lessly used commands
    local project_keymaps = {
      {
        '<leader>po',
        function()
          fzf.oldfiles { cwd_only = true }
        end,
        '[o]ld files',
      },
      { '<leader>pg', fzf.git_files, '[g]it [f]iles' },
      { '<leader>pw', fzf.grep_cword, '[w]ord' },
      { '<leader>ph', fzf.helptags, '[h]elp' },
      { '<leader>pr', fzf.resume, '[r]esume' },
      { '<leader>pm', fzf.builtin, '[m]ore...' },
    }

    -- special directories
    local special_dir_keymaps = {
      {
        '<leader>pc',
        function()
          fzf.files { cwd = '~/.config/' }
        end,
        '[c]onfigs',
      },
      {
        '<leader>pj',
        function()
          fzf.files { cwd = '~/projects/journals/' }
        end,
        '[j]ournals',
      },
    }

    -- LSP keymaps
    -- unset gr-defaults in nvim v0.11.0
    vim.keymap.set('n', 'gr', 'gr', { nowait = true })

    local lsp_keymaps = {
      { 'gr', fzf.lsp_references, '[g]oto [r]eferences' },
      { 'gI', fzf.lsp_implementations, '[g]oto [I]mplementation' },
      { 'gd', vim.lsp.buf.definition, '[g]oto [d]efinition' },
      { 'gD', vim.lsp.buf.type_definition, '[g]oto type [D]efinition' },

      { '<leader>s', fzf.lsp_document_symbols, '[s]ymbols' },
      { '<leader>S', fzf.lsp_live_workspace_symbols, 'workspace [S]ymbols' },
      { '<leader>x', fzf.lsp_finder, '[x]ray' },
      { '<leader>r', vim.lsp.buf.rename, '[r]ename' },
      { '<leader>r', vim.lsp.buf.rename, '[r]ename' },
      { '<leader>c', vim.lsp.buf.code_action, '[c]ode action', mode = { 'n', 'v' } },
    }

    -- apply keymaps
    local apply_keymaps = function(mappings)
      for _, mapping in ipairs(mappings) do
        local mode = mapping.mode or 'n'
        vim.keymap.set(mode, mapping[1], mapping[2], { desc = mapping[3] })
      end
    end

    apply_keymaps(keymaps)
    apply_keymaps(project_keymaps)
    apply_keymaps(special_dir_keymaps)
    apply_keymaps(lsp_keymaps)
  end,
}

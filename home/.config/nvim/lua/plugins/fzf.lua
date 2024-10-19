return {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local fzf = require 'fzf-lua'

    fzf.setup {
      'defaults',
      winopts = {
        preview = {
          delay = 10,
        },
      },
      grep = {
        actions = {
          -- toggle '.gitignore' for grep
          ['ctrl-g'] = { fzf.actions.toggle_ignore },
          -- narrow down the result set before switching to fuzzy matching with for further refinement.
          ['ctrl-r'] = { fzf.actions.grep_lgrep },
        },
      },
    }

    vim.keymap.set('n', '<leader>f', fzf.files, { desc = '[f]iles' })
    vim.keymap.set('n', '<leader>F', function()
      fzf.files { cwd = vim.fn.expand '%:p:h' }
    end, { desc = '[F]ile peers' })

    vim.keymap.set('n', '<leader>b', fzf.buffers, { desc = '[b]uffers' })
    vim.keymap.set('n', '<leader>d', fzf.diagnostics_document, { desc = '[d]iagnostics' })
    vim.keymap.set('n', '<leader>D', fzf.diagnostics_workspace, { desc = 'workspace [D]iagnostics' })
    vim.keymap.set('n', '<leader>/', fzf.live_grep, { desc = 'fuzzy search workspace' })
    vim.keymap.set('n', '<leader>?', fzf.lgrep_curbuf, { desc = 'fuzzy search current buffer' })
    vim.keymap.set('n', '<leader>j', fzf.jumps, { desc = '[j]ump list' })

    vim.keymap.set('n', '<leader>po', function()
      fzf.oldfiles { cwd_only = true }
    end, { desc = '[o]ld files' })
    vim.keymap.set('n', '<leader>pg', fzf.git_files, { desc = '[g]it [f]iles' })
    vim.keymap.set('n', '<leader>pw', fzf.files, { desc = '[w]ord' })
    vim.keymap.set('n', '<leader>ph', fzf.helptags, { desc = '[h]elp' })
    vim.keymap.set('n', '<leader>pr', fzf.resume, { desc = '[r]esume' })
    vim.keymap.set('n', '<leader>pm', fzf.builtin, { desc = '[m]ore...' })

    -- special dirs
    vim.keymap.set('n', '<leader>pc', function()
      fzf.files { cwd = '~/.config/' }
    end, { desc = '[c]onfigs' })
    vim.keymap.set('n', '<leader>pj', function()
      fzf.files { cwd = '~/projects/journals/' }
    end, { desc = '[j]ournals' })
  end,
}

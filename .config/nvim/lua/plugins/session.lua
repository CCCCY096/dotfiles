return {
  'echasnovski/mini.sessions',
  version = false,
  config = function()
    local session = require 'mini.sessions'
    session.setup()

    local set_session = function()
      session.write 'Session.vim'
    end

    vim.keymap.set('n', '<leader>S', set_session, { desc = 'save [S]ession' })
  end,
}

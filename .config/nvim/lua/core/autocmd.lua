-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  desc = 'Briefly highlight yanked text',
})

-- local events = {
--   'BufEnter',
--   'BufLeave',
--   'BufNew',
--   'BufNewFile',
--   'BufRead',
--   'BufReadPost',
--   'BufReadPre',
--   'BufUnload',
--   'BufWinEnter',
--   'BufWinLeave',
--   'BufWrite',
--   'BufWritePost',
--   'BufWritePre',
--   'FileReadPost',
--   'FileReadPre',
--   'FileWritePost',
--   'FileWritePre',
--   'FileType',
--   'VimEnter',
--   'UIEnter',
--   'InsertEnter',
-- }
--
-- vim.api.nvim_create_autocmd(events, {
--   callback = function(arg)
--     print('triggered', arg.event, arg.buf, arg.grouparg, arg.id)
--   end,
--   group = vim.api.nvim_create_augroup('MonitorEvents', { clear = true }),
--   pattern = '*',
-- })

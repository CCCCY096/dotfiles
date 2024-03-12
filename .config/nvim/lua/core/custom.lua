-- Better session experience!

local default_sf = vim.fn.join({ vim.fn.getcwd(), 'Session.vim' }, '/')

local mksession = function(custom_sf)
  local sf = default_sf
  if custom_sf then
    sf = custom_sf
  end

  local cmd = vim.fn.join { 'mksession! ', sf }
  vim.cmd(cmd)
  print 'Made a local session!'
end

local ldsession = function()
  if vim.fn.findfile(default_sf) ~= '' then
    print 'No local session to load!'
    return
  end

  local cmd = vim.fn.join { 'source ', default_sf }
  vim.cmd(cmd)
  print 'Loaded a local session!'
end

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    if vim.fn.argc() == 0 and vim.fn.findfile(default_sf) ~= '' then
      print 'Found a local session!'
    end
  end,
})

vim.api.nvim_create_autocmd('VimLeavePre', {
  callback = function()
    local sf = vim.v.this_session
    if sf ~= '' then
      mksession(vim.v.this_session)
    end
  end,
})

vim.keymap.set('n', '<leader>S', mksession, { desc = 'make [S]ession' })
vim.keymap.set('n', '<leader>s', ldsession, { desc = 'load [s]ession' })

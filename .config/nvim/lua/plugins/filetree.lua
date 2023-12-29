return {
  'echasnovski/mini.files',
  version = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('mini.files').setup()

    -- Toggle explorer
    local minifiles_toggle_current_directory = function()
      if not MiniFiles.close() then
        if not pcall(MiniFiles.open, vim.api.nvim_buf_get_name(0)) then
          MiniFiles.open(nil, false)
        end
        MiniFiles.reveal_cwd()
      end
    end
    vim.keymap.set('n', '<leader>e', minifiles_toggle_current_directory, { desc = 'Toggle file [e]xplore in cwd' })

    local minifiles_toggle = function()
      if not MiniFiles.close() then
        MiniFiles.open(nil, false)
      end
    end
    vim.keymap.set('n', '<leader>E', minifiles_toggle, { desc = 'Toggle fresh file [E]xplore' })

    -- Create mapping to show/hide dot-files
    local show_dotfiles = true

    local filter_show = function(_)
      return true
    end

    local filter_hide = function(fs_entry)
      return not vim.startswith(fs_entry.name, '.')
    end

    local toggle_dotfiles = function()
      show_dotfiles = not show_dotfiles
      local new_filter = show_dotfiles and filter_show or filter_hide
      MiniFiles.refresh { content = { filter = new_filter } }
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id
        -- Tweak left-hand side of mapping to your liking
        vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
      end,
    })

    -- Open with splits
    local map_split = function(buf_id, lhs, direction)
      local rhs = function()
        local target_window = MiniFiles.get_target_window()
        if target_window == nil then
          return
        end

        -- Make new window and set it as target
        local new_target_window
        vim.api.nvim_win_call(target_window, function()
          vim.cmd(direction .. ' split')
          new_target_window = vim.api.nvim_get_current_win()
        end)

        MiniFiles.set_target_window(new_target_window)
        MiniFiles.go_in()
        MiniFiles.close()
      end

      -- Adding `desc` will result into `show_help` entries
      local desc = 'Split ' .. direction
      vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id
        -- Tweak keys to your liking
        map_split(buf_id, 'gs', 'belowright horizontal')
        map_split(buf_id, 'gv', 'belowright vertical')
      end,
    })

    -- Create mapping to set current working directory
    local files_set_cwd = function(_)
      -- Works only if cursor is on the valid file system entry
      local cur_entry_path = MiniFiles.get_fs_entry().path
      local cur_directory = vim.fs.dirname(cur_entry_path)
      vim.fn.chdir(cur_directory)
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        vim.keymap.set('n', 'g@', files_set_cwd, { buffer = args.data.buf_id, desc = 'Set cwd' })
      end,
    })
  end,
}

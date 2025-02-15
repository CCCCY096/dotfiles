return {
  {
    'olimorris/codecompanion.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('codecompanion').setup {
        adapters = {
          ollama = function()
            return require('codecompanion.adapters').extend('ollama', {
              schema = {
                model = {
                  default = 'deepseek-r1:7b',
                },
                num_ctx = {
                  default = 4028,
                },
              },
            })
          end,
          openai_compatible = function()
            return require('codecompanion.adapters').extend('openai_compatible', {
              env = {
                api_key = 'LLM_NVIM_DEEPSEEK_API_TOKEN',
                url = 'https://api.deepseek.com',
                chat_url = '/v1/chat/completions',
              },
            })
          end,
        },
        strategies = {
          chat = {
            adapter = 'ollama',
          },
          inline = {
            adapter = 'ollama',
          },
        },
      }
    end,
  },

  {
    'huggingface/llm.nvim',
    enabled = false,
    event = 'VeryLazy',
    config = function()
      require('llm').setup {
        backend = 'ollama',
        model = 'deepseek-coder-v2:16b',
        url = 'http://localhost:11434', -- llm-ls uses "/api/generate"
        -- cf https://github.com/ollama/ollama/blob/main/docs/api.md#parameters
        request_body = {
          -- Modelfile options for the model you use
          options = {
            temperature = 0.2,
            top_p = 0.95,
          },
          lsp = {
            cmd_env = { LLM_LOG_LEVEL = 'DEBUG' },
          },
        },
      }
    end,
  },
}

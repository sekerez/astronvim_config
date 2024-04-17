return {
  {
    "nvim-dap",
    config = function()
      local dap = require "dap"
      dap.configurations.lua = {
        {
          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim instance",
        },
      }

      dap.adapters.nlua = function(callback, config)
        callback { type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 }
      end
    end,
  },
  {
    "nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        dependencies = "zbirenbaum/copilot.lua",
        config = function(_, opts)
          local copilot_cmp = require "copilot_cmp"
          copilot_cmp.setup(opts)
          -- attach cmp source whenever copilot attaches
          -- fixes lazy-loading issues with the copilot cmp source
          -- require("lazyvim.util").lsp.on_attach(function(client)
          --   if client.name == "copilot" then copilot_cmp._on_insert_enter {} end
          -- end)
        end,
      },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = "copilot",
        group_index = 1,
        priority = 100,
      })
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    opts = { shade_terminals = false },
    keys = {
      {
        "<leader>t",
        function() require("toggleterm").send_lines_to_terminal("single_line", true, { args = vim.v.count }) end,
        desc = "Send to Terminal",
        mode = { "v", "x" },
      },
    },
  },
  {
    "onsails/lspkind.nvim",
    opts = { symbol_map = { Copilot = "" } },
  },
  -- {
  --   "lspconfig",
  --   config = function(plugin, opts)
  --     require "plugins.configs.lspconfig"(plugin, opts)
  --     require("lspconfig").sqls.setup {
  --       on_attach = function(client, bufnr)
  --         require("sqls").on_attach(client, bufnr) -- require sqls.nvim
  --       end,
  --       settings = {
  --         sqls = {
  --           connections = {
  --             {
  --               driver = "postgresql",
  --               dataSourceName = os.getenv "POSTGRES_DBURL" or "",
  --             },
  --           },
  --         },
  --       },
  --     }
  --   end,
  -- },
  {
    "nmac427/guess-indent.nvim",
    opts = { filetype_exclude = { "go" } },
  },
  -- You can disable default plugins as follows:
  --
  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  -- {
  --   "L3MON4D3/LuaSnip",
  --   config = function(plugin, opts)
  --     require "plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom luasnip configuration such as filetype extend or custom snippets
  --     local luasnip = require "luasnip"
  --     luasnip.filetype_extend("javascript", { "javascriptreact" })
  --   end,
  -- },
  -- {
  --   "windwp/nvim-autopairs",
  --   config = function(plugin, opts)
  --     require "plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom autopairs configuration such as custom rules
  --     local npairs = require "nvim-autopairs"
  --     local Rule = require "nvim-autopairs.rule"
  --     local cond = require "nvim-autopairs.conds"
  --     npairs.add_rules(
  --       {
  --         Rule("$", "$", { "tex", "latex" })
  --           -- don't add a pair if the next character is %
  --           :with_pair(cond.not_after_regex "%%")
  --           -- don't add a pair if  the previous character is xxx
  --           :with_pair(
  --             cond.not_before_regex("xxx", 3)
  --           )
  --           -- don't move right when repeat character
  --           :with_move(cond.none())
  --           -- don't delete if the next character is xx
  --           :with_del(cond.not_after_regex "xx")
  --           -- disable adding a newline when you press <cr>
  --           :with_cr(cond.none()),
  --       },
  --       -- disable for .vim files, but it work for another filetypes
  --       Rule("a", "a", "-vim")
  --     )
  --   end,
  -- },
  -- By adding to the which-key config and using our helper function you can add more which-key registered bindings
  -- {
  --   "folke/which-key.nvim",
  --   config = function(plugin, opts)
  --     require "plugins.configs.which-key"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- Add bindings which show up as group name
  --     local wk = require "which-key"
  --     wk.register({
  --       b = { name = "Buffer" },
  --     }, { mode = "n", prefix = "<leader>" })
  --   end,
  -- },
}

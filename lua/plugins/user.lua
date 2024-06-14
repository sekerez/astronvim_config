-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  -- {
  --   "nvimdev/lspsaga.nvim",
  --   config = function()
  --     local get_icon = require("astroui.utils").get_icon
  --     require("lspsaga").setup {
  --       ui = {
  --         code_action_icon = get_icon "lightbulb",
  --       },
  --     }
  --   end,
  --   event = "LspAttach",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  -- },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    opts = { hint_enable = false },
  },
  {
    "willothy/flatten.nvim",
    config = true,
    -- or pass configuration with
    -- opts = {  }
    -- Ensure that it runs first to minimize delay when opening file from terminal
    opts = function()
      ---@type Terminal?
      local saved_terminal

      return {
        window = {
          open = "alternate",
        },
        callbacks = {
          should_block = function(argv)
            -- Note that argv contains all the parts of the CLI command, including
            -- Neovim's path, commands, options and files.
            -- See: :help v:argv

            -- In this case, we would block if we find the `-b` flag
            -- This allows you to use `nvim -b file1` instead of
            -- `nvim --cmd 'let g:flatten_wait=1' file1`
            return vim.tbl_contains(argv, "-b")

            -- Alternatively, we can block if we find the diff-mode option
            -- return vim.tbl_contains(argv, "-d")
          end,
          pre_open = function()
            local term = require "toggleterm.terminal"
            local termid = term.get_focused_id()
            saved_terminal = term.get(termid)
          end,
          post_open = function(bufnr, winnr, ft, is_blocking)
            if is_blocking and saved_terminal then
              -- Hide the terminal while it's blocking
              saved_terminal:close()
            else
              -- If it's a normal file, just switch to its window
              vim.api.nvim_set_current_win(winnr)

              -- If we're in a different wezterm pane/tab, switch to the current one
              -- Requires willothy/wezterm.nvim
              require("wezterm").switch_pane.id(tonumber(os.getenv "WEZTERM_PANE"))
            end

            -- If the file is a git commit, create one-shot autocmd to delete its buffer on write
            -- If you just want the toggleable terminal integration, ignore this bit
            if ft == "gitcommit" or ft == "gitrebase" then
              vim.api.nvim_create_autocmd("BufWritePost", {
                buffer = bufnr,
                once = true,
                callback = vim.schedule_wrap(function() vim.api.nvim_buf_delete(bufnr, {}) end),
              })
            end
          end,
          block_end = function()
            -- After blocking ends (for a git commit, etc), reopen the terminal
            vim.schedule(function()
              if saved_terminal then
                saved_terminal:open()
                saved_terminal = nil
              end
            end)
          end,
        },
      }
    end,
    lazy = false,
    priority = 1001,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    lazy = false,
    -- event = { "BufEnter *.ts*" },
    opts = {
      settings = {
        tsserver_file_preferences = {
          includeCompletionsForModuleExports = true,
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = false,
          includeInlayEnumMemberValueHints = true,
        },
        jsx_close_tag = {
          enable = true,
        },
      },
    },

    -- TSToolsOrganizeImports - sorts and removes unused imports
    -- TSToolsSortImports - sorts imports
    -- TSToolsRemoveUnusedImports - removes unused imports
    -- TSToolsRemoveUnused - removes all unused statements
    -- TSToolsAddMissingImports - adds imports for all statements that lack one and can be imported
    -- TSToolsFixAll - fixes all fixable errors
    -- TSToolsGoToSourceDefinition - goes to source definition (available since TS v4.7)
    -- TSToolsRenameFile - allow to rename current file and apply changes to connected files
    -- TSToolsFileReferences - find files that reference the current file (available since TS v4.2)
    keys = {
      { "<leader>lT", name = "Typescript Tools", desc = "Typescript Tools" },
      { "<leader>lTo", "<cmd>TSToolsOrganizeImports<CR>", desc = "Organize Imports" },
      { "<leader>lTs", "<cmd>TSToolsSortImports<CR>", desc = "Sort Imports" },
      { "<leader>lTX", "<cmd>TSToolsRemoveUnusedImports<CR>", desc = "Remove Unused Imports" },
      { "<leader>lTx", "<cmd>TSToolsRemoveUnused<CR>", desc = "Remove Unused Statements" },
      { "<leader>lTa", "<cmd>TSToolsAddMissingImports<CR>", desc = "Add Missing Imports" },
      { "<leader>lTf", "<cmd>TSToolsFixAll<CR>", desc = "Fix All Errors" },
      { "<leader>lTd", "<cmd>TSToolsGoToSourceDefinition<CR>", desc = "Source Definition" },
      { "<leader>lTr", "<cmd>TSToolsRenameFile<CR>", desc = "Rename File" },
      { "<leader>lTF", "<cmd>TSToolsFileReferences<CR>", desc = "Find File References" },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  -- == Examples of Overriding Plugins ==

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
  {
    "ggandor/leap.nvim",
    lazy = false,
    config = function() require("leap").create_default_mappings() end,
  },
  {
    "ellisonleao/dotenv.nvim",
    lazy = false,
    config = function()
      require("dotenv").setup {
        enable_on_load = true, -- will load your .env file upon loading a buffer
        verbose = false, -- show error notification if .env file is not found and if .env is loaded
      }
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot" },
    lazy = false,
    config = function()
      require("copilot").setup {
        suggestion = { enabled = false },
        panel = { enabled = false },
      }
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function() require("copilot_cmp").setup() end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePost" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "eslint_d" },
        yaml = { "yamllint" },
        json = { "fixjson", "eslint_d" },
        zig = { "zigfmt" },
        sql = { "pg_format" },
        go = { "gofumpt", "golines" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        -- tsx = { "eslint_d" },
        terraform = { "terraform_fmt" },
      },
      formatters = {
        black = {
          prepend_args = { "--fast" },
        },
        golines = {
          prepend_args = { "-m", "120", "-t", "2" },
        },
      },
      -- format_on_save = function(bufnr)
      --   local filetype = vim.bo[bufnr].filetype
      --   if slow_format_filetypes[filetype] then return end
      --   local function on_format(err)
      --     if err and err:match "timeout$" then slow_format_filetypes[filetype] = true end
      --   end
      --
      --   return { timeout_ms = 200, lsp_fallback = true }, on_format
      -- end,

      format_after_save = { lsp_fallback = false, timeout_ms = 1000 },
      log_level = vim.log.levels.DEBUG,
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-go",
    },
    event = { "BufEnter *test*" },
    config = function()
      local neotest_ns = vim.api.nvim_create_namespace "neotest"
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
      require("neotest").setup {
        adapters = {
          require "neotest-go",
        },
      }
    end,
    keys = {
      { "<leader>m", desc = "Test" },
      { "<leader>mn", function() require("neotest").run.run() end, desc = "Run Nearest" },
      { "<leader>ml", function() require("neotest").run.run_last() end, desc = "Run Last" },
      { "<leader>mf", function() require("neotest").run.run(vim.fn.expand "%") end, desc = "Run File" },
      { "<leader>ms", function() require("neotest").summary.toggle() end, desc = "Summary" },
      { "<leader>mx", function() require("neotest").run.stop() end, desc = "Stop" },
      { "<leader>ma", function() require("neotest").run.attach() end, desc = "Attach" },
      { "<leader>mo", function() require("neotest").output.open() end, desc = "Output" },
      { "<leader>mO", function() require("neotest").output_panel.toggle() end, desc = "Output Panel" },
      { "<leader>mw", function() require("neotest").run.run(vim.fn.getcwd()) end, desc = "Whole Suite" },
    },
  },
  {
    "nvim-neotest/neotest-go",
    event = { "BufEnter *test.go" },
  },
  {
    "leoluz/nvim-dap-go",
    dependencies = "nvim-dap",
    event = { "BufEnter *test.go" },
    config = function() require("dap-go").setup() end,
    keys = {
      { "<leader>dt", function() require("dap-go").debug_test() end, desc = "Test Nearest" },
      { "<leader>dl", function() require("dap-go").debug_last_test() end, desc = "Test Last" },
    },
  },
  {
    "jbyuki/one-small-step-for-vimkind",
    dependencies = "nvim-dap",
    event = { "BufEnter *.lua" },
    keys = {
      { "<leader>dL", function() require("osv").launch { port = 8086 } end, desc = "Launch OSV server" },
    },
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    event = { "BufEnter" },
    config = function(_, opts)
      opts.prompt_func_return_type = { go = true }
      opts.prompt_func_param_type = { go = true }
      require("refactoring").setup(opts)
    end,
    keys = {
      { "<leader>r", desc = "Refactor", mode = { "v", "x", "n" } },
      { "<leader>re", desc = "Extract", mode = { "v", "x", "n" } },
      {
        "<leader>ref",
        function() require("refactoring").refactor "Extract Function" end,
        desc = "Extract Function",
        mode = { "v", "x" },
      },
      {
        "<leader>rev",
        function() require("refactoring").refactor "Extract Variable" end,
        desc = "Extract Variable",
        mode = { "v", "x" },
      },
      {
        "<leader>reb",
        function() require("refactoring").refactor "Extract Block" end,
        desc = "Extract Block",
        mode = { "v", "x" },
      },
      { "<leader>ri", desc = "Inline", mode = { "v", "x" } },
      {
        "<leader>rif",
        function() require("refactoring").refactor "Inline Function" end,
        desc = "Inline Function",
        mode = { "v", "x" },
      },
      {
        "<leader>riv",
        function() require("refactoring").refactor "Inline Variable" end,
        desc = "Inline Variable",
        mode = { "v", "x" },
      },
      {
        "<leader>rib",
        function() require("refactoring").refactor "Inline Block" end,
        desc = "Inline Block",
        mode = { "v", "x" },
      },
      { "<leader>rp", desc = "Print", mode = { "v", "x" } },
      {
        "<leader>rpv",
        function() require("refactoring").refactor "Print Variable" end,
        desc = "Print Variable",
        mode = { "v", "x" },
      },
      { "<leader>rpc", function() require("refactoring").refactor "Clean" end, desc = "Clean", mode = { "v", "x" } },
    },
  },
  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
  },
}

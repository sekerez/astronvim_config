-- local slow_format_filetypes = {}

return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- { "aduros/ai.vim" },
  {
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot" },
    event = { "InsertEnter" },
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
        javascript = { "prettier" },
        yaml = { "yamlfix" },
        json = { "fixjson" },
        zig = { "zigfmt" },
        sql = { "pg_format" },
        go = { "gofmt", "golines" },
        typescript = { "eslint_d" },
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

      format_after_save = { lsp_fallback = true },
      -- log_level = vim.log.levels.DEBUG,
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
      { "<leader>mn", function() require("neotest").run.run() end, desc = "Nearest" },
      { "<leader>mf", function() require("neotest").run.run(vim.fn.expand "%") end, desc = "File" },
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
      { "<leader>dt", ft = "go", function() require("dap-go").debug_test() end, desc = "Test Nearest" },
      { "<leader>dl", ft = "go", function() require("dap-go").debug_last_test() end, desc = "Test Last" },
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
      { "<leader>r", desc = "Refactor", mode = "v" },
      { "<leader>re", desc = "Extract", mode = "v" },
      {
        "<leader>ref",
        function() require("refactoring").refactor "Extract Function" end,
        desc = "Extract Function",
        mode = "v",
      },
      {
        "<leader>rev",
        function() require("refactoring").refactor "Extract Variable" end,
        desc = "Extract Variable",
        mode = "v",
      },
      {
        "<leader>reb",
        function() require("refactoring").refactor "Extract Block" end,
        desc = "Extract Block",
        mode = "v",
      },
      { "<leader>ri", desc = "Inline", mode = "v" },
      {
        "<leader>rif",
        function() require("refactoring").refactor "Inline Function" end,
        desc = "Inline Function",
        mode = "v",
      },
      {
        "<leader>riv",
        function() require("refactoring").refactor "Inline Variable" end,
        desc = "Inline Variable",
        mode = "v",
      },
      {
        "<leader>rib",
        function() require("refactoring").refactor "Inline Block" end,
        desc = "Inline Block",
        mode = "v",
      },
      { "<leader>rp", desc = "Print", mode = "v" },
      {
        "<leader>rpv",
        function() require("refactoring").refactor "Print Variable" end,
        desc = "Print Variable",
        mode = "v",
      },
      { "<leader>rpc", function() require("refactoring").refactor "Clean" end, desc = "Clean", mode = "v" },
    },
  },
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
}

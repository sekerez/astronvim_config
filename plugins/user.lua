vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
  callback = function(args)
    if not (args.data and args.data.client_id) then return end
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.inlayHintProvider then
      local inlayhints = require "lsp-inlayhints"
      inlayhints.on_attach(client, args.buf)
      require("astronvim.utils").set_mappings({
        n = {
          ["<leader>uH"] = { inlayhints.toggle, desc = "Toggle inlay hints" },
        },
      }, { buffer = args.buf })
    end
  end,
})

return {
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
    event = { "BufEnter" },
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
    "lvimuser/lsp-inlayhints.nvim",
    config = function() require("lsp-inlayhints").setup() end,
    opts = {},
  },
  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = {
      -- your options here
    },
  },
}

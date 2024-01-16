-- local slow_format_filetypes = {}

return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- { "aduros/ai.vim" },
  {
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot" },
    event = { "InsertEnter" },
    config = function() require("copilot").setup {} end,
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
        sql = { "sql-formatter" },
      },
      formatters = {
        black = {
          prepend_args = { "--fast" },
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
    "klen/nvim-test",
    -- keys = {
    --   { "<leader>T" },
    -- },
    event = { "BufEnter *test*" },
    config = function() require("nvim-test").setup {} end,
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

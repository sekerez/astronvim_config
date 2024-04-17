local utils = require "astrocore"
local git_prefix = "<leader>g"
-- local gitlinker_prefix = git_prefix .. "y"
-- local neogit_prefix = git_prefix .. "n"
local icon = vim.g.icons_enabled and "󰰔 " or ""
local fold_signs = { require('astroui').get_icon "FoldClosed", require('astroui').get_icon "FoldOpened" }

utils.set_mappings { n = { [git_prefix] = { desc = icon .. "Neogit" } } }

return {
  {
    "sindrets/diffview.nvim",
    event = "User AstroGitFile",
    cmd = { "DiffviewOpen" },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = { winbar_info = true },
        file_history = { winbar_info = true },
      },
      hooks = { diff_buf_read = function(bufnr) vim.b[bufnr].view_activated = false end },
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    event = "User AstroGitFile",
    opts = function(_, opts)
      local disable_builtin_notifications = utils.is_available "nvim-notify" or utils.is_available "noice.nvim"
      opts.integrations = { diffview = true }

      return utils.extend_tbl(opts, {
        disable_builtin_notifications = disable_builtin_notifications,
        telescope_sorter = function()
          if utils.is_available "telescope-fzf-native.nvim" then
            return require("telescope").extensions.fzf.native_fzf_sorter()
          end
        end,
        integrations = { telescope = utils.is_available "telescope.nvim" },
        signs = { section = fold_signs, item = fold_signs },
      })
    end,
    keys = {
      { git_prefix .. "nt", "<cmd>Neogit<CR>", desc = "Open Neogit Tab Page" },
      { git_prefix .. "nc", "<cmd>Neogit commit<CR>", desc = "Open Neogit Commit Page" },
      { git_prefix .. "nd", ":Neogit cwd=", desc = "Open Neogit Override CWD" },
      { git_prefix .. "nk", ":Neogit kind=", desc = "Open Neogit Override Kind" },
    },
  },
  {
    "linrongbin16/gitlinker.nvim",
    event = { "User AstroGitFile" },
    config = function() require("gitlinker").setup { message = false, highlight_duration = 0 } end,
    keys = {
      { git_prefix .. "y", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank" },
      -- { git_prefix .. "yl", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Link" },
      -- { git_prefix .. "yb", "<cmd>GitLink blame<cr>", mode = { "n", "v" }, desc = "Blame" },
      { git_prefix .. "o", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open" },
      -- { git_prefix .. "ol", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Link" },
      -- { git_prefix .. "ob", "<cmd>GitLink! blame<cr>", mode = { "n", "v" }, desc = "Blame" },
    },
  },
  {
    "pwntester/octo.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function() require("octo").setup() end,
  },
}

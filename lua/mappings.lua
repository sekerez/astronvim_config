local qwerty_default = {
  m = { "m" },
  n = { "n" },
  i = { "i" },
  e = { "e" },
  M = { "M" },
  N = { "N" },
  I = { "I" },
  E = { "E" },
  h = { "h" },
  j = { "j" },
  k = { "k" },
  l = { "l" },
  H = { "H" },
  J = { "J" },
  K = { "K" },
  L = { "L" },
}

local colemak_default = {
  m = { "h" },
  n = { "j" },
  i = { "l" },
  e = { "k" },
  M = { "H" },
  N = { "J" },
  I = { "L" },
  E = { "K" },
  h = { "m" },
  j = { "n" },
  k = { "e" },
  l = { "i" },
  H = { "M" },
  J = { "N" },
  K = { "E" },
  L = { "I" },
}

local qwerty_mappings = {
  n = vim.tbl_extend("force", qwerty_default, { ["L"] = { "<Cmd>bnext<cr>" }, ["H"] = { "<Cmd>bprev<cr>" } }),
  v = qwerty_default,
  x = qwerty_default,
}

local colemak_mappings = {
  n = vim.tbl_extend("force", colemak_default, { ["I"] = { "<Cmd>bnext<cr>" }, ["M"] = { "<Cmd>bprev<cr>" } }),
  v = colemak_default,
  x = colemak_default,
}

local mappings = {
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<Leader>v"] = { "<cmd>vsplit<cr>", desc = "Vertical Split" },
    -- ["<c-\\>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
    ["gf"] = { "gF", desc = "Go to file under cursor" },
    ["<F7>"] = { '<Cmd>execute v:count . "ToggleTerm direction=float"<CR>', desc = "Toggle terminal" },
    ["<Leader>yF"] = {
      function()
        local filepath = vim.fn.expand "%"
        vim.fn.setreg("+", filepath)
        vim.notify("Yanked file path: " .. filepath)
      end,
      desc = "Yank file path",
    },
    ["<Leader>uq"] = {
      function() require("astrocore").set_mappings(qwerty_mappings) end,
      desc = "Use qwerty mappings",
    },
    ["<Leader>uk"] = {
      function() require("astrocore").set_mappings(colemak_mappings) end,
      desc = "Use colemak mappings",
    },
  },
  t = {
    ["<Esc>"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
  },
}

local startup_mappings
if os.getenv "COLEMAK" == "true" then
  startup_mappings = colemak_mappings
else
  startup_mappings = qwerty_mappings
end

mappings = vim.tbl_deep_extend("force", mappings, startup_mappings)

return { default_mappings = mappings }

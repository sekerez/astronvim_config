-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
local mappings = {
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["L"] = { "<cmd>bnext<cr>" },
    ["H"] = { "<cmd>bprev<cr>" },
    ["<leader>v"] = { "<cmd>vsplit<cr>", desc = "Vertical Split" },
    ["<c-\\>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
    ["gf"] = { "gF", desc = "Go to file under cursor" },
  },
  t = {
    ["<esc>"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
  },
}

if os.getenv "COLEMAK" == "true" then
  mappings["n"]["m"] = { "h" }
  mappings["n"]["n"] = { "j" }
  mappings["n"]["e"] = { "k" }
  mappings["n"]["i"] = { "l" }
  mappings["n"]["N"] = { "J" }
  mappings["n"]["E"] = { "K" }
  mappings["n"]["h"] = { "m" }
  mappings["n"]["j"] = { "n" }
  mappings["n"]["k"] = { "e" }
  mappings["n"]["l"] = { "i" }
  mappings["n"]["J"] = { "N" }
  mappings["n"]["K"] = { "E" } -- So K is "end"
  mappings["n"]["L"] = { "I" }
  mappings["n"]["I"] = { "<cmd>bnext<cr>" }
  mappings["n"]["M"] = { "<cmd>bprev<cr>" }
  mappings["v"] = {
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
  mappings["x"] = {
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
end

return mappings

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
    ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bc"] = {
      "<cmd>BufferLinePickClose<cr>",
      desc = "Pick to close"
    },
    ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
    ["<leader>bt"] = {
      "<cmd>BufferLineSortByTabs<cr>",
      desc = "Sort by tabs"
    },
    ["<C-\\>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" }
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  t = {
    ["<esc>"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
    ["<C-\\>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" }
  }
}

if os.getenv("COLEMAK") == "true" then
  mappings["n"]["I"] = { "<cmd>bnext<cr>" }
  mappings["n"]["M"] = { "<cmd>bprev<cr>" }
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
  mappings["v"]["m"] = { "h" }
  mappings["v"]["n"] = { "j" }
  mappings["v"]["i"] = { "l" }
  mappings["v"]["e"] = { "k" }
  mappings["v"]["M"] = { "H" }
  mappings["v"]["N"] = { "J" }
  mappings["v"]["I"] = { "L" }
  mappings["v"]["E"] = { "K" }
  mappings["v"]["h"] = { "m" }
  mappings["v"]["j"] = { "n" }
  mappings["v"]["k"] = { "e" }
  mappings["v"]["l"] = { "i" }
  mappings["v"]["H"] = { "M" }
  mappings["v"]["J"] = { "N" }
  mappings["v"]["K"] = { "E" }
  mappings["v"]["L"] = { "I" }
  mappings["x"]["m"] = { "h" }
  mappings["x"]["n"] = { "j" }
  mappings["x"]["i"] = { "l" }
  mappings["x"]["e"] = { "k" }
  mappings["x"]["M"] = { "H" }
  mappings["x"]["N"] = { "J" }
  mappings["x"]["I"] = { "L" }
  mappings["x"]["E"] = { "K" }
  mappings["x"]["h"] = { "m" }
  mappings["x"]["j"] = { "n" }
  mappings["x"]["k"] = { "e" }
  mappings["x"]["l"] = { "i" }
  mappings["x"]["H"] = { "M" }
  mappings["x"]["J"] = { "N" }
  mappings["x"]["K"] = { "E" }
  mappings["x"]["L"] = { "I" }
end


return mappings

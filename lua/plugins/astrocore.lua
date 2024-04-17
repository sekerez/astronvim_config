-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

local mappings = {
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["L"] = { "<Cmd>bnext<cr>" },
    ["H"] = { "<Cmd>bprev<cr>" },
    ["<Leader>v"] = { "<cmd>vsplit<cr>", desc = "Vertical Split" },
    -- ["<c-\\>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
    ["gf"] = { "gF", desc = "Go to file under cursor" },
  },
  t = {
    ["<Esc>"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
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

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = false, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = mappings,
  },
}

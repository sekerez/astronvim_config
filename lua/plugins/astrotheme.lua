-- local greenish = "#A7F6A7"
local pitch_black = "#000000"
local dark_grey = "#6b6b6b"
local green = "#39DD14"
local white = "#D3D3D3"
local red = "#FF0000"

return {
  "AstroNvim/astrotheme",
  opts = {
    palette = "astrodark",
    style = {
      -- inactive = false,
      -- transparent = false,
      -- float = false,
    },
    terminal_color = false,
    palettes = {
      astrodark = {
        term = {
          background = pitch_black,
          black = pitch_black,
          bright_black = dark_grey,
          blue = "#2196F3",
          cyan = "#00FFFF",
          green = green,
          purple = "#963DFF",
          red = red,
          white = white,
          yellow = "#FFFF55",
        },
        ui = {
          base = pitch_black,
          black = pitch_black,
          white = white,
          blue = "#2196F3",
          cyan = "#00FFFF",
          green = green,
          purple = "#963DFF",
          red = red,
          yellow = "#FFFF55",
          title = green,
          accent = green,
          text = white,
          -- tool = dark_grey,
          -- tabline = "#FF0000",
          -- text_inactive = "#FFFF00",
          --           text = greenish,
          --           accent = greenish,
          --           green = greenish,
          --           -- blue = greenish,
          --           current_line = "#000000",
        },
        -- syntax = {
        --   base = "#000000",
        --   black = "#000000",
        --   white = "#FFFFFF",
        --   blue = "#2196F3",
        --   cyan = "#00FFFF",
        --   green = green,
        --   purple = "#963DFF",
        --   red = "#FF0000",
        --   yellow = "#FFFF55",
        --   --           text = greenish,
        --   --           accent = greenish,
        --   --           green = greenish,
        --   --           -- blue = greenish,
        --   --           current_line = "#000000",
        -- },
        --         syntax = {
        --           green = greenish,
        --           -- blue = greenish,
        --         },
      },
      --       -- c.ui.blue = "#50A4E9""#50A4E9"
    },
    highlights = {
      astrodark = {
        modify_hl_groups = function(hl, c)
          hl.CmpItemKindCopilot = { fg = c.ui.green }

          -- term stuff
          hl.Normal = { bg = c.ui.base }
          hl.NormalNC = { bg = c.ui.base }
          hl.FloatTitle = { fg = c.ui.green, bg = c.ui.base }
          hl.FloatBorder = { fg = c.ui.border, bg = c.ui.base }
          hl.NormalFloat = { bg = c.ui.base }

          -- dashboard stuff
          hl.DashboardHeader = { fg = c.ui.green }
          hl.DashboardCenter = { fg = c.ui.green }
          hl.DashboardFooter = { fg = c.ui.green }
          hl.DashboardShortcut = { fg = c.ui.text }

          -- telescope
          hl.TelescopePromptTitle = { fg = c.ui.green, bg = c.ui.base }
          hl.TelescopeResultsNormal = { fg = c.ui.text, bg = c.ui.base }

          -- notifications
          hl.NotifyERRORBorder = { fg = C.ui.red, bg = c.none }
          hl.NotifyWARNBorder = { fg = C.ui.orange, bg = c.none }
          hl.NotifyINFOBorder = { fg = C.ui.green, bg = c.none }
          hl.NotifyDEBUGBorder = { fg = C.ui.cyan, bg = c.none }
          hl.NotifyTRACERBorder = { fg = C.ui.purple, bg = c.none }

          hl.NotifyERRORIcon = { fg = C.ui.red, bg = c.none }
          hl.NotifyWARNIcon = { fg = C.ui.orange, bg = c.none }
          hl.NotifyINFOIcon = { fg = C.ui.green, bg = c.none }
          hl.NotifyDEBUGIcon = { fg = C.ui.cyan, bg = c.none }
          hl.NotifyTRACEIcon = { fg = C.ui.purple, bg = c.none }

          hl.NotifyERRORTitle = { fg = C.ui.red, bg = c.none }
          hl.NotifyWARNTitle = { fg = C.ui.orange, bg = c.none }
          hl.NotifyINFOTitle = { fg = C.ui.green, bg = c.none }
          hl.NotifyDEBUGTitle = { fg = C.ui.cyan, bg = c.none }
          hl.NotifyTRACETitle = { fg = C.ui.purple, bg = c.none }

          hl.NotifyERRORBody = { fg = C.ui.text, bg = c.none }
          hl.NotifyWARNBody = { fg = C.ui.text, bg = c.none }
          hl.NotifyINFOBody = { fg = C.ui.text, bg = c.none }
          hl.NotifyDEBUGBody = { fg = C.ui.text, bg = c.none }
          hl.NotifyTRACEBody = { fg = C.ui.text, bg = c.none }

          hl.NotifyLogTime = { fg = C.ui.text_inactive, bg = c.none }
          hl.NotifyLogTitle = { fg = C.ui.blue, bg = c.none }
          --         --   hl.StatusNormal.bg = c.ui.green
          --         --   -- hl.Label.fg = c.syntax.green
          --         --   -- hl.Function.fg = c.syntax.green
          --         --   -- hl.Type.fg = c.syntax.green
          --         --   -- hl.Special.fg = c.syntax.green
          --         --   -- hl.PreCondit.fg = c.syntax.green
          --         --   -- hl.StorageClass.fg = c.syntax.green
          --         --   -- hl.Type.fg = c.syntax.green
          --         --   -- hl.Special.fg = c.syntax.green
          --         --   hl.DashboardCenter.fg = c.syntax.green
          --         --   hl.DashboardShortcut.fg = c.syntax.green
          --         --   hl.DashboardFooter.fg = c.syntax.green
          --         --
          --         --   hl.TelescopePromptTitle.fg = c.syntax.green
          --         --   hl.TelescopeResultsTitle.fg = c.syntax.green
          --         --   hl.TelescopePreviewTitle.fg = c.syntax.green
          --         --   hl.TelescopeMultiSelection.fg = c.syntax.green
          --         --   hl.TelescopeMultiIcon.fg = c.syntax.green
        end,
      },
    },
  },
}
-- ---@class AstroThemePalette
-- local c = {
--   none = "NONE",
--   syntax = {},
--   ui = {},
--   term = {},
-- }
--
-- --------------------------------
-- --- Syntax
-- --------------------------------
-- c.syntax.red = "#FF838B"
-- c.syntax.orange = "#F5983A"
-- c.syntax.yellow = "#DFAB25"
-- c.syntax.green = "#87C05F"
-- c.syntax.cyan = "#4AC2B8"
-- c.syntax.blue = "#5EB7FF"
-- c.syntax.purple = "#DD97F1"
-- c.syntax.text = "#ADB0BB"
-- c.syntax.comment = "#696C76"
-- c.syntax.mute = "#595C66"
--
-- --------------------------------
-- --- UI
-- --------------------------------
-- c.ui.red = "#F8747E"
-- c.ui.orange = "#EB8332"
-- c.ui.yellow = "#D09214"
-- c.ui.green = "#75AD47"
-- c.ui.cyan = "#00B298"
-- c.ui.blue = "#50A4E9"
-- c.ui.purple = "#CC83E3"
--
-- c.ui.accent = "#50A4E9"
--
-- c.ui.tabline = "#111317"
-- c.ui.winbar = "#797D87"
-- c.ui.tool = "#16181D"
-- c.ui.base = "#1A1D23"
-- c.ui.inactive_base = "#16181D"
-- c.ui.statusline = "#111317"
-- c.ui.split = "#111317"
-- c.ui.float = "#14161B"
-- c.ui.title = c.ui.accent
-- c.ui.border = "#3A3E47"
-- c.ui.current_line = "#1E222A"
-- c.ui.scrollbar = c.ui.accent
-- c.ui.selection = "#26343F"
-- -- TODO: combine menu_selection and selection
-- c.ui.menu_selection = c.ui.selection
-- c.ui.highlight = "#23272F"
-- c.ui.none_text = "#3A3E47"
-- c.ui.text = "#9B9FA9"
-- c.ui.text_active = "#ADB0BB"
-- c.ui.text_inactive = "#494D56"
-- c.ui.text_match = "#E0E0Ee"
--
-- c.ui.prompt = "#21242A"
--
-- --------------------------------
-- --- terminal
-- --------------------------------
-- c.term.black = c.ui.tabline
-- c.term.bright_black = c.ui.tabline
--
-- c.term.red = c.syntax.red
-- c.term.bright_red = c.syntax.red
--
-- c.term.green = c.syntax.green
-- c.term.bright_green = c.syntax.green
--
-- c.term.yellow = c.syntax.yellow
-- c.term.bright_yellow = c.syntax.yellow
--
-- c.term.blue = c.syntax.blue
-- c.term.bright_blue = c.syntax.blue
--
-- c.term.purple = c.syntax.purple
-- c.term.bright_purple = c.syntax.purple
--
-- c.term.cyan = c.syntax.cyan
-- c.term.bright_cyan = c.syntax.cyan
--
-- c.term.white = c.ui.text
-- c.term.bright_white = c.ui.text_active
--
-- c.term.background = c.ui.base
-- c.term.foreground = c.ui.text
--
-- --------------------------------
-- --- Icons
-- --------------------------------
-- c.icon = {
--   c = "#519aba",
--   css = "#61afef",
--   deb = "#a1b7ee",
--   docker = "#384d54",
--   html = "#de8c92",
--   jpeg = "#c882e7",
--   jpg = "#c882e7",
--   js = "#ebcb8b",
--   jsx = "#519ab8",
--   kt = "#7bc99c",
--   lock = "#c4c720",
--   lua = "#51a0cf",
--   mp3 = "#d39ede",
--   mp4 = "#9ea3de",
--   out = "#abb2bf",
--   png = "#c882e7",
--   py = "#a3b8ef",
--   rb = "#ff75a0",
--   robots = "#abb2bf",
--   rpm = "#fca2aa",
--   rs = "#dea584",
--   toml = "#39bf39",
--   ts = "#519aba",
--   ttf = "#abb2bf",
--   vue = "#7bc99c",
--   woff = "#abb2bf",
--   woff2 = "#abb2bf",
--   zip = "#f9d71c",
--   md = "#519aba",
--   pkg = "#d39ede",
-- }
--
-- return c

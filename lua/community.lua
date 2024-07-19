-- if true then return {} end
-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.rust" },
  -- { import = "astrocommunity.pack.lua" },
  -- { import = "astrocommunity.pack.sql" },
  -- import/override with your plugins folder
}

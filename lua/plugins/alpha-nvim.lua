return {
  "goolord/alpha-nvim",
  opts = function(_, dashboard)
    -- customize the dashboard header
    dashboard.section.header.val = { "" }
    -- local find_by = function(txt)
    --   for _, elem in dashboard.section.buttons.val do
    --     if string.find(elem.val, txt) then return elem end
    --   end
    -- end
    local button, get_icon = dashboard.button, require("astroui").get_icon
    dashboard.section.buttons.val = {
      button("LDR f f", get_icon("Search", 2, true) .. "Find File  "),
      button("LDR f w", get_icon("WordFile", 2, true) .. "Find Word  "),
      button("LDR f o", get_icon("DefaultFile", 2, true) .. "Recents  "),
      button("LDR n  ", get_icon("FileNew", 2, true) .. "New File  "),
      button("LDR f '", get_icon("Bookmarks", 2, true) .. "Bookmarks  "),
      button("LDR S l", get_icon("Refresh", 2, true) .. "Last Session  "),
    }
    return dashboard
  end,
}

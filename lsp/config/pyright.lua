-- Prologue - Python stuff
local function get_python_path(workspace)
  local function path_join(...)
    local args = { ... }
    return table.concat(args, "/")
  end
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then return path_join(vim.env.VIRTUAL_ENV, "bin", "python") end

  -- Find and use virtualenv via poetry in workspace directory.
  local match = vim.fn.glob(path_join(workspace, "poetry.lock"))
  if match ~= "" then
    local venv = vim.fn.trim(vim.fn.system "poetry env info -p")
    return path_join(venv, "bin", "python")
  end

  -- Fallback to system Python.
  return vim.fn.exepath "python3" or vim.fn.exepath "python" or "python"
end

return {
  on_init = function(client)
    client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
    client.config.settings.python.analysis.typeCheckingMode = "off"
    client.config.settings.python.analysis.diagnosticMode = "openFilesOnly"
  end,
  -- python = {
  --   analysis = {
  --     typeCheckingMode = "off",
  --     useLibraryCodeForTypes = false,
  --   },
  -- },
}

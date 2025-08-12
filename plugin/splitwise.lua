if pcall(require, "splitwise") then
  -- Lazy users can rely on default setup via this entrypoint,
  -- but we avoid auto-setup to let users configure first.
  -- To enable out-of-the-box behavior, uncomment the following:
  require("splitwise").setup({})
end

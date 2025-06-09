local config = require("saturate.config")

local M = {}

--- Setup the nvim-saturate plugin with user options.
---@param opts saturate.Opts? (optional) User settings.
function M.setup(opts)
  config.opts = vim.tbl_deep_extend("force", config.opts, opts or {})
  require("saturate._usercommands").setup()
  require("saturate.commands").apply()
end

return M

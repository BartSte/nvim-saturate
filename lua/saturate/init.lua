local M = require("saturate._boosters")
local opts = require("saturate.opts")
local usercommands = require("saturate._usercommands")

--- Setup the nvim-saturate plugin with user options.
---@param user_opts saturate.Opts? (optional) User settings.
function M.setup(user_opts)
  user_opts = user_opts or {}
  opts.update(user_opts)
  usercommands.setup()
end

return M

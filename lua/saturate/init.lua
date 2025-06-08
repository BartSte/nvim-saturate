local M = require("saturate._boosters")
local opts = require("saturate.opts")

function M.setup(user_opts)
  opts.update(user_opts)
end

return M

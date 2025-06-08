--- Module for managing saturate.nvim options.
local M = {}

---@class saturate.Opts
---@field saturation number
---@field light_delta number
M.default = {
  saturation = 1,
  light_delta = 0.08
}

---@type saturate.Opts
local opts = M.default

--- Get the current options.
---@return table The options table.
function M.get()
  return opts
end

--- Update the options with new values.
---@param new saturate.Opts A table of new options to merge.
function M.update(new)
  opts = vim.tbl_deep_extend("force", opts, new)
end

return M

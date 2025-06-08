--- Module for managing saturate.nvim options.
local M = {}

---@class saturate.Palette: table<string, string>

---@class saturate.Opts
---@field saturation number The initial saturation value.
---@field saturation_step number The step value for increasing the saturation.
---@field light_delta number The initial light delta value.
---@field light_delta_step number The step value for increasing the light delta.
---@field palette saturate.Palette The color palette to adjust.
---@field after function(saturate.Palette) A function to execute after adjusting the palette.
M.default = {
  saturation = 1,
  saturation_step = 0.2,
  light_delta = 0.08,
  light_delta_step = 0.02,
  palette = {},
  after = function(palette) end
}

---@type saturate.Opts
local opts = vim.deepcopy(M.default)

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

local M = {}

---@class saturate.Opts
---@field after function?(saturate.Palette) A function to execute after adjusting the palette.
---@field light_delta number? The initial light delta value.
---@field light_delta_step number? The step value for increasing the light delta.
---@field log_level number? The log level for notifications (default: vim.log.levels.INFO).
---@field palette saturate.Palette? The color palette to adjust.
---@field saturation number? The initial saturation value.
---@field saturation_step number? The step value for increasing the saturation.
M.opts = {
  after = function(palette) end,
  light_delta = 0.08,
  light_delta_step = 0.02,
  log_level = vim.log.levels.INFO,
  ---@class saturate.Palette: table<string, string>
  palette = {},
  saturation = 1,
  saturation_step = 0.2,
}

--- Setup the nvim-saturate plugin with user options.
---@param opts saturate.Opts? (optional) User settings.
function M.setup(opts)
  M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})
  require("saturate.commands").setup(M.opts)
  require("saturate._usercommands").setup()
end

return M

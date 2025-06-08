local M = {}
local boosters = require("saturate._boosters")
local opts = require("saturate.opts")

-- Increases the saturation of the palette by a given step size.
---@param palette saturate.Palette? Palette to saturate.
---@param step number? Step size to increment saturation by.
---@return saturate.Palette Palette with increased saturation.
function M.increment_saturation(palette, step)
  ---@type saturate.Opts
  local user_opts = opts.get()
  palette = palette or user_opts.palette
  step = step or user_opts.saturation_step
  user_opts.saturation = user_opts.saturation + step
  palette = boosters.palette(palette, user_opts.saturation, user_opts.light_delta)
  user_opts.after(palette)
  return palette
end

function M.decrement_saturation(palette, step)
  return M.increment_saturation(palette, -step)
end

function M.increment_light_delta(palette, step)
  local user_opts = opts.get()
  palette = palette or user_opts.palette
  step = step or user_opts.light_delta_step
  user_opts.light_delta = user_opts.light_delta + step
  palette = boosters.palette(palette, user_opts.saturation, user_opts.light_delta)
  user_opts.after(palette)
  return palette
end

function M.decrement_light_delta(palette, step)
  return M.increment_light_delta(palette, -step)
end

return M

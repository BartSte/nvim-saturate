local M = {}
local boosters = require("saturate._boosters")
local config = require("saturate.config")

-- Unique notification IDs for each setting
local NOTIFY_ID = 1000

---@type saturate.Opts
local state = {}

--- Applies the boosters to the current theme and notifies the user of the changes.
---@param opts saturate.Opts? Options for boosting the theme.
function M.apply(opts)
  state = vim.tbl_deep_extend("force", state, opts or {})
  state = vim.tbl_deep_extend("force", config.opts, state)
  local palette = boosters.palette(state.palette, state.saturation, state.light_delta)
  state.after(palette)
  M.notify()
end

--- Notifies the user of the current saturation and light_delta.
function M.notify()
  vim.notify(string.format("Saturation: %.2f\nLight delta: %.2f", state.saturation, state.light_delta),
    vim.log.levels.INFO, { id = NOTIFY_ID, replace = true }
  )
end

--- Increments the saturation by the given step (or the default step if not provided).
---@param step? number The amount to add to the current saturation (can be negative). If not provided, uses state.saturation_step.
---@param palette? saturate.Palette The palette to use. If not provided, uses the current palette.
function M.increment_saturation(step, palette)
  step = step or state.saturation_step or config.opts.saturation_step
  return M.apply({
    palette = palette or state.palette,
    saturation = state.saturation + step
  })
end

--- Decrements the saturation by the given step (or the default step if not provided).
---@param step? number The amount to subtract from the current saturation (can be negative). If not provided, uses state.saturation_step.
---@param palette? saturate.Palette The palette to use. If not provided, uses the current palette.
function M.decrement_saturation(step, palette)
  step = step or state.saturation_step or config.opts.saturation_step
  return M.increment_saturation(-step, palette)
end

--- Increments the light_delta by the given step (or the default step if not provided).
---@param step? number The amount to add to the current light_delta (can be negative). If not provided, uses state.light_delta_step.
---@param palette? saturate.Palette The palette to use. If not provided, uses the current palette.
function M.increment_light_delta(step, palette)
  step = step or state.light_delta_step or config.opts.light_delta_step
  return M.apply({
    palette = palette or state.palette,
    light_delta = state.light_delta + step
  })
end

--- Decrements the light_delta by the given step (or the default step if not provided).
---@param step? number The amount to subtract from the current light_delta (can be negative). If not provided, uses state.light_delta_step.
---@param palette? saturate.Palette The palette to use. If not provided, uses the current palette.
function M.decrement_light_delta(step, palette)
  step = step or state.light_delta_step or config.opts.light_delta_step
  return M.increment_light_delta(-step, palette)
end

return M

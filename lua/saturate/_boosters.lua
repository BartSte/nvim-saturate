local M = {}
local conv = require("saturate._convertors")

--- Boost the saturation and adjust the lightness of a hex color.
---@param hex string The input hex color string (e.g. "#RRGGBB").
---@param sat_multiplier number? (optional) Saturation multiplier (default = 1.5).
---@param light_delta number? (optional) Lightness delta (default = 0.08).
---@return string The adjusted hex color string.
function M.hex(hex, sat_multiplier, light_delta)
  local s_mult  = sat_multiplier or 1.5
  local l_delta = light_delta or 0.08

  local r, g, b = conv.hex_to_rgb(hex)
  local h, s, l = conv.rgb_to_hsl(r, g, b)

  local s2      = math.min(s * s_mult, 1.0)

  local l2
  if l < 0.5 then
    l2 = math.max(0, l - l_delta)
  else
    l2 = math.min(1, l + l_delta)
  end

  local r2, g2, b2 = conv.hsl_to_rgb(h, s2, l2)
  return M.rgb_to_hex(r2, g2, b2)
end

--- Boost the saturation and adjust the lightness of a palette of hex colors.
---@param palette table<string, string> A mapping of keys to hex color strings.
---@param sat_multiplier number? Optional saturation multiplier (default = 1.5).
---@param light_delta number? Optional lightness delta (default = 0.08).
---@return table<string, string> The adjusted palette with new hex color strings.
function M.palette(palette, sat_multiplier, light_delta)
  local result = {}
  for key, hex in pairs(palette) do
    result[key] = M.hex(hex, sat_multiplier, light_delta)
  end
  return result
end

return M

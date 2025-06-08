local M = {}
local conv = require("saturate._convertors")

--- Boost saturation and adjust lightness of a hex color
---@param hex string: The input hex color string (e.g. "#RRGGBB")
---@param saturation_multiplier number: Multiplier for saturation (1.0 = no change)
---@param light_delta number: Lightness adjustment (-1.0 to 1.0)
---@return string: The modified hex color string
function M.hex(hex, saturation_multiplier, light_delta)
  local r, g, b = conv.hex_to_rgb(hex)
  local h, s, l = conv.rgb_to_hsl(r, g, b)

  local s2      = math.min(s * saturation_multiplier, 1.0)

  local l2
  if l < 0.5 then
    l2 = math.max(0, l - light_delta)
  else
    l2 = math.min(1, l + light_delta)
  end

  local r2, g2, b2 = conv.hsl_to_rgb(h, s2, l2)
  return conv.rgb_to_hex(r2, g2, b2)
end

--- Apply saturation boost and lightness adjustment to a color palette
---@param palette table: Table of color names to hex strings
---@param saturation_multiplier number: Multiplier for saturation (1.0 = no change)
---@param light_delta number: Lightness adjustment (-1.0 to 1.0)
---@return table: New table with modified colors
function M.palette(palette, saturation_multiplier, light_delta)
  local result = {}
  for key, hex in pairs(palette) do
    result[key] = M.hex(hex, saturation_multiplier, light_delta)
  end
  return result
end

return M

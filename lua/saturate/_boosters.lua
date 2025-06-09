local M = {}
local conv = require("saturate._convertors")

--- Adjust saturation by multiplying and clamping to [0,1]
---@param saturation number
---@param multiplier number
---@return number
local function adjust_saturation(saturation, multiplier)
  return math.min(saturation * multiplier, 1.0)
end

--- Adjust lightness by adding/subtracting delta based on current lightness, then clamping to [0,1]
---@param lightness number
---@param delta number
---@return number
local function adjust_lightness(lightness, delta)
  if lightness < 0.5 then
    return math.max(0, lightness - delta)
  else
    return math.min(1, lightness + delta)
  end
end

--- Boost saturation and adjust lightness of a hex color
---@param hex string: The input hex color string (e.g. "#RRGGBB")
---@param saturation_multiplier number: Multiplier for saturation (1.0 = no change)
---@param light_delta number: Lightness adjustment (-1.0 to 1.0)
---@return string: The modified hex color string
function M.hex(hex, saturation_multiplier, light_delta)
  local r, g, b = conv.hex_to_rgb(hex)
  local hue, saturation, lightness = conv.rgb_to_hsl(r, g, b)

  local saturation_adjusted = adjust_saturation(saturation, saturation_multiplier)
  local lightness_adjusted = adjust_lightness(lightness, light_delta)

  local r2, g2, b2 = conv.hsl_to_rgb(hue, saturation_adjusted, lightness_adjusted)
  return conv.rgb_to_hex(r2, g2, b2)
end

--- Apply saturation boost and lightness adjustment to a color palette
---@param palette table<string, string> Table of color names to hex strings
---@param saturation_multiplier number Multiplier for saturation (1.0 = no change)
---@param light_delta number Lightness adjustment (-1.0 to 1.0)
---@return table<string, string> New table with modified colors
function M.palette(palette, saturation_multiplier, light_delta)
  local result = {}
  for key, hex in pairs(palette) do
    result[key] = M.hex(hex, saturation_multiplier, light_delta)
  end
  return result
end

return M

local M = {}
local commands = require("saturate.commands")

local create_saturate_command = function()
  --- Accepts 0, 1, or 2 arguments: saturation, and light_delta, respectively
  vim.api.nvim_create_user_command('Saturate', function(opts)
    local saturation
    if #opts.fargs > 0 then
      saturation = tonumber(opts.fargs[1])
    end

    local light_delta
    if #opts.fargs > 1 then
      light_delta = tonumber(opts.fargs[2])
    end

    if saturation then
      if not saturation then
        vim.notify("Invalid saturation: must be a number", vim.log.levels.ERROR)
        return
      end
    end
    if light_delta then
      if not light_delta then
        vim.notify("Invalid light delta: must be a number", vim.log.levels.ERROR)
        return
      end
    end
    commands.apply({
      saturation = saturation,
      light_delta = light_delta
    })
  end, { nargs = "*", desc = "Set saturation and light delta (or use the default if not provided)" })
end

--- Helper function to create a step-based command
---@param command_function fun(step: number|nil) The command function to call with the step
---@return function The function that handles the user command
local function create_step_command(command_function)
  return function(opts)
    local step = nil
    if opts.args ~= "" then
      step = tonumber(opts.args)
      if not step then
        vim.notify("Invalid step: must be a number", vim.log.levels.ERROR)
        return
      end
    end
    command_function(step)
  end
end

--- Create user commands for saturate.nvim
function M.setup()
  -- Step-based commands using helper function
  create_saturate_command()
  vim.api.nvim_create_user_command('IncrementSaturation', create_step_command(commands.increment_saturation),
    { nargs = '?', desc = "Increment saturation by step (or default step if not provided)" })
  vim.api.nvim_create_user_command('DecrementSaturation', create_step_command(commands.decrement_saturation),
    { nargs = '?', desc = "Decrement saturation by step (or default step if not provided)" })
  vim.api.nvim_create_user_command('IncrementLightDelta', create_step_command(commands.increment_light_delta),
    { nargs = '?', desc = "Increment light delta by step (or default step if not provided)" })
  vim.api.nvim_create_user_command('DecrementLightDelta', create_step_command(commands.decrement_light_delta),
    { nargs = '?', desc = "Decrement light delta by step (or default step if not provided)" })
end

return M

local M = {}
local commands = require("saturate.commands")

--- Create user commands for saturate.nvim
function M.setup()
  --- Accepts 0, 1, or 2 arguments: saturation, and light_delta, respectively
  vim.api.nvim_create_user_command('Saturate', function(opts)
    local saturation, light_delta = opts.fargs[1], opts.fargs[2]
    if saturation then
      saturation = tonumber(saturation)
      if not saturation then
        vim.notify("Invalid saturation: must be a number", vim.log.levels.ERROR)
        return
      end
    end
    if light_delta then
      light_delta = tonumber(light_delta)
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

  -- IncrementSaturation command
  vim.api.nvim_create_user_command('IncrementSaturation', function(opts)
    local step = nil
    if opts.args ~= "" then
      step = tonumber(opts.args)
      if not step then
        vim.notify("Invalid step: must be a number", vim.log.levels.ERROR)
        return
      end
    end
    commands.increment_saturation(step)
  end, { nargs = '?', desc = "Increment saturation by step (or default step if not provided)" })

  -- DecrementSaturation command
  vim.api.nvim_create_user_command('DecrementSaturation', function(opts)
    local step = nil
    if opts.args ~= "" then
      step = tonumber(opts.args)
      if not step then
        vim.notify("Invalid step: must be a number", vim.log.levels.ERROR)
        return
      end
    end
    commands.decrement_saturation(step)
  end, { nargs = '?', desc = "Decrement saturation by step (or default step if not provided)" })

  -- IncrementLightDelta command
  vim.api.nvim_create_user_command('IncrementLightDelta', function(opts)
    local step = nil
    if opts.args ~= "" then
      step = tonumber(opts.args)
      if not step then
        vim.notify("Invalid step: must be a number", vim.log.levels.ERROR)
        return
      end
    end
    commands.increment_light_delta(step)
  end, { nargs = '?', desc = "Increment light delta by step (or default step if not provided)" })

  -- DecrementLightDelta command
  vim.api.nvim_create_user_command('DecrementLightDelta', function(opts)
    local step = nil
    if opts.args ~= "" then
      step = tonumber(opts.args)
      if not step then
        vim.notify("Invalid step: must be a number", vim.log.levels.ERROR)
        return
      end
    end
    commands.decrement_light_delta(step)
  end, { nargs = '?', desc = "Decrement light delta by step (or default step if not provided)" })
end

return M

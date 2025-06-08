local M = {}
local commands = require("saturate.commands")

--- Create user commands for saturate.nvim
function M.setup()
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

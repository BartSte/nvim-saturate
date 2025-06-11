--- Sends a notification if its level is <= configured log_level.
---@param msg string The message to notify.
---@param level number The log level (e.g., vim.log.levels.INFO).
---@param opts table? Options to pass to vim.notify.
return function(msg, level, opts)
  if level <= require("saturate.config").opts.log_level then
    vim.notify(msg, level, opts)
  end
end


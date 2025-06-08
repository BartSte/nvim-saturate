local M = {}

M.default = {
  saturation = 1,
  light_delta = 0.08
}

local opts = M.default

function M.get()
  return opts
end

function M.update(new)
  M.opts = vim.tbl_deep_extend("force", M.opts, new)
end

return M

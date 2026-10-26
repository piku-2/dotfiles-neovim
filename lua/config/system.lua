local M = {}

-- pacman のバイナリを Mason の同名ツールより先に使う
function M.bin(name)
  local path = "/usr/bin/" .. name
  if vim.fn.executable(path) == 1 then
    return path
  end
  return name
end

return M

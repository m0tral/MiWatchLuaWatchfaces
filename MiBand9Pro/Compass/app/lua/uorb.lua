local M = {}

function M.open(path)
    return io.open(path, "rb")
end

function M.read(fd, size)
    if not fd then return nil end
    local data = fd:read("*a")
    if not data or #data < size then return nil end
    return data:sub(1, size)
end

return M
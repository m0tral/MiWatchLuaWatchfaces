local watchVersion = {
    version = nil,
    model = nil
}

local tmpLogFile = '/data/tmp_B981D51C.log'

local function starts_with(str, prefix)
    return string.sub(str, 1, #prefix) == prefix
end

function watchVersion.get_model()

    if watchVersion.model then
        return watchVersion.model
    end

    local cmd = "getprop product.model"

    os.execute(cmd .. " > " .. tmpLogFile)

    local result = ''
    for f in io.lines(tmpLogFile) do
        result = result .. f
    end

    if result == nil or result == "" then
        result = "unknown"
    end

    watchVersion.model = result
    return result
end

function watchVersion.get_version()

    if watchVersion.version then
        return watchVersion.version
    end

    local cmd = "getprop ro.build.version"

    os.execute(cmd .. " > " .. tmpLogFile)

    local result = ''
    for f in io.lines(tmpLogFile) do
        result = result .. f
    end

    watchVersion.version = result
    return result
end

function watchVersion.is_chinese()

    local version = watchVersion.get_version()

	return starts_with(version, '1.')
end

return watchVersion
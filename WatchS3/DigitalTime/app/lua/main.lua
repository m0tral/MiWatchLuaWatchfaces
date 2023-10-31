local lvgl = require("lvgl")

local globalWidth = lvgl.HOR_RES()
local globalHeight = lvgl.VER_RES()

local IMAGE_PATH = SCRIPT_PATH
if not IMAGE_PATH then
    IMAGE_PATH = "/"
    print("Note image root path is set to: ", IMAGE_PATH)
end

print("IMAGE_PATH:", IMAGE_PATH)

local function createBack()
    local property = {
        w = globalWidth,
        h = globalHeight,
        bg_color = 0,
        bg_opa = lvgl.OPA(100),
        border_width = 0,
        pad_all = 0
    }

    scr = lvgl.Object(nil, property)
    scr:clear_flag(lvgl.FLAG.SCROLLABLE)
    return scr
end

local function entry()
    local bak = createBack()

end

entry()

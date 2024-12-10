local lvgl = require("lvgl")

local globalWidth = lvgl.HOR_RES()
local globalHeight = lvgl.VER_RES()

function createRoot()
    local property = {
        w = globalWidth,
        h = globalHeight,
        bg_color = 0,
        bg_opa = lvgl.OPA(100),
        border_width = 0,
        pad_all = 0
    }

    local scr = lvgl.Object(nil, property)
    scr:add_flag(lvgl.FLAG.SCROLLABLE)
	scr:clear_flag(lvgl.FLAG.EVENT_BUBLE)
    scr:clear_flag(lvgl.FLAG.GESTURE_BUBBLE)

    local root = lvgl.Object(scr, {
        outline_width = 0,
        border_width = 0,
        pad_all = 0,
        bg_opa = 0,
        bg_color = 0,
        align = lvgl.ALIGN.CENTER,
        w = 390,
        h = 450
    })

    root:add_flag(lvgl.FLAG.SCROLLABLE)
    --root:add_flag(lvgl.FLAG.EVENT_BUBBLE)

    return root
end

-- return {
--     createRoot = createRoot
-- }
local lvgl = require("lvgl")

local IMAGE_PATH = SCRIPT_PATH
if not IMAGE_PATH then
    IMAGE_PATH = "/"
    print("Note image root path is set to: ", IMAGE_PATH)
end

print("IMAGE_PATH:", IMAGE_PATH)

function imgPath(src)
    return IMAGE_PATH .. src
end

function Image(root, src, pos)
    --- @class Image
    local t = {} -- create new table

    src = imgPath(src);

    t.widget = root:Image { src = src }

    local w, h = t.widget:get_img_size()
    t.w = w
    t.h = h
    -- current state, center
    t.pos = {
        x = pos[1],
        y = pos[2]
    }

    function t:getImageWidth()
        return t.w
    end

    function t:getImageheight()
        return t.h
    end   

    t.defaultY = pos[2]
    t.lastState = STATE_POSITION_MID
    t.state = STATE_POSITION_MID

    t.widget:set {
        w = w,
        h = h,
        x = t.pos.x,
        y = t.pos.y
    }

    return t
end

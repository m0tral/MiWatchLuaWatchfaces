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

-- define global function Image
function Image(root, src, pos)

    local t = {} -- create new table

    src = imgPath(src)

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

    t.widget:set {
        w = w,
        h = h,
        x = t.pos.x,
        y = t.pos.y
    }

    return t
end

-- define global function HandImage
-- analog clock hand
function HandImage(root, src, pos)

    local t = {} -- create new table

    src = imgPath(src)

    t.widget = root:Image { src = src }

    local w, h = t.widget:get_img_size()
    t.w = w
    t.h = h
    -- current state, center
    t.pos = {
        x = pos[1] - (w // 2),
        y = pos[2] - (h // 2)
    }

    function t:getImageWidth()
        return t.w
    end

    function t:getImageheight()
        return t.h
    end

    t.widget:set {
        w = w,
        h = h,
        x = t.pos.x,
        y = t.pos.y
    }

    return t
end

-- define global function HandImageAnim
-- animated analog clock hand
function HandImageAnim(root, src, pos)

    local t = {} -- create new table

    src = imgPath(src)

    t.widget = root:Image { src = src }

    local w, h = t.widget:get_img_size()
    t.w = w
    t.h = h
    -- current state, center
    t.pos = {
        x = pos[1] - (w // 2),
        y = pos[2] - (h // 2)
    }

    function t:getImageWidth()
        return t.w
    end

    function t:getImageheight()
        return t.h
    end

    t.widget:set {
        w = w,
        h = h,
        x = t.pos.x,
        y = t.pos.y
    }
	
    local anim = t.widget:Anim {
        run = false,
        start_value = 0,
        end_value = 60,
        duration = 1000,
        repeat_count = 1,
        path = "linear",
        exec_cb = function(obj, value)
            obj:set { angle = value }
        end
    }

	t.rotateAnim = anim

    return t
end

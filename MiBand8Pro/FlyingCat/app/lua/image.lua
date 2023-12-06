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

    function t:getImageHeight()
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


function ImageGroup(root, pos)
    --- @class Image
    local t = {} -- create new table

    t.view_root = lvgl.Object(root, {
        outline_width = 0,
        border_width = 0,
        border_color = 0x000000,
        pad_all = 0,
        bg_opa = 0,
        bg_color = 0,
        w = lvgl.SIZE_CONTENT,
        h = lvgl.SIZE_CONTENT,
        x = pos.x,
        y = pos.y,
    })

    function t:setChild(src, pos)

        src = imgPath(src)

        local img = t.view_root:Image { src = src, x = pos.x, y = pos.y }
        return img
    end
    
    function t:getX()
        return t.x
    end

    function t:getY()
        return t.y
    end

    function t:getChildCnt()
        return t.view_root:get_child_cnt()
    end
    
    function t:getChild(i)
        return t.view_root:get_child(i)
    end
    
    function t:getParent()
        return t.view_root:get_parent()
    end

    return t
end

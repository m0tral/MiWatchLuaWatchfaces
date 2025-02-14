local lvgl = require("lvgl")

local printline = print("Line at"..debug.getinfo(1,"l").currentline)
-- local imgPath(fileName) = SCRIPT_PATH .. "/assets/nine.png"

local DEBUG = true
local ROOT = DEBUG and "diffusion/" or "/"
local fsRoot = DEBUG and SCRIPT_PATH .. ROOT or SCRIPT_PATH

local dataman = require(ROOT .. "dataman")

function __FILE__()
    return debug.getinfo(2,"S").source
end

function __LINE__()
    return debug.getinfo(1,"l").currentline
end

function imgPathByNum(num)
    src = {"one","tow","three","four","five","six","seven","nine","ten","eleven","twelve"}
    str = string.format("%s.png",src[num])
    return fsRoot .. "number/" .. str
end

function imgPath(src)
    local path = fsRoot .. "number/" .. src
    return path
end

local function watchfaceAttrInit()
    local InitialAttr= {
        {--1
            left = {
                bg = {x = 20, y = 43,w = 35,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -20, y = 0, src = imgPath("1.png")},
                fg = {x = 0, y = 0,w = 35,h = 320,src = imgPath("left.png")},
            },
            leftmid = {
                bg = {x = 55, y = 43,w = 70,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -5, y = 0, src = imgPath("1.png")},
                fg = {x = 0, y = 0,w = 70,h = 320,src = imgPath("leftmid.png")},
            },
            mid = {
                bg = {x = 90, y = 43,w = 210,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = 35, y = 0, src = imgPath("1.png")},
                fg = {x = 0, y = 0,w = 140,h = 320},
            },
            rightmid = {
                bg = {x = 265, y = 43,w = 70,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -115, y = 0, src = imgPath("1.png")},
                fg = {x = 0, y = 0,w = 70,h = 320,src = imgPath("rightmid.png")},
            },
            right = {
                bg = {x = 335, y = 43,w = 35,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -132, y = 0, src = imgPath("1.png")},
                fg = {x = 0, y = 0,w = 35,h = 320,src = imgPath("right.png")},
            },
        },
        {--2
            left = {
                bg = {x = 20, y = 43,w = 35,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = 1, y = 0, src = imgPath("2.png")},
                fg = {x = 0, y = 0,w = 35,h = 320,src = imgPath("left.png")},
            },
            leftmid = {
                bg = {x = 55, y = 43,w = 70,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = 5, y = 0, src = imgPath("2.png")},
                fg = {x = 0, y = 0,w = 70,h = 320,src = imgPath("leftmid.png")},
            },
            mid = {
                bg = {x = 90, y = 43,w = 210,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -83+35, y = 0, src = imgPath("2.png")},
                fg = {x = 0, y = 0,w = 140,h = 320},
            },
            rightmid = {
                bg = {x = 265, y = 43,w = 70,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -238, y = 0, src = imgPath("2.png")},
                fg = {x = 0, y = 0,w = 70,h = 320,src = imgPath("rightmid.png")},
            },
            right = {
                bg = {x = 335, y = 43,w = 35,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -269, y = 0, src = imgPath("2.png")},
                fg = {x = 0, y = 0,w = 35,h = 320,src = imgPath("right.png")},
            },
        },
        {--3
            left = {
                bg = {x = 20, y = 43,w = 35,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = 0, y = 0, src = imgPath("3.png")},
                fg = {x = 0, y = 0,w = 35,h = 320,src = imgPath("left.png")},
            },
            leftmid = {
                bg = {x = 55, y = 43,w = 70,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = 7-6, y = 0, src = imgPath("3.png")},
                fg = {x = 0, y = 0,w = 70,h = 320,src = imgPath("leftmid.png")},
            },
            mid = {
                bg = {x = 90, y = 43,w = 210,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -83+35, y = 0, src = imgPath("3.png")},
                fg = {x = 0, y = 0,w = 140,h = 320},
            },
            rightmid = {
                bg = {x = 265, y = 43,w = 70,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -238, y = 0, src = imgPath("3.png")},
                fg = {x = 0, y = 0,w = 70,h = 320,src = imgPath("rightmid.png")},
            },
            right = {
                bg = {x = 335, y = 43,w = 35,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -269, y = 0, src = imgPath("3.png")},
                fg = {x = 0, y = 0,w = 35,h = 320,src = imgPath("right.png")},
            },
        },
        {--4
            left = {
                bg = {x = 20, y = 43,w = 35,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = 8, y = 0, src = imgPath("4.png")},
                fg = {x = 0, y = 0,w = 35,h = 320,src = imgPath("left.png")},
            },
            leftmid = {
                bg = {x = 55, y = 43,w = 70,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = 10, y = 0, src = imgPath("4.png")},
                fg = {x = 0, y = 0,w = 70,h = 320,src = imgPath("leftmid.png")},
            },
            mid = {
                bg = {x = 90, y = 43,w = 210,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -92+35, y = 0, src = imgPath("4.png")},
                fg = {x = 0, y = 0,w = 140,h = 320},
            },
            rightmid = {
                bg = {x = 265, y = 43,w = 70,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -236, y = 0, src = imgPath("4.png")},
                fg = {x = 0, y = 0,w = 70,h = 320,src = imgPath("rightmid.png")},
            },
            right = {
                bg = {x = 335, y = 43,w = 35,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -299, y = 0, src = imgPath("4.png")},
                fg = {x = 0, y = 0,w = 35,h = 320,src = imgPath("right.png")},
            },
        },
        {--5
            left = {
                bg = {x = 20, y = 43,w = 35,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = 0, y = 0, src = imgPath("5.png")},
                fg = {x = 0, y = 0,w = 35,h = 320,src = imgPath("left.png")},
            },
            leftmid = {
                bg = {x = 55, y = 43,w = 70,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = 8, y = 0, src = imgPath("5.png")},
                fg = {x = 0, y = 0,w = 70,h = 320,src = imgPath("leftmid.png")},
            },
            mid = {
                bg = {x = 90, y = 43,w = 210,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -80+35, y = 0, src = imgPath("5.png")},
                fg = {x = 0, y = 0,w = 140,h = 320},
            },
            rightmid = {
                bg = {x = 265, y = 43,w = 70,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -247, y = 0, src = imgPath("5.png")},
                fg = {x = 0, y = 0,w = 70,h = 320,src = imgPath("rightmid.png")},
            },
            right = {
                bg = {x = 335, y = 43,w = 35,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -284, y = 0, src = imgPath("5.png")},
                fg = {x = 0, y = 0,w = 35,h = 320,src = imgPath("right.png")},
            },
        },
        {--6
            left = {
                bg = {x = 20, y = 43,w = 35,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = 5, y = 0, src = imgPath("6.png")},
                fg = {x = 0, y = 0,w = 35,h = 320,src = imgPath("left.png")},
            },
            leftmid = {
                bg = {x = 55, y = 43,w = 70,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = 8, y = 0, src = imgPath("6.png")},
                fg = {x = 0, y = 0,w = 70,h = 320,src = imgPath("leftmid.png")},
            },
            mid = {
                bg = {x = 90, y = 43,w = 210,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -84+35, y = 0, src = imgPath("6.png")},
                fg = {x = 0, y = 0,w = 140,h = 320},
            },
            rightmid = {
                bg = {x = 265, y = 43,w = 70,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -248, y = 0, src = imgPath("6.png")},
                fg = {x = 0, y = 0,w = 70,h = 320,src = imgPath("rightmid.png")},
            },
            right = {
                bg = {x = 335, y = 43,w = 35,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -277, y = 0, src = imgPath("6.png")},
                fg = {x = 0, y = 0,w = 35,h = 320,src = imgPath("right.png")},
            },
        },
        {--7
            left = {
                bg = {x = 20, y = 43,w = 35,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = 0, y = 0, src = imgPath("7.png")},
                fg = {x = 0, y = 0,w = 35,h = 320,src = imgPath("left.png")},
            },
            leftmid = {
                bg = {x = 55, y = 43,w = 70,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = 8, y = 0, src = imgPath("7.png")},
                fg = {x = 0, y = 0,w = 70,h = 320,src = imgPath("leftmid.png")},
            },
            mid = {
                bg = {x = 90, y = 43,w = 210,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -70+35, y = 0, src = imgPath("7.png")},
                fg = {x = 0, y = 0,w = 140,h = 320},
            },
            rightmid = {
                bg = {x = 265, y = 43,w = 70,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -228, y = 0, src = imgPath("7.png")},
                fg = {x = 0, y = 0,w = 70,h = 320,src = imgPath("rightmid.png")},
            },
            right = {
                bg = {x = 335, y = 43,w = 35,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -254, y = 0, src = imgPath("7.png")},
                fg = {x = 0, y = 0,w = 35,h = 320,src = imgPath("right.png")},
            },
        },
        {--8
            left = {
                bg = {x = 20, y = 43,w = 35,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = 3, y = 0, src = imgPath("8.png")},
                fg = {x = 0, y = 0,w = 35,h = 320,src = imgPath("left.png")},
            },
            leftmid = {
                bg = {x = 55, y = 43,w = 70,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = 6, y = 0, src = imgPath("8.png")},
                fg = {x = 0, y = 0,w = 70,h = 320,src = imgPath("leftmid.png")},
            },
            mid = {
                bg = {x = 90, y = 43,w = 210,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -76+35, y = 0, src = imgPath("8.png")},
                fg = {x = 0, y = 0,w = 140,h = 320},
            },
            rightmid = {
                bg = {x = 265, y = 43,w = 70,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -231, y = 0, src = imgPath("8.png")},
                fg = {x = 0, y = 0,w = 70,h = 320,src = imgPath("rightmid.png")},
            },
            right = {
                bg = {x = 335, y = 43,w = 35,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -263, y = 0, src = imgPath("8.png")},
                fg = {x = 0, y = 0,w = 35,h = 320,src = imgPath("right.png")},
            },
        },
        {--9
            left = {
                bg = {x = 20, y = 43,w = 35,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = 0, y = 0, src = imgPath("9.png")},
                fg = {x = 0, y = 0,w = 35,h = 320,src = imgPath("left.png")},
            },
            leftmid = {
                bg = {x = 55, y = 43,w = 70,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = 0, y = 0, src = imgPath("9.png")},
                fg = {x = 0, y = 0,w = 70,h = 320,src = imgPath("leftmid.png")},
            },
            mid = {
                bg = {x = 90, y = 43,w = 210,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -49+35, y = 0, src = imgPath("9.png")},
                fg = {x = 0, y = 0,w = 140,h = 320},
            },
            rightmid = {
                bg = {x = 265, y = 43,w = 70,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -177, y = 0, src = imgPath("9.png")},
                fg = {x = 0, y = 0,w = 70,h = 320,src = imgPath("rightmid.png")},
            },
            right = {
                bg = {x = 335, y = 43,w = 35,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -234, y = 0, src = imgPath("9.png")},
                fg = {x = 0, y = 0,w = 35,h = 320,src = imgPath("right.png")},
            },
        },
        {--10
            left = {
                bg = {x = 20, y = 43,w = 35,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -50, y = 0, src = imgPath("10.png")},
                fg = {x = 0, y = 0,w = 35,h = 320,src = imgPath("left.png")},
            },
            leftmid = {
                bg = {x = 55, y = 43,w = 70,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -61, y = 0, src = imgPath("10.png")},
                fg = {x = 0, y = 0,w = 70,h = 320,src = imgPath("leftmid.png")},
            },
            mid = {
                bg = {x = 90, y = 43,w = 210,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -113+35, y = 0, src = imgPath("10.png")},
                fg = {x = 0, y = 0,w = 140,h = 320},
            },
            rightmid = {
                bg = {x = 265, y = 43,w = 70,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -300, y = 0, src = imgPath("10.png")},
                fg = {x = 0, y = 0,w = 70,h = 320,src = imgPath("rightmid.png")},
            },
            right = {
                bg = {x = 335, y = 43,w = 35,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -384, y = 0, src = imgPath("10.png")},
                fg = {x = 0, y = 0,w = 35,h = 320,src = imgPath("right.png")},
            },
        },
        {--11
            left = {
                bg = {x = 20, y = 43,w = 35,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -26, y = 0, src = imgPath("1.png")},
                fg = {x = 0, y = 0,w = 35,h = 320,src = imgPath("left.png")},
            },
            leftmid = {
                bg = {x = 55, y = 43,w = 70,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -35, y = 0, src = imgPath("1.png")},
                fg = {x = 0, y = 0,w = 70,h = 320,src = imgPath("leftmid.png")},
            },
            mid = {
                bg = {x = 90, y = 43,w = 210,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -78+35, y = 0, src = imgPath("11.png")},
                fg = {x = 0, y = 0,w = 140,h = 320},
            },
            rightmid = {
                bg = {x = 265, y = 43,w = 70,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -63-60, y = 0, src = imgPath("1.png")},
                fg = {x = 0, y = 0,w = 70,h = 320,src = imgPath("rightmid.png")},
            },
            right = {
                bg = {x = 335, y = 43,w = 35,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -79-60, y = 0, src = imgPath("1.png")},
                fg = {x = 0, y = 0,w = 35,h = 320,src = imgPath("right.png")},
            },
        },
        {--12
            left = {
                bg = {x = 20, y = 43,w = 35,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -53, y = 0, src = imgPath("12.png")},
                fg = {x = 0, y = 0,w = 35,h = 320,src = imgPath("left.png")},
            },
            leftmid = {
                bg = {x = 55, y = 43,w = 70,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -65, y = 0, src = imgPath("12.png")},
                fg = {x = 0, y = 0,w = 70,h = 320,src = imgPath("leftmid.png")},
            },
            mid = {
                bg = {x = 90, y = 43,w = 210,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -115+35, y = 0, src = imgPath("12.png")},
                fg = {x = 0, y = 0,w = 140,h = 320},
            },
            rightmid = {
                bg = {x = 265, y = 43,w = 70,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -313, y = 0, src = imgPath("12.png")},
                fg = {x = 0, y = 0,w = 70,h = 320,src = imgPath("rightmid.png")},
            },
            right = {
                bg = {x = 335, y = 43,w = 35,h = 320,bg_opa = lvgl.OPA(100)},
                img = {x = -364, y = 0, src = imgPath("12.png")},
                fg = {x = 0, y = 0,w = 35,h = 320,src = imgPath("right.png")},
            },
        },
    }

    return InitialAttr
end

local function ImageComponent(root,src,attr)
    local t = {}
    t.bg = lvgl.Object(root, {outline_width = 0,border_width = 0,pad_all = 0,bg_opa = attr.bg.bg_opa,bg_color = 0x000000,radius = 0,x = attr.bg.x, y = attr.bg.y,w = attr.bg.w,h = attr.bg.h})
    t.bg:clear_flag(lvgl.FLAG.SCROLLABLE)
    t.bg:add_flag(lvgl.FLAG.EVENT_BUBLE)
    t.img = lvgl.Image(t.bg, {x = attr.img.x, y = attr.img.y, src = attr.img.src,zoom = lvgl.IMG_ZOOM_NONE})
    t.img:add_flag(lvgl.FLAG.EVENT_BUBLE)
    if attr.fg.src == nil
    then 
        t.fg = lvgl.Image(t.bg, {x = attr.fg.x, y = attr.fg.y,zoom = lvgl.IMG_ZOOM_NONE})
    else   
        t.fg = lvgl.Image(t.bg, {x = attr.fg.x, y = attr.fg.y,src = attr.fg.src,zoom = lvgl.IMG_ZOOM_NONE})
    end
    t.fg:add_flag(lvgl.FLAG.EVENT_BUBLE) 
    -- create animation and put it on hold
    local animbg = t.bg:Anim {
        run = false,
        start_value = 0,
        end_value = 450,
        time = 1200,
        delay = 120,
        playback_delay = 1000,
        playback_time = 1000,
        repeat_count = 1,
        path = "ease_in_out",
        exec_cb = function(obj, value)
            obj:set { x = value }
        end
    }

    local animimg = t.img:Anim {
        run = false,
        start_value = 0,
        end_value = 450,
        time = 1200,
        delay = 120,
        repeat_count = 1,
        playback_delay = 1000,
        playback_time = 1000,
        path = "ease_in_out",
        exec_cb = function(obj, value)
            obj:set { x = value }
        end
    }

    local animfg = t.fg:Anim {
        run = false,
        start_value = 0,
        end_value = 450,
        time = 1200,
        delay = 120,
        repeat_count = 1,
        playback_delay = 1000,
        playback_time = 1000,
        path = "ease_in_out",
        exec_cb = function(obj, value)
            obj:set { x = value }
        end
    }

    t.bgAnim = animbg
    t.fgAnim = animfg
    t.imgAnim = animimg
    return t
end

-- Create an image to support state amim etc.
---@param root Object
---@return Image

local function imageGroup(root, pos)
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
local function getPowerPos()
    t = { x = 166,y = 1}
    return t
end

local function getMinutePos()
    t = { x = 160,y = 391 }
    return t
end

local function createWatchface(parent)
    print('-------create  watchface--------')
    local t = {}
    print("Line at"..debug.getinfo(1,"l").currentline)
    t.root = parent
    -- 电量
    local pos_power = getPowerPos()
    t.power_status = imageGroup(parent, pos_power)
    t.power_status1 = t.power_status:setChild(imgPath("num11.png"),{x = 0,y = 0})
    t.power_status2 = t.power_status:setChild(imgPath("num8.png"),{x = 15,y = 0})
    t.power_status3 = t.power_status:setChild(imgPath("num0.png"),{x = 30,y = 0})
    t.power_status4 = t.power_status:setChild(imgPath("num10.png"),{x = 45,y = 0})
    t.power_status5 = t.power_status:setChild(imgPath("num10.png"),{x = 60,y = 0})
    t.power_status5:add_flag(lvgl.FLAG.HIDDEN)
    local hour_num = 8
    local attr = watchfaceAttrInit()
    t.attr = attr[hour_num]
    t.mid = ImageComponent(parent,attr[hour_num].mid.img.src,attr[hour_num].mid)
    t.left = ImageComponent(parent,attr[hour_num].mid.img.src,attr[hour_num].left)
    t.leftmid = ImageComponent(parent,attr[hour_num].mid.img.src,attr[hour_num].leftmid)
    t.rightmid = ImageComponent(parent,attr[hour_num].mid.img.src,attr[hour_num].rightmid)
    t.right = ImageComponent(parent,attr[hour_num].mid.img.src,attr[hour_num].right)
    t.event_mask = lvgl.Object(parent, {outline_width = 0,border_width = 0,pad_all = 0,bg_opa = lvgl.OPA(0),bg_color = 0x000000,w = lvgl.HOR_RES(), h = lvgl.VER_RES()})
    -- 时间
    local pos_min = getMinutePos()
    t.minute = imageGroup(parent, pos_min)
    t.minute1 = t.minute:setChild(imgPath("min0.png"),{x = 0,y = 0})
    t.minute2 = t.minute:setChild(imgPath("min0.png"),{x = 38,y = 0})
   
    return t
end

local function uiCreate()
    local root = lvgl.Object(nil, {outline_width = 0,border_width = 0,pad_all = 0,bg_opa = lvgl.OPA(100),bg_color = 0x0,w = lvgl.HOR_RES(), h = lvgl.VER_RES()})
    root:clear_flag(lvgl.FLAG.SCROLLABLE)
    root:add_flag(lvgl.FLAG.EVENT_BUBLE)
    local watchface = createWatchface(root)
    local t = {}    

    local function screenONCb()
        print("365250009 screen on")
    end

    local function screenOFFCb()
        print("365250009 screen off")
    end

    dataman.subscribe("systemStatusBattery", watchface.power_status.view_root, function(obj, value)
        index = value // 256
        watchface.power_status1:add_flag(lvgl.FLAG.HIDDEN)
        watchface.power_status2:add_flag(lvgl.FLAG.HIDDEN)
        watchface.power_status3:add_flag(lvgl.FLAG.HIDDEN)
        watchface.power_status4:add_flag(lvgl.FLAG.HIDDEN)
        watchface.power_status5:add_flag(lvgl.FLAG.HIDDEN)       

        local pos = getPowerPos()
        if index ~= 100 then
            watchface.power_status.view_root:set({ x = pos.x })
            watchface.power_status1:clear_flag(lvgl.FLAG.HIDDEN)
        else
            watchface.power_status.view_root:set({ x = pos.x - 8 })
            watchface.power_status1:clear_flag(lvgl.FLAG.HIDDEN)
        end
   
        if index < 10 then
            src = string.format("num%d.png", index)
            watchface.power_status2:set({ src = imgPath(src) })
            watchface.power_status2:clear_flag(lvgl.FLAG.HIDDEN)

            watchface.power_status3:set({ src = imgPath("num10.png") })
            watchface.power_status3:clear_flag(lvgl.FLAG.HIDDEN)
        elseif index < 100 then
            src = string.format("num%d.png", index // 10)
            watchface.power_status2:set({ src = imgPath(src) })
            watchface.power_status2:clear_flag(lvgl.FLAG.HIDDEN)

            src = string.format("num%d.png", index % 10)
            watchface.power_status3:set({ src = imgPath(src) })
            watchface.power_status3:clear_flag(lvgl.FLAG.HIDDEN)

            watchface.power_status4:set({ src = imgPath("num10.png") })
            watchface.power_status4:clear_flag(lvgl.FLAG.HIDDEN)
        else
            src = string.format("num%d.png", 1)
            watchface.power_status2:set({ src = imgPath(src) })
            watchface.power_status2:clear_flag(lvgl.FLAG.HIDDEN)

            src = string.format("num%d.png", 0)
            watchface.power_status3:set({ src = imgPath(src) })
            watchface.power_status3:clear_flag(lvgl.FLAG.HIDDEN)

            src = string.format("num%d.png", 0)
            watchface.power_status4:set({ src = imgPath(src) })
            watchface.power_status4:clear_flag(lvgl.FLAG.HIDDEN)

            watchface.power_status5:set({ src = imgPath("num10.png") })
            watchface.power_status5:clear_flag(lvgl.FLAG.HIDDEN)
        end
    end)
    
    dataman.subscribe("timeHour", watchface.root, function(obj, value)
        local hour = value // 256
        print("timeHour",value,hour)
        if hour == 0
        then 
            hour = 12
        elseif hour > 12 
        then
            hour = hour - 12
        end
        local attrAll = watchfaceAttrInit()
        local attrHour = attrAll[hour]
        watchface.attr = attrHour
        watchface.left.bg:set{x = attrHour.left.bg.x, y = attrHour.left.bg.y,w = attrHour.left.bg.w,h = attrHour.left.bg.h}
        watchface.left.img:set{x = attrHour.left.img.x, y = attrHour.left.img.y, src = attrHour.left.img.src}
        watchface.left.fg:set{x = attrHour.left.fg.x, y = attrHour.left.fg.y,src = attrHour.left.fg.src}
        -- leftmid
        watchface.leftmid.bg:set{x = attrHour.leftmid.bg.x, y = attrHour.leftmid.bg.y,w = attrHour.leftmid.bg.w,h = attrHour.leftmid.bg.h}
        watchface.leftmid.img:set{x = attrHour.leftmid.img.x, y = attrHour.leftmid.img.y, src = attrHour.leftmid.img.src}
        watchface.leftmid.fg:set{x = attrHour.leftmid.fg.x, y = attrHour.leftmid.fg.y,src = attrHour.leftmid.fg.src}
        -- mid
        watchface.mid.bg:set{x = attrHour.mid.bg.x, y = attrHour.mid.bg.y,w = attrHour.mid.bg.w,h = attrHour.mid.bg.h}
        watchface.mid.img:set{x = attrHour.mid.img.x, y = attrHour.mid.img.y, src = attrHour.mid.img.src}
        watchface.mid.fg:set{x = attrHour.mid.fg.x, y = attrHour.mid.fg.y,src = attrHour.mid.fg.src}
        -- rightmid
        watchface.rightmid.bg:set{x = attrHour.rightmid.bg.x, y = attrHour.rightmid.bg.y,w = attrHour.rightmid.bg.w,h = attrHour.rightmid.bg.h}
        watchface.rightmid.img:set{x = attrHour.rightmid.img.x, y = attrHour.rightmid.img.y, src = attrHour.rightmid.img.src}
        watchface.rightmid.fg:set{x = attrHour.rightmid.fg.x, y = attrHour.rightmid.fg.y,src = attrHour.rightmid.fg.src}
        -- right
        watchface.right.bg:set{x = attrHour.right.bg.x, y = attrHour.right.bg.y,w = attrHour.right.bg.w,h = attrHour.right.bg.h}
        watchface.right.img:set{x = attrHour.right.img.x, y = attrHour.right.img.y, src = attrHour.right.img.src}
        watchface.right.fg:set{x = attrHour.right.fg.x, y = attrHour.right.fg.y,src = attrHour.right.fg.src}
    end)


    dataman.subscribe("timeSecondHigh", watchface.minute.view_root, function(obj, value)
        src = string.format("min%d.png", value // 256)
        watchface.minute1:set { src = imgPath(src) }
    end)
    dataman.subscribe("timeSecondLow", watchface.minute.view_root, function(obj, value)
        src = string.format("min%d.png", value // 256)
        watchface.minute2:set { src = imgPath(src) }
    end)



    return screenONCb, screenOFFCb ,watchface
end
local on,off,t = uiCreate()

t.event_mask:onClicked(function (obj, code)
    print("Line at"..debug.getinfo(1,"l").currentline)
    t.animStart = true
-- left
    t.left.bgAnim:set{
        start_value = t.attr.left.bg.x,
        end_value = t.attr.left.bg.x - 10,
        run = t.animStart,
    }
    t.left.imgAnim:set{
        start_value = t.attr.left.img.x,
        end_value = t.attr.left.img.x - 70,
        run = t.animStart,
    }
-- leftmid
    t.leftmid.bgAnim:set{
        start_value = t.attr.leftmid.bg.x,
        end_value = t.attr.leftmid.bg.x - 10,
        run = t.animStart,
    }
    t.leftmid.imgAnim:set{
        start_value = t.attr.leftmid.img.x,
        end_value = t.attr.leftmid.img.x - 60,
        run = t.animStart,
    }
-- rightmid
    t.rightmid.bgAnim:set{
        start_value = t.attr.rightmid.bg.x,
        end_value = t.attr.rightmid.bg.x + 10,
        run = t.animStart,
    }
    t.rightmid.imgAnim:set{
        start_value = t.attr.rightmid.img.x,
        end_value = t.attr.rightmid.img.x + 60,
        run = t.animStart,
    }
-- right
    t.right.bgAnim:set{
        start_value = t.attr.right.bg.x,
        end_value = t.attr.right.bg.x + 10,
        run = t.animStart,
    }
    t.right.imgAnim:set{
        start_value = t.attr.right.img.x,
        end_value = t.attr.right.img.x + 70,
        run = t.animStart,
    }
end)

--[[
function ScreenStateChangedCB(pre, now, reason)
    print("screen state", pre, now, reason)
    if pre ~="ON" and now == "ON" then
        on()
    elseif pre == "ON" and now ~= "ON" then
        off()
    end
end
]]
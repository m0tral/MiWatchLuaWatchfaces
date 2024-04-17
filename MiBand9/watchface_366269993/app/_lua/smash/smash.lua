local lvgl = require("lvgl")
local dataman = require("dataman")

local fsRoot = SCRIPT_PATH
local DEBUG_ENABLE = false

local STATE_POSITION_UP = 1
local STATE_POSITION_MID = 2
local STATE_POSITION_BOTTOM = 3

local printf = DEBUG_ENABLE and print or function(...)
end

function imgPath(src)
    return fsRoot .. src
end

-- Create an image to support state amim etc.
---@param root Object
---@return Image
local function Image(root, src, pos)
    --- @class Image
    local t = {} -- create new table

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

    -- create animation and put it on hold
    local anim = t.widget:Anim {
        run = false,
        start_value = 0,
        end_value = 1000,
        time = 560, -- 560ms fixed
        repeat_count = 1,
        path = "ease_in_out",
        exec_cb = function(obj, now)
            obj:set { y = now }
            t.pos.y = now
        end
    }

    t.posAnim = anim

    return t
end

---@param root Object
local function imageGroup(root, pos)
    --- @class Image
    local t = {} -- create new table

    t.widget = lvgl.Object(root, {
        outline_width = 0,
        border_width = 0,
        pad_all = 0,
        bg_opa = 0,
        bg_color = 0,
        w = lvgl.SIZE_CONTENT,
        h = lvgl.SIZE_CONTENT,
        x = pos.x,
        y = pos.y,
    })

    function t:setChild(src, pos)
        local img = t.widget:Image { src = src, x = pos.x, y = pos.y }
        return img
    end

    -- current state, center
    t.pos = {
        x = pos[1],
        y = pos[2]
    }

    t.defaultY = pos[2]
    t.lastState = STATE_POSITION_MID
    t.state = STATE_POSITION_MID

    t.widget:set {
        x = t.pos.x,
        y = t.pos.y
    }

    function t:getChildCnt()
        return t.widget:get_child_cnt()
    end

    function t:getChild(i)
        return t.widget:get_child(i)
    end

    function t:getParent()
        return t.widget:get_parent()
    end

    -- create animation and put it on hold
    local anim = t.widget:Anim {
        run = false,
        start_value = 0,
        end_value = 1000,
        time = 560, -- 560ms fixed
        repeat_count = 1,
        path = "ease_in_out",
        exec_cb = function(obj, now)
            obj:set { y = now }
            t.pos.y = now
        end
    }

    t.posAnim = anim

    return t
end


---@param parent Object
local function createWatchface(parent)
    local t = {}

    local wfRoot = lvgl.Object(parent, {
        outline_width = 0,
        border_width = 0,
        pad_all = 0,
        bg_opa = 0,
        bg_color = 0,
        align = lvgl.ALIGN.CENTER,
        w = 192,
        h = 490,
    })
    wfRoot:clear_flag(lvgl.FLAG.SCROLLABLE)
    wfRoot:add_flag(lvgl.FLAG.EVENT_BUBBLE)

    -- 背景
    t.objImage = lvgl.Image(wfRoot,{x = 0, y = 0,src=imgPath("piece_bg.rle")})

    -- 充电图标
    t.chargeImg = Image(wfRoot, imgPath("charge.rle"), {18, 75})

    -- 电池电量
    t.chargeCont = imageGroup(wfRoot, {19, 102})
    t.chargeContChild1 = t.chargeCont:setChild(imgPath("num8.rle"), { x = 0, y = 0 });
    t.chargeContChild2 = t.chargeCont:setChild(imgPath("num0.rle"), { x = 15, y = 0 });
    t.chargeContChild3 = t.chargeCont:setChild(imgPath("num%.rle"), { x = 31, y = 0 });
    t.chargeContChild4 = t.chargeCont:setChild(imgPath("num0.rle"), { x = 46, y = 0 });

    -- 小时分钟
    t.timeHourHigh = Image(wfRoot, imgPath("0.rle"), {15, 142})
    t.timeHourLow = Image(wfRoot, imgPath("9.rle"), {62, 142})
    t.timeMinuteHigh = Image(wfRoot, imgPath("2.rle"), {15, 229})
    t.timeMinuteLow = Image(wfRoot, imgPath("8.rle"), {62, 229})

    -- 星期
    t.dateWeek = Image(wfRoot, imgPath("MON.rle"), {107, 330})

    -- 日期
    t.dateCont = imageGroup(wfRoot, {105, 357})
    t.dateContChild1 = t.dateCont:setChild(imgPath("num0.rle"), { x = 0, y = 0 });
    t.dateContChild2 = t.dateCont:setChild(imgPath("num8.rle"), { x = 16, y = 0 });
    t.dateContChild3 = t.dateCont:setChild(imgPath("slash.rle"), { x = 32, y = 0 });
    t.dateContChild4 = t.dateCont:setChild(imgPath("num1.rle"), { x = 40, y = 0 });
    t.dateContChild5 = t.dateCont:setChild(imgPath("num6.rle"), { x = 56, y = 0 });

    -- 碎片
    t.pieceTopImage = lvgl.Image(wfRoot,{x = 0, y = 0,src=imgPath("piece_top.rle")})
	t.pieceMiddleImage = lvgl.Image(wfRoot,{x = 0, y = 164,src=imgPath("piece_middle.rle")})
	t.pieceBottomImage = lvgl.Image(wfRoot,{x = 0, y = 289,src=imgPath("piece_bottom.rle")})
    t.pieceTopImage:add_flag(lvgl.FLAG.HIDDEN)
    t.pieceMiddleImage:add_flag(lvgl.FLAG.HIDDEN)
    t.pieceBottomImage:add_flag(lvgl.FLAG.HIDDEN)

    wfRoot:onevent(lvgl.EVENT.SHORT_CLICKED,function(obj, code)
        local indev = lvgl.indev.get_act()
        local x, y = indev:get_point()
        if (y <= 184) then
            t.pieceTopImage:clear_flag(lvgl.FLAG.HIDDEN)
        elseif (y > 184 and y<289) then
            t.pieceMiddleImage:clear_flag(lvgl.FLAG.HIDDEN)
        elseif (y>289) then
            t.pieceBottomImage:clear_flag(lvgl.FLAG.HIDDEN)
        end
    end)

    return t
end

local function uiCreate()
    local root = lvgl.Object(nil, {
        w = lvgl.HOR_RES(),
        h = lvgl.VER_RES(),
        bg_color = 0,
        bg_opa = lvgl.OPA(100),
        border_width = 0,
    })
    root:clear_flag(lvgl.FLAG.SCROLLABLE)
    root:add_flag(lvgl.FLAG.EVENT_BUBBLE)

    local watchface = createWatchface(root)

    local function screenONCb()
        --printf("screen on")
    end

    local function screenOFFCb()
        --printf("screen off")
        watchface.pieceTopImage:add_flag(lvgl.FLAG.HIDDEN)
        watchface.pieceMiddleImage:add_flag(lvgl.FLAG.HIDDEN)
        watchface.pieceBottomImage:add_flag(lvgl.FLAG.HIDDEN)
    end

    screenONCb() -- screen is ON when watchface created

    -- 电池电量
    dataman.subscribe("systemStatusBattery", watchface.chargeCont.widget, function(obj, value)
        local index = value // 256
        watchface.chargeContChild1:add_flag(lvgl.FLAG.HIDDEN)
        watchface.chargeContChild2:add_flag(lvgl.FLAG.HIDDEN)
        watchface.chargeContChild3:add_flag(lvgl.FLAG.HIDDEN)
        watchface.chargeContChild4:add_flag(lvgl.FLAG.HIDDEN)

        local num = 1
        if index < 10 then
            src = string.format("num%d.rle", index)
            watchface.chargeContChild1:set({ src = imgPath(src) })
            watchface.chargeContChild1:clear_flag(lvgl.FLAG.HIDDEN)
            watchface.chargeContChild2:set({ src = imgPath("num%.rle") })
            watchface.chargeContChild2:clear_flag(lvgl.FLAG.HIDDEN)
        elseif index < 100 then
            src = string.format("num%d.rle", index // 10)
            watchface.chargeContChild1:set({ src = imgPath(src) })
            watchface.chargeContChild1:clear_flag(lvgl.FLAG.HIDDEN)
            src = string.format("num%d.rle", index % 10)
            watchface.chargeContChild2:set({ src = imgPath(src) })
            watchface.chargeContChild2:clear_flag(lvgl.FLAG.HIDDEN)
            watchface.chargeContChild3:set({ src = imgPath("num%.rle") })
            watchface.chargeContChild3:clear_flag(lvgl.FLAG.HIDDEN)
            num = 2
        else
            src = string.format("num%d.rle", 1)
            watchface.chargeContChild1:set({ src = imgPath(src) })
            watchface.chargeContChild1:clear_flag(lvgl.FLAG.HIDDEN)
            src = string.format("num%d.rle", 0)
            watchface.chargeContChild2:set({ src = imgPath(src) })
            watchface.chargeContChild2:clear_flag(lvgl.FLAG.HIDDEN)
            src = string.format("num%d.rle", 0)
            watchface.chargeContChild3:set({ src = imgPath(src) })
            watchface.chargeContChild3:clear_flag(lvgl.FLAG.HIDDEN)
            watchface.chargeContChild4:set({ src = imgPath("num%.rle") })
            watchface.chargeContChild4:clear_flag(lvgl.FLAG.HIDDEN)
            num = 3
        end
    end)

    -- 小时分钟
    dataman.subscribe("timeHourHigh", watchface.timeHourHigh.widget, function(obj, value)
        src = string.format("%d.rle", value // 256)
        obj:set { src = imgPath(src) }
    end)
    dataman.subscribe("timeHourLow", watchface.timeHourLow.widget, function(obj, value)
        src = string.format("%d.rle", value // 256)
        obj:set { src = imgPath(src) }
    end)
    dataman.subscribe("timeMinuteHigh", watchface.timeMinuteHigh.widget, function(obj, value)
        src = string.format("%d.rle", value // 256)
        obj:set { src = imgPath(src) }
    end)
    dataman.subscribe("timeMinuteLow", watchface.timeMinuteLow.widget, function(obj, value)
        src = string.format("%d.rle", value // 256)
        obj:set { src = imgPath(src) }
    end)

    -- 星期
    dataman.subscribe("dateWeek", watchface.dateWeek.widget, function(obj, value)
        index = value // 256
        index = index + 1
        src = { "SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT" }
        str = string.format("%s.rle", src[index])
        obj:set { src = imgPath(str) }
    end)

    dataman.subscribe("dateMonth", watchface.dateCont.widget, function(obj, value)
        index = value // 256
        watchface.dateContChild1:add_flag(lvgl.FLAG.HIDDEN)
        watchface.dateContChild2:add_flag(lvgl.FLAG.HIDDEN)
        if index < 10 then
            watchface.dateContChild1:set({ src = imgPath("num0.rle") });
            src = string.format("num%d.rle", index)
            watchface.dateContChild2:set({ src = imgPath(src) });
            watchface.dateContChild2:clear_flag(lvgl.FLAG.HIDDEN)
        else
            src = string.format("num%d.rle", index // 10)
            watchface.dateContChild1:set({ src = imgPath(src) });
            watchface.dateContChild1:clear_flag(lvgl.FLAG.HIDDEN)
            src = string.format("num%d.rle", index % 10)
            watchface.dateContChild2:set({ src = imgPath(src) });
            watchface.dateContChild2:clear_flag(lvgl.FLAG.HIDDEN)
        end
    end)

    dataman.subscribe("dateDay", watchface.dateCont.widget, function(obj, value)
        index = value // 256
        watchface.dateContChild4:add_flag(lvgl.FLAG.HIDDEN)
        watchface.dateContChild5:add_flag(lvgl.FLAG.HIDDEN)
        if index < 10 then
            watchface.dateContChild4:set({ src = imgPath("num0.rle") });
            src = string.format("num%d.rle", index)
            watchface.dateContChild5:set({ src = imgPath(src) });
            watchface.dateContChild5:clear_flag(lvgl.FLAG.HIDDEN)
        else
            src = string.format("num%d.rle", index // 10)
            watchface.dateContChild4:set({ src = imgPath(src) });
            watchface.dateContChild4:clear_flag(lvgl.FLAG.HIDDEN)
            src = string.format("num%d.rle", index % 10)
            watchface.dateContChild5:set({ src = imgPath(src) });
            watchface.dateContChild5:clear_flag(lvgl.FLAG.HIDDEN)
        end
    end)

    return screenONCb, screenOFFCb
end

local on, off = uiCreate()

function ScreenStateChangedCB(pre, now, reason)
    --printf("screen state", pre, now, reason)
    if pre ~="ON" and now == "ON" then
        on()
    elseif pre == "ON" and now ~= "ON" then
        off()
    end
end

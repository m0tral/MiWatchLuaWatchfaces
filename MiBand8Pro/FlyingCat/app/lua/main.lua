local lvgl = require("lvgl")
local math = require("math")
local os = require("os")
local topic = require("topic")
local dataman = require("dataman")

-- load our submodules
require "image"
require "root"

local function getItemsPosition()
    
	local imgPosition = {
        cat =	 { 168, 240 },
        tree =	 {  26, 326 },
        hourH =	 {  15, 180 },
        hourL =	 {  85, 180 },
        minH =	 { 177, 180 },
        minL =	 { 247, 180 },
        delim =	 { 160, 207 },
        power =  { x = 142, y = 150 },
    }

    return imgPosition
end

-- snow config
local SnowCount = 2
local ShowSizeMin = 10
local ShowSizeMax = 20
local FallDurationMin = 1000 * 15
local FallDurationMax = 1000 * 25

-- prepare main watchface fuction
local function entry()

    local root = createRoot()
	
	local watchface = {}
	
    -- setup watchface elements positions
	local pos = getItemsPosition()
	
    -- create watchface elements
    watchface.hourH = Image(root, "num_0.bin", pos.hourH)
    watchface.hourL = Image(root, "num_0.bin", pos.hourL)
    watchface.minH =  Image(root, "num_0.bin", pos.minH)
    watchface.minL =  Image(root, "num_0.bin", pos.minL)
    watchface.delim = Image(root, "delim.bin", pos.delim)
    watchface.tree  = Image(root, "tree.bin", pos.tree)

    watchface.power_status = ImageGroup(root, pos.power)
    watchface.power_status1 = watchface.power_status:setChild("num11.rle", {x = 0,y = 0})
    watchface.power_status2 = watchface.power_status:setChild("num0.rle", {x = 15,y = 0})
    watchface.power_status3 = watchface.power_status:setChild("num0.rle", {x = 30,y = 0})
    watchface.power_status4 = watchface.power_status:setChild("num10.rle", {x = 45,y = 0})
    watchface.power_status5 = watchface.power_status:setChild("num10.rle", {x = 60,y = 0})
    watchface.power_status5:add_flag(lvgl.FLAG.HIDDEN)

    watchface.cat   = HandImage(root, "cat_b.bin", pos.cat)
    watchface.catIndex = 1

    math.randomseed(os.time())

    dataman.subscribe("systemStatusBattery", watchface.power_status.view_root, function(obj, value)
        
        local src = ""
        local index = value // 256
        watchface.power_status1:add_flag(lvgl.FLAG.HIDDEN)
        watchface.power_status2:add_flag(lvgl.FLAG.HIDDEN)
        watchface.power_status3:add_flag(lvgl.FLAG.HIDDEN)
        watchface.power_status4:add_flag(lvgl.FLAG.HIDDEN)
        watchface.power_status5:add_flag(lvgl.FLAG.HIDDEN)

        local pos = getItemsPosition()
        if index ~= 100 then
            watchface.power_status.view_root:set({ x = pos.power.x })
            watchface.power_status1:clear_flag(lvgl.FLAG.HIDDEN)
        else
            watchface.power_status.view_root:set({ x = pos.power.x - 8 })
            watchface.power_status1:clear_flag(lvgl.FLAG.HIDDEN)
        end
   
        if index < 10 then
            src = string.format("num%d.rle", index)
            watchface.power_status2:set({ src = imgPath(src) })
            watchface.power_status2:clear_flag(lvgl.FLAG.HIDDEN)

            watchface.power_status3:set({ src = imgPath("num10.rle") })
            watchface.power_status3:clear_flag(lvgl.FLAG.HIDDEN)
        elseif index < 100 then
            src = string.format("num%d.rle", index // 10)
            watchface.power_status2:set({ src = imgPath(src) })
            watchface.power_status2:clear_flag(lvgl.FLAG.HIDDEN)

            src = string.format("num%d.rle", index % 10)
            watchface.power_status3:set({ src = imgPath(src) })
            watchface.power_status3:clear_flag(lvgl.FLAG.HIDDEN)

            watchface.power_status4:set({ src = imgPath("num10.rle") })
            watchface.power_status4:clear_flag(lvgl.FLAG.HIDDEN)
        else
            src = string.format("num%d.rle", 1)
            watchface.power_status2:set({ src = imgPath(src) })
            watchface.power_status2:clear_flag(lvgl.FLAG.HIDDEN)

            src = string.format("num%d.rle", 0)
            watchface.power_status3:set({ src = imgPath(src) })
            watchface.power_status3:clear_flag(lvgl.FLAG.HIDDEN)

            src = string.format("num%d.rle", 0)
            watchface.power_status4:set({ src = imgPath(src) })
            watchface.power_status4:clear_flag(lvgl.FLAG.HIDDEN)

            watchface.power_status5:set({ src = imgPath("num10.rle") })
            watchface.power_status5:clear_flag(lvgl.FLAG.HIDDEN)
        end
    end)

    dataman.subscribe("timeHourHigh", watchface.hourH.widget, function(obj, value)
        local src = string.format("num_%d.bin", value // 256)
        obj:set { src = imgPath(src) }
    end)
    dataman.subscribe("timeHourLow", watchface.hourL.widget, function(obj, value)
        local src = string.format("num_%d.bin", value // 256)
        obj:set { src = imgPath(src) }
    end)

    dataman.subscribe("timeMinuteHigh", watchface.minH.widget, function(obj, value)
        local src = string.format("num_%d.bin", value // 256)
        obj:set { src = imgPath(src) }
    end)
    dataman.subscribe("timeMinuteLow", watchface.minL.widget, function(obj, value)
        local src = string.format("num_%d.bin", value // 256)
        obj:set { src = imgPath(src) }
    end)
    dataman.subscribe("timeSecond", root, function(parent, value)
        
        for i = 1, SnowCount do
        
            local obj = parent:Object {
                bg_color = "#e0e0e0",
                bg_opa = math.random(80, 255),
                radius = lvgl.RADIUS_CIRCLE,
                x = math.random(globalWidth),
                y = 0,
                border_width = 0,
                pad_all = 0,
                size = math.random(ShowSizeMin, ShowSizeMax)
            }
            obj:clear_flag(lvgl.FLAG.SCROLLABLE)

            local animPara = {
                run = true,
                start_value = 0,
                end_value = globalHeight - 20,
                duration = math.random(FallDurationMin, FallDurationMax),
                repeat_count = 0,
                path = "linear",
                exec_cb = function(obj, value)
                    obj:set { y = value }
                end,
                done_cb = function(anim, value)
                    value:delete()
                end
            }

            obj:Anim(animPara)
        end        
    end)

    function watchface:move(acc)
        local speed = 4

        local pX = watchface.cat.pos.x - (acc.x * speed)
        local pY = watchface.cat.pos.y + (acc.y * speed)
        local pW = watchface.cat:getImageWidth()
        local pH = watchface.cat:getImageHeight()

        if pX < 0 then pX = 0 end
        if pY < 0 then pY = 0 end
        if pX > globalWidth - pW then pX = globalWidth - pW end
        if pY > globalHeight - pH then pY = globalHeight - pH end

        --watchface.cat.widget:scroll_by { x = pX, y = pY, anim = true }
        watchface.cat.widget:set { x = pX, y = pY }

        watchface.cat.pos.x = pX
        watchface.cat.pos.y = pY
    end

    watchface.cat.widget:add_flag(lvgl.FLAG.CLICKABLE)
    watchface.cat.widget:onevent(lvgl.EVENT.PRESSED, function(obj, code)

		if watchface.catIndex == 0 then
			watchface.catIndex = 1
            watchface.cat.widget:set { src = imgPath("cat_b.bin") }
        else
			watchface.catIndex = 0
            watchface.cat.widget:set { src = imgPath("cat_o.bin") }
		end
	end)

    local t
    local function screenONCb()
        if t then return end

        t = topic.subscribe("sensor_accel", 0, function(topic, status, value)
            if status ~= 0 or not value or #value == 0 then
                return
            end

            local acc = value[1]
            watchface:move(acc)
        end)
        
        t:frequency(50) -- set update interval 50msec
    end

    local function screenOFFCb()
        if t then
            t:unsubscribe()
            t = nil
        end
    end

    screenONCb()

    return screenONCb, screenOFFCb
end

-- execute watchface function
local on, off = entry()

-- subscribe on screen state
-- turn off subscription when screen is off
-- to low down load on MCU and save a battery
function ScreenStateChangedCB(pre, now, reason)
    if pre ~="ON" and now == "ON" then
        on()
    elseif pre == "ON" and now ~= "ON" then
        off()
    end
end

local isShow = false

-- local isFull = {1, 2, 3, 4, 5, 6, 7, 8}
local isFull = {"", "", "", "", "", "", "", ""}

local photoBoardHtml = ""
local photoBoardhead = [[
    <div style="width: 1200px; height: 747px; background: url(achievement/bgphoto.png)">
    <div onclick="hidePhotoWnd" style="margin-top:15px;margin-left: 1100px;width: 80px; height: 80px; background: url(images/icon/close.png)"></div>
    <div style="margin-top:-10px;margin-left: 85px;">
]]
local photoBoardtail = [[</div></div>]]

local tipsTable = {"长大后的派瑞专注工作，小女孩在一旁偷偷看着他。",
                   "小时候的派瑞和小女孩在工坊外面一起玩耍。",
                   "现在的波比忙于整理货仓，无暇顾及小女孩了。",
                   "儿时的波比会经常给小女孩讲好玩的故事。",
                   "罗斯现在经常要忙于打理花草，小女孩只能静静的在一旁看着。",
                   "多年前的午后，罗斯和小女孩在开心的吃着饭团。",
                   "7照片xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                   "8照片xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"}

function showTip(i, mcmlNode)
    local index = tonumber(mcmlNode:GetAttribute("param"))
    local text = tipsTable[index + 1]
    tip(text)
end

function initPhotoBoardHtml()
    local html = ""
    for index = 0, 7 do
        if isFull[index + 1] ~= "" then
            html = html .. [[<span param="]] .. index ..
                       [[" onclick="showTip" style="margin-top:20px;margin-left: 20px;width: 228px; height: 265px; background: url(achievement/photo]] ..
                       isFull[index + 1] .. [[.png)"></span>]]
        else
            html = html ..
                       [[<span style="margin-top:20px;margin-left: 20px;width: 228px; height: 265px; background: url(achievement/photo.png)"></span>]]
        end
    end
    photoBoardHtml = photoBoardhead .. html .. photoBoardtail
end

function initPhotoBoard()
    initPhotoBoardHtml()
    if photoBoard then
        photoBoard:CloseWindow()
        isShow = false
    end
    photoBoard = window(photoBoardHtml, "_ct", -600, -438.5, 1200, 877)
    photoBoard:hide()
    photoBoard:SetDesignResolution(1600, 1169)
end

initPhotoBoard()

function hidePhotoWnd()
    photoBoard:hide()
    isShow = false
end

function togglePhoto()
    if isShow then
        hidePhotoWnd()
    else
        photoBoard:show()
        isShow = true
    end
end
local iconHtml =
    [[<div><div onclick="togglePhoto" style="width: 125px;height: 139px;background: url(achievement/icon.png);"></div></div>]]


registerBroadcastEvent("photo", function(msg)
    icon = window(iconHtml, "_rt", -140, 20, 125, 140)
end)


function checkPhoto()
    for k, v in pairs(isFull) do
        if k ~= v then
            return
        end
    end
    tip("照片收集完毕，箱子可以打开了")
    -- 将宝箱设置为可开启
    -- grey世界卧室里的箱子 更换后需要更新
    local boxEntity = GameLogic.EntityManager.GetEntity("20220525T083323.793140-161")
    if boxEntity then
        boxEntity:SetOnClickEvent("onclickChest")
    end
end

registerBroadcastEvent("clickBox", function(msg)
    if isFull[7] ~= 7 then
        isFull[7] = 7
        isFull[8] = 8
        tip("获得2张照片")
        cmd("/setblock 19262,5,19629 192") -- playMovie
        initPhotoBoard()
        checkPhoto()
    end
end)

registerBroadcastEvent("clickFather", function(msg)
    if isFull[1] ~= 1 then
        isFull[1] = 1
        isFull[2] = 2
        tip("获得2张照片")
        cmd("/setblock 19262,5,19625 192") -- playMovie
        initPhotoBoard()
        checkPhoto()
    end
end)

registerBroadcastEvent("clickCustodian", function(msg)
    if isFull[3] ~= 3 then
        isFull[3] = 3
        isFull[4] = 4
        tip("获得2张照片")
        cmd("/setblock 19262,5,19627 192") -- playMovie
        initPhotoBoard()
        checkPhoto()
    end
end)

registerBroadcastEvent("clickGardener", function(msg)
    if isFull[5] ~= 5 then
        isFull[5] = 5
        isFull[6] = 6
        tip("获得2张照片")
        cmd("/setblock 19262,5,19623 192") -- playMovie
        initPhotoBoard()
        checkPhoto()
    end
end)

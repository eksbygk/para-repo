local isShow = false

function closeDialog2()
    dialog2:CloseWindow()
    isShow = false
end

-- 第一章
local dialogs3 =
    {[[<div style="width: 1834px;height: 337px;background: url(images/father/dialog2.png);"><div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/father/dialog2-1a.png);"></div></div>]],
     [[<div style="width: 1834px;height: 337px;background: url(images/father/dialog2.png);"><div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/father/dialog2-2a.png);"></div></div>]],
     [[<div style="width: 1834px;height: 337px;background: url(images/father/dialog2.png);"><div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/father/dialog2-3a.png);"></div></div>]],
     [[<div style="width: 1834px;height: 337px;background: url(images/father/dialog2.png);"><div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/father/dialog2-4a.png);"></div></div>]]}

function renderDialog3(i, mcmlNode)
    local index = tonumber(mcmlNode:GetAttribute("param"))
    dialog2:CloseWindow()
    dialog3 = window(dialogs3[index], "_ctb", 0, 0, 1834, 337)
    dialog3:SetDesignResolution(1834, 337)
    dialog3:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then
            dialog3:CloseWindow()
            isShow = false
        end
    end)
end

function renderDialog2()
    dialog2 = window([[
        <div style="width: 1834px;height: 337px;background: url(images/father/dialog2.png);">
        <span style="margin-top: 85px;margin-left: 1730px;width:70px;height:70px;background: url(images/icon/close.png);" onclick="closeDialog2"></span>
        <div style="margin-top: -15px;margin-left: 600px;width:270px;height:35px;background: url(images/father/dialog2-1.png);" param="1" onclick="renderDialog3"></div>
        <div style="margin-top: 15px;margin-left: 600px;width:270px;height:35px;background: url(images/father/dialog2-2.png);" param="2" onclick="renderDialog3"></div>
        <div style="margin-top: -85px;margin-left: 900px;width:270px;height:35px;background: url(images/father/dialog2-3.png);" param="3" onclick="renderDialog3"></div>
        <div style="margin-top: -35px;margin-left: 900px;width:270px;height:35px;background: url(images/father/dialog2-4.png);" param="4" onclick="renderDialog3"></div>
    </div>
    ]], "_ctb", 0, 0, 1834, 337)
    dialog2:SetDesignResolution(1834, 337)
end

function renderDialog1()
    if not isShow then
        isShow = true
        dialog1 = window([[
    <div style="width: 1834px;height: 337px;background: url(images/father/dialog1.png);"></div>
]], "_ctb", 0, 0, 1834, 337)
        dialog1:SetDesignResolution(1834, 337)
        dialog1:registerEvent("onmouseup", function(event)
            if (event:button() == "left") then
                dialog1:CloseWindow()
                renderDialog2()
                broadcast("showTasks", "")
            end
        end)
    end
end

-- 第二章
local dialogsS23 =
    {[[<div style="width: 1834px;height: 337px;background: url(images/father/dialog2.png);"><div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/father/dialog02-1a.png);"></div></div>]],
     [[<div style="width: 1834px;height: 337px;background: url(images/father/dialog2.png);"><div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/father/dialog02-2a.png);"></div></div>]],
     [[<div style="width: 1834px;height: 337px;background: url(images/father/dialog2.png);"><div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/father/dialog02-3a.png);"></div></div>]],
     [[<div style="width: 1834px;height: 337px;background: url(images/father/dialog2.png);"><div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/father/dialog02-4a.png);"></div></div>]],
     [[<div style="width: 1834px;height: 337px;background: url(images/father/dialog2.png);"><div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/father/dialog02-5a.png);"></div></div>]]}

function renderDialogS23(i, mcmlNode)
    local index = tonumber(mcmlNode:GetAttribute("param"))
    dialog2:CloseWindow()
    dialog3 = window(dialogsS23[index], "_ctb", 0, 0, 1834, 337)
    dialog3:SetDesignResolution(1834, 337)
    dialog3:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then
            dialog3:CloseWindow()
            isShow = false
        end
    end)
end

function renderDialogS22()
    dialog2 = window([[
        <div style="width: 1834px;height: 337px;background: url(images/father/dialog2.png);">
        <span style="margin-top: 85px;margin-left: 1730px;width:70px;height:70px;background: url(images/icon/close.png);" onclick="closeDialog2"></span>
        <div style="margin-top: -15px;margin-left: 600px;width:270px;height:35px;background: url(images/father/dialog02-1.png);" param="1" onclick="renderDialogS23"></div>
        <div style="margin-top:  15px;margin-left: 600px;width:270px;height:35px;background: url(images/father/dialog02-2.png);" param="2" onclick="renderDialogS23"></div>
        <div style="margin-top: -85px;margin-left: 900px;width:270px;height:35px;background: url(images/father/dialog02-3.png);" param="3" onclick="renderDialogS23"></div>
        <div style="margin-top: -35px;margin-left: 900px;width:270px;height:35px;background: url(images/father/dialog02-4.png);" param="4" onclick="renderDialogS23"></div>
        <div style="margin-top:  15px;margin-left: 600px;width:270px;height:35px;background: url(images/father/dialog02-5.png);" param="5" onclick="renderDialogS23"></div>
    </div>
    ]], "_ctb", 0, 0, 1834, 337)
    dialog2:SetDesignResolution(1834, 337)
end

function renderDialogS2()
    if not isShow then
        isShow = true
        local dialog = window([[
    <div style="width: 1834px;height: 337px;background: url(images/father/dialog4-3.png);"></div>
]], "_ctb", 0, 0, 1834, 337)
        dialog:SetDesignResolution(1834, 337)
        dialog:registerEvent("onmouseup", function(event)
            if (event:button() == "left") then
                dialog:CloseWindow()
                renderDialogS22()
                broadcast("showTasks", "")
            end
        end)
    end
end

-- 第三章
local dialogsS33 =
    {[[<div style="width: 1834px;height: 337px;background: url(images/father/dialog2.png);"><div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/father/dialog03-1a.png);"></div></div>]],
     [[<div style="width: 1834px;height: 337px;background: url(images/father/dialog2.png);"><div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/father/dialog03-2a.png);"></div></div>]],
     [[<div style="width: 1834px;height: 337px;background: url(images/father/dialog03-3a.png);"></div>]]}

local getbook = false
local glass = "blocktemplates/w9.bmax"
function renderDialogS33(i, mcmlNode)
    local index = tonumber(mcmlNode:GetAttribute("param"))
    if not getbook and index == 2 then
        -- 第一次点击送玻璃书籍
        getbook = true
        local taskDeskEntity = GameLogic.EntityManager.GetEntity("workshop_task_desk")
        local subEntity = GameLogic.EntityManager.GetEntity("workshop_task_glass_book")
        if (not subEntity) then
            subEntity = taskDeskEntity:CloneMe()
            subEntity:SetName("workshop_task_glass_book")
            subEntity:SetModelFile(glass)
            subEntity:SetOnClickEvent("onClickBook")
            subEntity:SetCanDrag(true)
            subEntity:EnablePhysics(true)
            subEntity:SetAutoTurningDuringDragging(true)
            subEntity:SetScaling(1)
            local x, y, z = subEntity:GetPosition()
            subEntity:SetPosition(x - 1, y + 3, z)
            subEntity:FallDown()
        end
    end
    dialog2:CloseWindow()
    dialog3 = window(dialogsS33[index], "_ctb", 0, 0, 1834, 337)
    dialog3:SetDesignResolution(1834, 337)
    dialog3:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then
            dialog3:CloseWindow()
            isShow = false
        end
    end)
end

function renderDialogS32()
    dialog2 = window([[
        <div style="width: 1834px;height: 337px;background: url(images/father/dialog2.png);">
        <span style="margin-top: 85px;margin-left: 1730px;width:70px;height:70px;background: url(images/icon/close.png);" onclick="closeDialog2"></span>
        <div style="margin-top:  15px;margin-left: 600px;width:270px;height:35px;background: url(images/father/dialog03-1.png);" param="1" onclick="renderDialogS33"></div>
        <div style="margin-top: -15px;margin-left: 600px;width:270px;height:35px;background: url(images/father/dialog03-2.png);" param="2" onclick="renderDialogS33"></div>
        <div style="margin-top: -15px;margin-left: 600px;width:270px;height:35px;background: url(images/father/dialog03-3.png);" param="3" onclick="renderDialogS33"></div>
    </div>
    ]], "_ctb", 0, 0, 1834, 337)
    dialog2:SetDesignResolution(1834, 337)
end

function renderDialogS3()
    if not isShow then
        isShow = true
        local dialog = window([[<div style="width: 1834px;height: 337px;background: url(images/father/dialog2.png);">
        <div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/father/dialog03aa.png);"></div>
        </div>]], "_ctb", 0, 0, 1834, 337)
        dialog:SetDesignResolution(1834, 337)
        dialog:registerEvent("onmouseup", function(event)
            if (event:button() == "left") then
                dialog:CloseWindow()
                renderDialogS32()
                broadcast("showTasks", "")
            end
        end)
    end
end

local fristClick = true
registerClickEvent(function()
    if fristClick then
        fristClick = false
        cmd("/setblock 19278,5,19648 192") -- 尺子
        cmd("/setblock 19275,5,19648 192") -- 交付物品
        broadcast("newSection", 1) -- 0->1开启后续章节
        cmd("/setblock 19227 8 19558 (0 7 8) 0") -- 解除限制区域
    end
    if _G.section == 0 or _G.section == 1 then
        renderDialog1()
    elseif _G.section == 2 then
        renderDialogS2()
    elseif _G.section == 3 then
        renderDialogS3()
    end
    stopMovie("notice2")
end)


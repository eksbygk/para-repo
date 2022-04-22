local htmlClicked = [[<div style="width: 1834px;height: 337px;background: url(images/custodian/dialog2.png);"></div>]]
local html = [[<div style="width: 1834px;height: 337px;background: url(images/custodian/dialog1.png);"></div>]]
local htmlMouse = [[
    <div style="width: 1834px;height: 337px;background: url(images/custodian/dialog0.png);">
        <div style="margin-top: 200px;margin-left: 500px;width:1134px;height:57px;background: url(images/custodian/mouse1.png);"></div>
    </div>]]
local htmlMouseGot = [[
    <div style="width: 1834px;height: 337px;background: url(images/custodian/dialog0.png);">
        <div style="margin-top: 200px;margin-left: 500px;width:1134px;height:57px;background: url(images/custodian/mouse2.png);"></div>
    </div>]]

-- 捉到老鼠
function renderDialogMouseGot()
    local dialog = window(htmlMouseGot, "_ctb", 0, 0, 1834, 337)
    dialog:SetDesignResolution(1834, 337)
    dialog:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then
            dialog:CloseWindow()
            -- dosomething
            -- 进入动画、移除点击事件等
        end
    end)
end

function renderDialogMouse()
    local dialog = window(htmlMouse, "_ctb", 0, 0, 1834, 337)
    dialog:SetDesignResolution(1834, 337)
    dialog:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then
            dialog:CloseWindow()
            cmd("/setblock 19275,5,19619 192")
        end
    end)
end

function renderDialogClicked()
    local dialog = window(htmlClicked, "_ctb", 0, 0, 1834, 337)
    dialog:SetDesignResolution(1834, 337)
    dialog:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then
            dialog:CloseWindow()
        end
    end)
end

function renderDialog(entity)
    local dialog = window(html, "_ctb", 0, 0, 1834, 337)
    dialog:SetDesignResolution(1834, 337)
    dialog:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then
            dialog:CloseWindow()
            entity:SetOnMountEvent("onMountCustodian")
            renderDialogClicked()
        end
    end)
end

local isGetKey = false
local isGetMouse = false
registerBroadcastEvent("getFood", function(msg)
    -- 此变量设置为空，章节2开始前都不会弹出对话框，点击事件保留
    isGetKey = nil
end)
registerBroadcastEvent("getMouse", function(msg)
    isGetMouse = true
end)
registerBroadcastEvent("onClickCustodian", function(msg)
    stopMovie("notice1")
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        if _G.section == 1 then
            if (isGetKey == false) then
                renderDialog(entity)
                local subEntity = GameLogic.EntityManager.GetEntity(msg.name .. "_key")
                subEntity = entity:CloneMe()
                subEntity:SetName(msg.name .. "_key")
                subEntity:SetModelFile("blocktemplates/k17.bmax")
                subEntity:SetOnClickEvent(nil)
                subEntity:SetScaling(1.27)
                subEntity:SetFacing(95 * 3.14 / 180)
                local x, y, z = subEntity:GetPosition()
                subEntity:SetPosition(x, y + 1, z - 1)
                isGetKey = true
            elseif (isGetKey) then
                renderDialogClicked()
            end
        elseif _G.section == 2 then
            if isGetMouse then
                renderDialogMouseGot()
                entity:SetOnClickEvent(nil)
            else
                renderDialogMouse()
            end
        end
    end
end)

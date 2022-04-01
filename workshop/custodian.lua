function renderDialog2()
    local dialog2 = window([[
    <div style="width: 1834px;height: 337px;background: url(images/dialog3-2.png);"></div>
]], "_ctb", 0, 0, 1834, 337)
    dialog2:SetDesignResolution(1834, 337)
    dialog2:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then
            dialog2:CloseWindow()
            stopMovie("notice1")
        end
    end)
end

function renderDialog1()
    local dialog1 = window([[
    <div style="width: 1834px;height: 337px;background: url(images/dialog3-1.png);"></div>
]], "_ctb", 0, 0, 1834, 337)
    dialog1:SetDesignResolution(1834, 337)
    dialog1:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then
            dialog1:CloseWindow()
            renderDialog2()
        end
    end)
end

local isGetKey = false

registerBroadcastEvent("onClickCustodian", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        renderDialog1()
        if (isGetKey == false) then
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
        end
    end
end)

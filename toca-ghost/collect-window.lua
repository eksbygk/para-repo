local itemHtml = [[<div style="width: 70px;height: 70px;background: url(images/0.png);"></div>]]

local itemsCollected = {[[<div style="width: 70px;height: 70px;background: url(images/1.png);"></div>]],
                        [[<div style="width: 70px;height: 70px;background: url(images/2.png);"></div>]],
                        [[<div style="width: 70px;height: 70px;background: url(images/3.png);"></div>]],
                        [[<div style="width: 70px;height: 70px;background: url(images/4.png);"></div>]]}

local PositionsA = {10, 90, 170, 250}

local itemWindows = {window(itemHtml, "_lt", PositionsA[1], 10, 70, 70),
                     window(itemHtml, "_lt", PositionsA[2], 10, 70, 70),
                     window(itemHtml, "_lt", PositionsA[3], 10, 70, 70),
                     window(itemHtml, "_lt", PositionsA[4], 10, 70, 70)}

registerBroadcastEvent("onclickCollectItem", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local staticTag = commonlib.LoadTableFromString(entity:GetStaticTag())
    if (staticTag and staticTag[1] == "collect") then
        local index = staticTag[2]
        itemWindows[index]:CloseWindow()
        itemWindows[index] = window(itemsCollected[index], "_lt", PositionsA[index], 10, 70, 70)
    end
end)

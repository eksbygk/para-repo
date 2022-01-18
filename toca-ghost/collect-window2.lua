local itemHtml = [[<div style="width: 70px;height: 70px;background: url(images/0.png);"></div>]]

local itemsCollected = {[[<div style="width: 70px;height: 70px;background: url(images/1.png);"></div>]],
                        [[<div style="width: 70px;height: 70px;background: url(images/2.png);"></div>]],
                        [[<div style="width: 70px;height: 70px;background: url(images/3.png);"></div>]],
                        [[<div style="width: 70px;height: 70px;background: url(images/4.png);"></div>]],
                        [[<div style="width: 70px;height: 70px;background: url(images/1.png);"></div>]],
                        [[<div style="width: 70px;height: 70px;background: url(images/2.png);"></div>]],
                        [[<div style="width: 70px;height: 70px;background: url(images/3.png);"></div>]],
                        [[<div style="width: 70px;height: 70px;background: url(images/4.png);"></div>]],
                        [[<div style="width: 70px;height: 70px;background: url(images/1.png);"></div>]],
                        [[<div style="width: 70px;height: 70px;background: url(images/2.png);"></div>]],
                        [[<div style="width: 70px;height: 70px;background: url(images/3.png);"></div>]],
                        [[<div style="width: 70px;height: 70px;background: url(images/4.png);"></div>]],
                        [[<div style="width: 70px;height: 70px;background: url(images/1.png);"></div>]],
                        [[<div style="width: 70px;height: 70px;background: url(images/2.png);"></div>]],
                        [[<div style="width: 70px;height: 70px;background: url(images/3.png);"></div>]],
                        [[<div style="width: 70px;height: 70px;background: url(images/4.png);"></div>]]}

-- 注释掉的是水平排列
-- local PositionsA = {10, 90, 170, 250, 330, 410, 490, 570, 650, 730, 810, 890, 970, 1050, 1130, 1210}
local PositionsA = {10, 90, 170, 250, 330, 410, 490, 570, 10, 90, 170, 250, 330, 410, 490, 570}

-- local itemWindows = {window(itemHtml, "_lt", PositionsA[1], 10, 70, 70),
--                      window(itemHtml, "_lt", PositionsA[2], 10, 70, 70),
--                      window(itemHtml, "_lt", PositionsA[3], 10, 70, 70),
--                      window(itemHtml, "_lt", PositionsA[4], 10, 70, 70),
--                      window(itemHtml, "_lt", PositionsA[5], 10, 70, 70),
--                      window(itemHtml, "_lt", PositionsA[6], 10, 70, 70),
--                      window(itemHtml, "_lt", PositionsA[7], 10, 70, 70),
--                      window(itemHtml, "_lt", PositionsA[8], 10, 70, 70),
--                      window(itemHtml, "_lt", PositionsA[9], 10, 70, 70),
--                      window(itemHtml, "_lt", PositionsA[10], 10, 70, 70),
--                      window(itemHtml, "_lt", PositionsA[11], 10, 70, 70),
--                      window(itemHtml, "_lt", PositionsA[12], 10, 70, 70),
--                      window(itemHtml, "_lt", PositionsA[13], 10, 70, 70),
--                      window(itemHtml, "_lt", PositionsA[14], 10, 70, 70),
--                      window(itemHtml, "_lt", PositionsA[15], 10, 70, 70),
--                      window(itemHtml, "_lt", PositionsA[16], 10, 70, 70)}

local itemWindows = {window(itemHtml, "_lt", PositionsA[1], 10, 70, 70),
                     window(itemHtml, "_lt", PositionsA[2], 10, 70, 70),
                     window(itemHtml, "_lt", PositionsA[3], 10, 70, 70),
                     window(itemHtml, "_lt", PositionsA[4], 10, 70, 70),
                     window(itemHtml, "_lt", PositionsA[5], 10, 70, 70),
                     window(itemHtml, "_lt", PositionsA[6], 10, 70, 70),
                     window(itemHtml, "_lt", PositionsA[7], 10, 70, 70),
                     window(itemHtml, "_lt", PositionsA[8], 10, 70, 70),
                     window(itemHtml, "_lt", PositionsA[1], 90, 70, 70),
                     window(itemHtml, "_lt", PositionsA[2], 90, 70, 70),
                     window(itemHtml, "_lt", PositionsA[3], 90, 70, 70),
                     window(itemHtml, "_lt", PositionsA[4], 90, 70, 70),
                     window(itemHtml, "_lt", PositionsA[5], 90, 70, 70),
                     window(itemHtml, "_lt", PositionsA[6], 90, 70, 70),
                     window(itemHtml, "_lt", PositionsA[7], 90, 70, 70),
                     window(itemHtml, "_lt", PositionsA[8], 90, 70, 70)}

registerBroadcastEvent("onclickCollectItem", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local staticTag = commonlib.LoadTableFromString(entity:GetStaticTag())
    if (staticTag and staticTag[1] == "collect") then
        local index = staticTag[2]
        itemWindows[index]:CloseWindow()
        if (index <= 8) then
            itemWindows[index] = window(itemsCollected[index], "_lt", PositionsA[index], 10, 70, 70)
        else
            itemWindows[index] = window(itemsCollected[index], "_lt", PositionsA[index], 90, 70, 70)
        end
    end
end)

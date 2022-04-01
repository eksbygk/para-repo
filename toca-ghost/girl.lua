-- 点击 小女孩的照片
local itemNum = 0
local index = 1
registerBroadcastEvent("itemNum", function(msg)
    itemNum = msg
    if (itemNum == 12) then
        playMovie("task", 0, -1);
        index = 2
    elseif (itemNum == 16) then
        playMovie("task", 0, -1);
        index = 3
    elseif (itemNum == 20) then
        playMovie("task", 0, -1);
        index = 4
    end
end)

local pics = {[[<div style="width: 800px;height: 800px;background: url(images/end1.png);"></div>]],
              [[<div style="width: 800px;height: 800px;background: url(images/end2.png);"></div>]],
              [[<div style="width: 800px;height: 800px;background: url(images/end3.png);"></div>]],
              [[<div style="width: 800px;height: 800px;background: url(images/end4.png);"></div>]]}

registerBroadcastEvent("onClickShowPic", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        if (index == 2) then
            entity:PutOnCustomCharItem("88002")
        elseif (index == 4) then
            entity:PutOnCustomCharItem("88011")
        end
        stopMovie("task")
        local pic = window(pics[index], "_ct", -400, -400, 800, 800)
        pic:registerEvent("onmouseup", function(event)
            if (event:button() == "left") then
                pic:CloseWindow()
            end
        end)
    end
end)

local replacedItemId = entity:PutOnCustomCharItem(itemId)

html1 = [[<div style="width: 1834px;height: 337px;background: url(images/robot/robot1.png);"></div>]]
html2 = [[<div style="width: 1834px;height: 337px;background: url(images/robot/robot2.png);"></div>]]
html = html1
local flag = true

function renderDialog()
    local dialog = window(html, "_ctb", 0, 0, 1834, 337)
    dialog:SetDesignResolution(1834, 337)
    dialog:registerEvent("onmouseup", function(event)
        if (event:button() == "left") then
            dialog:CloseWindow()
            if flag then
                cmd("/setblock 19338,5,19544 192")
                say("游戏开始！请控制方向拿到电池")
            end
        end
    end)
end

local robotEntity = {}
registerBroadcastEvent("gameWin1", function(msg)
    robotEntity:SetOnMountEvent("onMountIdentify")
    html = html2
    flag = false
    say("鉴定机已经可以使用了，请试试看吧", 4)
end)

registerBroadcastEvent("onClickRobot", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        cmd("/camera roomview") -- 取消视角限制
        robotEntity = entity
        -- do something
        renderDialog()
    end
end)

local isFull = {"", "", "", "", "", "", "", "", "", "", "", ""}

local taskBoardHtml = ""
local taskBoardhead = [[<div style="width: 1200px; height: 877px; background: url(achievement/bg.png)">
<div onclick="hideTaskWnd" style="margin-top:70px;margin-left: 1050px;width: 80px; height: 80px; background: url(images/icon/close.png)"></div>
<div style="margin-top:70px;margin-left: 65px;">]]
local taskBoardtail = [[</div></div>]]

function initTaskBoardHtml()
    local html = ""
    for index = 0, 11 do
        -- if isFull[index + 1] == "f" then
        --     html =
        --         html .. [[<span style="margin-left: 12px;width: 166px; height: 265px; background: url(achievement/]] ..
        --             index .. isFull[index + 1] .. [[.png)"></span>]]
        -- else
        --     html = html .. [[<span param="]] .. index ..
        --                [[" onclick="showTip" style="margin-left: 12px;width: 166px; height: 265px; background: url(achievement/]] ..
        --                index .. isFull[index + 1] .. [[.png)"></span>]]
        -- end
        html = html .. [[<span param="]] .. index ..
                   [[" onclick="showTip" style="margin-left: 12px;width: 166px; height: 265px; background: url(achievement/]] ..
                   index .. isFull[index + 1] .. [[.png)"></span>]]
    end
    taskBoardHtml = taskBoardhead .. html .. taskBoardtail
end

local isShow = false -- 成就界面的显示
function initTaskBoard()
    initTaskBoardHtml()
    if taskBoard then
        taskBoard:CloseWindow()
        isShow = false
    end
    taskBoard = window(taskBoardHtml, "_ct", -600, -438.5, 1200, 877)
    taskBoard:hide()
    taskBoard:SetDesignResolution(1600, 1169)
end

initTaskBoard()

-- 成就部分 四叶草
local leafNum = 0
registerBroadcastEvent("leafNum", function(msg)
    leafNum = leafNum + 1
    if leafNum == 2 then
        isFull[1] = "f"
        tip("获得成就：你从哪来")
        initTaskBoard()
    elseif leafNum == 4 then
        isFull[2] = "f"
        tip("获得成就：找到你了")
        initTaskBoard()
    elseif leafNum == 6 then
        isFull[3] = "f"
        tip("获得成就：给你幸运")
        initTaskBoard()
    elseif leafNum == 8 then
        isFull[4] = "f"
        tip("获得成就：最佳拍档")
        initTaskBoard()
    end
end)

-- 成就部分 园艺鉴赏
registerBroadcastEvent("gardening1", function(msg)
    if isFull[5] ~= "f" then
        isFull[5] = "f"
        tip("获得成就：园艺鉴赏")
        initTaskBoard()
    end
end)

-- 成就部分 园艺美学
registerBroadcastEvent("gardening2", function(msg)
    if isFull[6] ~= "f" then
        isFull[6] = "f"
        tip("获得成就：园艺美学")
        initTaskBoard()
    end
end)

-- 成就部分 在线时间
local onlineTime = 0
registerBroadcastEvent("onlineTime", function(msg)
    onlineTime = onlineTime + 1
    if onlineTime == 1 then
        isFull[7] = "f"
        tip("获得成就：用力思考")
        initTaskBoard()
    elseif onlineTime == 2 then
        isFull[8] = "f"
        tip("获得成就：拼命探索")
        initTaskBoard()
    end
end)

-- 成就部分 点击查看描述
local clickCount = 0
registerBroadcastEvent("clickTip", function(msg)
    clickCount = clickCount + 1
    if clickCount == 5 then
        isFull[9] = "f"
        tip("获得成就：刨根问底")
        initTaskBoard()
    elseif clickCount == 10 then
        isFull[10] = "f"
        tip("获得成就：孜孜不倦")
        initTaskBoard()
    end
end)

-- 成就部分 蛋糕
registerBroadcastEvent("cake", function(msg)
    if isFull[11] ~= "f" then
        isFull[11] = "f"
        tip("获得成就：甜食专家")
        initTaskBoard()
    end
end)

-- 成就部分 礼盒
registerBroadcastEvent("giftBox", function(msg)
    if isFull[12] ~= "f" then
        isFull[12] = "f"
        tip("获得成就：珍贵礼盒")
        initTaskBoard()
    end
end)

local tipsTable = {"当玩家收集2片四叶草时获得：你从哪来",
                   "当玩家收集4片四叶草时获得：找到你了",
                   "当玩家收集6片四叶草时获得：给你幸运",
                   "当玩家收集齐全8片四叶草时获得：最佳拍档",
                   "当玩家合成了1个最高等级的花草时获得：园艺鉴赏",
                   "当玩家合成了1个最大草团时获得：园艺美学",
                   "当玩家在世界中体验的时长达到30分钟时获得：用力思考",
                   "当玩家在世界中体验的时长达到60分钟时获得：拼命探索",
                   "当玩家在世界中查看物品描述达到50次时获得：刨根问底",
                   "当玩家在世界中查看物品描述达到100次时获得：孜孜不倦 ",
                   "当玩家制作了1个蛋糕时获得：甜食专家",
                   "当玩家包装好了1个蛋糕礼盒时获得：珍贵礼盒"}

function showTip(i, mcmlNode)
    local index = tonumber(mcmlNode:GetAttribute("param"))
    local text = ""
    if isFull[index + 1] == "f" then
        text = tipsTable[index + 1] .. "（已完成）"
    else
        text = tipsTable[index + 1]
    end
    tip(text)
end

function hideTaskWnd()
    taskBoard:hide()
    isShow = false
end

function toggleTask()
    if isShow then
        hideTaskWnd()
    else
        taskBoard:show()
        isShow = true
    end
end

local iconHtml =
    [[<div onclick="toggleTask" style="width: 80px;height: 80px;background: url(achievement/achievement.png);"></div>]]

local icon = window(iconHtml, "_lt", 50, 110, 80, 80)

-- icon:registerEvent("onmouseup", function(event)
--     if (event:button() == "left") then
--         if isShow then
--             hideTaskWnd()
--         else
--             taskBoard:show()
--             isShow = true
--         end
--     end
-- end)

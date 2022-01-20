---------------------------------------
-- 闲置代码收集处
---------------------------------------
local function OnClickTest()
    print(12345)
end

local beginBtn = window(
    [[<div style="width: 100px;height: 100px;background: url(images/1.png);" onclick="OnClickTest"></div>]], "_ct", 50,
    50, 100, 100)

for k, v in pairs(entity) do
    print(v)
end

-- split
function split(str, sep)
    local res = {}
    if sep == nil then
        sep = "%s"
    end
    for s in string.gmatch(str, "([^" .. sep .. "]+)") do
        table.insert(res, s)
    end
    return res
end

local str = "abc,123,345"

local tab = split(str, ",")
for k, v in ipairs(tab) do
    print(k, v)
end

registerBroadcastEvent("onFoodDragEnd", function(msg)
    msg = commonlib.totable(msg)
    if (msg.targetName) then
        local targetEntity = GameLogic.EntityManager.GetEntity(msg.targetName)
        if (targetEntity) then
            targetEntity:Say("good yellow pie!")
        end
    end
end)

-- 拖拽结束 可能不需要
registerBroadcastEvent("onFoodDragEnd", function(msg)
    msg = commonlib.totable(msg)
    local foodEntity = GameLogic.EntityManager.GetEntity(msg.name)
    local foodTagTable = split(foodEntity:GetStaticTag(), ',')
    if (msg.targetName) then
        local targetEntity = GameLogic.EntityManager.GetEntity(msg.targetName)
        local targetTag = targetEntity:GetStaticTag()
        -- 是熟食，才进行一系列判断
        if (targetEntity) then
            if (foodTagTable[1] == 'food_cooked' and foodTagTable[2] == targetTag) then
                -- 给对了
                targetEntity:Say("Good!")
            else
                targetEntity:Say("Not this!")
            end
        end
    end
end)

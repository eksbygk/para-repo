-- split
function split(str, sep)
    local res = {}
    if str ~= nil then
        if sep == nil then
            sep = "%s"
        end
        for s in string.gmatch(str, "([^" .. sep .. "]+)") do
            table.insert(res, s)
        end
    end
    return res
end

-- 切菜 菜刀拖拽结束事件
registerBroadcastEvent("onEndDragKnife", function(msg)
    msg = commonlib.totable(msg)
    if (msg.targetName) then
        local targetEntity = GameLogic.EntityManager.GetEntity(msg.targetName)
        local vegetableName = targetEntity:GetModelFile()
        if (targetEntity) then
            local targetTag = targetEntity:GetStaticTag()
            if (targetTag == 'vegetable') then
                local cutFileName = vegetableName:gsub("(%.%w+)$", "_cut%1")
                targetEntity:SetModelFile(cutFileName)
                targetEntity:SetStaticTag('cut')
            end
        end
    end
end)

-- 点击事件for Can 鱼罐头变为鱼，不可复用
registerBroadcastEvent("onClickReplace4Can", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if entity then
        entity:SetModelFile('blocktemplates/c6.bmax')
        entity:SetStaticTag('food,a6,11')
    end
end)

-- 锅里的物体名字
local foodEntityName = ''
-- 第2个静态属性（表示与NPC交换得到的新物体文件名）,会存到烤熟的物体中
local newEntityName = ''
-- 第3个静态属性（表示收集品的索引）,会存到烤熟的物体中
local collectIndex = ''

-- 烤鱼 平底锅插件点事件
registerBroadcastEvent("onMountCooking", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if entity then
        -- local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
        local mountedEntityTag = GameLogic.EntityManager.GetEntity(msg.mountedEntityName):GetStaticTag()
        local tagTable = split(mountedEntityTag, ",")
        if (tagTable[1] == 'food') then
            foodEntityName = msg.mountedEntityName
            newEntityName = tagTable[2]
            collectIndex = tagTable[3]
        end
    end
end)

-- 点击-> 点火+烤鱼 
local fireModelFile = "character/CC/05effect/fire.x"
registerBroadcastEvent("onclickFireOnStove", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        if (entity.tag == "open") then
            entity.tag = "close"
        else
            entity.tag = "open"
        end
        local subEntity = GameLogic.EntityManager.GetEntity(msg.name .. "_fire")
        if (entity.tag == "open") then
            playSound("shao.mp3")
            -- 创建火模型
            if (not subEntity) then
                subEntity = entity:CloneMe()
                subEntity:SetName(msg.name .. "_fire")
                subEntity:SetModelFile(fireModelFile)
                subEntity:SetOnClickEvent(nil)
                subEntity:SetCanDrag(false)
                subEntity:EnablePhysics(false)
                subEntity:SetScaling(1)
                subEntity:SetFacing(subEntity:GetFacing() + math.pi)
                local x, y, z = subEntity:GetPosition()
                -- subEntity.SetScale(10)
                subEntity:SetPosition(x, y, z)
            end

            -- 替换食物模型（变为已烤熟），放进锅里时保存，移走也会替换
            if (foodEntityName) then
                local foodEntity = GameLogic.EntityManager.GetEntity(foodEntityName)
                if (foodEntity) then
                    local foodFilename = foodEntity:GetModelFile()
                    local cookedFileName = foodFilename:gsub("(%.%w+)$", "_cooked%1")
                    wait(0.5)
                    foodEntity:SetModelFile(cookedFileName)
                    foodEntity:SetOnEndDragEvent('onFoodDragEnd')
                    local foodStaticTag = 'food_cooked'
                    if (newEntityName) then
                        foodStaticTag = foodStaticTag .. ',' .. newEntityName
                        if collectIndex then
                            foodStaticTag = foodStaticTag .. ',' .. collectIndex
                        end
                        foodEntity:SetStaticTag(foodStaticTag)
                        -- 对鸡蛋模型的特殊处理（鸡蛋属性是food,e37,19）
                        if (newEntityName == 'e37') then
                            foodEntity:SetScaling(1)
                        end
                    else
                        foodEntity:SetStaticTag('food_cooked')
                    end
                    foodEntityName = ''
                end
            end
        else
            if (subEntity) then
                subEntity:Destroy()
                stopSound("shao.mp3")
            end
        end
    end
end)

-- 灶台的火(旧的方法，暂时没用)
local fireModelFile = "character/CC/05effect/fire.x"
registerBroadcastEvent("onclickFireOnStove1", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        if (entity.tag == "open") then
            entity.tag = "close"
        else
            entity.tag = "open"
        end
        local subEntity = GameLogic.EntityManager.GetEntity(msg.name .. "_fire")

        if (entity.tag == "open") then
            if (not subEntity) then
                subEntity = entity:CloneMe()
                subEntity:SetName(msg.name .. "_fire")
                subEntity:SetModelFile(fireModelFile)
                subEntity:SetOnClickEvent(nil)
                subEntity:SetCanDrag(false)
                subEntity:EnablePhysics(false)
                subEntity:SetScaling(1)
                subEntity:SetFacing(subEntity:GetFacing() + math.pi)
                local x, y, z = subEntity:GetPosition()
                -- subEntity.SetScale(10)
                subEntity:SetPosition(x, y, z)
            end
        else
            if (subEntity) then
                subEntity:Destroy()
            end
        end
    end
end)

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

-- 点击事件for Can 鱼罐头变为鱼，不可复用
registerBroadcastEvent("onClickReplace4Can", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if entity then
        entity:SetModelFile('blocktemplates/c6.bmax')
        entity:SetStaticTag('food')
    end
end)

-- 锅里的物体名字
local foodEntityName = ''
-- 第二个静态属性（表示食物的类别）,会存到烤熟的物体中
local foodCategory = ''

-- 烤鱼
registerBroadcastEvent("onMountCooking", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if entity then
        -- local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
        local mountedEntityTag = GameLogic.EntityManager.GetEntity(msg.mountedEntityName):GetStaticTag()
        local tagTable = split(mountedEntityTag, ",")
        if (tagTable[1] == 'food') then
            foodEntityName = msg.mountedEntityName
            foodCategory = tagTable[2]
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
                    if foodCategory then
                        foodEntity:SetStaticTag('food_cooked,' .. foodCategory)
                    else
                        foodEntity:SetStaticTag('food_cooked')
                    end
                    foodEntityName = ''
                end
            end
        else
            if (subEntity) then
                subEntity:Destroy()
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

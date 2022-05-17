function Pouring(hoverEntity)
    run(function()
        if (not hoverEntity.isPouring) then
            hoverEntity.isPouring = true
            if (hoverEntity:IsAutoTurningDuringDragging()) then
                hoverEntity:SetFacing(entity:GetFacing())
            end
            for i = 1, 10 do
                hoverEntity:SetPitch(-i / 10 * math.pi / 2)
                wait(0.03)
            end
            for i = 10, 0, -1 do
                hoverEntity:SetPitch(-i / 10 * math.pi / 2)
                wait(0.03)
            end
            hoverEntity.isPouring = nil;
            return
        end
    end)
end

local egg = "blocktemplates/c3.bmax"
local materialTable = {
    ["blocktemplates/c14.bmax"] = "suger", -- 砂糖
    ["blocktemplates/c2.bmax"] = "flour", -- 面粉
    ["blocktemplates/c13.bmax"] = "milk", -- 牛奶 1
    ["blocktemplates/c12.bmax"] = "milk" -- 牛奶 2
}

local bowl = "blocktemplates/c4.bmax"

local bowlSemi = {
    -- 半成品
    filename = "blocktemplates/c17.bmax",
    spec = "半成品的面糊"
}
local bowlFinished = {
    filename = "blocktemplates/c16.bmax",
    spec = "制作好的面糊(可以放进烤箱了)"
}

-- cakeStatus 半成品状态，1.面粉 2.糖 3.鸡蛋 4.任一种牛奶
function setCakeStatus(entity, materialName)
    -- 模型变为半成品面糊
    if entity.filename == bowl then
        entity:SetModelFile(bowlSemi.filename)
        entity.tag = bowlSemi.spec
    end
    if not entity.cakeStatus[materialName] then
        entity.cakeStatus[materialName] = true
        entity:Say("合适的材料", 1)
        if entity.cakeStatus["flour"] and entity.cakeStatus["suger"] and entity.cakeStatus["egg"] and
            entity.cakeStatus["milk"] then
            -- all true 模型变为成品面糊，移除事件
            entity:SetModelFile(bowlFinished.filename)
            entity.tag = bowlFinished.spec
            entity.cakeStatus = nil
            entity:SetOnHoverEvent(nil)
            entity:SetOnMountEvent(nil)
        end
    end
end

-- Hover
registerBroadcastEvent("onHoverCake", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local hoverEntity = GameLogic.EntityManager.GetEntity(msg.hoverEntityName)
    if (entity and hoverEntity) then
        if not entity.cakeStatus then
            entity.cakeStatus = {
                ["flour"] = false,
                ["suger"] = false,
                ["egg"] = false,
                ["milk"] = false
            }
        end
        local hoverFileName = hoverEntity.filename
        local materialName = materialTable[hoverFileName]
        if materialName then
            Pouring(hoverEntity)
            setCakeStatus(entity, materialName)
        end
    end
end)

-- Mount
registerBroadcastEvent("onMountCake", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
    if (entity and mountedEntity) then
        if not entity.cakeStatus then
            entity.cakeStatus = {
                ["flour"] = false,
                ["suger"] = false,
                ["egg"] = false,
                ["milk"] = false
            }
        end
        local mountedFilename = mountedEntity.filename
        if mountedFilename == egg and not entity.cakeStatus["egg"] then
            setCakeStatus(entity, "egg")
            mountedEntity:Destroy()
        else
            entity:Say("不需要加入这个物品", 1)
        end
    end
end)

-- 开宝箱
local boxItemTable = {
    ["blocktemplates/b16-2.bmax"] = {
        -- 铜宝箱 开出粉红方块
        key = "blocktemplates/j25.bmax",
        boxOpen = "blocktemplates/b16-1.bmax",
        inner = {
            filename = "blocktemplates/j3.bmax",
            spec = "淡红方块(未鉴定物品)",
            scaling = 0.6,
            clickEvent = "showTag"
        }
    },
    ["blocktemplates/g21-2.bmax"] = {
        -- 金宝箱 开出四叶草
        key = "blocktemplates/h14.bmax",
        boxOpen = "blocktemplates/g21-1.bmax",
        inner = {
            filename = "blocktemplates/j13.bmax",
            scaling = 0.7,
            clickEvent = "onClickLeaf"
        }
    }
}

registerBroadcastEvent("onMountBox", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
    if (entity and mountedEntity) then
        local filename = entity.filename
        local mountedFilename = mountedEntity.filename
        if boxItemTable[filename] and boxItemTable[filename].key == mountedFilename then
            mountedEntity:Destroy()
            entity:SetModelFile(boxItemTable[filename].boxOpen)
            local subEntity = GameLogic.EntityManager.GetEntity(msg.name .. "_inner")
            if (not subEntity) then
                subEntity = entity:CloneMe()
                subEntity:SetName(msg.name .. "_inner")
                subEntity:SetModelFile(boxItemTable[filename].inner.filename)
                subEntity.tag = boxItemTable[filename].inner.spec or nil
                subEntity:SetOnClickEvent(boxItemTable[filename].inner.clickEvent or nil)
                subEntity:SetCanDrag(true)
                subEntity:EnablePhysics(true)
                subEntity:SetScaling(boxItemTable[filename].inner.scaling or 1)
                local x, y, z = subEntity:GetPosition()
                subEntity:SetPosition(x, y + 2, z)
                subEntity:FallDown()
                subEntity:LinkTo(entity)

                entity:SetOnClickEvent("onclickBox")
                entity.tag = nil
            end
        end
    end
end)

-- 开启之后 不需要钥匙 
local models = {
    open = "blocktemplates/g21-1.bmax",
    close = "blocktemplates/g21-2.bmax"

}

local boxToggleTable = {
    -- 铜箱子
    ["blocktemplates/b16-1.bmax"] = "blocktemplates/b16-2.bmax",
    ["blocktemplates/b16-2.bmax"] = "blocktemplates/b16-1.bmax",
    -- 金箱子
    ["blocktemplates/g21-1.bmax"] = "blocktemplates/g21-2.bmax",
    ["blocktemplates/g21-2.bmax"] = "blocktemplates/g21-1.bmax"
}

registerBroadcastEvent("onclickBox", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        local filename = entity:GetModelFile()
        if boxToggleTable[filename] then
            entity:SetModelFile(boxToggleTable[filename])
        end
    end
end)

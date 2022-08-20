local cakeRoll = "blocktemplates/n7.bmax"
local cakeTriangle = "blocktemplates/n1.bmax"

local knife = "blocktemplates/g11.bmax" -- 小刀形态的瑞士军刀
local boxEmpty = "blocktemplates/n4.bmax" -- 空盒子
local ribbon = {
    -- 包装用的丝带
    filename = "blocktemplates/m30.bmax",
    spec = "两条装饰彩带(用于礼盒包装)"
}
local boxRoll = {
    -- 只有蛋糕卷
    filename = "blocktemplates/n6.bmax",
    spec = "少了一块蛋糕的礼盒"
}
local boxTriangle = {
    filename = "blocktemplates/n5.bmax",
    spec = "少了一块蛋糕的礼盒"
} -- 只有三角蛋糕
local boxFull = {
    filename = "blocktemplates/n3.bmax",
    spec = "完整的蛋糕礼盒(需要包装好)"
}
local giftBox = {
    filename = "blocktemplates/n2.bmax",
    spec = "包装好的蛋糕礼盒(快去送给老爷爷吧！)"
}

local cakeBoxTable = {
    [boxEmpty] = {
        [cakeRoll] = {
            filename = boxRoll.filename,
            spec = boxRoll.spec
        },
        [cakeTriangle] = {
            filename = boxTriangle.filename,
            spec = boxTriangle.spec
        }

    },
    [boxRoll.filename] = {
        [cakeTriangle] = {
            filename = boxFull.filename,
            spec = boxFull.spec
        }
    },
    [boxTriangle.filename] = {
        [cakeRoll] = {
            filename = boxFull.filename,
            spec = boxFull.spec
        }
    },
    [boxFull.filename] = {
        [ribbon.filename] = {
            filename = giftBox.filename,
            spec = giftBox.spec
        }
    }
}

-- Mount
registerBroadcastEvent("onMountCakeBox", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
    if (entity and mountedEntity) then
        local filename = entity.filename
        local mountedFilename = mountedEntity.filename

        if cakeBoxTable[filename] and cakeBoxTable[filename][mountedFilename] then
            local newBox = cakeBoxTable[filename][mountedFilename]
            mountedEntity:Destroy()
            entity:SetModelFile(newBox.filename)
            entity.tag = newBox.spec
            if newBox.filename == giftBox.filename then
                entity:SetOnMountEvent(nil)
                broadcast("giftBox", "")
            end
        end
    end
end)

-- Mount
registerBroadcastEvent("onMountRibbon", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
    if (entity and mountedEntity) then
        local mountedFile = mountedEntity.filename
        if mountedFile == knife then
            entity:SetModelFile(ribbon.filename)
            entity.tag = ribbon.spec
            entity:SetScaling(0.78)
            entity:SetOnMountEvent(nil)
        end
    end
end)

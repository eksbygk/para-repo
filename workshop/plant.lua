-- 一袋种子->花籽
local seedFileName = {
    ["blocktemplates/w6.bmax"] = {
        filename = "blocktemplates/w29.bmax"
    },
    ["blocktemplates/w7.bmax"] = {
        filename = "blocktemplates/w27.bmax"
    },
    ["blocktemplates/w8.bmax"] = {
        filename = "blocktemplates/w28.bmax"
    }
}

-- 花籽->花苗
local budFileName = {
    ["blocktemplates/w29.bmax"] = {
        filename = "blocktemplates/w22.bmax"
    },
    ["blocktemplates/w27.bmax"] = {
        filename = "blocktemplates/w21.bmax"
    },
    ["blocktemplates/w28.bmax"] = {
        filename = "blocktemplates/w20.bmax"
    }
}

-- 花苗->花卉
local flowerFileName = {
    ["blocktemplates/w22.bmax"] = {
        filename = "blocktemplates/w32.bmax"
    },
    ["blocktemplates/w21.bmax"] = {
        filename = "blocktemplates/w30.bmax"
    },
    ["blocktemplates/w20.bmax"] = {
        filename = "blocktemplates/w31.bmax"
    }
}

local fieldFilename = "blocktemplates/w23.bmax" -- 田地
local wateringpotFilename = "blocktemplates/w25.bmax" -- 水壶
local fertilizerFilename = "blocktemplates/m4.bmax" -- 肥料

function createSeed(entity, hoverEntity)
    echo(entity)
    if entity.filename == fieldFilename then
        local seedEntity = GameLogic.EntityManager.GetEntity(entity.name .. "_seed")
        local budEntity = GameLogic.EntityManager.GetEntity(entity.name .. "_seed_bud")
        local flowerEntity = GameLogic.EntityManager.GetEntity(entity.name .. "_seed_bud_flower")
        if not seedEntity and not budEntity and not flowerEntity then
            seedEntity = entity:CloneMe()
            seedEntity:SetName(entity.name .. "_seed")
            seedEntity:SetModelFile(seedFileName[hoverEntity.filename].filename)
            seedEntity:SetOnClickEvent(nil)
            seedEntity:SetCanDrag(false)
            seedEntity:EnablePhysics(false)
            seedEntity:SetScaling(0.6)
            local x, y, z = entity:GetPosition()
            seedEntity:SetPosition(x, y + 0.1, z)
        end
    end
end

function replaceToBud(entity, hoverEntity)
    local subEntity = {}
    local newSubEntityName = ""
    -- entity is field
    if entity.filename == fieldFilename then
        subEntity = GameLogic.EntityManager.GetEntity(entity.name .. "_seed")
        newSubEntityName = entity.name .. "_seed_bud"
        if subEntity then
            local newSubEntityFileName = budFileName[subEntity.filename].filename
            subEntity:SetModelFile(newSubEntityFileName)
            subEntity:SetName(newSubEntityName)
            subEntity:SetScaling(1.2)
        end

    end
    -- entity is seed
    if budFileName[entity.filename] then
        subEntity = GameLogic.EntityManager.GetEntity(entity.name)
        newSubEntityName = entity.name .. "_bud"
        if subEntity then
            local newSubEntityFileName = budFileName[entity.filename].filename
            subEntity:SetModelFile(newSubEntityFileName)
            subEntity:SetName(newSubEntityName)
            subEntity:SetScaling(1.2)
        end
    end

end

function replaceToFlower(entity, hoverEntity)
    local subEntity = {}
    local newSubEntityName = ""
    if entity.filename == fieldFilename then
        -- entity is field
        subEntity = GameLogic.EntityManager.GetEntity(entity.name .. "_seed_bud")
        newSubEntityName = entity.name .. "_seed_bud_flower"
        if subEntity then
            local newSubEntityFileName = flowerFileName[subEntity.filename].filename
            subEntity:SetModelFile(newSubEntityFileName)
            subEntity:SetName(newSubEntityName)
            subEntity:SetScaling(1.5)
            subEntity:SetCanDrag(true)
            life = hoverEntity:GetStaticTag()
            if (life ~= 1) then
                hoverEntity:SetStaticTag(life - 1)
            else
                hoverEntity:Destroy()
                subEntity:Say("肥料已经被消耗了")
            end
        end
    end
    -- entity is bud
    if flowerFileName[entity.filename] then
        subEntity = GameLogic.EntityManager.GetEntity(entity.name)
        newSubEntityName = entity.name .. "_bud_flower"
        if subEntity then
            local newSubEntityFileName = flowerFileName[entity.filename].filename
            subEntity:SetModelFile(newSubEntityFileName)
            subEntity:SetName(newSubEntityName)
            subEntity:SetScaling(1.5)
            subEntity:SetCanDrag(true)
            life = hoverEntity:GetStaticTag()
            if (life ~= 1) then
                hoverEntity:SetStaticTag(life - 1)
            else
                hoverEntity:Destroy()
                subEntity:Say("肥料已经被消耗了")
            end
        end
    end
    -- entity is seed
    if budFileName[entity.filename] then
        subEntity = GameLogic.EntityManager.GetEntity(entity.name)
        subEntity:Say("我需要浇水！")
    end
end

registerBroadcastEvent("onHoverField", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local hoverEntity = GameLogic.EntityManager.GetEntity(msg.hoverEntityName)
    if (entity and hoverEntity) then
        -- Pouring, check filename match seed filename 
        hoverFileName = hoverEntity:GetModelFile()
        if (hoverFileName == fertilizerFilename or seedFileName[hoverFileName]) then
            run(function()
                if (not hoverEntity.isPouring) then
                    hoverEntity.isPouring = true
                    if (hoverEntity:IsAutoTurningDuringDragging()) then
                        hoverEntity:SetFacing(entity:GetFacing())
                    end
                    for i = 1, 10 do
                        hoverEntity:SetPitch(-i / 10 * math.pi / 2)
                        wait(0.01)
                    end
                    for i = 10, 0, -1 do
                        hoverEntity:SetPitch(-i / 10 * math.pi / 2)
                        wait(0.01)
                    end
                    hoverEntity.isPouring = nil;
                    return
                end
            end)
            if hoverFileName ~= fertilizerFilename then
                -- plant
                createSeed(entity, hoverEntity)
            else
                -- 化肥
                replaceToFlower(entity, hoverEntity)
            end
        end
        -- watering pot
        if hoverFileName == wateringpotFilename then
            replaceToBud(entity, hoverEntity)
        end
    end
end)

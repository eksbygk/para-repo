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
        playSound("music/bj.mp3")
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
        playSound("music/jjj.mp3")
        subEntity = GameLogic.EntityManager.GetEntity(entity.name .. "_seed")
        newSubEntityName = entity.name .. "_seed_bud"
        if subEntity and budFileName[subEntity.filename] then
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
        playSound("music/bj.mp3")
        -- entity is field
        subEntity = GameLogic.EntityManager.GetEntity(entity.name .. "_seed_bud")
        newSubEntityName = entity.name .. "_seed_bud_flower"
        if subEntity and flowerFileName[subEntity.filename] then
            local newSubEntityFileName = flowerFileName[subEntity.filename].filename
            subEntity:SetModelFile(newSubEntityFileName)
            subEntity:SetName(newSubEntityName)
            subEntity:SetScaling(1.5)
            subEntity:SetCanDrag(true)
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
        end
    end
    -- entity is seed
    if budFileName[entity.filename] then
        subEntity = GameLogic.EntityManager.GetEntity(entity.name)
        subEntity:Say("我需要浇水！")
    end
end

-- 彩色种子，实在没力气写了，简单拷贝上面的
local seedColor = {
    ["blocktemplates/m8.bmax"] = {
        filename = "blocktemplates/m5.bmax"
    }
}

-- 花籽->花苗
local budColor = {
    ["blocktemplates/m5.bmax"] = {
        filename = "blocktemplates/m6.bmax"
    }
}

-- 花苗->花卉
local flowerColor = {
    ["blocktemplates/m6.bmax"] = {
        filename = "blocktemplates/m7.bmax",
        spec = "游戏碟(去卧室找到游戏机试试)"
    }
}

local wateringpotColor = "blocktemplates/m9.bmax"
local fertilizerColor = "blocktemplates/m10.bmax"

function createSeedColor(entity, hoverEntity)
    echo(entity)
    if entity.filename == fieldFilename then
        playSound("music/bj.mp3")
        local seedEntity = GameLogic.EntityManager.GetEntity(entity.name .. "_seed")
        local budEntity = GameLogic.EntityManager.GetEntity(entity.name .. "_seed_bud")
        local flowerEntity = GameLogic.EntityManager.GetEntity(entity.name .. "_seed_bud_flower")
        if not seedEntity and not budEntity and not flowerEntity then
            seedEntity = entity:CloneMe()
            seedEntity:SetName(entity.name .. "_seed")
            seedEntity:SetModelFile(seedColor[hoverEntity.filename].filename)
            seedEntity:SetOnClickEvent(nil)
            seedEntity:SetCanDrag(false)
            seedEntity:EnablePhysics(false)
            seedEntity:SetScaling(1.4)
            local x, y, z = entity:GetPosition()
            seedEntity:SetPosition(x, y + 0.2, z)
        end
    end
end

function replaceToBudColor(entity, hoverEntity)
    local subEntity = {}
    local newSubEntityName = ""
    -- entity is field
    if entity.filename == fieldFilename then
        playSound("music/bling.mp3")
        subEntity = GameLogic.EntityManager.GetEntity(entity.name .. "_seed")
        newSubEntityName = entity.name .. "_seed_bud"
        if subEntity and budColor[subEntity.filename] then
            local newSubEntityFileName = budColor[subEntity.filename].filename
            subEntity:SetModelFile(newSubEntityFileName)
            subEntity:SetName(newSubEntityName)
            subEntity:SetScaling(1.2)
        end

    end
    -- entity is seed
    if budColor[entity.filename] then

        subEntity = GameLogic.EntityManager.GetEntity(entity.name)
        newSubEntityName = entity.name .. "_bud"
        if subEntity then
            local newSubEntityFileName = budColor[entity.filename].filename
            subEntity:SetModelFile(newSubEntityFileName)
            subEntity:SetName(newSubEntityName)
            subEntity:SetScaling(1.2)
        end
    end

end

function replaceToFlowerColor(entity, hoverEntity)
    local subEntity = {}
    local newSubEntityName = ""
    if entity.filename == fieldFilename then

        -- entity is field
        playSound("music/bj.mp3")
        subEntity = GameLogic.EntityManager.GetEntity(entity.name .. "_seed_bud")
        newSubEntityName = entity.name .. "_seed_bud_flower"
        if subEntity and flowerColor[subEntity.filename] then
            local newSubEntity = flowerColor[subEntity.filename]
            subEntity:SetModelFile(newSubEntity.filename)
            subEntity.tag = newSubEntity.spec
            subEntity:SetOnClickEvent("showTag")
            subEntity:SetName(newSubEntityName)
            subEntity:SetScaling(0.5)
            subEntity:SetCanDrag(true)
        end
    end
    -- entity is bud
    if flowerColor[entity.filename] then

        subEntity = GameLogic.EntityManager.GetEntity(entity.name)
        newSubEntityName = entity.name .. "_bud_flower"
        if subEntity then
            local newSubEntity = flowerColor[subEntity.filename]
            subEntity:SetModelFile(newSubEntity.filename)
            subEntity.tag = newSubEntity.spec
            subEntity:SetOnClickEvent("showTag")
            subEntity:SetName(newSubEntityName)
            subEntity:SetScaling(0.5)
            subEntity:SetCanDrag(true)
        end
    end
    -- entity is seed
    if budColor[entity.filename] then
        subEntity = GameLogic.EntityManager.GetEntity(entity.name)
        subEntity:Say("我需要浇水！")
    end
end

function pouring(hoverEntity)
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
end

registerBroadcastEvent("onHoverField", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local hoverEntity = GameLogic.EntityManager.GetEntity(msg.hoverEntityName)
    if (entity and hoverEntity) then
        hoverFileName = hoverEntity:GetModelFile()
        -- 普通的花
        if (hoverFileName == fertilizerFilename or seedFileName[hoverFileName]) then
            pouring(hoverEntity)
            -- 新增的彩色种子提示 start
            if budColor[hoverFileName] or flowerColor[hoverFileName] then
                hoverEntity:Say("彩色种子需要特殊水壶和肥料")
                return
            end
            -- 新增的彩色种子提示 end
            if hoverFileName ~= fertilizerFilename then
                createSeed(entity, hoverEntity)
            else
                replaceToFlower(entity, hoverEntity)
            end
        elseif hoverFileName == wateringpotFilename then
            replaceToBud(entity, hoverEntity)
        end

        -- 彩色的种子（也是拷贝上面的）
        if (hoverFileName == fertilizerColor or seedColor[hoverFileName]) then
            pouring(hoverEntity)
            -- 新增的彩色种子提示 start
            if budFileName[hoverFileName] or flowerFileName[hoverFileName] then
                hoverEntity:Say("请使用普通的水壶和肥料")
                return
            end
            -- 新增的彩色种子提示 end
            if hoverFileName ~= fertilizerColor then
                createSeedColor(entity, hoverEntity)
            else
                replaceToFlowerColor(entity, hoverEntity)
            end
        elseif hoverFileName == wateringpotColor then
            replaceToBudColor(entity, hoverEntity)
        end

    end
end)

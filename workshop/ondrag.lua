dragTiltModels = {
    ["blocktemplates/w25.bmax"] = {
        angle = -35,
        submodel = "character/particles/fountain2/fountain2.x",
        dy = -1.6,
        dz = 2
    },
    ["blocktemplates/m9.bmax"] = {
        angle = -35,
        submodel = "character/CC/05effect/V5/yanhua/yanhua.x",
        scaling = 0.3,
        facing = 180
    }
}

registerBroadcastEvent("__entity_onbegindrag", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        local filename = entity:GetModelFile()
        broadcast("playEntityClickSound", filename)
        local category = entity:GetCategory()
        if (category == "customCharItem") then
            entity:SetBootHeight(0.55)
            entity:SetPitch(0)
        end
        local result = dragTiltModels[filename]
        if (result) then
            entity.oldPitch = entity:GetPitch()
            entity.isTilting = true
            if (result.submodel) then
                local subEntity = GameLogic.EntityManager.GetEntity(entity.name .. "_subModel")
                if (not subEntity) then
                    subEntity = entity:CloneMe()
                    subEntity:SetName(entity.name .. "_subModel")
                    subEntity:SetModelFile(result.submodel)
                    subEntity:SetPersistent(false)
                    subEntity:SetOnClickEvent(nil)
                    subEntity:SetCanDrag(false)
                    subEntity:EnablePhysics(false)
                    subEntity:SetScaling(result.scaling or 1)
                    if (result.facing) then
                        subEntity:SetFacing(subEntity:GetFacing() + result.facing)
                    end
                    local x, y, z = subEntity:GetPosition()
                    if (result.offsetInFacing) then
                        local facing = entity:GetFacing() + result.dFacing or 0;
                        x = x + math.cos(facing) * result.offsetInFacing
                        z = z - math.sin(facing) * result.offsetInFacing
                    end
                    subEntity:SetPosition(x + (result.dx or 0), y + (result.dy or 0), z + (result.dz or 0))
                    subEntity:LinkTo(entity)
                end
            end
            for i = 1, 10 do
                if (entity.isTilting) then
                    entity:SetPitch(entity.oldPitch + (result.angle * i / 10 * math.pi / 180))
                    wait(0.02)
                end
            end
            if (result.sound) then
                playSound(result.sound)
            end
            entity.isTilting = nil
        end
    end
end)

registerBroadcastEvent("__entity_onenddrag", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        local filename = entity:GetModelFile()
        local result = dragTiltModels[filename]
        if (result) then
            if (entity.oldPitch) then
                entity.isTilting = false
                entity:SetPitch(entity.oldPitch)
            end
            if (result.submodel) then
                local subEntity = GameLogic.EntityManager.GetEntity(entity.name .. "_subModel")
                if (subEntity) then
                    subEntity:Destroy()
                end
            end
        end

        local stackedOnEntity = entity:GetStackedOnEntity()
        if (stackedOnEntity) then
            -- tip("end drag on: "..stackedOnEntity.name)
        else
            -- tip("end drag")
        end
    end
end)

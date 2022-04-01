dragTiltModels = {
    ["blocktemplates/towelred.bmax"] = {
        angle = 90
    },
    ["blocktemplates/towelorange.bmax"] = {
        angle = 90
    },
    ["blocktemplates/towelgreen.bmax"] = {
        angle = 90
    },
    ["blocktemplates/towelblue.bmax"] = {
        angle = 90
    },
    ["blocktemplates/salt.bmax"] = {
        angle = 45,
        submodel = "character/CC/05effect/V5/tiaoliao/tiaoliao1.x",
        dy = -0.85,
        dFacing = -1.57,
        offsetInFacing = 0.5
    },
    ["blocktemplates/pepper.bmax"] = {
        angle = 45,
        submodel = "character/CC/05effect/V5/tiaoliao/tiaoliao.x",
        dy = -0.85,
        dFacing = -1.57,
        offsetInFacing = 0.5
    },
    ["blocktemplates/toothbrushred.bmax"] = {
        angle = 75,
        sound = "toothbrush.ogg",
        submodel = "character/CC/05effect/V5/shuaya/shuaya.x",
        dy = 0.22,
        dFacing = 1.7,
        offsetInFacing = -0.7
    },
    ["blocktemplates/toothbrushgreen.bmax"] = {
        angle = 75,
        sound = "toothbrush.ogg",
        submodel = "character/CC/05effect/V5/shuaya/shuaya.x",
        dy = 0.22,
        dFacing = 1.7,
        offsetInFacing = -0.7
    },
    ["blocktemplates/toothbrushblue.bmax"] = {
        angle = 75,
        sound = "toothbrush.ogg",
        submodel = "character/CC/05effect/V5/shuaya/shuaya.x",
        dy = 0.22,
        dFacing = 1.7,
        offsetInFacing = -0.7
    },
    ["blocktemplates/toothbrushorange.bmax"] = {
        angle = 75,
        sound = "toothbrush.ogg",
        submodel = "character/CC/05effect/V5/shuaya/shuaya.x",
        dy = 0.22,
        dFacing = 1.7,
        offsetInFacing = -0.7
    },
    ["blocktemplates/toothpaste.bmax"] = {
        angle = 75,
        sound = "toothpaste.ogg",
        submodel = "character/CC/05effect/V5/shuaya/shuaya.x",
        dy = 0,
        dFacing = 1.57,
        offsetInFacing = 0
    },
    ["blocktemplates/showerjell.bmax"] = {
        angle = 75,
        submodel = "character/CC/05effect/V5/shuaya/shuaya.x",
        dy = 0.22,
        dFacing = 1.7,
        offsetInFacing = -0.7
    },
    ["blocktemplates/shampoo.bmax"] = {
        angle = 75,
        submodel = "character/CC/05effect/V5/shuaya/shuaya.x",
        dy = 0.22,
        dFacing = 1.7,
        offsetInFacing = -0.7
    },
    ["blocktemplates/presspowdercushion.bmax"] = {
        angle = 75,
        sound = "showerjell.ogg",
        submodel = "character/CC/05effect/V5/huazhuang/huazhuang.x",
        facing = 3.14,
        dy = 0
    },
    ["blocktemplates/hairdrier.bmax"] = {
        angle = 0,
        submodel = "character/CC/05effect/V5/fengtong/fengtong.x",
        dy = 0.42,
        dFacing = -1.57,
        offsetInFacing = -0.5
    },
    ["blocktemplates/perfume.bmax"] = {
        angle = 0,
        submodel = "character/CC/05effect/V5/fengtong/xiangshui.x",
        dy = 0.3,
        facing = 3.14
    },
    ["blocktemplates/hairsprayblue.bmax"] = {
        angle = 0,
        sound = "showerjell.ogg",
        submodel = "character/CC/05effect/V5/fengtong/xiangshui.x",
        dy = 0.7,
        facing = -1.57,
        dFacing = 0,
        offsetInFacing = 0.2
    },
    ["blocktemplates/hairspraypink.bmax"] = {
        angle = 0,
        sound = "showerjell.ogg",
        submodel = "character/CC/05effect/V5/fengtong/xiangshui.x",
        dy = 0.7,
        facing = -1.57,
        dFacing = 0,
        offsetInFacing = 0.2
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
                    subEntity:SetScaling(1)
                    if (result.facing) then
                        subEntity:SetFacing(subEntity:GetFacing() + result.facing)
                    end
                    local x, y, z = subEntity:GetPosition()
                    if (result.offsetInFacing) then
                        local facing = entity:GetFacing() + result.dFacing or 0;
                        x = x + math.cos(facing) * result.offsetInFacing
                        z = z - math.sin(facing) * result.offsetInFacing
                    end
                    subEntity:SetPosition(x, y + (result.dy or 0), z)
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

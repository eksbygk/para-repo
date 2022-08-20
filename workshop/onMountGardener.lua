-- gardener
-- 1. 收集萝卜和玫瑰 (第二章)
local getPlants = false
local palnts = {
    ["blocktemplates/z2.bmax"] = {
        num = 3,
        type = false
    },
    ["blocktemplates/z25.bmax"] = {
        num = 1,
        type = false
    }
}
local boxOrange = {
    filename = "blocktemplates/j4.bmax",
    spec = "橙色方块(未鉴定物品)"
}
local plantNum = 0
function checkPlant(entity, mountedEntity)
    local filename = mountedEntity.filename
    local x, y, z = entity:GetPosition()
    if palnts[filename] and palnts[filename].num > 0 then
        palnts[filename].num = palnts[filename].num - 1
        if palnts[filename].num <= 0 then
            entity:Say("谢谢，这些正是我需要的")
            wait(0.5)
            mountedEntity:Destroy()
            plantNum = plantNum + 1
            if plantNum == 2 then
                wait(0.5)
                local boxEntity = GameLogic.EntityManager.GetEntity()
                boxEntity = entity:CloneMe()
                boxEntity:SetPosition(x, y, z - 1)
                boxEntity:SetModelFile(boxOrange.filename)
                boxEntity.tag = boxOrange.spec
                boxEntity:SetCanDrag(true)
                boxEntity:SetOnClickEvent("showTag")
                boxEntity:SetOnMountEvent(nil)
                entity:Say("送你一个橙色方块")
                playSound("music/npc.mp3")
                getPlants = true
                broadcast("gardenerTask1", "") --   通知click方块
            end
            return
        end
        entity:Say("谢谢你，我还需要" .. palnts[filename].num .. "个")
        wait(0.5)
        mountedEntity:Destroy()
    else
        entity:Say("抱歉，我不需要这个物品")
        wait(0.5)
        mountedEntity:SetPosition(x, y, z - 1.5)
    end
end

-- 2. 收集鲜花 (第二章)
local flowers = {
    ["blocktemplates/w30.bmax"] = true,
    ["blocktemplates/w31.bmax"] = true,
    ["blocktemplates/w32.bmax"] = true
}

local getFlower = false
local flowerNum = 0
local boxGrass = {
    filename = "blocktemplates/j6.bmax",
    spec = "草本方块(未鉴定物品)"
}
local noBoxHtml = [[<div style="width: 1834px;height: 337px;background: url(images/gardener/dialog.png);">
<div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/gardener/flower3.png);"></div>
</div>]]
function checkFlower(entity, mountedEntity)
    local filename = mountedEntity.filename
    local x, y, z = entity:GetPosition()
    if flowers[filename] then
        if flowerNum >= 6 then
            -- entity:Say("我没有草本方块啦")
            broadcast("gardenerTask2", "") --   通知click方块
            local dialog = window(noBoxHtml, "_ctb", 0, 0, 1834, 337)
            dialog:SetDesignResolution(1834, 337)
            dialog:registerEvent("onmouseup", function(event)
                if (event:button() == "left") then
                    dialog:CloseWindow()
                end
            end)
            getFlower = true
            return
        end
        flowerNum = flowerNum + 1
        wait(0.5)
        -- mountedEntity:Destroy()
        entity:Say("谢谢你,送你一个草本方块")
        playSound("music/npc.mp3")
        wait(0.5)
        mountedEntity:SetModelFile(boxGrass.filename)
        mountedEntity.tag = boxGrass.spec
        mountedEntity:SetOnClickEvent("showTag")
        mountedEntity:SetCanDrag(true)
        mountedEntity:SetScaling(1)
        mountedEntity:SetPosition(x, y, z - 1.5)
    else
        entity:Say("抱歉，我不需要这个物品")
        wait(0.5)
        mountedEntity:SetPosition(x, y, z - 1.5)
    end
end

-- 2. 交付寿司 (第三章)
local sushi = {
    ["blocktemplates/m20.bmax"] = true,
    ["blocktemplates/m21.bmax"] = true
}
local sushiWithoutSauce = {
    ["blocktemplates/c8.bmax"] = true,
    ["blocktemplates/c9.bmax"] = true,
    ["blocktemplates/m23.bmax"] = true,
    ["blocktemplates/m22.bmax"] = true
}
local html = [[<div style="width: 1834px;height: 337px;background: url(images/gardener/dialog.png);">
        <div style="margin-top: 135px;margin-left: 470px;width:1134px;height:57px;background: url(images/gardener/sushiError.png);"></div>
    </div>]]

local sushiNum = 0
local steal = {
    filename = "blocktemplates/m27.bmax",
    spec = "一块钢板"
}
function checkSushi(entity, mountedEntity)
    local filename = mountedEntity.filename
    local x, y, z = entity:GetPosition()
    if sushi[filename] and sushiNum <= 2 then
        sushiNum = sushiNum + 1
        if sushiNum == 1 then
            entity:Say("谢谢, 我还没吃饱, 还需要一个饭团")
            wait(0.5)
            mountedEntity:Destroy()
        elseif sushiNum == 2 then
            entity:Say("谢谢, 给你钢板")
            playSound("music/npc.mp3")
            wait(0.5)
            mountedEntity:SetPosition(x, y, z - 1.5)
            mountedEntity:SetModelFile(steal.filename)
            mountedEntity.tag = steal.spec
            mountedEntity:SetScaling(1)
            entity:SetOnClickEvent(nil)
            entity:SetOnMountEvent(nil)
        end
    elseif sushiWithoutSauce[filename] then
        local dialog = window(html, "_ctb", 0, 0, 1834, 337)
        dialog:SetDesignResolution(1834, 337)
        dialog:registerEvent("onmouseup", function(event)
            if (event:button() == "left") then
                dialog:CloseWindow()
            end
        end)
        mountedEntity:SetPosition(x, y, z - 1.5)
    else
        entity:Say("抱歉，我不需要这个物品")
        wait(0.5)
        mountedEntity:SetPosition(x, y, z - 1.5)
    end
end

registerBroadcastEvent("onMountGardener", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        if (msg.mountname == "" and entity:HasCustomGeosets()) then
            local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
            if (mountedEntity) then
                local boneName = "L_Hand"
                local oldEntity = entity:GetLinkChildAtBone(boneName)
                local x, y, z = entity:GetPosition()
                local aabb = mountedEntity:GetInnerObjectAABB()
                local dx, dy, dz = aabb:GetExtendValues()
                local pos = {math.max(math.sqrt(dx ^ 2, dz ^ 2) - 0.2, 0), -0.1,
                             -math.max(math.sqrt(dx ^ 2 + dz ^ 2) - 0.2, 0)}
                mountedEntity:LinkTo(entity, boneName, pos);

                -- my code begin
                if _G.section == 2 then
                    if getPlants then
                        if getFlower then
                            return
                        end
                        checkFlower(entity, mountedEntity)
                    else
                        checkPlant(entity, mountedEntity)
                    end
                elseif _G.section == 3 then
                    checkSushi(entity, mountedEntity)
                end
                -- my code end
            end
        end
    end
end)

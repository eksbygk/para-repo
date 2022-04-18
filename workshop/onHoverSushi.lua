local mustard = "blocktemplates/m12.bmax" -- 一支芥末
local sauce = "blocktemplates/m13.bmax" -- 酱油
local mustardSauce = "blocktemplates/m14.bmax" -- 芥末酱油

-- local sauceDesc = "酱油盘里有酱油，似乎还少了点芥末。"
local mustardSauceDesc = "酱油盘里拥有了芥末。"
local sushiSauceDesc = "蘸了酱油但没有芥末的饭团，不够完美。"
local sushiMustardDesc = "蘸了酱油和芥末的饭团，完美！"

-- 为酱油碟提供的table
local table4Sauce = {
    ["blocktemplates/c8.bmax"] = {
        filename = "blocktemplates/m23.bmax"
    },
    ["blocktemplates/c9.bmax"] = {
        filename = "blocktemplates/m22.bmax"
    }
}

-- 为芥末碟提供的table，普通寿司和酱油寿司都会变成芥末寿司
local table4MustardSauce = {
    ["blocktemplates/m22.bmax"] = {
        filename = "blocktemplates/m20.bmax"
    },
    ["blocktemplates/c8.bmax"] = {
        filename = "blocktemplates/m20.bmax"
    },
    ["blocktemplates/m23.bmax"] = {
        filename = "blocktemplates/m21.bmax"
    },
    ["blocktemplates/c9.bmax"] = {
        filename = "blocktemplates/m21.bmax"
    }
}

function Pouring(hoverEntity)
    run(function()
        if (not hoverEntity.isPouring) then
            hoverEntity.isPouring = true
            if (hoverEntity:IsAutoTurningDuringDragging()) then
                hoverEntity:SetFacing(entity:GetFacing())
            end
            for i = 1, 10 do
                hoverEntity:SetRoll(-i / 10 * math.pi / 2)
                wait(0.03)
            end
            for i = 10, 0, -1 do
                hoverEntity:SetRoll(-i / 10 * math.pi / 2)
                wait(0.03)
            end
            hoverEntity.isPouring = nil;
            return
        end
    end)
end

registerBroadcastEvent("onHoverSauce", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local hoverEntity = GameLogic.EntityManager.GetEntity(msg.hoverEntityName)
    if (entity and hoverEntity) then
        local entityFile = entity.filename
        local hoverEntityFile = hoverEntity.filename
        Pouring(hoverEntity)
        if entityFile == sauce then
            -- 酱油碟
            if table4Sauce[hoverEntityFile] then
                -- 寿司蘸酱油碟
                local newFile = table4Sauce[hoverEntityFile].filename
                hoverEntity:SetModelFile(newFile)
                hoverEntity.tag = sushiSauceDesc
                entity:Say("寿司蘸上了酱油", 3)
            elseif hoverEntityFile == mustard then
                -- 酱油碟里加芥末
                entity:SetModelFile(mustardSauce)
                entity.tag = mustardSauceDesc
                entity:Say(mustardSauceDesc, 3)
            else
                -- 其他物品
                -- entity:Say("什么也没发生呢", 3)
            end

        elseif entityFile == mustardSauce then
            -- 芥末碟
            if table4MustardSauce[hoverEntityFile] then
                local newFile = table4MustardSauce[hoverEntityFile].filename
                hoverEntity:SetModelFile(newFile)
                hoverEntity.tag = sushiMustardDesc
                entity:Say("寿司蘸上了芥末和酱油", 3)
            else
                -- entity:Say("什么也没发生呢", 3)
            end
        end
    end
end)

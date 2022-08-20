-- 待收集表
local materialTable = {}
function initMaterialTable()
    materialTable = {
        ["blocktemplates/j7.bmax"] = true,
        ["blocktemplates/z18.bmax"] = true,
        ["blocktemplates/j12.bmax"] = true,
        ["blocktemplates/g22.bmax"] = true,
        ["blocktemplates/k29.bmax"] = true
    }
end
initMaterialTable()

local materialNum = 0
local glass = {
    filename = "blocktemplates/m24.bmax",
    spec = "一块玻璃"
}
local glassNum = 0
registerBroadcastEvent("onMountMergeGlass", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
    if (entity and mountedEntity) then
        local filename = mountedEntity.filename
        if (materialTable[filename]) then
            playSound("music/item.ogg")
            mountedEntity:Destroy()
            materialTable[filename] = false
            materialNum = materialNum + 1
            if materialNum == 5 then
                entity:Say("玻璃制作完成")
                local subEntity = GameLogic.EntityManager.GetEntity(msg.name .. "_galss" .. glassNum)
                if (not subEntity) then
                    subEntity = entity:CloneMe()
                    subEntity:SetName(msg.name .. "_galss" .. glassNum)
                    subEntity:SetModelFile(glass.filename)
                    subEntity:SetOnClickEvent("showTag")
                    subEntity.tag = glass.spec
                    subEntity:SetCanDrag(true)
                    subEntity:EnablePhysics(true)
                    subEntity:SetScaling(1)
                    local x, y, z = subEntity:GetPosition()
                    subEntity:SetPosition(x, y + 2, z)
                    subEntity:FallDown()

                    glassNum = glassNum + 1
                    materialNum = 0
                end
                initMaterialTable()

            else
                entity:Say("还需要要" .. 5 - materialNum .. "种材料")
            end
        else
            entity:Say("不需要这个物品")
        end
    end
end)

local animalTable = {
    ["blocktemplates/j19.bmax"] = "blocktemplates/h7.bmax",
    ["blocktemplates/j20.bmax"] = "blocktemplates/m3.bmax",
    ["blocktemplates/j21.bmax"] = "blocktemplates/w11.bmax",
    ["blocktemplates/j22.bmax"] = "blocktemplates/c30.bmax",
    ["blocktemplates/j23.bmax"] = "blocktemplates/h6.bmax",
    ["blocktemplates/j24.bmax"] = "blocktemplates/w10.bmax"
}
local animalNum = 0
local key = {
    filename = "blocktemplates/j25.bmax",
    spec = "铜钥匙(可以打开指定的宝箱)"
}
registerBroadcastEvent("onMountAnimal", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
    if (entity and mountedEntity) then
        local filename = entity:GetModelFile()
        local mountedFilename = mountedEntity:GetModelFile()
        if animalTable[filename] and animalTable[filename] == mountedFilename then
            mountedEntity:SetCanDrag(false)
            animalNum = animalNum + 1
            tip("成功复原雕像")
            if animalNum == 6 then
                tip("获得钥匙")
                local subEntity = GameLogic.EntityManager.GetEntity(msg.name .. "_key")
                if (not subEntity) then
                    subEntity = entity:CloneMe()
                    subEntity:SetName(msg.name .. "_key")
                    subEntity:SetModelFile(key.filename)
                    subEntity.tag = key.spec
                    subEntity:SetOnClickEvent("showTag")
                    subEntity:SetCanDrag(true)
                    subEntity:EnablePhysics(true)
                    subEntity:SetScaling(1)
                    subEntity:SetPosition(19954.69, -125, 20380.73)
                    subEntity:FallDown()
                end
            end
        end
    end
end)

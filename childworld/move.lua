local moveTable = {
    ["blocktemplates/d26.bmax"] = {
        -- 蓝色的鱼
        x = 1,
        y = 0,
        z = -0.5
    },
    ["blocktemplates/c36.bmax"] = {
        -- 草团
        x = 1,
        y = 0,
        z = 0
    },
    ["blocktemplates/j6.bmax"] = {
        -- 黄色生物
        x = -1,
        y = 0,
        z = 0
    },
    ["blocktemplates/d25.bmax"] = {
        -- 鲸鱼
        x = 0,
        y = 0,
        z = 1
    }
}

registerBroadcastEvent("onclickMove", function(msg)
    msg = commonlib.totable(msg)
    local entity = GetEntity(msg.name)
    if entity then
        local moveEntity = moveTable[entity:GetModelFile()]
        if moveEntity then
            local facing = entity:GetFacing()
            local dirX, dirY, dirZ = facing, 1, -math.sin(facing);
            print(dirX, dirY, dirZ)
            if (moveEntity.tag == "true") then
                dirX, dirY, dirZ = -dirX, -dirY, -dirZ;
                moveEntity.tag = "false"
            else
                moveEntity.tag = "true"
            end
            local x, y, z = entity:GetPosition()
            for i = 0, 1, 0.1 do
                entity:SetPosition(x + dirX * i * moveEntity.x, y + dirY * i * moveEntity.y, z + dirZ * i * moveEntity.z)
                wait(0.03)
            end
        end
    end
end)

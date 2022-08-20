local elevatorCount = 4;

local isMoving;
registerBroadcastEvent("elevatorUp", function()
    run(function()
        MoveElevator(true)
    end)
end)

registerBroadcastEvent("elevatorDown", function()
    run(function()
        MoveElevator(false)
    end)
end)

function MoveElevator(isUp)
    if (isMoving) then
        return
    end
    isMoving = true
    local entity = GameLogic.EntityManager.GetEntity("elevatorBox1")
    local aabb = entity:GetInnerObjectAABB()
    local _, height, _ = aabb:GetExtendValues()
    height = height * 2;
    local dirSign = (isUp and 1 or -1)

    local steps = 20
    for i = 1, steps do
        for i = 1, elevatorCount do
            local entity = GameLogic.EntityManager.GetEntity("elevatorBox" .. i)
            if (entity) then
                local x, y, z = entity:GetPosition()
                y = y + 1 / steps * dirSign * height
                entity:SetPosition(x, y, z)
            end
        end
        wait(0.05)
    end
    for i = 1, elevatorCount do
        local entity = GameLogic.EntityManager.GetEntity("elevatorBox" .. i)
        if (entity) then
            local floor = tonumber(entity.tag or i)
            floor = floor + dirSign
            if (isUp and floor > elevatorCount) then
                floor = 1
                local x, y, z = entity:GetPosition()
                entity:SetPosition(x, y - height * elevatorCount, z)
            elseif (not isUp and floor < 1) then
                floor = elevatorCount
                local x, y, z = entity:GetPosition()
                entity:SetPosition(x, y + height * elevatorCount, z)
            end
            entity.tag = tostring(floor);
        end
    end
    isMoving = false
end

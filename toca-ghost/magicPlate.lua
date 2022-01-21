-- change this entity name
local entityName = "magicPlate"
local maxHeight = 4;
local rotSpeed = 0.02
local entity = GameLogic.EntityManager.GetEntity(entityName)
if(entity) then
    local aabb = entity:GetInnerObjectAABB()
    local maxRadius = aabb:GetMaxExtent()
    local cx, cy, cz = entity:GetPosition()
    local _, dy, _ = aabb:GetExtendValues()
    cy = cy + dy * 2
    
    while (true) do
        entity:ForEachChildLinkEntity(function(childEntity)
            if(not childEntity:IsDragging() and not childEntity:HasRealPhysics()) then
                local x, y, z = childEntity:GetPosition()
                local distSq = (x-cx)^2 + (z-cz)^2
                if(distSq > 0.01) then
                    local dist = math.sqrt(distSq)
                    local sign = childEntity._goingDown and -1 or 1;
                    y = math.max(cy, math.min(cy+maxHeight, y + 0.01*sign))
                    if(y == cy + maxHeight) then
                        childEntity._goingDown = true
                    elseif(y==cy) then
                        childEntity._goingDown = nil;
                    end
                    local percent = (y - cy) / maxHeight
                    local angle = math.acos((x-cx) / dist)
                    if((z-cz) < 0) then
                        angle = -angle
                    end
                    angle = angle + rotSpeed
                    x = cx + math.cos(angle) * dist
                    z = cz + math.sin(angle) * dist
                    childEntity:SetPitch(percent*math.pi*2)
                    childEntity:SetFacing(percent*math.pi*2)
                    childEntity:SetPosition(x, y, z)
                end
            end
        end)
        wait(0.01);
    end
end
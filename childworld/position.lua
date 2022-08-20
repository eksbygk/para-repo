for i = 1, 5 do
    local entity = GetEntity('sky' .. i)
    entity:SetCanDrag(false)
end

local entity1 = GetEntity('floor1')

local x, y, z = entity1:GetPosition()
local scale = entity1:GetScaling()

entity1:SetCanDrag(false)

entity1:SetPosition(x, y - 200, z)

entity1.visible = false
entity1:SetOpacity(1)

-- hide and seek
local positions = {
    {x = 18920, y = -131, z = 20578}, {x = 18921, y = -131, z = 20577},
    {x = 18922, y = -131, z = 20576}, {x = 18923, y = -131, z = 20575},
    {x = 18924, y = -131, z = 20574}, {x = 18925, y = -131, z = 20573},
    {x = 18926, y = -131, z = 20572}, {x = 18927, y = -131, z = 20571},
    {x = 18928, y = -131, z = 20570}
}

local nums = {
    [1] = 'blocktemplates/e25.bmax',
    [2] = 'blocktemplates/e26.bmax',
    [3] = 'blocktemplates/e27.bmax',
    [4] = 'blocktemplates/e28.bmax',
    [5] = 'blocktemplates/e29.bmax',
    [6] = 'blocktemplates/e30.bmax',
    [7] = 'blocktemplates/e31.bmax',
    [8] = 'blocktemplates/e32.bmax',
    [9] = 'blocktemplates/e33.bmax'
}

local count = 0
registerBroadcastEvent("onClickHideNum", function(msg)
    local positionsCopy = commonlib.deepcopy(positions)
    msg = commonlib.totable(msg)
    local entity = GetEntity(msg.name)
    if entity then
        ask("藏几个数字？(1-9)")
        count = tonumber(answer)
        if not count or count > 9 then
            tip('请输入1-9内的数字')
            return
        end
        for i = 1, count do
            local subEntity = entity:CloneMe()
            subEntity:SetOnClickEvent(nil)
            subEntity:SetModelFile(nums[i])
            local posIndex = math.random(1, #positionsCopy)
            local x = tonumber(positionsCopy[posIndex].x)
            local y = tonumber(positionsCopy[posIndex].y)
            local z = tonumber(positionsCopy[posIndex].z)
            subEntity:SetPosition(x, y, z)
            table.remove(positionsCopy, posIndex)
        end
    end
end)

local currentNum = 0
local count = 0
local numberTable = {
    ['blocktemplates/f23.bmax'] = {num = 1, model = 'blocktemplates/e25.bmax'},
    ['blocktemplates/f24.bmax'] = {num = 2, model = 'blocktemplates/e26.bmax'},
    ['blocktemplates/f25.bmax'] = {num = 3, model = 'blocktemplates/e27.bmax'},
    ['blocktemplates/f26.bmax'] = {num = 4, model = 'blocktemplates/e28.bmax'},
    ['blocktemplates/f27.bmax'] = {num = 5, model = 'blocktemplates/e29.bmax'},
    ['blocktemplates/f28.bmax'] = {num = 6, model = 'blocktemplates/e30.bmax'},
    ['blocktemplates/f29.bmax'] = {num = 7, model = 'blocktemplates/e31.bmax'},
    ['blocktemplates/f30.bmax'] = {num = 8, model = 'blocktemplates/e32.bmax'},
    ['blocktemplates/f31.bmax'] = {num = 9, model = 'blocktemplates/e33.bmax'}
}

local screenNumEntity = GetEntity('screenNum')
screenNumEntity:SetModelFile('blocktemplates/e24.bmax')
registerBroadcastEvent("onChangeNum", function(msg)
    msg = commonlib.totable(msg)
    local entity = GetEntity(msg.name)
    if entity and screenNumEntity then
        local filename = entity:GetModelFile()
        if numberTable[filename] then
            currentNum = numberTable[filename].num
            screenNumEntity:SetModelFile(numberTable[filename].model)
            tip('已设置当前数字为' .. numberTable[filename].num)
        end
    end
end)

-- count

registerBroadcastEvent("onBeginDragNum", function(msg)
    msg = commonlib.totable(msg)
    local entity = GetEntity(msg.name)
    if entity then
        count = count - 1
        tip(count)
        entity:SetOnEndDragEvent('clearEvent')
    end
end)

registerBroadcastEvent("clearEvent", function(msg)
    msg = commonlib.totable(msg)
    local entity = GetEntity(msg.name)
    if entity then
        entity:SetOnBeginDragEvent(nil)
        entity:SetOnEndDragEvent(nil)
    end
end)

registerBroadcastEvent("onMountCountingBoard", function(msg)
    msg = commonlib.totable(msg)
    local entity = GetEntity(msg.name)
    local mountedEntity = GetEntity(msg.mountedEntityName)
    if entity and mountedEntity then
        count = count + 1
        tip(count)
        if count == currentNum then tip('物品数量正确') end
        mountedEntity:SetOnBeginDragEvent('onBeginDragNum')
    end
end)

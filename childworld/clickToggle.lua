local toggleTable = {
    -- 1
    ["blocktemplates/j2.bmax"] = { model="blocktemplates/d24.bmax", },
    ["blocktemplates/j3.bmax"] = { model="blocktemplates/d23.bmax", },
    ["blocktemplates/j4.bmax"] = { model="blocktemplates/d18.bmax", },
    ["blocktemplates/j10.bmax"] = { model="blocktemplates/d11.bmax", },
    -- 2
    ["blocktemplates/d24.bmax"] = { model="blocktemplates/j2.bmax", },
    ["blocktemplates/d23.bmax"] = { model="blocktemplates/j3.bmax", },
    ["blocktemplates/d18.bmax"] = { model="blocktemplates/j4.bmax", },
    ["blocktemplates/d11.bmax"] = { model="blocktemplates/j10.bmax", },
}

registerBroadcastEvent("onToggle", function(msg)
    msg = commonlib.totable(msg)
    local entity = GetEntity(msg.name)
    if entity then
        local filename = entity:GetModelFile()
        if toggleTable[filename] then
            entity:SetModelFile(toggleTable[filename].model)
            
        end
    end
end)

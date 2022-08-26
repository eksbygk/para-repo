local numberToggleTable = {
    -- 1-9 to中文字
    ["blocktemplates/g1.bmax"] = { model="blocktemplates/g10.bmax", num = 1},
    ["blocktemplates/g2.bmax"] = { model="blocktemplates/g11.bmax", num = 2},
    ["blocktemplates/g3.bmax"] = { model="blocktemplates/g12.bmax", num = 3},
    ["blocktemplates/g4.bmax"] = { model="blocktemplates/g13.bmax", num = 4},
    ["blocktemplates/g5.bmax"] = { model="blocktemplates/g14.bmax", num = 5},
    ["blocktemplates/g6.bmax"] = { model="blocktemplates/g15.bmax", num = 6},
    ["blocktemplates/g7.bmax"] = { model="blocktemplates/g16.bmax", num = 7},
    ["blocktemplates/g8.bmax"] = { model="blocktemplates/g17.bmax", num = 8},
    ["blocktemplates/g9.bmax"] = { model="blocktemplates/g18.bmax", num = 9},
    -- 1-9 to阿拉伯数字
    ["blocktemplates/g10.bmax"] = { model="blocktemplates/g1.bmax", num = 1},
    ["blocktemplates/g11.bmax"] = { model="blocktemplates/g2.bmax", num = 2},
    ["blocktemplates/g12.bmax"] = { model="blocktemplates/g3.bmax", num = 3},
    ["blocktemplates/g13.bmax"] = { model="blocktemplates/g4.bmax", num = 4},
    ["blocktemplates/g14.bmax"] = { model="blocktemplates/g5.bmax", num = 5},
    ["blocktemplates/g15.bmax"] = { model="blocktemplates/g6.bmax", num = 6},
    ["blocktemplates/g16.bmax"] = { model="blocktemplates/g7.bmax", num = 7},
    ["blocktemplates/g17.bmax"] = { model="blocktemplates/g8.bmax", num = 8},
    ["blocktemplates/g18.bmax"] = { model="blocktemplates/g9.bmax", num = 9}

}

registerBroadcastEvent("onToggleNumber", function(msg)
    msg = commonlib.totable(msg)
    local entity = GetEntity(msg.name)
    if entity then
        local filename = entity:GetModelFile()
        if numberToggleTable[filename] then
            entity:SetModelFile(numberToggleTable[filename].model)
            playSound('music/'..numberToggleTable[filename].num..'.mp3')
        end
    end
end)

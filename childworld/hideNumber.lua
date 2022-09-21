-- hide number
local positions = {
    {
        pos = "18165, -1, 19738",
        worldPos = {18922.39, -132.3, 20560.93},
        spec = "广场中心花底下"
    }, {
        pos = "18159, 0, 19713",
        worldPos = {18916.14, -132.3, 20534.89},
        spec = "蓝色小鱼底下"
    }, {
        pos = "18161, 0, 19709",
        worldPos = {18918.22, -131.25, 20530.72},
        spec = "蓝色大鱼旁边"
    }, {
        pos = "18143, 1, 19678",
        worldPos = {18899.47, -131.25, 20498.43},
        spec = "甜品屋后面"
    }, {
        pos = "18164, 1, 19687",
        worldPos = {18921.35, -131.25, 20507.81},
        spec = "草团旁边"
    }, {
        pos = "18148, 1, 19768",
        worldPos = {18904.68, -131.25, 20592.18},
        spec = "计数屋桌子底下"
    }, {
        pos = "18219, 1, 19743",
        worldPos = {18978.64, -131.25, 20566.14},
        spec = "广场边青苔石块下"
    }, {
        pos = "18204, 1, 19695",
        worldPos = {18963.01, -131.25, 20516.14},
        spec = "池塘内"
    }, {
        pos = "18193, 1, 19685",
        worldPos = {18951.56, -130.96, 20505.63},
        spec = "竞技场旁边的宝箱里"
    }, {
        pos = "18159, 1, 19718",
        worldPos = {18916.14, -131.25, 20540.1},
        spec = "荷叶下"
    }, {
        pos = "18125, 1, 19682",
        worldPos = {18880.72, -131.25, 20502.6},
        spec = "甜品站旁边马车底下"
    }, {
        pos = "18141, 1, 19682",
        worldPos = {18897.39, -130.79, 20502.6},
        spec = "甜品屋里面"
    }, {
        pos = "18199, 1, 19753",
        worldPos = {18957.81, -131.25, 20576.56},
        spec = "眼镜老师房子后面的树"
    }
}

local nums = {
    [1] = "blocktemplates/e25.bmax",
    [2] = "blocktemplates/e26.bmax",
    [3] = "blocktemplates/e27.bmax",
    [4] = "blocktemplates/e28.bmax",
    [5] = "blocktemplates/e29.bmax",
    [6] = "blocktemplates/e30.bmax",
    [7] = "blocktemplates/e31.bmax",
    [8] = "blocktemplates/e32.bmax",
    [9] = "blocktemplates/e33.bmax"
}

local numModels = {
    ["blocktemplates/e25.bmax"] = 1,
    ["blocktemplates/e26.bmax"] = 2,
    ["blocktemplates/e27.bmax"] = 3,
    ["blocktemplates/e28.bmax"] = 4,
    ["blocktemplates/e29.bmax"] = 5,
    ["blocktemplates/e30.bmax"] = 6,
    ["blocktemplates/e31.bmax"] = 7,
    ["blocktemplates/e32.bmax"] = 8,
    ["blocktemplates/e33.bmax"] = 9
}

local count = 0
local isFinded = true
local findedNumCount = 0
local currentNums = {}
registerBroadcastEvent("onHideNum", function(msg)
    if not isFinded then
        local tipText = "数字已藏好，请先找到所有数字（剩余" .. count - findedNumCount .. "个）"
        if currentNums[1] then tipText = tipText .. " 提示： " .. currentNums[1].spec end
        tip(tipText)
        return
    end
    tip("找朋友")
    ask("藏几个数字？(1-9)")
    count = tonumber(answer)
    if not count or count > 9 then
        tip("请输入1-9内的数字")
        return
    end
    isFinded = false
    local positionsCopy = commonlib.deepcopy(positions)
    local entity = GetEntity("number")
    for i = 1, count do
        local subEntity = entity:CloneMe()
        subEntity:SetOnClickEvent("onClickNum")
        subEntity:SetModelFile(nums[i])
        local posIndex = math.random(1, #positionsCopy)
        local x = tonumber(positionsCopy[posIndex].worldPos[1])
        local y = tonumber(positionsCopy[posIndex].worldPos[2])
        local z = tonumber(positionsCopy[posIndex].worldPos[3])
        subEntity:SetPosition(x, y, z)
        currentNums[i] = positionsCopy[posIndex]
        currentNums[i].index = i
        table.remove(positionsCopy, posIndex)
    end
    tip("数字已藏好，开始寻找吧")
end)

registerBroadcastEvent("onClickNum", function(msg)
    msg = commonlib.totable(msg)
    local entity = GetEntity(msg.name)
    if entity then
        local filename = entity:GetModelFile()
        local num = numModels[filename]
        tip("恭喜找到数字" .. num .. "，剩余" .. count - findedNumCount - 1 .. "个数字")
        findedNumCount = findedNumCount + 1
        -- table.remove(currentNums, num)
        for k, v in pairs(currentNums) do if v.index == num then table.remove(currentNums, k) end end
        entity:Destroy()
        if findedNumCount == count then
            broadcast("finded")
            findedNumCount = 0
            isFinded = true
            currentNums = {}
        end
    end
end)

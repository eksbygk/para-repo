anim(0)
turnTo(270)
local keepworkToken = ''
local currentLevel = 0
local shotTime = 0
local rank = ''
local rankDisplay = ''

registerClickEvent(function()
    wnd:show()
end)

function getToken()
    System.os.GetUrl({
        url = "https://api.keepwork.com/core/v0/users/login",
        form = {
            username = "nainiumao",
            password = "nainiumao"
        },
        json = true
    }, function(err, msg, data)
        keepworkToken = data.token
    end);
end

function generateRank()
    local result = ''
    local allScore = {}
    local hash = {}
    for item in string.gmatch(rank, '([^/\n]+)') do
        if item ~= nil and item ~= '' and string.len(item) > 2 then
            local currentRow = string.gmatch(item, '([^/ ]+)')
            local userName = currentRow()
            local shot = tonumber(currentRow())
            local level = tonumber(currentRow())

            table.insert(allScore, {
                name = userName,
                shotNum = shot,
                levelNum = level
            })
        end
    end

    local userName = ""
    if (System.User.NickName ~= nil and System.User.NickName ~= '') then
        userName = System.User.NickName
    else
        userName = System.User.username
    end

    table.insert(allScore, {
        name = userName,
        shotNum = shotTime,
        levelNum = currentLevel - 1
    })

    table.sort(allScore, function(a, b)
        if a.levelNum > b.levelNum then
            return true
        elseif a.levelNum == b.levelNum then
            if a.shotNum <= b.shotNum then
                return true
            end
        end

        return false
    end)

    local count = 0

    for _, item in pairs(allScore) do
        if count >= 5 then
            break
        end
        if (not hash[item.name]) then
            count = count + 1
            result = result .. item.name .. ' ' .. item.shotNum .. ' ' .. item.levelNum .. "\n"
            hash[item.name] = true
        end
    end

    return result
end

function putTheScore()
    if currentLevel <= 1 then
        return
    end
    System.os.GetUrl({
        method = "PUT",
        url = "https://api.keepwork.com/core/v0/repos/nainiumao%2Frank/files/nainiumao%2Frank%2Findex.md",
        form = {
            content = generateRank()
        },
        headers = {
            ["authorization"] = 'Bearer ' .. keepworkToken,
            ["content-type"] = 'application/json;charset=UTF-8'
        },
        json = true
    }, function(err, msg, data)
        if err ~= 200 then
            getToken()
        end
    end);
end

function doNothing()
end

registerBroadcastEvent("levelChange", function(msg)
    currentLevel = msg
    if (msg > 0 and msg <= 6) then
        say('当前关卡' .. msg .. '，射击次数' .. shotTime .. '次')
    end

    if (msg > 0 and msg <= 7) then
        if keepworkToken == '' or keepworkToken == nil then
            xpcall(getToken, doNothing)
        end
        xpcall(putTheScore, doNothing)
    end
end)

registerBroadcastEvent("shot", function(msg)
    if (msg > 0 and msg <= 6) then
        shotTime = shotTime + 1
        say('当前关卡' .. msg .. '，射击次数' .. shotTime .. '次')
    end
end)

wnd = window([[
    <div style="text-align:center;font-size:20px;font-weight:bold;padding:10px;">
        <div style="color:#fff;">英雄榜</div>
    </div>
]], "_rt", -230, 20, 200, 200);

local ctx = wnd:getContext();
while (true) do
    System.os.GetUrl("https://api.keepwork.com/core/v0/repos/nainiumao%2Frank/files/nainiumao%2Frank%2Findex.md",
        function(err, msg, data)
            if (err == 200) then
                rank = data
                local rankInfo = ''
                for item in string.gmatch(rank, '([^/\n]+)') do
                    if item ~= nil and item ~= '' then
                        local currentRow = string.gmatch(item, '([^/ ]+)')
                        local userName = currentRow()
                        local shot = tonumber(currentRow())
                        local level = tonumber(currentRow())
                        rankInfo = rankInfo .. userName .. ' ' .. shot .. '次射击 ' .. level .. "关\n"
                    end
                end
                rankDisplay = rankInfo
            end
        end);
    ctx:clearRect()
    ctx.font = "System;16;"
    ctx.fillStyle = "#00000080"
    ctx:fillRect(0, 0, ctx:getWidth(), ctx:getHeight())
    ctx.fillStyle = "#f05b72"
    ctx:fillText(rankDisplay, 20, 40)
    wait(2)
end

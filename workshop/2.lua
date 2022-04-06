-- 1 房屋

say("Click me to start game!")
registerClickEvent(function()
    cmd("/setblock 19340,5,19556 192")
end)

-- position
hide()
-- setPos(cameras[i].x, cameras[i].y, cameras[i].z)
setPos(19341,8,19563)
focus()
camera(0, 90, 0)


-- boy

-- hide()

--cmd("/show boundingbox")
--cmd("/mode game")
cmd("/replacetexture 255 texture/arrow.png")
--cmd("/registeritem 2001 texture/start_button.png")
setActorValue("physicsRadius", 0.49)
setActorValue("physicsHeight", 1)
scale(-40)

_G.protagonistDegree = 0
--_G.curMission = 9

registerBroadcastEvent('init_level', function(msg)
    local level_num = msg.level_num or 1
    _G.curMission = level_num
    SelectMission(_G.curMission)
end)

local missions = {
    {x = 19340, y =5, z = 19562}, --1
    {x = 19188.5, y = 4.9, z = 19192.5}, --2
    {x = 19188.5, y = 4.9, z = 19174.5}, --3
    {x = 19188.5, y = 4.9, z = 19166.5}, --4
    {x = 19188.5, y = 4.9, z = 19147.5}, --5
    {x = 19188.5, y = 4.9, z = 19135.5}, --6
    {x = 19189.5, y = 4.9, z = 19123.5}, --7
    {x = 19194.5, y = 4.9, z = 19110.5}, --8
    {x = 19188.5, y = 4.9, z = 19096.5}, --9
    {x = 19189.5, y = 4.9, z = 19075.5},  --10
    {x = 19179.5, y = 4.9, z = 19197.5}, --11
    {x = 19175.5, y = 4.9, z = 19188.5}, --12
    {x = 19172.5, y = 4.9, z = 19172.5}, --13
    {x = 19176.5, y = 4.9, z = 19158.5}, --14
    {x = 19174.5, y = 4.9, z = 19143.5}, --15
    {x = 19171.5, y = 4.9, z = 19131.5}, --16
    {x = 19174.5, y = 4.9, z = 19118.5}, --17
    {x = 19174.5, y = 4.9, z = 19105.5}, --18
    {x = 19178.5, y = 4.9, z = 19092.5}, --19
    {x = 19178.5, y = 4.9, z = 19076.5} --20
}

local isTouchBox = false
--local isRestart = false
--local isKeyPress = false

registerCollisionEvent("", function(actor)
    local name = actor:GetActorValue("name")
    if(name:match("box")) then
        isTouchBox = true
    end
end)

function SelectMission(index)
    if not missions[index] then
        tip("游戏结束,回到关卡界面!")
        broadcast('focus_menu')
        broadcast("reset")
    end

    _G.curMission = index
    show()

    broadcast("SetMissionsTimes")
    broadcast("SetMultipleButton")
    broadcast("SetBoxPosition")
    broadcast("SetOneTimeButton")
    broadcast("SetArrowPosition")
    
    tip(format("---第%d关---", index))
    
    broadcast("SetCameras", index)
    setPos(missions[index].x, missions[index].y, missions[index].z)
end

function Pass()
    if ( _G.passMissionTimes > 0) then
        return false
    end

    for i = 1, 9 do
        moveForward(0.1)
    end
    
    if (isTouching(131)) then
        say("win!")
        -- local msg = { level_num = _G.curMission + 1 }
        -- broadcast('init_level', msg)
        -- return true
    end
end

function Trap()
    tip("踩到陷阱，稍等重新开始此关")
    broadcast("reset")
    wait(2)
    local msg = { level_num = _G.curMission }
    broadcast('init_level', msg)
    return true
end

function Brake()
    local x, y, z = getPos()
    
    if isTouching("box") then
        moveForward(-0.1)
        wait(0.2)
        return true
    end 

    if isTouching(5) and  string.match(x, "%d+%.5")  and string.match(z, "%d+%.5") then
        wait(0.2)
        --isKeyPress = false 
        return true
    end
end

function OneTimeButton()
    local x, y, z = getPos()
    local id, other = getBlock(x, 5, z)
    
    if id == 201 and  string.match(x, "%d+%.5")  and string.match(z, "%d+%.5") then
        local sx = string.match(x, "(%d+)%.5") or x
        local sy = 5
        local sz = string.match(z, "(%d+)%.5") or z

        setBlock(sx, sy, sz, 237)

        if (_G.passMissionTimes > 0) then
            local times = _G.passMissionTimes - 1
            broadcast('SetMissionsTimes', times)
        end
    end
end

function MultipleButton()
    local x, y, z = getPos()
    local id, other = getBlock(x, 5, z)

    if id == 200 and string.match(x, "%d+%.5")  and string.match(z, "%d+%.5") then
        local sx = string.match(x, "(%d+)%.5") or x
        local sy = 5
        local sz = string.match(z, "(%d+)%.5") or z

        if _G.multipleButtonMode == 'subtraction' and _G.passMissionTimes > 0 then
            local times = _G.passMissionTimes - 1
            broadcast('SetMissionsTimes', times)
        end

        if _G.multipleButtonMode == 'direction' then
            broadcast('ChangeArrowDirection', {x=x, y=y, z=z})
        end        
    end
end

-- 2 is up
-- 14 is down
-- 8 is right
-- 20 is left
function Arrow(callback)
    local x, y, z = getPos()
    local id, directId = getBlock(x, 5, z)

    if string.match(x, "%d+%.5")  and string.match(z, "%d+%.5") and  type(callback) == 'function' then
        callback(
            function()
                --isKeyPress = false

                if directId == 2 then
                    ActorMove(0)
                elseif directId == 14 then
                    ActorMove(180)
                elseif directId == 8 then
                    ActorMove(90)
                elseif directId == 20 then
                    ActorMove(270)
                end
            end
        )

        if directId ~= 0 then
            return true
        end
    end
end

function HandleFunctionBlock(callback)
    if isTouching(58) then
        moveForward(-0.1)
        wait(0.2)
        --isKeyPress = false
        return true
    end

    if isTouching(131) then
        -- return Pass()
        say("win!")
        camera(0, 0, 0)
        cmd("/setblock 19340,5,19556 0")
        return
    end

    if isTouching(16) then
        return Trap()
    end

    if isTouching(255) then
        return Arrow(callback)
    end

    if isTouching(200) then
        MultipleButton()
    end

    if isTouching(201) then
        OneTimeButton()
    end
    
    if isTouching(5) then
        return Brake()
    end

    if isTouching("box") then
        moveForward(-0.1)
        wait(0.2)
        --isKeyPress = false 
        return true
    end
end

function ActorMove(degree)
    --if isKeyPress then
        --return
    --end

    --isKeyPress = true
    _G.protagonistDegree = degree
    turnTo(degree or 0)

    while (true) do
        moveForward(0.1)
        broadcastCollision()
        
        --if isRestart then
            --isRestart = false
            --break
        --end

        if HandleFunctionBlock(
            function(callback)
                if type(callback) == 'function' then
                    callback()
                end
            end
        ) then 
            break 
        end
    end
end

while (true) do
    if isKeyPressed("w") or isKeyPressed("up") then
        ActorMove(0)
    elseif isKeyPressed("s") or isKeyPressed("down") then    
        ActorMove(180)
    elseif isKeyPressed("a") or isKeyPressed("left") then
        ActorMove(270)
    elseif isKeyPressed("d") or isKeyPressed("right") then
        ActorMove(90)
    end
end
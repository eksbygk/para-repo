-- 收音机换bgm
registerBroadcastEvent("onMountRepalceBgm", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
        local music = mountedEntity:GetStaticTag()
        if (mountedEntity and music) then  
            playMusic()
            playMusic(music)
        end
    end
end)

-- 旧的--收音机换bgm
registerBroadcastEvent("onMountRepalceBgm", function(msg)
    msg = commonlib.LoadTableFromString(msg)
    local entity = GameLogic.EntityManager.GetEntity(msg.name)
    if (entity) then
        local mountedEntity = GameLogic.EntityManager.GetEntity(msg.mountedEntityName)
        if (mountedEntity and mountedEntity:GetStaticTag() == "bgm") then
            playMusic()
            playMusic("bgm2.mp3")
        end
    end
end)

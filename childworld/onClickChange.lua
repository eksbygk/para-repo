local skys = {
    {},
    {name="sky1"},
    {name="sky2"},
    {name="sky3"},
    {name="sky4"},
    {name="sky5"},
}

local scenes = {
    {},
    {name="scenes1"},
    {name="scenes2"},
    {name="scenes3"},
    {name="scenes4"},
    {name="scenes5"},
}

local floor = {
    {},
    {name="floor1"},
    {name="floor2"},
    {name="floor3"},
    {name="floor4"},
    {name="floor5"},
}

local function OnSelectNextScene(scenes, isBackward)
    local selectedIndex = 1;
    for i=1, #scenes do
        local scene = scenes[i]
        if(scene.visible) then
            selectedIndex = i
            break;
        end
    end
    selectedIndex = selectedIndex + 1
    if(selectedIndex > #scenes) then
        selectedIndex = 1;
    end
    for i=1, #scenes do
        local scene = scenes[i]
        scene.visible = i==selectedIndex;
        if(scene.name) then
            local entity = GetEntity(scene.name)
            if(entity) then
                local x, y, z = entity:GetPosition()
                if(scene.visible) then
                    y = (y<-150) and (y+200) or y
                else
                    y = (y<-150) and y or (y-200)
                end
                entity:SetPosition(x, y, z)
            end
        end
    end
end

registerBroadcastEvent("onChangeMovieSky", function(msg)
    OnSelectNextScene(skys)
end)

registerBroadcastEvent("onChangeMovieScene", function(msg)
    OnSelectNextScene(scenes)
end)

registerBroadcastEvent("onChangeMovieFloor", function(msg)
    OnSelectNextScene(floor)
end)

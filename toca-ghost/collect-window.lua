function randerCollectWindows()
    local itemsHtml = {[[<div style="width: 50px;height: 50px;background: url(images/001.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/002.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/003.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/004.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/005.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/006.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/007.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/008.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/009.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/010.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/011.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/012.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/013.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/014.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/015.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/016.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/017.png);"></div>]],
                       [[<div style="width: 50px;height: 50px;background: url(images/018.png);"></div>]]}

    local itemsCollected = {[[<div style="width: 50px;height: 50px;background: url(images/01.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/02.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/03.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/04.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/05.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/06.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/07.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/08.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/09.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/10.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/11.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/12.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/13.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/14.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/15.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/16.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/17.png);"></div>]],
                            [[<div style="width: 50px;height: 50px;background: url(images/18.png);"></div>]]}

    local PositionsA = {10, 65, 120, 175, 230, 285, 340, 395, 450, 505, 560, 615, 670, 725, 780, 835, 890, 945}

    local itemWindows = {window(itemsHtml[1], "_lt", PositionsA[1], 10, 70, 70),
                         window(itemsHtml[2], "_lt", PositionsA[2], 10, 70, 70),
                         window(itemsHtml[3], "_lt", PositionsA[3], 10, 70, 70),
                         window(itemsHtml[4], "_lt", PositionsA[4], 10, 70, 70),
                         window(itemsHtml[5], "_lt", PositionsA[5], 10, 70, 70),
                         window(itemsHtml[6], "_lt", PositionsA[6], 10, 70, 70),
                         window(itemsHtml[7], "_lt", PositionsA[7], 10, 70, 70),
                         window(itemsHtml[8], "_lt", PositionsA[8], 10, 70, 70),
                         window(itemsHtml[9], "_lt", PositionsA[9], 10, 70, 70),
                         window(itemsHtml[10], "_lt", PositionsA[10], 10, 70, 70),
                         window(itemsHtml[11], "_lt", PositionsA[11], 10, 70, 70),
                         window(itemsHtml[12], "_lt", PositionsA[12], 10, 70, 70),
                         window(itemsHtml[13], "_lt", PositionsA[13], 10, 70, 70),
                         window(itemsHtml[14], "_lt", PositionsA[14], 10, 70, 70),
                         window(itemsHtml[15], "_lt", PositionsA[15], 10, 70, 70),
                         window(itemsHtml[16], "_lt", PositionsA[16], 10, 70, 70),
                         window(itemsHtml[17], "_lt", PositionsA[17], 10, 70, 70),
                         window(itemsHtml[18], "_lt", PositionsA[18], 10, 70, 70)}

    registerBroadcastEvent("onclickCollectItem", function(msg)
        msg = commonlib.LoadTableFromString(msg)
        local entity = GameLogic.EntityManager.GetEntity(msg.name)
        local staticTag = commonlib.LoadTableFromString(entity:GetStaticTag())
        if (staticTag and staticTag[1] == "collect") then
            local index = staticTag[2]
            itemWindows[index]:CloseWindow()
            itemWindows[index] = window(itemsCollected[index], "_lt", PositionsA[index], 10, 70, 70)
        end
    end)
end

function OnClickBegin()
    wait(0.5)
    randerCollectWindows()
    wait(0.2)
    stopMovie()
    beginImg:CloseWindow()
    beginBtn:CloseWindow()
    helpBtn:CloseWindow()
end
beginImg = window([[
<div> 
    <div style="width: 400px;height: 400px;background: url(images/begin.png);"></div>
</div> 
]], "_ct", -200, -200, 400, 400)

beginBtn = window([[
<div> 
    <div style="width: 97px;height: 56px;background: url(images/start.png);" onclick="OnClickBegin"></div>
</div> 
]], "_ct", 10, 10, 97, 56)

helpBtn = window([[
<div> 
    <div style="width: 97px;height: 56px;background: url(images/help.png);></div>
</div> 
]], "_ct", 80, 30, 97, 56)

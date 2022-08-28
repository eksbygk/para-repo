local numberCard = {
    width = 159,
    height = 238
}
local nunberCards = {}
for i = 1, 9 do
    nunberCards[i] = {
        width = numberCard.width,
        height = numberCard.height,
        index = i
    }
end

-- [[
--     <span style="margin-left:20px;width: 159px;height: 238px;background: url(images/number/1.png);"></span>
--     <span style="margin-left:20px;width: 159px;height: 238px;background: url(images/number/2.png);"></span>
--     <span style="margin-left:20px;width: 159px;height: 238px;background: url(images/number/3.png);"></span>
--     <span style="margin-left:20px;width: 159px;height: 238px;background: url(images/number/4.png);"></span>
-- ]]
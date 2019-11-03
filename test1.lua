blocks = {
    {{0, 1, 1}, {1, 1, 0}},
    {{1, 1, 0}, {0, 1, 1}},
    {{1, 1, 1}, {0, 0, 1}},
    {{1, 1, 1}, {1, 0, 0}},
    {{1, 1, 1}, {0, 1, 0}},
    {{1, 1}, {1, 1}},
    {{1, 1, 1, 1}}
}
field = {}
for i=1,22 do
    field[i] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
end
cb, cx, cy = blocks[math.random(7)], 4, 10

-- 输入方块和坐标，检测是否和场地有重叠
function ifoverlap(bk, x, y)
    if x < 1 or x + #bk[1] > 11 or y < 1 then return true end
    for i = 1, #bk do
        for j = 1, #bk[1] do
            if field[y+i-1] and bk[i][j] > 0 and field[y+i-1][x+j-1] > 0 then
                return true
            end
        end
    end
end

-- 下落一格
function drop()
    cy = cy - 1
    if ifoverlap(cb, cx, cy) then -- 如果有重叠，说明已经落过一格
        cy = cy + 1
        for i = 1, #cb do
            for j = 1, #cb[1] do
                if cb[i][j] ~= 0 then
                    field[cy+i-1][cx+j-1] = 1
                end
            end
        end
        for i = cy + #cb - 1, cy, -1 do -- 检测，消除行，补充行
            local ct = 0
            for j = 1, 10 do
                ct = ct + field[i][j]
            end
            if ct == 10 then
                table.remove(field, i)
                table.insert(field, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
            end
        end
        cb, cx, cy = blocks[math.random(7)], 4, 19 -- 刷新新方块，重置坐标
    end
end

function love.keypressed(key)
    if key == "left" then
        if not ifoverlap(cb, cx-1, cy) then
            cx = cx - 1
        end
    elseif key == "right" then
        if not ifoverlap(cb, cx+1, cy) then
            cx = cx + 1
        end
    elseif key == "up" then
        local m = {}
        for i = 1, #cb[1] do
            m[i] = {}
            for j = 1, #cb do
                m[i][j] = cb[j][#cb[1] + 1 - i]
            end
        end
        if not ifoverlap(m, cx, cy) then
            cb = m
        end
    elseif key == "down" then
        repeat drop() until cy == 19
    end
end

function love.load()
    flag = love.timer.getTime() -- 初始化计时
    love.graphics.setColor(0, 0.4, 0.4) -- 设置红色画笔
end

-- 引擎工作函数
function love.draw()
    if love.timer.getTime() - flag > 0.5 then -- 下落计时器
        drop()
        flag = love.timer.getTime()
    end
    love.graphics.clear(255, 255, 255) -- 清空屏幕
    -- 场地
    for j = 1, 20 do
        for i = 1, 10 do
            if field[j][i] == 1 then
                love.graphics.rectangle("fill", 40*i-39, 801-40*j, 38, 38)
            end
        end
    end
    -- 下落方块
    for j=1,#cb do
        for i=1,#cb[1] do
            if cb[j][i] == 1 then
                love.graphics.rectangle("fill", 40*(i+cx-1)-39, 801-40*(j+cy-1), 38, 38);
            end
        end
    end
end
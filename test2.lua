font_a = love.graphics.newFont("font/YaHeiConsolas.ttf", 50)
love.graphics.setPointSize(10)
love.graphics.setLineWidth(3)

function love.load()
    love.keyboard.setKeyRepeat(true)
end

function testDraw()
    love.graphics.clear(255, 255, 255)
    love.graphics.setFont(font_a);
    love.graphics.print("你好", 0, 0);
    love.graphics.points(100, 100)

    love.graphics.setColor(0, 0.4, 0.4)
    love.graphics.line(100, 100, 300, 300)
    love.graphics.rectangle("line", 300, 300, 50, 50)
    love.graphics.rectangle("fill", 300, 360, 50, 50)

    love.graphics.circle("line", 200, 200, 60)
    love.graphics.circle("fill", 200, 200, 60)

    love.graphics.polygon("line", 100, 100, 200, 200, 260, 500)
    love.graphics.polygon("fill", 100, 100, 200, 200, 260, 500)
end

function love.draw()
end

function love.update(dt)
    if love.keyboard.isDown("w", "y") then
        -- print("press w or y")
    end
    if love.mouse.isDown(1, 2) then
        -- print("press mouse left or right")
    end
end

function love.keypressed(key, scancode, isrepeat)
    print("键盘按下: ", key, scancode, isrepeat)
end

function love.keyreleased(key, scancode)
    print("键盘松开：", key, scancode)
end

function love.mousepressed(x, y, button)
    print("鼠标按下：", x, y, button)
end

function love.mousereleased(x, y, button)
    print("鼠标松开：", x, y, button)
end

function love.mousemoved(x, y, button)
    print("鼠标移动：", x, y, button)
end

function love.mousefocus()
    print("鼠标进入")
end
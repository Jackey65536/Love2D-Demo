
local speed = 200

local otherNum = 100
local other = {}

local WIDTH
local HEIGHT

function newObject(x, y, size, color, dir)
    local object = {
        x = x,
        y = y,
        size = size,
        color = color,
        dir = dir
    }

    function object:isBump(obj)
        local dir = obj.size + self.size
        local dx, dy = obj.x - self.x, obj.y - self.y
        local dir2 = math.sqrt(dx^2 + dy^2)
        return dir2 <= dir
    end

    function object:move(vx, vy)
        self.x = self.x + (vx or 0)
        self.y = self.y + (vy or 0)
    end

    function object:draw()
        love.graphics.setColor(unpack(color))
        love.graphics.circle("fill", self.x, self.y, self.size)
        love.graphics.setColor(1,1,1,1)
    end
    
    return object
end

local player = newObject(100, 100, 20, {1, 1, 0,1})

function createObj()
    local x = math.random(0, WIDTH)
    local y = math.random(0, HEIGHT)
    local size = math.random(10, 30)
    local color = {
        math.random(0, 255) / 255,
        math.random(0, 255) / 255,
        math.random(0, 255) / 255,
    }
    local rad = math.rad(math.random(0, 360))
    local dir = {
        x = math.cos(rad) * speed,
        y = math.sin(rad) * speed
    }
    return newObject(x, y, size, color, dir)
end

function love.load()
    love.window.setFullscreen(true)
    WIDTH = love.graphics.getWidth()
    HEIGHT = love.graphics.getHeight()
    for i=1,otherNum do
        table.insert(other, createObj())
    end
end

function gameOver()
    love.graphics.print("GAME OVER", WIDTH/2, HEIGHT/2)
end

function love.update(dt)
    local vx, vy = 0, 0
    if love.keyboard.isDown('w') then
        vy = -speed
    end
    if love.keyboard.isDown('s') then
        vy = speed
    end
    if love.keyboard.isDown('a') then
        vx = -speed
    end
    if love.keyboard.isDown('d') then
        vx = speed
    end
    player:move(vx*dt, vy*dt)

    for k,obj in pairs(other) do
        obj:move(obj.dir.x*dt, obj.dir.y*dt)
        if obj.x < 0 or obj.x > WIDTH then
            obj.dir.x = - obj.dir.x
        end
        if obj.y < 0 or obj.y > HEIGHT then
            obj.dir.y = - obj.dir.y
        end
        if player:isBump(obj) then
            if obj.size > player.size then
                gameOver()
            else
                local playerArea = math.pow(player.size, 2) * math.pi
                local objArea = math.pow(obj.size, 2) * math.pi
                player.size = math.sqrt((playerArea + objArea) / math.pi)
                table.remove(other, k)
                table.insert(other, createObj())
            end
        end
    end
end

function love.draw()
    love.graphics.clear(0, 0.3, 0.3)
    for k,obj in pairs(other) do
        obj:draw()
    end
    player:draw()
end
Player = {}


function Player:load()
    self.width = 20
    self.height = 100

    self.x = 50
    self.y = (love.graphics.getHeight() * 0.5) - (self.height / 2)

    self.speed = 1750
end


function Player:update(dt)
    self:move(dt)
    self:checkBounds()
end


function Player:draw()
   local r, g, b, a = love.graphics.getColor()
   love.graphics.setColor(0.88, 0.88, 0.78, 1.0)
   love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, 10)
   love.graphics.setColor(r, g, b, a)
end


function Player:move(dt)
    if love.keyboard.isDown('w') or love.keyboard.isDown('up') then
        self.y = self.y - self.speed * dt
    end
    if love.keyboard.isDown('s') or love.keyboard.isDown('down') then
        self.y = self.y + self.speed * dt
    end
end
 
function Player:checkBounds()
    if self.y < 0 then
        self.y = 0
    end
    if self.y > love.graphics.getHeight() - self.height then
        self.y = love.graphics.getHeight() - self.height
    end
end
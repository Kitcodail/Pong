OpponentBot = {}


function OpponentBot:load()
    self.width = 20
    self.height = 100

    self.x = love.graphics.getWidth() - self.width - 50
    self.y = (love.graphics.getHeight() * 0.5) - (self.height / 2)

    self.speed = 750
    self.yVel = 0
end


function OpponentBot:update(dt)
    self:move(dt)
    self:moveTowardsY(Ball)
end


function OpponentBot:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end


function OpponentBot:move(dt)
    self.y = self.y + self.yVel * dt
end
 

function OpponentBot:checkBounds()
    if self.y < 0 then
        self.y = 0
    end
    if self.y > love.graphics.getHeight() - self.height then
        self.y = love.graphics.getHeight() - self.height
    end
    
end

function OpponentBot:moveTowardsY(target)
    if target.y + target.height * 0.5 < self.y + self.height * 0.5 then
        self.yVel = -self.speed
    elseif target.y + target.height * 0.5 > self.y + self.height * 0.5 then
        self.yVel = self.speed
    else
        self.yVel = 0
    end
end
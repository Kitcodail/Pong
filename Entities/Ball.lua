Ball = {}


function Ball:load()
   self.width = 20
   self.height = 20

   self.x = love.graphics.getWidth() * 0.5 - self.width * 0.5
   self.y = (love.graphics.getHeight() * 0.5) - (self.height / 2)

   self.speed = 1250
   self.xVel = -self.speed
   self.yVel = 0
   self.score = 0

   self.sounds = {}
   self.sounds.pad_collision = love.audio.newSource("Resources/Sounds/pad_collision.wav", "static")
   self.sounds.wall_collision = love.audio.newSource("Resources/Sounds/wall_collision.wav", "static")
   self.sounds.ball_escapes = love.audio.newSource("Resources/Sounds/ball_escapes.wav", "static")
end


function Ball:update(dt)
   self:collide()
   self:move(dt)
   self:updateScore()
end


function Ball:draw()
   local r, g, b, a = love.graphics.getColor()
   love.graphics.setColor(0.88, 0.88, 0.78, 1.0)
   love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, self.width)
   love.graphics.setColor(r, g, b, a)
   love.graphics.print(self.score, 150, 50, 0)
end


function Ball:move(dt)
   self.x = self.x + self.xVel * dt
   self.y = self.y + self.yVel * dt
end
 

function Ball:collide()
   if checkCollision(self, Player) then -- Checks if the ball (self) and Player rectangles are intersecting.
      self.sounds.pad_collision:play()
      self.xVel = self.speed --sets the balls X-velocity to the speed variable (200), meaning it will now travel towards the right.
      local middleBall = self.y + self.height / 2 --Stores the middle point of the ball in a local variable.
      local middlePlayer = Player.y + Player.height / 2 --Stores the middle point of the player in a local variable
      local collisionPosition = middleBall - middlePlayer --Stores the collision position (basically if the ball hit the top or bottom part of the player paddle), in a local variable.
      self.yVel = collisionPosition * 8 -- Sets the Y-velocity to be equal to the collision position * 5, this changes the angle of the balls trajectory.
   end

   if checkCollision(self, OpponentBot) then -- Checks if the ball (self) and Player rectangles are intersecting.
      self.sounds.pad_collision:play()
      self.xVel = -self.speed --sets the balls X-velocity to the speed variable (200), meaning it will now travel towards the right.
      local middleBall = self.y + self.height / 2 --Stores the middle point of the ball in a local variable.
      local middleOpponentBot = OpponentBot.y + OpponentBot.height / 2 --Stores the middle point of the player in a local variable
      local collisionPosition = middleBall - middleOpponentBot --Stores the collision position (basically if the ball hit the top or bottom part of the player paddle), in a local variable.
      self.yVel = collisionPosition * 8 -- Sets the Y-velocity to be equal to the collision position * 5, this changes the angle of the balls trajectory.
   end


   if self.y < 0 then -- Checks if the top of the ball is above the top of the screen.
      self.sounds.wall_collision:play()
      self.y = 0 -- Sets the ball back inside the screen.
      self.yVel = -self.yVel -- Flips the y-velocity
   elseif self.y + self.height > love.graphics.getHeight() then -- Checks if the bottom of the ball is below the bottom of the screen.
      self.sounds.wall_collision:play()
      self.y = love.graphics.getHeight() - self.height -- Sets the ball back inside the screen.
      self.yVel = -self.yVel -- Flips the y-velocity.
   end
end


function Ball:updateScore()

   if self.x < 50 - self.width then
      self.sounds.ball_escapes:play()
      self.x = love.graphics.getWidth() * 0.5 - self.width * 0.5
      self.y = love.graphics.getHeight() * 0.5 - self.height * 0.5


      self.score = self.score - 1
      self.x = love.graphics.getWidth() * 0.5 - self.width * 0.5
      self.y = love.graphics.getHeight() * 0.5 - self.height * 0.5
      self.xVel = self.speed
      self.yVel = 0
   elseif self.x > (love.graphics.getWidth() + self.width) - 50 then
      self.sounds.ball_escapes:play()
      self.x = love.graphics.getWidth() * 0.5 - self.width * 0.5
      self.y = love.graphics.getHeight() * 0.5 - self.height * 0.5


      self.score = self.score + 1
      self.x = love.graphics.getWidth() * 0.5 - self.width * 0.5
      self.y = love.graphics.getHeight() * 0.5 - self.height * 0.5
      self.xVel = -self.speed
      self.yVel = 0
      return 2
   end
end
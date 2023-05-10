require('Entities/Player')
require('Entities/Ball')
require('Entities/OpponentBot')


function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setBackgroundColor(0.12, 0.12, 0.22)
    love.graphics.setNewFont(50)
    entities = {Player, Ball, OpponentBot}

    for i = 1, #entities do
        entities[i]:load()
    end
end


function love.update(dt)
    for i = 1, #entities do
        entities[i]:update(dt)
    end
end


function love.draw()
    for i = 1, #entities do
        entities[i]:draw()
    end
end


function checkCollision(a, b) --Takes two arguments, the rectangles we want to check for collision.
   if a.x + a.width > b.x and a.x < b.x + b.width and a.y + a.height > b.y and a.y < b.y + b.height then -- Is A, intersecting B
      return true -- Returns the boolean value true, indicating that A and B are colliding.
   else
      return false -- Returns the boolean value false, indicating that A and B are not colliding.
   end
end
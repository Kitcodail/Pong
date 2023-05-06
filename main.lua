require('Entities/Player')

function love.load()
    entities = {Player}

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

-- using Classic library to create a class
Player = Object:extend()

function Player:new()
  self.x = 20
  self.y = love.graphics.getHeight() / 2 - 75
  self.width = 20
  self.height = 150
  self.speed = 500
end

function Player:update(dt)
  movePlayer(dt)
  checkPlayerBounds()   
end

function Player:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

-- control the Player's movement
function movePlayer(dt)
  if love.keyboard.isDown('w') then
   Player.y = Player.y - Player.speed * dt
  elseif love.keyboard.isDown('s') then
   Player.y = Player.y + Player.speed * dt
  end
end

-- stay on the screen
function checkPlayerBounds()
  if Player.y < 0 then
    Player.y = 0
  elseif Player.y > love.graphics.getHeight() - Player.height then
    Player.y = love.graphics.getHeight() - Player.height
  end
end




-- using Classic library to create a class
Player = Object:extend()

function Player:new()
  self.width = 20
  self.height = 100
  self.x = 15
  self.y = love.graphics.getHeight() / 2 - self.height /2  
  self.speed = 600
end

function Player:update(dt)
  movePlayer(dt)
  checkPlayerBounds()   
end

function Player:draw()
  local myPaddle = love.graphics.newImage("Assets/paddle2.png")
  love.graphics.draw(myPaddle, self.x, self.y)  
end

-- control the Player's movement
function movePlayer(dt)
  -- keyboard code
  if love.keyboard.isDown('w') then
   Player.y = Player.y - Player.speed * dt
  elseif love.keyboard.isDown('s') then
   Player.y = Player.y + Player.speed * dt
  end
  
  -- gamepad code
  if joystick then -- if a joystick/gamepad is connected     
    if joystick:getGamepadAxis('lefty') == 1 then     
      Player.y = Player.y + Player.speed * dt     
    elseif joystick:getGamepadAxis('lefty') == -1 then 
      Player.y = Player.y - Player.speed * dt   
    end        
  end 
end    

-- stay on the screen
function checkPlayerBounds()
  if Player.y < 10 then
    Player.y = 10
  elseif Player.y > love.graphics.getHeight() - Player.height -10 then
    Player.y = love.graphics.getHeight() - Player.height - 10
  end
end



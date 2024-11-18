
-- using Classic library to create a class
Ai = Object:extend()

function Ai:new()
  self.x = love.graphics.getWidth() - 35
  self.y = love.graphics.getHeight() / 2 - 75
  self.width = 20
  self.height = 100
  self.yVel = 0
  self.speed = 600
  
  -- slow down the AI response to ball moves so it doesn't win all the time
  self.timer = 0
  self.rate = 0.045
end

function Ai:update(dt)
  Ai.timer = Ai.timer + dt
  if Ai.timer > Ai.rate then
    Ai.timer = 0
    AiMove(dt) 
  end
  checkAiBounds()
  acquireBall()
end

function Ai:draw()
  --love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
   local myPaddle = love.graphics.newImage("Assets/paddle2.png")
  love.graphics.draw(myPaddle, self.x, self.y) 
end

function AiMove(dt)
  Ai.y = Ai.y + Ai.yVel * dt
end

function acquireBall(dt)
  if Ball.y + Ball.height < Ai.y then
    Ai.yVel = -Ai.speed
  elseif Ball.y > Ai.y + Ai.height then
    Ai.yVel = Ai.speed
  else
    Ai.yVel = 0 
  end
end

-- stay on the screen
function checkAiBounds()
  if Ai.y < 10 then
    Ai.y = 10
  elseif Ai.y > love.graphics.getHeight() - Ai.height - 10 then
    Ai.y = love.graphics.getHeight() - Ai.height - 10
  end
end

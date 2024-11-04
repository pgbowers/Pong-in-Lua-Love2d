
-- using Classic library to create a class
Ai = Object:extend()

function Ai:new()
  self.x = love.graphics.getWidth() - 40
  self.y = love.graphics.getHeight() / 2 - 75
  self.width = 20
  self.height = 150
  self.yVel = 0
  self.speed = 500
end

function Ai:update(dt)
  AiMove(dt)
 -- moveAi(dt)
  checkAiBounds()
  acquireBall()
end

function Ai:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
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
 --if love.keyboard.isDown('p') then
   --Ai.y = Ai.y - Ai.speed * dt
  --elseif love.keyboard.isDown('l') then
   --Ai.y = Ai.y + Ai.speed * dt
  end

end


-- stay on the screen
function checkAiBounds()
  if Ai.y < 0 then
    Ai.y = 0
  elseif Ai.y > love.graphics.getHeight() - Ai.height then
    Ai.y = love.graphics.getHeight() - Ai.height
  end
end





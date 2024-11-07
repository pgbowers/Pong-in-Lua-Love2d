
-- using Classic library to create a class
Ball = Object:extend()

function Ball:new()
  self.x = love.graphics.getWidth() /2
  self.y = love.graphics.getHeight() / 2
  self.width = 20
  self.height = 20
  self.speed = 300 
  self.xVel = -self.speed * love.math.random(1)--ai serves to player at start of game
  self.yVel = 0  
end

function Ball:update(dt)
  moveBall(dt)
  collision()
  checkBallBounds() 
end

function Ball:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function moveBall(dt)   
  Ball.x = Ball.x + Ball.xVel * dt   
  Ball.y = Ball.y + Ball.yVel * dt   
end

function collision()
  if checkCollision(Ball, Player) then
    Ball.xVel = Ball.speed
    centerBall = Ball.y + Ball.height / 2
    local centerPlayer = Player.y + Player.height / 2    
    local collisionPointPlayer = centerBall - centerPlayer    
    Ball.yVel = collisionPointPlayer * 5
  elseif checkCollision(Ball, Ai) then 
    local centerAi = Ai.y + Ai.height / 2
    local collisionPointAi = centerBall - centerAi
    Ball.xVel = -Ball.speed
    Ball.yVel = -collisionPointAi * 2    
  end      
end

-- score points and restart ball
function checkBallBounds()
  if Ball.x < 0 then --ball hit left side
    Ball.x = love.graphics.getWidth() /2 -- reset to center
    Ball.y = love.graphics.getHeight() / 2
    aiScore = aiScore + 1 -- point for ai
    Ball.xVel = -Ball.speed --* love.math.random(10)-- ai serves to player
    --Ball.y = love.math.random(-1, 1)   
  elseif Ball.x > love.graphics.getWidth() - Ball.width then --ball hit right side
    Ball.x = love.graphics.getWidth() /2 -- reset to center
    Ball.y = love.graphics.getHeight() / 2
    playerScore = playerScore + 1 --point for player
    Ball.xVel = Ball.speed --player serves to ai   
  end

-- bounce off the top and bottom
  if Ball.y > love.graphics.getHeight() - Ball.height then
    Ball.yVel= -Ball.yVel
  elseif Ball.y < 0 then
    Ball.yVel= -Ball.yVel
  end
end


-- generic function to find collision between any two non-rotating rectangles
function checkCollision(a, b)
  if a.x + a.width > b.x and a.x < b.x + b.width and a.y + a.height > b.y and a.y < b.y + b.height then
    return true
  else
    return false
  end
end





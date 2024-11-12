
-- using Classic library to create a class
Ball = Object:extend()

function Ball:new()
  self.x = love.graphics.getWidth() /2
  self.y = love.graphics.getHeight() / 2
  self.radius = 15
  
  self.width = 20
  self.height = 20
  self.speed = 500 
  self.xVel = -self.speed --ai serves to player at start of game
  self.yVel = 0   
end

function Ball:update(dt)
  moveBall(dt)
  collision()
  checkBallBounds()
end

function Ball:draw()
  local myBall = love.graphics.newImage("Assets/ball_small.png")
  love.graphics.draw(myBall, self.x, self.y) 
end

function moveBall(dt)   
  Ball.x = Ball.x + Ball.xVel * dt   
  Ball.y = Ball.y + Ball.yVel * dt   
end

function collision()
  if checkCollision(Ball, Player) then 
    local centerBall = Ball.y + Ball.radius       
    local centerPlayer = Player.y + Player.height / 2    
    local collisionPointPlayer = centerBall - centerPlayer
    Ball.xVel = Ball.speed
    Ball.yVel = collisionPointPlayer * 4 -- tweaked for best game play    
    player_beep:play()
  end
  if checkCollision(Ball, Ai) then
    local centerBall = Ball.y - Ball.radius
    local centerAi = Ai.y + Ai.height / 2
    local collisionPointAi = centerBall - centerAi
    Ball.xVel = -Ball.speed
    Ball.yVel = collisionPointAi * 4     
    ai_beep:play()
  end      
end

-- score points and restart ball
function checkBallBounds()
  if Ball.x < 0 then --ball hit left side
    Ball.x = love.graphics.getWidth() /2 -- reset to center
    Ball.y = love.graphics.getHeight() / 2
    aiScore = aiScore + 1 -- point for ai
    missed:play()
    Ball.xVel = -Ball.speed  - 100 -- slow the serves a bit     
  elseif Ball.x > love.graphics.getWidth() - Ball.width then --ball hit right side
    Ball.x = love.graphics.getWidth() /2 -- reset to center
    Ball.y = love.graphics.getHeight() / 2
    playerScore = playerScore + 1 --point for player
    missed:play()
    Ball.xVel = Ball.speed  - 100  
  end

-- bounce off the top and bottom
  if Ball.y > love.graphics.getHeight() - Ball.height then
    Ball.yVel = -Ball.yVel    
  elseif Ball.y < 0 then
    Ball.yVel = - Ball.yVel
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





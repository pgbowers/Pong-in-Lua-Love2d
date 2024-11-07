-- Oct29, 2024 - An attempt to make a finished Pong game just for the experience - Peter
-- also learning classes using the classic.lua library

function love.load()
  love.graphics.setBackgroundColor(LIGHT_BLUE)
  
  font = love.graphics.newFont("Assets/INVASION2000.TTF", 60)
  
  Object = require "classic"
  require "player"
  require "ai"
  require "ball"
  
  Player = Player() -- creates a new instance of the Player class
  Ai = Ai() -- creates a second new instance of the Player class with different parameters
  Ball = Ball()
  playerScore = 0
  aiScore = 0
  
  gameState = 2 -- 2 is playing
end

function love.update(dt)
  if gameState == 2 then
    Player:update(dt)
    Ai:update(dt)
    Ball:update(dt)    
  end
  
   
end

function love.draw()
  love.mouse.setVisible(false)
  
  -- draw a center line
  love.graphics.rectangle("fill", love.graphics.getWidth() /2, 0, 4, love.graphics.getHeight())
  
  love.graphics.setColor(ORANGE)
  love.graphics.print(playerScore, font, 200, 50)
  love.graphics.print(aiScore, font, 600, 50)
  love.graphics.setColor(WHITE)
  
  if gameState == 4 then    
    love.graphics.setColor(MEDIUM_GREEN) 
    
    local text = "Game Paused"
    love.graphics.print(text, font, love.graphics.getWidth() / 2 - font:getWidth(text) / 2, love.graphics.getHeight() / 2 - font:getHeight(text) / 2)
   
    love.graphics.setColor(WHITE)
  end
  
  Player:draw()
  Ai:draw()
  Ball:draw()  

end

function love.keypressed(key)
  if key == "escape" or key == "q" then
    love.event.quit()
  end 
  if key == 'p' and gameState == 2 then         
    gameState = 4 
  else gameState = 2
  end
  
end



-- Oct29, 2024 - An attempt to make a finished Pong game just for the experience - Peter
-- also learning classes using the classic.lua library

function love.load()
  love.graphics.setBackgroundColor(LIGHT_BLUE)
  
  font = love.graphics.newFont("Assets/INVASION2000.TTF", 40)
  
  Object = require "classic"
  require "player"
  require "ai"
  require "ball"
  
  Player = Player() -- creates a new instance of the Player class
  Ai = Ai() -- creates a second new instance of the Player class with different parameters
  Ball = Ball()
  playerScore = 0
  aiScore = 0
  
  gameState = 1 -- 1 is Start, 2 is Playing, 3 is Over and 4 is Pause
end

function love.update(dt)
  if gameState == 2 then
    Player:update(dt)
    Ai:update(dt)
    Ball:update(dt)
    if aiScore == 5 then
      gameState = 3
    end
  end      
end

function love.draw()
  love.mouse.setVisible(false)
  
  if gameState == 1 then --Welcome screen   
    love.graphics.setColor(MEDIUM_GREEN)     
    local text1 = "Welcome to PONG! by Peter"
    local text2 = "Space to start, ESC to quit"
    love.graphics.print(text1, font, love.graphics.getWidth() / 2 - font:getWidth(text1) / 2, love.graphics.getHeight() / 2 - font:getHeight(text1) / 2)
    love.graphics.print(text2, font, love.graphics.getWidth() / 2 - font:getWidth(text2) / 2, love.graphics.getHeight() / 2 - font:getHeight(text2) / 2 + 50)   

    love.graphics.setColor(WHITE)
  end
  
  if gameState ==2 then --Playing screen
    -- draw a center line
    love.graphics.rectangle("fill", love.graphics.getWidth() /2, 0, 4, love.graphics.getHeight())
    -- draw the scores
    love.graphics.setColor(ORANGE)
    love.graphics.print(playerScore, font, 200, 50)
    love.graphics.print(aiScore, font, 600, 50)
    love.graphics.setColor(WHITE)
    -- draw everything else
    Player:draw()
    Ai:draw()
    Ball:draw()  
  end
  
  if gameState == 3 then -- game over screen   
    love.graphics.setColor(MEDIUM_GREEN)     
    local text = "Game Over"
    love.graphics.print(text, font, love.graphics.getWidth() / 2 - font:getWidth(text) / 2, love.graphics.getHeight() / 2 - font:getHeight(text) / 2)   
    love.graphics.setColor(WHITE)
  end
  
  if gameState == 4 then    
    love.graphics.setColor(MEDIUM_GREEN)     
    local text = "Game Paused"
    love.graphics.print(text, font, love.graphics.getWidth() / 2 - font:getWidth(text) / 2, love.graphics.getHeight() / 2 - font:getHeight(text) / 2)   
    love.graphics.setColor(WHITE)
  end   
end

function love.keypressed(key)
  if key == "escape" or key == "q" then -- quit the game
    love.event.quit()
  end 
  if key == 'p' and gameState == 2 then  -- pause and resume the game      
    gameState = 4  
  elseif key == 'p' and gameState == 4 then
    gameState = 2
  end
  if key == "space" and gameState == 1 then -- start the game
    gameState = 2
  end
  
end



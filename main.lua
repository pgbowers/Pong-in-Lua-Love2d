-- Oct29, 2024 - An attempt to make a finished Pong game just for the experience - Peter
-- also learning classes using the classic.lua library

function love.load()
  love.graphics.setBackgroundColor(LIGHT_BLUE)
  
  font = love.graphics.newFont("Assets/INVASION2000.TTF", 40)
  
  Object = require "classic"
  require "player"
  require "ai"
  require "ball"
  
  Player = Player(50) -- creates a new instance of the Player class
  Ai = Ai() -- creates a second new instance of the Player class with different parameters
  Ball = Ball()
  playerScore = 0
  aiScore = 0
end


function love.update(dt)
  Player:update(dt)
  Ai:update(dt)
  Ball:update(dt)
  --Player2:update(dt)
end

function love.draw()
  love.mouse.setVisible(false)
  
  love.graphics.print(playerScore, font, 200, 50)
  love.graphics.print(aiScore, font, 600, 50)
  
  Player:draw()
  Ai:draw()
  Ball:draw()  

end

function love.keypressed(key)
  if key == "escape" or key == "q" then
    love.event.quit()
  end  
end



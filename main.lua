-- Oct29, 2024 - An attempt to make a finished Pong game just for the experience - Peter
-- also learning classes using the classic.lua library

function love.load()  
  game_background = love.graphics.newImage("Assets/green_leather.png")
  intro_background = love.graphics.newImage("Assets/intro_background.png")
  over_background = love.graphics.newImage("Assets/over_background.png")
  pause_background = love.graphics.newImage("Assets/pause_background.png")
  
  small_font = love.graphics.newFont("Assets/INVASION2000.TTF", 60)
  large_font = love.graphics.newFont("Assets/INVASION2000.TTF", 60)
  
  Object = require "classic"
  require "player"
  require "ai"
  require "ball"
  
  Player = Player() -- creates a new instance of the Player class
  Ai = Ai() -- creates a second new instance of the Player class with different parameters
  Ball = Ball()
  playerScore = 0
  aiScore = 0
  winner = ""
  
  player_beep = love.audio.newSource('Assets/players_beep.wav', 'static')
  ai_beep= love.audio.newSource('Assets/ai_beep.wav', 'static')
  missed = love.audio.newSource('Assets/missed.wav', 'static')
  
  -- check for a gamepad or joystick
  joysticks = love.joystick.getJoysticks()
  joystick = joysticks[1]
  
  gameState = 1 -- 1 is Start, 2 is Playing, 3 is Over and 4 is Paused
end

function love.update(dt)
  if gameState == 2 then
    Player:update(dt)
    Ai:update(dt)
    Ball:update(dt)
    if aiScore == 5 then
      winner = "Computer Wins! "
      gameState = 3
    elseif playerScore == 5 then
      winner = "You Won! "
      gameState = 3
    end    
  end
end 

function love.draw()
  love.mouse.setVisible(false) 
    
  if gameState == 1 then --Welcome screen
    love.graphics.draw(intro_background, 0, 0)     
  end
  
  if gameState == 2 then --Playing screen
    love.graphics.draw(game_background, 0, 0)    
    -- draw the scores    
    love.graphics.print(playerScore, large_font, 200, 50)
    love.graphics.print(aiScore, large_font, 600, 50)
    love.graphics.setColor(WHITE)
    -- draw everything else
    Player:draw()
    Ai:draw()
    Ball:draw()  
  end
  
  if gameState == 3 then -- game over screen 
    love.graphics.draw(over_background, 0, 0)
    love.graphics.setColor(BROWN)
    love.graphics.print(winner, small_font, love.graphics.getWidth() / 2 - small_font:getWidth(winner) / 2, (love.graphics.getHeight() - 400) - small_font:getHeight(winner) / 2)   
    love.graphics.print("Play again? Y/N", small_font, love.graphics.getWidth() / 2 - small_font:getWidth("Play again Y/N") / 2, love.graphics.getHeight() / 2)   
    love.graphics.setColor(WHITE)
  end
  
  if gameState == 4 then -- game paused screen
    love.graphics.draw(pause_background, 0, 0)    
  end   
end

function love.gamepadpressed(joystick, button)
  if button == "x" then
        love.event.quit()
  end
  if button == "start" and gameState == 1 then
    gameState = 2
  end
  if button == "back" and gameState == 2 then
    gameState = 4
  elseif button == "back" and gameState == 4 then
    gameState = 2
  end 
  if button == "a" and gameState == 3 then
    resetGame()
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
  if key == "y" and gameState == 3 then -- restart the game    
    resetGame()
  elseif key == "n" and gameState == 3 then
    love.event.quit()
  end  
end

function resetGame()
  playerScore = 0
  aiScore = 0
  winner = ""
  gameState = 2
end




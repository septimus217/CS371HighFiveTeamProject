-----------------------------------------------------------------------------------------
--
-- EndScreen.lua
-- Developers:  Jonathan L. Joiner, Chris Odom, Davis Toomey, Alexander Martin
-- Team:		High Five
-- Description: Ball and Paddle Game. Get the ball to "escape" the top of the map by getting past bricks that must be hit by the ball to be broken.
-- Class:       CS371-01
-- Disclaimer:  We wrote all of the following code ourselves. yeet.

-----------------------------------------------------------------------------------------

-- Import composer to use scenes
local composer = require( "composer" )

-- Import widget to use widgets
local widget = require("widget")

-- Import soundTable to load music tracks from
local SoundTable=require("SoundTable");
 
-- Declare a new scene
local scene = composer.newScene()

-- Declare new display group for balls
local ballGroup = display.newGroup()

 -- Function to generate animating balls for the background
local function generateBalls(event)
    -- Function to generate 1 to 3 balls
    local function generateBall()
        -- Function to make each ball slowly dissapear
        local function subtractAlpha(ball)
            -- Subract .1 from ball alpha
            ball.alpha = ball.alpha - 0.1

            -- Test if ball alpha is == 0
            if ball.alpha == 0 then
                -- If true remove ball from memory
                ball:removeSelf()
            end

        end -- End of subtractAlpha function

        -- Generate a random number to determine the amount of balls to generate at one time
        local count = math.random(1,3)

        -- Loop through 1 to 3 times
        for i = 1, count do
            -- Randomize x,y coordinates and ballsize dynamically
            local x = math.random(display.contentWidth)
            local y = math.random(display.contentHeight)
            local ballRadius = math.random(5,(display.contentHeight+display.contentWidth)/20)

            -- Declare ball with randomized values
            local ball = display.newCircle(ballGroup, x, y, ballRadius)

            -- Set ball color and transparency/alpha
            ball:setFillColor(.9,0,.6)
            ball.alpha = 0.4

            -- Call subtract alpha every .5 seconds for passed in ball 4 times until alpha = 0 (happens every time a ball is declared)
            timer.performWithDelay(500,function(e) subtractAlpha(ball) end, 4)

        end 
    end -- End of generateBall function

    -- Call generateball every 180 ms (infinite loop)
    timer.performWithDelay(180, generateBall, -1)
end

 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 

 --Function to handle start button
 function ReturnToStart(event)
 	-- Create table for transition to start scene
 	local switch ={
 		effect = "fade",
 		time = 1000,
 	}

 	-- Remove Scene function
 	composer.removeScene("EndScreen")

 	-- Call Function to go to StartScreen
 	composer.gotoScene("StartScreen",switch)
 end

 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

    -- Function to return to main screen
    local startButton = widget.newButton(
    {
        label = "Main Menu",
        font = "Papyrus",
        labelColor = { default = {.9, .7, .7,  1}, over = {0.6, 0.3, 0.3, 0.9}},
        x = display.contentCenterX,
        y = display.contentCenterY + 100,
        onPress = ReturnToStart,
        shape = "RoundedRect",
        cornerRadius = 25   ,
        width = display.contentWidth/2.5,
        height = display.contentHeight/13,
        fillColor = { default = {.8,0,.8, 0.6}, over = {0.3, 0.3, 1, 1}},
        strokeColor = { default = {.8, .2, .8, 0.5}, over = {1, 1, 1, 1}},
        strokeWidth = 2
    })

    -- Call function to display balls in background
    timer.performWithDelay(1000, generateBalls)

    -- Insert display objects into sceneGroup so it will be deleted when destroy function is called
    sceneGroup:insert(ballGroup)
    sceneGroup:insert(startButton)
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 		audio.play(SoundTable["endMusic"], {channel=1, loops=-1})
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
    audio.stop(1)
end

scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );
scene:addEventListener( "hide", scene );
scene:addEventListener( "destroy", scene );

return scene

-----------------------------------------------------------------------------------------
--
-- GameScreen.lua
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

-- Import Physics to use Physics engine
local physics = require("physics")

-- Import soundTable to load music tracks from
local SoundTable=require("SoundTable");
 
-- Declare a new scene
local scene = composer.newScene()




 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 

 --Function to handle end of game
 function EndGame(event)
 	-- Create table for transition to end scene
 	local switch ={
 		effect = "fade",
 		time = 1000,
 	}

 	-- Remove Scene function
 	composer.removeScene("GameScreen")

 	-- Call Function to go to EndScreen
 	composer.gotoScene("EndScreen",switch)
 end

 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	-- Declare and initialize end button 
	local endButton = widget.newButton(
	{
		label = "End Game",
		font = "Papyrus",
		labelColor = { default = {.9, .7, .7,  1}, over = {0.6, 0.3, 0.3, 0.9}},
		x = display.contentCenterX,
		y = display.contentCenterY + 100,
		onPress = EndGame,
		shape = "RoundedRect",
		cornerRadius = 25	,
		width = display.contentWidth/2.5,
		height = display.contentHeight/13,
		fillColor = { default = {.8,0,.8, 0.6}, over = {0.3, 0.3, 1, 1}},
		strokeColor = { default = {.8, .2, .8, 0.5}, over = {1, 1, 1, 1}},
		strokeWidth = 2
	})

	-- Declare new Group for borders
	local borderGroup = display.newGroup()

	-- Declare border rectangles
	local left = display.newRect(borderGroup,0,-120,10, display.actualContentHeight+50);
	local right = display.newRect(borderGroup,display.contentWidth-10,-120,10,display.actualContentHeight+50);

	-- Set anchor points for borders
	left.anchorX = 0;left.anchorY = 0;
	right.anchorX = 0;right.anchorY = 0;

	-- Set fill colors for borders
	left:setFillColor(.9,0,.6)
	right:setFillColor(.9,0,.6)

	-- Insert display objects into sceneGroup so it will be deleted when destroy function is called
	sceneGroup:insert(borderGroup)
    sceneGroup:insert(endButton)
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 		-- Start game music
 		audio.play(SoundTable["gameMusic"], {channel=1, loops=-1});
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

-- Add event listeners for each scene function
scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );
scene:addEventListener( "hide", scene );
scene:addEventListener( "destroy", scene );

-- Return Scene
return scene

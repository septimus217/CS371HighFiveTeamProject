-----------------------------------------------------------------------------------------
--
-- StartScreen.lua
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

 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
-- Create a display group for balls
local ballGroup = display.newGroup()


 --Function to handle start button
local function StartGame(event)
 	-- Create table for transition to game scene
 	local switch ={
 		effect = "fade",
 		time = 1000,
 	}

 	-- Remove Scene function
 	composer.removeScene("StartScreen")

 	-- Call Function to go to GameScreen
 	composer.gotoScene("GameScreen",switch)
 end


local function scaleLogo(logo)
	-- Declare boolean to be used when swapping between functions
	local isLowScale = true

	-- Declare clock value to determine how long scaling of logo takes
	local clock = 200

	-- Function to determine which way to scale logo
	local function determineScale()
		-- Test if isLowScale is true
		if logo.xScale < 0.6 then
			-- Set xScale and yScale
			logo.xScale = logo.xScale + 0.005
			logo.yScale = logo.yScale + 0.005

		elseif logo.xScale > 0.595 then -- If isLowScale is false
			-- Set xScale and yScale
			logo.xScale = logo.xScale - 0.005
			logo.yScale = logo.yScale - 0.005
		end
	end

	-- Call determineScale infinitely with delay
	timer.performWithDelay(clock, determineScale, -1)
end

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
	end	-- End of generateBall function

	-- Call generateball every 180 ms (infinite loop)
 	timer.performWithDelay(180, generateBall, -1)
end

 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event ) 
	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	-- Create table for logo image sheet
	local logoOptions = {
		frames = {
			{ x = 300, y = 235, width = 423, height = 533}, --frame 1\
		}
	};

	-- Create sheet object for logo 
	local sheet = graphics.newImageSheet( "Images/BILogo.png", logoOptions );
	
	-- Declare logo
	local logo = display.newImage(sheet, 1);

	-- Scale the logo's size
	logo:scale(.595,.595)

	-- Specify logo position dynamically
	logo.x= display.contentWidth/ 2;
	logo.y = (display.contentHeight / 2) -100;

	-- Declare and initialize start button 
	local startButton = widget.newButton(
	{
		label = "Start Game",
		font = "Papyrus",
		labelColor = { default = {.9, .7, .7,  1}, over = {0.6, 0.3, 0.3, 0.9}},
		x = display.contentCenterX,
		y = display.contentCenterY + 100,
		onPress = StartGame,
		shape = "RoundedRect",
		cornerRadius = 25	,
		width = display.contentWidth/2.5,
		height = display.contentHeight/13,
		fillColor = { default = {.8,0,.8, 0.6}, over = {0.3, 0.3, 1, 1}},
		strokeColor = { default = {.8, .2, .8, 0.5}, over = {1, 1, 1, 1}},
		strokeWidth = 2
	})

	-- Declare and initialize store button 
	local storeButton = widget.newButton(
	{
		label = "Store",
		font = "Papyrus",
		labelColor = { default = {.9, .7, .7,  .9}, over = {0.6, 0.3, 0.3, 0.9}},
		x = display.contentCenterX,
		y = display.contentCenterY + 148,
		onPress = OpenStore,
		shape = "RoundedRect",
		cornerRadius = 22,
		width = display.contentWidth/3,
		height = display.contentHeight/15,
		fillColor = { default = {.8,0,.8, 0.6}, over = {0.3, 0.3, 1, 1}},
		strokeColor = { default = {.8, .2, .8, 0.5}, over = {1, 1, 1, 1}},
		strokeWidth = 2
	})
	-- Call function to scale logo
	timer.performWithDelay(1000, function(e) scaleLogo(logo) end)

	-- Call function to display balls in background
	timer.performWithDelay(1000, generateBalls)

	-- Insert display objects into sceneGroup so it will be deleted when destroy function is called
    sceneGroup:insert(ballGroup)
	sceneGroup:insert(logo)
    sceneGroup:insert(startButton)
    sceneGroup:insert(storeButton)
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        -- Start start music
 		audio.play(SoundTable["startMusic"], {channel=1, loops=-1});
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
 		display:remove(startButton)
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
    -- Stop start music
    audio.stop(1)
end

-- Add event listeners for each scene function
scene:addEventListener( "create", scene );
scene:addEventListener( "show", scene );
scene:addEventListener( "hide", scene );
scene:addEventListener( "destroy", scene );

-- Return scene
return scene

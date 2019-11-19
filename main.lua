-----------------------------------------------------------------------------------------
--
-- main.lua
-- Developers:   Jonathan L. Joiner, Chris Odom, Davis Toomey, Alexander Martin
-- Team:		High Five
-- Description: Ball and Paddle Game. Get the ball to "escape" the top of the map by getting past bricks that must be hit by the ball to be broken.
-- Class:       CS371-01
-- Disclaimer:  We wrote all of the following code ourselves. yeet.

-----------------------------------------------------------------------------------------

-- Include composer to go to scenes
local composer = require("composer")

-- Specify start options for transition to start screen
local options = {
	effect = "fade",	
	time = 1000
}

-- Go to StartScreen
composer.gotoScene("StartScreen", options)
-----------------------------------------------------------------------------------------
--
-- main.lua
-- Developer:   Jonathan L. Joiner
-- Description: 
-- Class:       CS371-01
-- Disclaimer:  I wrote all of the following code myself. yeet.

-----------------------------------------------------------------------------------------

--Include composer to go to scenes
local composer = require("composer")

local options = {
	effect = "fade",	
	time = 1000
}

-- Go to scene1
composer.gotoScene("scene1", options)
-----------------------------------------------------------------------------------------
--
-- SoundTable.lua
-- Developers:  Jonathan L. Joiner, Chris Odom, Davis Toomey, Alexander Martin
-- Team:		High Five
-- Description: Ball and Paddle Game. Get the ball to "escape" the top of the map by getting past bricks that must be hit by the ball to be broken.
-- Class:       CS371-01
-- Disclaimer:  We wrote all of the following code ourselves. yeet.
-- Copyright Information:	Some of the music tracks on here were downloaded from https://www.ashamaluevmusic.com/. They are available for
--							free use without monetization. As such, do not sell this product. Any distribution of this app for currency
--							is done without our knowledge; therefore, we withhold all responsibility.

-----------------------------------------------------------------------------------------

-- Declare soundTable to load sounds from
local soundTable = {
	startMusic = audio.loadSound("Sounds/StartMusic.mp3"),
	gameMusic = audio.loadSound("Sounds/GameMusic.mp3"),
	endMusic = audio.loadSound("Sounds/EndMusic.mp3"),
}

-- Return the soundTable
return soundTable;

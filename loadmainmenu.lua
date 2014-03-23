-- 
-- Abstract: Ghosts Vs Monsters sample project 
-- Designed and created by Jonathan and Biffy Beebe of Beebe Games exclusively for Ansca, Inc.
-- http://beebegamesonline.appspot.com/

-- (This is easiest to play on iPad or other large devices, but should work on all iOS and Android devices)
-- 
-- Version: 1.0
-- 
-- Sample code is MIT licensed, see http://developer.anscamobile.com/code/license
-- Copyright (C) 2010 ANSCA Inc. All Rights Reserved.




module(..., package.seeall)

-- Main function - MUST return a display.newGroup()
function new()
	local localGroup = display.newGroup()
	
	local theTimer
	local loadingImage
	
	local showLoadingScreen = function()
		loadingImage = display.newImageRect( "Splash.png", 480, 320 )
		loadingImage.x = 240; loadingImage.y = 160
		loadingImage.alpha = 0
		transition.to(loadingImage, {time=2000, alpha=1})
		transition.to(loadingImage, {time=300, delay=3000, alpha=0})
		
		local goToLevel = function()
			director:changeScene( "mainmenu" )
		end
		
		theTimer = timer.performWithDelay( 3300, goToLevel, 1 )
	end
	
	showLoadingScreen()
	
	unloadMe = function()
		if theTimer then timer.cancel( theTimer ); end
		
		if loadingImage then
			loadingImage:removeSelf()
			loadingImage = nil
		end
	end
	
	-- MUST return a display.newGroup()
	return localGroup
end

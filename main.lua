display.setStatusBar( display.HiddenStatusBar )

-- Import director class
local director = require("director")

-- Create a main group
local mainGroup = display.newGroup()

-- Main function
local function main()
	
	-- Add the group from director class
	mainGroup:insert(director.directorView)
	
	-- Uncomment below code and replace init() arguments with valid ones to enable openfeint
	--[[
	openfeint = require ("openfeint")
	openfeint.init( "App Key Here", "App Secret Here", "Ghosts vs. Monsters", "App ID Here" )
	]]--
	
	director:changeScene( "loadmainmenu" )
	
	return true
end

-- Begin
main()
--[[local director = require("director")

-- Create a main group
local mainGroup = display.newGroup()

-- Main function
local function main()

-- Add the group from director class
mainGroup:insert(director.directorView)

-- Change scene without effects
director:changeScene("menu")



return true
end

-- Begin
transition.to(splash, {time=2000, alpha=1})
transition.to(splash, {time=300, delay=3000, alpha=0, onComplete=main})

-- It's that easy! :-)]]--
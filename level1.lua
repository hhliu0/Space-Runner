module(..., package.seeall)

--====================================================================--
-- SCENE: SCREEN 2
--====================================================================--

--[[

 - Version: 1.3
 - Made by Ricardo Rauber Pereira @ 2010
 - Blog: http://rauberlabs.blogspot.com/
 - Mail: ricardorauber@gmail.com

******************
 - INFORMATION
******************

  - Sample scene.

--]]

new = function ( params )
	
	------------------
	-- Params
	------------------
	
	local vLabel = "Touch to go back"
	local vReload = false
	--
	if type( params ) == "table" then
		--
		if type( params.label ) == "string" then
			vLabel = params.label
		end
		--
		if type( params.reload ) == "boolean" then
			vReload = params.reload
		end
		--
	end
	
	------------------
	-- Groups
	------------------
	
	local localGroup = display.newGroup()
	
	------------------
	-- Display Objects
	------------------
	
	local background = display.newImage( "background2.png" )
	local title = display.newText( vLabel, 0, 0, native.systemFontBold, 16 )
	
	------------------
	-- Listeners
	------------------
	
	local touched = function ( event )
		if event.phase == "ended" then
			if vReload then
				director:changeScene( { label="Scene Reloaded" }, "screen2","moveFromRight" )
			else
				director:changeScene( "screen1", "crossfade" )
			end
		end
	end
	
	--====================================================================--
	-- INITIALIZE
	--====================================================================--
	
	local initVars = function ()
		
		------------------
		-- Inserts
		------------------
		local physics = require("physics")
physics.start()
physics.setScale( 40 )
physics.setDrawMode("hybrid")

system.activate( "multitouch" )

require "sprite"

display.setStatusBar( display.HiddenStatusBar )

local background = display.newImage ("background.png")
background.x = display.contentWidth / 2
background.y = display.contentHeight / 2

local floor1 = display.newRect(0, 0, display.contentHeight, 50)
floor1.x = display.contentWidth / 2
floor1.y = (display.contentHeight / 2) + 150
physics.addBody( floor1, "static", { friction=1000, isGround = true } )

local wall1 = display.newRect(0, 0, 50, display.contentWidth - 150)
wall1.x = (display.contentWidth / 2) + 200
wall1.y = (display.contentHeight / 2) - 75
physics.addBody( wall1, "static", { friction=100, isGround = true } )

local map = display.newGroup()
map:insert( floor1 )
map:insert( wall1 )

local sheet2 = sprite.newSpriteSheet( "SS_SRWalk.png", 200, 200 )

local spriteSet2 = sprite.newSpriteSet(sheet2, 1, 10)
sprite.add( spriteSet2, "man", 1, 10, 650, 0 ) -- play 15 frames every 200 ms

local instance2 = sprite.newSprite( spriteSet2 )
instance2.x = -50
instance2.y = 542

squareShape = { -39,-75, 39,-75, 39,63, -39,63 }

physics.addBody( instance2, "dynamic", {density=0, friction=100, bounce=0, shape=squareShape } )

------------------------------------------------------------------------

local left = display.newImage ("left.png")
left.x = -50
left.y = 720
left.alpha = 0.1

local up = display.newImage ("up.png")
up.x = 75
up.y = 720
up.alpha = 0.1

local right = display.newImage ("right.png")
right.x = 200
right.y = 720
right.alpha = 0.1

local rotleft = display.newImage ("left.png")
rotleft.x = 550
rotleft.y = 720
rotleft.alpha = 0.1

local rotright = display.newImage ("right.png")
rotright.x = 700
rotright.y = 720
rotright.alpha = 0.1

-- Puts in all four movement arrow images and positions them

local motionx = 0
local motiony = 0
local rot = 0
local rotspeed = 2
local speed = 5
-- Speed can be adjusted here to easily change how fast my picture moves. Very convenient!

local function stop (event)
if event.phase =="ended" then

instance2:pause()
motionx = 0
motiony = 0
transition.to( left, { time=200, alpha=0.1 } )
transition.to( right, { time=200, alpha=0.1 } )
transition.to( up, { time=200, alpha=0.1 } )
rot = 0
rotleft.alpha = 0.1
rotright.alpha = 0.1

end
end

Runtime:addEventListener("touch", stop )
-- When no arrow is pushed, this will stop me from moving.

local function moveinstance2 (event)
instance2.x = instance2.x + motionx
instance2.y = instance2.y + motiony
end

local function rotmap (event)
floor1.rotation = floor1.rotation + rot
wall1.rotation = wall1.rotation + rot
end

function rotleft:touch()
rot = -rotspeed
end
rotleft:addEventListener("touch", rotleft)

function rotright:touch()
rot = rotspeed
end
rotright:addEventListener("touch", rotright)

Runtime:addEventListener("enterFrame", rotmap)

Runtime:addEventListener("enterFrame", moveinstance2)
-- When an arrow is pushed, this will make me move.

function up:touch()
up.alpha = 1
motionx = 0
motiony = -8
end
--[[up:addEventListener("touch", up) ]]--

--[[local hitTime = system.getTimer ()
-- This can be changed to whatever interval you want, 250 seems to work ok
local tapDelay = 250
 
local function up (event)
        
        if "began" == phase then
                
                local currTime = system.getTimer ()
        
                if currTime < hitTime + tapDelay then
                
					up.alpha = 1
					motionx = 0
					motiony = -30
                
                else
                
                	up.alpha = 1
					motionx = 0
					motiony = -8
				
                end
                
                hitTime = currTime
        
        end
        
end]]--
 
up:addEventListener ("touch", up)

function right:touch()
right.alpha = 1
instance2:prepare("man")
instance2:play()
motionx = speed
motiony = 0
end
right:addEventListener("touch",right)

function left:touch()
left.alpha = 1
instance2.xScale = -1
instance2:prepare("man")
instance2:play()
motionx = -speed
motiony = 0
end
left:addEventListener("touch",left)

-- The above four functions are stating the arrows should all listen for touches and defining
-- the way I should move based on each touch.

local function wrap (event)

if instance2.x < -120 then
instance2.x = -120
end
----
if instance2.x > 770 then
instance2.x = 770
end
----
if instance2.y > 770 then
instance2.y = 770
end
----
if instance2.y < 50 then
instance2.y = 50
end
----
if speed < 0 then
speed = 0
end
end

Runtime:addEventListener("enterFrame", wrap)
		
	end
	
	------------------
	-- Initiate variables
	------------------
	
	initVars()
	
	------------------
	-- MUST return a display.newGroup()
	------------------
	
	return localGroup
	
end
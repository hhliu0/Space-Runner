module(..., package.seeall)

--***********************************************************************************************--
--***********************************************************************************************--

-- mainmenu

--***********************************************************************************************--
--***********************************************************************************************--

-- Main function - MUST return a display.newGroup()
require "sprite"
local movieclip = require( "movieclip" )

function new()
	local menuGroup = display.newGroup()

	local ui = require("ui")
	local floorTween
	local floorTween1
	--local playTween
	--local isLevelSelection = false
	
	-- AUDIO
	local tapSound = audio.loadSound( "tapsound.wav" )
	local backgroundSound = audio.loadStream( "anarch_dotn.mp3" )	--> This is how you'd load music
	
	local drawScreen = function()
		-- BACKGROUND IMAGE
		local backgroundImage = display.newImageRect( "mainmenu.png", 480, 320 )
		backgroundImage.x = 240; backgroundImage.y = 160
		
		menuGroup:insert( backgroundImage )
		
		glowObject = movieclip.newAnim({ "glow.png", "glow1.png" }, 480, 320)
		glowObject.x = 240; glowObject.y = 160
		glowObject:play()
		glowObject:toFront
		
		local title = display.newImageRect( "title.png", 480, 320 )
		title.x = 240; title.y = 160
		
		menuGroup:insert( title )
		
		local menufloor = display.newImageRect( "menufloor.png", 480, 320 )
		menufloor.x = 240; menufloor.y = 160
		
		menuGroup:insert( menufloor )
		
		local menufloor1 = display.newImageRect( "menufloor.png", 480, 320 )
		menufloor1.x = 720; menufloor1.y = 160
		
		menuGroup:insert( menufloor1 )
		
		local play = display.newImageRect( "Play.png", 100, 46 )
		play.x = 240; play.y = 160
		
		menuGroup:insert( play )
		
		-- MAN
		
		local sheet2 = sprite.newSpriteSheet( "SS_SRWalk.png", 100, 100 )

		local spriteSet2 = sprite.newSpriteSet(sheet2, 1, 10)
		sprite.add( spriteSet2, "man", 1, 10, 650, 0 ) -- play 15 frames every 200 ms

		local instance2 = sprite.newSprite( spriteSet2 )
		instance2.x = display.contentWidth / 2
		instance2.y = display.contentHeight * 0.8
		
		menuGroup:insert( instance2 )
		
		-- ANIMATION
		
		local function Anim()
			instance2:prepare("man")
			instance2:play()
		end
		
		Anim()
		
		if floorTween then
			transition.cancel( floorTween )
		end
		
		if floorTween1 then
			transition.cancel( floorTween1 )
		end
		
		local function floorAnimation()
			local animside = function()
					floorTween = transition.to( menufloor, { time=4750, x=-240, onComplete=floorAnimation })
					floorTween1 = transition.to( menufloor1, { time=4750, x=240, onComplete=floorAnimation })
			end
			
			floorTween = transition.to( menufloor, { time=0, x=240, onComplete=animside })
			floorTween1 = transition.to( menufloor1, { time=0, x=720, onComplete=animside })
		end
		
		floorAnimation()
		-- END ANIMATION
		
		-- PLAY BUTTON
		local playBtn
		
		local onPlayTouch = function( event )
			if event.phase == "release" and not isLevelSelection and playBtn.isActive then
				
				audio.play( tapSound )
				
				-- Bring Up Level Selection Screen
				
				isLevelSelection = true
				
				local shadeRect = display.newRect( 0, 0, 480, 320 )
				shadeRect:setFillColor( 0, 0, 0, 255 )
				shadeRect.alpha = 0
				menuGroup:insert( shadeRect )
				transition.to( shadeRect, { time=100, alpha=0.85 } )
				
				local levelSelectionBg = display.newImageRect( "levelselection.png", 328, 194 )
				levelSelectionBg.x = 240; levelSelectionBg.y = 160
				levelSelectionBg.isVisible = false
				menuGroup:insert( levelSelectionBg )
				timer.performWithDelay( 200, function() levelSelectionBg.isVisible = true; end, 1 )
				
				local level1Btn
				
				local onLevel1Touch = function( event )
					if event.phase == "release" and level1Btn.isActive then
						audio.play( tapSound )
						audio.stop( backgroundSound )
						audio.dispose( backgroundSound ); backgroundSound = nil
						
						level1Btn.isActive = false
						director:changeScene( "loadlevel1" )
					end
				end
				
				level1Btn = ui.newButton{
					defaultSrc = "level1btn.png",
					defaultX = 114,
					defaultY = 114,
					overSrc = "level1btn-over.png",
					overX = 114,
					overY = 114,
					onEvent = onLevel1Touch,
					id = "Level1Button",
					text = "",
					textColor = { 255, 255, 255, 255 },
					size = 16,
					emboss = false
				}
				
				level1Btn.x = 174 level1Btn.y = 175
				level1Btn.isVisible = false
				
				menuGroup:insert( level1Btn )
				timer.performWithDelay( 200, function() level1Btn.isVisible = true; end, 1 )
				
				local closeBtn
				
				local onCloseTouch = function( event )
					if event.phase == "release" then
						
						audio.play( tapSound )
						
						-- unload level selection screen
						levelSelectionBg:removeSelf(); levelSelectionBg = nil
						level1Btn:removeSelf(); level1Btn = nil
						shadeRect:removeSelf(); shadeRect = nil
						closeBtn:removeSelf(); closeBtn = nil
						
						isLevelSelection = false
						playBtn.isActive = true
					end
				end
				
				closeBtn = ui.newButton{
					defaultSrc = "closebtn.png",
					defaultX = 44,
					defaultY = 44,
					overSrc = "closebtn-over.png",
					overX = 44,
					overY = 44,
					onEvent = onCloseTouch,
					id = "CloseButton",
					text = "",
					textColor = { 255, 255, 255, 255 },
					size = 16,
					emboss = false
				}
				
				closeBtn.x = 85; closeBtn.y = 245
				closeBtn.isVisible = false
				
				menuGroup:insert( closeBtn )
				timer.performWithDelay( 201, function() closeBtn.isVisible = true; end, 1 )
				
			end
		end
		
		playBtn = ui.newButton{
			defaultSrc = "playbtn.png",
			defaultX = 146,
			defaultY = 116,
			overSrc = "playbtn-over.png",
			overX = 146,
			overY = 116,
			onEvent = onPlayTouch,
			id = "PlayButton",
			text = "",
			textColor = { 255, 255, 255, 255 },
			size = 16,
			emboss = false
		}
		
		playBtn:setReferencePoint( display.BottomCenterReferencePoint )
		playBtn.x = 365 playBtn.y = 440
		
		menuGroup:insert( playBtn )
		
		
		-- SLIDE PLAY AND OPENFEINT BUTTON FROM THE BOTTOM:
		local setPlayBtn = function()
			playTween = transition.to( playBtn, { time=100, x=378, y=325 } )
		end
		
		playTween = transition.to( playBtn, { time=500, y=320, onComplete=setPlayBtn, transition=easing.inOutExpo } )
		
	end
	
	drawScreen()
	audio.play( backgroundSound, { channel=1, loops=-1 }  )
	
	--[[unloadMe = function()
		if floorTween then transition.cancel( floorTween ); end
		if floorTween1 then transition.cancel( floorTween1 ); end
		if playTween then transition.cancel( playTween ); end
		
		if tapSound then audio.dispose( tapSound ); end
	end]]--
	
	-- MUST return a display.newGroup()
	return menuGroup
end
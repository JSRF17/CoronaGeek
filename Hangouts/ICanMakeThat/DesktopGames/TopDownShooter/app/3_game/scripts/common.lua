-- =============================================================
-- Copyright Roaming Gamer, LLC. 2009-2015 
-- =============================================================
-- This content produced for Corona Geek Hangouts audience.
-- You may use any and all contents in this example to make a game or app.
-- =============================================================
local mFloor = math.floor

local common = {}

--
-- Icput Control
--
--common.inputStyle = "keyboardAndMouse"
common.inputStyle    = "controller"
common.reticleDist   = 150 
common.moveLen       = 0.7

--
-- Helper Variables
--
common.w 				   = display.contentWidth
common.h 				   = display.contentHeight
common.centerX 			= display.contentCenterX
common.centerY 			= display.contentCenterY
common.fullw			   = display.actualContentWidth 
common.fullh			   = display.actualContentHeight
common.unusedWidth		= common.fullw - common.w
common.unusedHeight		= common.fullh - common.h
common.left				   = 0 - common.unusedWidth/2
common.top 				   = 0 - common.unusedHeight/2
common.right 			   = common.w + common.unusedWidth/2
common.bottom 			   = common.h + common.unusedHeight/2

-- Clean up variables
common.w 				= mFloor(common.w+0.5)
common.h 				= mFloor(common.h+0.5)
common.left				= mFloor(common.left+0.5)
common.top				= mFloor(common.top+0.5)
common.right			= mFloor(common.right+0.5)
common.bottom			= mFloor(common.bottom+0.5)
common.fullw			= mFloor(common.fullw+0.5)
common.fullh			= mFloor(common.fullh+0.5)

--
-- Game Variables
--
common.debugEn		= false

common.startLevel    = 1
common.currentLevel  = common.startLevel 

common.selectedTrap = 1
common.selectedTrapType = "mouseTrap"
common.trapCounts = {}
common.trapCounts.mouseTrap = 100
common.trapCounts.leafStorm = 100
common.trapCounts.spikeTrap = 100

common.leafStormSpeed = 200

common.gemColors = { "red", "blue", "white", "yellow" }

common.hasGem = {}
common.hasGem.red = false
common.hasGem.blue = false
common.hasGem.white = false
common.hasGem.yellow = false

--
-- World Settings
--
common.gridSize 	   = 80 -- set to 40 for debugging and demo 80 otherwise
common.worldWidth 	= 32 -- # gridSize units wide
common.worldHeight   = 24 -- # gridSize units tall

--
-- Player Settings
--
common.leftLimit = common.centerX - common.gridSize * 7 
common.rightLimit = common.centerX + common.gridSize * 7
common.upLimit = common.centerY - common.gridSize * 5
common.downLimit = common.centerY + common.gridSize * 5

--
-- Enemy Settings
--
common.chanceToDropChest = 20 
common.enemySpawnOffset = 0 -- For debug ONLY; Should normally be 0 or negative; Large enough values cause enemies to spawn 'on screen'.
common.enemyTweenTime   = 1000
common.maxEnemies       = 1
common.enemyBaseSpeed   = 60
common.enemyMinSpeed    = 75/2 -- 75
common.enemyMaxSpeed    = 150/2 -- 150


-- Level Based Enemy Distribution
common.enemyDistro = {}
for i = 1, 400 do
   local distro = {}
   common.enemyDistro[i] = distro
   distro.maxEnemies = math.ceil(i/2)
   if( distro.maxEnemies > 100 ) then 
      distro.maxEnemies = 100
   end
   distro.greenZombie = i
   if( distro.greenZombie > 33 ) then
      distro.greenZombie = 33
   end   
   distro.redZombie = distro.greenZombie + i
   if( distro.redZombie > 66 ) then
      distro.redZombie = 66
   end   
   
   distro.maxValue = distro.greenZombie
   if( i >= 5 ) then
      distro.maxValue = distro.redZombie
   end 
   
   if( i >= 15 ) then
      distro.maxValue = distro.redZombie + i - 15
   end 
   
   if( distro.maxValue > 100 ) then
      distro.maxValue = 100
   end 
   --table.dump(distro,nil,i)
end
   



--
-- Arrow Settings
--
common.arrowsPerSecond 		= 5
common.arrowPeriod 			= 1000/common.arrowsPerSecond
common.arrowLifetime 		= 2000
common.arrowSpeed 			= 300 -- pixels per seconbd
common.maxArrows           = 10


common.gridColors = { {1,1,1,0.2}, {0,1,1,0.2}, }
common.gridColors2 = { {1,1,1,0.2}, {1,0,1,0.2}, }


-- Determine design orientation
common.orientation  	= ( common.w > common.h ) and "landscape"  or "portrait"
common.isLandscape 		= ( common.w > common.h )
common.isPortrait 		= ( common.h > common.w )

-- Further clean up variables
common.left 			= (common.left>=0) and math.abs(common.left) or common.left
common.top 				= (common.top>=0) and math.abs(common.top) or common.top

--
-- Image Sheets
--
-- Load and Config Player Sprite Data
common.mouseTrapInfo 	   = require "images.reiners.mousetrap"
common.mouseTrapSheet 	   = graphics.newImageSheet("images/reiners/mousetrap.png", common.mouseTrapInfo:getSheet() )

common.leafStormInfo 	   = require "images.reiners.leafstorm"
common.leafStormSheet 	   = graphics.newImageSheet("images/reiners/leafstorm.png", common.leafStormInfo:getSheet() )

common.needleTrapInfo 	   = require "images.reiners.trap2"
common.needleTrapSheet 	   = graphics.newImageSheet("images/reiners/trap2.png", common.needleTrapInfo:getSheet() )


--
-- Helper Functions
--

--
-- Test if a display object is valid
--
function common.isValid( obj )
   return obj.removeSelf ~= nil
end

-- Shorthand for Runtime:*() functions
--
local getTimer = system.getTimer
local pairs = _G.pairs
function common.isValid( obj ) 
	return (obj and obj.removeSelf ~= nil)
end

function common.listen( name, listener ) Runtime:addEventListener( name, listener ) end
function common.ignore( name, listener ) Runtime:removeEventListener( name, listener ) end
function common.autoIgnore( name, obj ) 
    if( not common.isValid( obj ) ) then
      common.ignore( name, obj )
      obj[name] = nil
      return true
    end
    return false 
end
function common.post( name, params, debuglvl )
   params = params or {}
   local event = { name = name }
   for k,v in pairs( params ) do event[k] = v end
   if( not event.time ) then event.time = getTimer() end
   if( debuglvl and debuglvl >= 2 ) then table.dump(event) end
   Runtime:dispatchEvent( event )
   if( debuglvl and debuglvl >= 1 ) then print("post( '" .. name .. "' )" ) end   
end

-- Normalize Rotations - Force rotation (number of object.rotation ) to be in range [ 0, 360 )
--
function common.normRot( toNorm )
	if( type(toNorm) == "table" ) then
		while( toNorm.rotation >= 360 ) do toNorm.rotation = toNorm.rotation - 360 end		
		while( toNorm.rotation < 0 ) do toNorm.rotation = toNorm.rotation + 360 end
		return 
	else
		while( toNorm >= 360 ) do toNorm = toNorm - 360 end
		while( toNorm < 0 ) do toNorm = toNorm + 360 end
	end
	return toNorm
end

--
-- Table counter for non-numerically indexed tables
--
function common.tableCount( tbl )
   local count = 0
   if( tbl ~= nil ) then
      for k,v in pairs( tbl ) do 
         count = count + 1
      end
   end
   return count
end

-- ==
--    string:split( tok ) - Splits token (tok) separated string into integer indexed table.
-- ==
function common.split(str,tok)
	local t = {}  -- NOTE: use {n = 0} in Lua-5.0
	local ftok = "(.-)" .. tok
	local last_end = 1
	local s, e, cap = str:find(ftok, 1)
	while s do
		if s ~= 1 or cap ~= "" then
			table.insert(t,cap)
		end
		last_end = e+1
		s, e, cap = str:find(ftok, last_end)
	end
	if last_end <= #str then
		cap = str:sub(last_end)
		table.insert(t, cap)
	end
	return t
end


--
-- Collision Calculator For Easy Collision Calculations
--
local ccmgr = require "plugin.cc"

common.myCC = ccmgr:newCalculator()
common.myCC:addNames( "player", "zombie", "skeleton", "playerarrow", "skeletonarrow", "chest", "gem", "trap" )
common.myCC:collidesWith( "player", { "zombie", "skeleton", "skeletonarrow", "chest", "gem" } )
common.myCC:collidesWith( "zombie", { "player", "playerarrow", "skeletonarrow", "trap" } )
common.myCC:collidesWith( "skeleton", { "player", "playerarrow", "trap" } )

return common
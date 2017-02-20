--Global
--CCDirector:sharedDirector():getWinSize()
CCDirector = {}
function CCDirector:sharedDirector(self)
	return CCDirector
end

function CCDirector:getWinSize(self)
	return { width = 1136, height = 640 }
end

function CCDirector:setDisplayStats()

end

function CCDirector:getActionManager()

end

-- CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(function(dt)
-- CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(handle)
local Scheduler = {}
Scheduler.array = {}
function CCDirector:getScheduler()
	-- body
	return Scheduler
end

function Scheduler:scheduleScriptFunc( func )
	-- body
	return func
end

function Scheduler:setTimeScale()

end

function Scheduler:unscheduleScriptEntry( func )
	-- body
end


MusicFactory = {}
local function emptyFunc( ... )
	-- body
	return 1
end
setmetatable(MusicFactory, { __index = function ( t,k )
	-- body
	return emptyFunc
end} )

XMLFactory = {}
local function emptyFunc( ... )
	-- body
	return {}
end
setmetatable(XMLFactory, { __index = function ( t,k )
	-- body
	return emptyFunc
end} )

kTargetWindows = 'windows'
kTargetMacOS = 'mac'
kTargetAndroid = 'android'
kTargetIphone = 'iphone'
kTargetIpad = 'ipad'

CCApplication = {}
function CCApplication:sharedApplication()
	return CCApplication
end

function CCApplication:getTargetPlatform()
	return 'iphone'
end

function CCApplication:getCurrentLanguage()
	return 'cn'
end

CCEGLView = {}
function CCEGLView:sharedOpenGLView()
	return CCEGLView
end

function CCEGLView:getDesignResolutionSize()
	return { width = 1136, height = 640 }
end

-- CCFileUtils:sharedFileUtils():getWritablePath()
-- device.bundlePath = FileHelper:getBundlePath()

CCFileUtils = {}
function  CCFileUtils:sharedFileUtils( ... )
	-- body
	return CCFileUtils
end

function CCFileUtils:getWritablePath( ... )
	-- body
	return ''
end

FileHelper = {}
function FileHelper:getBundlePath()
	return ''
end

function FileHelper:setWritableRelativePath()
	return nil
end

function FileHelper:getWritablePath()
	return ''
end

print('SystemHelper init called!')

SystemHelper = {}
function SystemHelper:currentTimeMillis()
	return os.clock() * 1000
end

function SystemHelper:random(i, j)
	if i==nil and j==nil then
		return CSharpRandom_randomF()
	elseif j==nil then
		return CSharpRandom_randomB(i)
	else
		return CSharpRandom_randomI(i, j)
	end
end

function SystemHelper:getPlatFormID()
	return 1
end

function SystemHelper:initRandom(seed)
	-- body
	return CSharpRandom_initRandom(seed)
end

function SystemHelper:cleanUnusedTexture()
	-- body
end

function ccc4f(r,g,b,a)
	return { r,g,b,a }
end


------meaningless

local emptyTable = {}

local function emptyFunc( ... )
	-- body
	return emptyTable
end

setmetatable(emptyTable, {__index = function(t,k)
	return emptyFunc
end})



local function cleanTable(t)
	assert(t)
	local keySet = {}
	for i,v in pairs(t) do
		keySet[i] = true
	end

	for i,v in pairs(keySet) do
		t[i] = nil
	end
end

local function setEmptyFunc(t)
	assert(t)
	setmetatable(t, {__index = function(t,k)
		return emptyFunc
	end})
end

local function injectTable(t)
	cleanTable(t)
	setEmptyFunc(t)
end

local SwfActionFactory 		= require 'framework.swf.SwfActionFactory'
injectTable(SwfActionFactory)

CCArray = {}
injectTable(CCArray)

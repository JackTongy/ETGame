local function getWidth()
	-- body
	local size = CCEGLView:sharedOpenGLView():getDesignResolutionSize();
	return size.width
end

local function getHeight()
	-- body
	local size = CCEGLView:sharedOpenGLView():getDesignResolutionSize();
	return size.height
end

local Global = {}

-- local meta = { __index = function ( t, k )
-- 	-- body
-- 	local WinSize=CCDirector:sharedDirector():getWinSize()
-- 	Global.WinSize = WinSize

-- 	print('------Global.WinSize------')
-- 	print('width = '..WinSize.width..' , height = '..WinSize.height)

-- 	return Global.WinSize
-- end}

-- setmetatable(Global, meta)

Global.getWidth = getWidth
Global.getHeight = getHeight

print('------Global.DesignSize------')
print('width = '..getWidth()..' , height = '..getHeight() )

local WinSize=CCDirector:sharedDirector():getWinSize()
print('------Global.WinSize------')
print('width = '..WinSize.width..' , height = '..WinSize.height)

Global.Battle_Use_View = true

return Global
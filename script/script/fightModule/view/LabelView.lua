local LabelUtils = require 'LabelUtils'
local ViewCache = require 'ViewCache'.new()

local LabelView = class( require 'AbsView' )

--[[
异常文字
LabelUtils.Label_BaoJi 		= '@BaoJiWenZi'
LabelUtils.Label_DongJie 	= '@DongJieWenZi'
LabelUtils.Label_HuanShu 	= '@HuanSuWenZi'
LabelUtils.Label_HunMi 		= '@HunMiWenZi'
LabelUtils.Label_MianYi 	= '@MianYiWenZi'
LabelUtils.Label_ZhiMang 	= '@ZhiMangWenZi'
LabelUtils.Label_ZhongDu 	= '@ZhongDuWenZi'
LabelUtils.Label_WuDi 		= '@WuDi'
--]]

function LabelView:ctor( label )
	-- body
	-- assert(false)

	self:setXmlName('LabelSet')
	self:setXmlGroup('Fight')	

	self._luaset =  self:createDyLuaset( label )
	
	self._luaset[1]:setScale(1)

	self._key = label

	-- print( 'create '..label )

	self:reset()
end

function LabelView:getKey()
	-- body
	return self._key
end

function LabelView:reset()
	-- body
	self._luaset[1]:setListener(function ( ... )
		-- body
		ViewCache:recycle(self)

		self._luaset[1]:removeFromParent()
		-- self:dispose()
	end)
	self._luaset[1]:start()
end

local function clean()
	-- body
	ViewCache:clean()
end

local function initViewCache()
	-- body
	clean()

	ViewCache:setCreator(function ( label )
		-- body
		return LabelView.new( label )
	end)

	for i=1, 8 do
		ViewCache:createCache(LabelUtils.Label_BaoJi )
	end

	-- for i=1, 4 do
	-- 	ViewCache:createCache(LabelUtils.Label_BaoJi )
	-- end
end

-- initViewCache()

local function createLabelView( label )
	-- body
	local view = ViewCache:getCache(label)
	if view then
		view:reset()
		return view
	else
		-- assert(false)
		-- debug.catch(true, 'no label cache')
		return LabelView.new( label )
	end
end



return { initViewCache = initViewCache, createLabelView = createLabelView, clean = clean }
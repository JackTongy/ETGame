-----------------------action-----------------
local SwfActionFactory 		= require 'framework.swf.SwfActionFactory'
local Action_putongwenzi 	= require 'QAction_putongwenzi'
local Action_baojiwenzi 	= require 'QAction_baojiwenzi'
local Action_dazhaowenzi 	= require 'QAction_dazhaowenzi'
local SkillUtil 			= require 'SkillUtil'

local Key_ZhiLiao 	= 1
local Key_DaZhao 	= 2
local Key_BaoJi 	= 3
local Key_PuTong 	= 4

local ActionCache = {}
ActionCache[Key_DaZhao] 	= SwfActionFactory.createAction( Action_dazhaowenzi,nil,nil,20 );
ActionCache[Key_BaoJi] 		= SwfActionFactory.createAction( Action_baojiwenzi,nil,nil,20 );
ActionCache[Key_ZhiLiao] 	= SwfActionFactory.createAction( Action_putongwenzi,nil,nil,20 );
ActionCache[Key_PuTong] 	= SwfActionFactory.createAction( Action_putongwenzi,nil,nil,20 );

ActionCache[Key_DaZhao]:retain()
ActionCache[Key_BaoJi]:retain()
ActionCache[Key_ZhiLiao]:retain()
ActionCache[Key_PuTong]:retain()





-----------------------NumberView-----------------------
local XmlCache = require 'XmlCache'
local CfgHelper = require 'CfgHelper'
local ViewCache = require 'ViewCache'.new()


local function value2key( number, skillId, isCrit )
	-- body
	if number == 0 then
		local skillVo = CfgHelper.getCache('skill','id',skillId)
		if skillVo then
			if skillVo.skilltype == SkillUtil.SkillType_DaZhaoZhiLiao then
				return Key_ZhiLiao
			elseif skillVo.skilltype == SkillUtil.SkillType_Dance then
				return Key_ZhiLiao
			else
				return nil
			end
		else
			-- 来自被动? , buff ?
			return Key_ZhiLiao
		end
	end


	if number > 0 then

		return Key_ZhiLiao

	elseif isCrit then

		return Key_BaoJi

	elseif skillId then
		local skillVo = CfgHelper.getCache('skill','id',skillId)
		isBigSkill = skillVo.skilltype >= 10

		if isBigSkill then
			return Key_DaZhao
		else
			return Key_PuTong
		end
	else
		--比如中毒
		return Key_PuTong
	end
end

local ViewToActionMap = {}

local NumberView = class( require 'AbsView' )

function NumberView:ctor( number, skillId, isCrit )
	-- body
	-- assert(false)
	
	self:setXmlName('NumberSet')
	self:setXmlGroup('Fight')

	if skillId == nil then
		self:initByKey(number)
	else
		self:initByArgs(number, skillId, isCrit)
	end
end

function NumberView:initByKey( key )
	-- body
	self._luaset = { [1] = true }

	local node
	if key == Key_ZhiLiao then
		node = CCLabelBMFont:create('', 'bmfont/health.fnt')

	elseif key == Key_DaZhao then
		node = CCLabelBMFont:create('', 'bmfont/critical.fnt')

	elseif key == Key_BaoJi then
		node = CCLabelBMFont:create('', 'bmfont/normal.fnt')

	elseif key == Key_PuTong then
		node = CCLabelBMFont:create('', 'bmfont/normal.fnt')
	else
		-- assert(false, tostring(key))
		key = Key_PuTong 
		node = CCLabelBMFont:create('', 'bmfont/normal.fnt')
	end

	node:setWidth(300)
	node:setAlignment(kCCTextAlignmentCenter)
	node:setAnchorPoint(ccp(0.5,0.5))

	self._luaset[1] = node
	self._key = key

	local elfAction = ActionCache[self._key]:clone()
	ViewToActionMap[self] = elfAction
	elfAction:retain()

	elfAction:setListener(function ( )
		ViewCache:recycle(self)
		node:removeFromParentAndCleanup(true)
	end)

end

function NumberView:initByArgs( number, skillId, isCrit )
	-- body
	local key = value2key(number, skillId, isCrit)
	self:initByKey(key)
end

function NumberView:getKey()
	-- body
	return self._key
end

function NumberView:show( number )
	-- body
	local node = self._luaset[1]

	if self._key == Key_ZhiLiao then
		node:setString( '+'..math.floor(math.abs(number)+0.5) )
	else
		node:setString( tostring(math.floor(math.abs(number)+0.5)) )
	end

	node:setScale(1)
	node:setOpacity(255)

	node:setPosition(ccp(25, 25))

	-- local elfAction
	-- if self._key == Key_ZhiLiao then
	-- 	elfAction = SwfActionFactory.createAction( Action_putongwenzi,nil,nil,20 )
	-- elseif self._key == Key_PuTong then
	-- 	elfAction = SwfActionFactory.createAction( Action_putongwenzi,nil,nil,20 )
	-- elseif self._key == Key_BaoJi then
	-- 	elfAction = SwfActionFactory.createAction( Action_baojiwenzi,nil,nil,20 )
	-- elseif self._key == Key_DaZhao then
	-- 	elfAction = SwfActionFactory.createAction( Action_baojiwenzi,nil,nil,20 )
	-- end

	local elfAction = ViewToActionMap[self]

	node:stopAllActions()
	node:runAction(elfAction)
end

local function clean()
	-- body
	ViewCache:clean()

	if ViewToActionMap then
		for i,v in pairs(ViewToActionMap) do
			v:release()
		end

		ViewToActionMap = {}
	end
end  


local function initViewCache()
	-- body
	clean()

	ViewCache:setCreator( function ( ... )
		-- body
		return NumberView.new(...)
	end)

	-------------------------------------
	for i=1, 4 do
		ViewCache:createCache(Key_DaZhao)
	end
	-------------------------------------
	for i=1, 8 do
		ViewCache:createCache(Key_ZhiLiao)
	end
	-------------------------------------
	for i=1, 16 do
		ViewCache:createCache(Key_PuTong)
	end
	-------------------------------------
	for i=1, 16 do
		ViewCache:createCache(Key_BaoJi)
	end
end

-- initViewCache()

function showNumber(node, number, skillId, isCrit )
	-- body
	local key = value2key(number, skillId, isCrit)

	if key then
		local view = ViewCache:getCache(key)
		if not view then
			view = NumberView.new(number, skillId, isCrit)
		end

		if view then
			view:show( number)
			node:addChild( view:getRootNode() )
		end
	end
end


return { initViewCache = initViewCache, showNumber = showNumber, clean = clean }

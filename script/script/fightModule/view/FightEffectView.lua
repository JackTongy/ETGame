local Utils = require 'framework.helper.Utils'

local ViewCache = require 'ViewCache'.new()

local FightEffectView = class(require 'AbsView')

local KeyCache = {}

function moduleid2key( moduleid )
	-- body
	local str = KeyCache[moduleid]

	if not str then
		local originModule = moduleid

		if type(moduleid) == 'number' then

			local negtive = (moduleid < 0 and '-') or ''
			moduleid = math.abs(moduleid)

			if moduleid <= 0 then
				return
			end

			if moduleid < 10 then
				str = '@'..negtive..'000'..moduleid
			elseif moduleid < 100 then
				str = '@'..negtive..'00'..moduleid
			elseif moduleid < 1000 then
				str = '@'..negtive..'0'..moduleid
			else
				str = '@'..negtive..moduleid
			end

			-- str = '@'..negtive..moduleid
		else
			str = '@'..moduleid
		end

		KeyCache[originModule] = str
	end

	return str
end

function FightEffectView:ctor(moduleid)
	-- body
	-- assert(false)
	
	self:setXmlName('FightEffectSet')
	self:setXmlGroup('FightEffect')

	--not clean up ???

	self._moduleid = moduleid
	local str = moduleid2key(moduleid)
	self._moduleStr = str

	local luaset = self:createDyLuaset(str)
	self._luaset = luaset
	local root = luaset[1]

	local objType = tolua.type(root)
	self._objType = objType

	local x,y = root:getPosition()
	self._pos = { x, y }

	print(''..str..' pos:'..self._pos[1]..','..self._pos[2])

	self._scaleX = root:getScaleX()
	self._scaleY = root:getScaleY()

	if objType == 'FlashMainNode' then
		-- root:setETCAlphaEnable(true)
		root:setVisible(true)

		local mc = root:getModifierControllerByName('swf');
		mc:setLoops(1)

		root:playWithCallback('swf', function ()
			-- body
			self:finalDisposed()
		end)

		local Device = require 'framework.basic.Device'
		if Device.platform == "android" then
			root:setShaderVertFrag(NULL, 'shaders/elf_hero_etc.fsh')
		end

	elseif objType == 'JointAnimateNode' then
		
		root:setProgressTime(0)
		--暂时默认循环一次
		root:setLoops(1)
		root:start()
		root:setListener(function ()
			-- body
			self:finalDisposed()
		end)

		root:reload()

		local Device = require 'framework.basic.Device'
		if Device.platform == "android" then
			root:setETCAlphaDeepEnable(true)
		end

		self._step0 = root:getStepLoops(0)
		self._step1 = root:getStepLoops(1)
		self._step2 = root:getStepLoops(2)

		print(string.format('moduleid=%s, step0=%d, step1=%d, step2=%d', tostring(moduleid), self._step0, self._step1, self._step2))

	else
		error(objType)
	end
end

function FightEffectView:getKey()
	-- body
	return self._moduleid
end

function FightEffectView:getModuleId()
	-- body
	return self._moduleid
end

function FightEffectView:getObjType()
	-- body
	return self._objType
end

function FightEffectView:setVisible(visible)
	-- body
	if not self:isDisposed() then
		visible = (visible and true) or false
		self._luaset[1]:setVisible(visible)
	end
end

function FightEffectView:setStep1Loops( loops )
	-- body
	-- self._luaset[1]:setLoop1( loops )
	if self:getObjType() == 'JointAnimateNode' then
		self._luaset[1]:setStepLoops( loops, 1)
	end
end

function FightEffectView:setStep1Life( life )
	-- body
	if self:getObjType() == 'JointAnimateNode' then
		local frames = self._luaset[1]:getFrameCountByStep(1)
		local perTime = self._luaset[1]:getFrameDelay()

		life = life * 1000

		local loops = math.floor( life / (frames*perTime) )
		self._luaset[1]:setLoop1( loops )
	end
end

function FightEffectView:finalDisposed(  )
	-- body
	ViewCache:recycle( self, self:getModuleId() )

	local root = self._luaset[1]

	if root and not tolua.isnull(root) then
		root:resetListener()

		root:removeFromParent()
		-- print('finalDisposed '..self._moduleStr)
	end
	
	self._dead = true
end

function FightEffectView:setDisposed()
	-- body
	local root = self._luaset[1]

	if not self._dead then
		self._dead = true

		if self:getObjType() == 'JointAnimateNode' then
			if root and not tolua.isnull(root) then
				root:setStepLoops( 0, 0)
				root:setStepLoops( 0, 1)
				root:setStepLoops( 1, 2)

				root:setLoops(1)

				root:setProgressTime(0)

				root:setListener(function ( ... )
					-- body
					self:finalDisposed()
				end)
			end
		elseif self:getObjType() == 'FlashMainNode' then
			self:finalDisposed()
		end
	end
end

function FightEffectView:getLastStepTime()
	-- body
	if not self:isDisposed() and self:getObjType() == 'JointAnimateNode' then
		local root = self._luaset[1]

		local count = root:getFrameCountByStep(2)
		local fdelay = root:getFrameDelay()

		return count * fdelay
	end

	return 0
end

function FightEffectView:getFirstStepTime()
	-- body
	if not self:isDisposed() and self:getObjType() == 'JointAnimateNode' then
		local root = self._luaset[1]
		
		local count = root:getFrameCountByStep(0)
		local fdelay = root:getFrameDelay()

		return count * fdelay
	end

	return 0
end

function FightEffectView:reset()
	-- body
	self._dead = false
	local root = self:getRootNode()

	assert(root)

	root:setPosition(ccp(self._pos[1], self._pos[2]))
	root:setScaleX( self._scaleX )
	root:setScaleY( self._scaleY )

	if self._objType == 'FlashMainNode' then
		root:setVisible(true)

		local mc = root:getModifierControllerByName('swf');
		mc:setLoops(1)

		root:playWithCallback('swf', function ()
			-- body
			self:finalDisposed()
		end)

	elseif self._objType == 'JointAnimateNode' then
		root:setProgressTime(0)
		--暂时默认循环一次
		root:setLoops(1)
		root:start()
		root:setListener(function ()
			-- body
			self:finalDisposed()
		end)

		-- self._step0 = root:getStepLoops(0)
		-- self._step1 = root:getStepLoops(1)
		-- self._step2 = root:getStepLoops(2)

		root:setStepLoops(self._step0, 0)
		root:setStepLoops(self._step1, 1)
		root:setStepLoops(self._step2, 2)
	else
		error(objType)
	end
end

function FightEffectView:setAutoRemoveFromParent( auto, func )
	-- body
	if self._objType == 'FlashMainNode' then
		if auto then
			self._luaset[1]:playWithCallback('swf', function ()
				-- body
				if func then
					func()
					func = nil
				end
				self:finalDisposed()
			end)
		else
			self._luaset[1]:playWithCallback('swf', function ()
				-- body
				if func then
					func()
					func = nil
				end
				-- self:finalDisposed()
			end)
		end

	elseif self._objType == 'JointAnimateNode' then
		if auto then
			self._luaset[1]:setListener(function ()
				-- body
				if func then
					func()
					func = nil
				end

				self:finalDisposed()
			end)
		else	
			self._luaset[1]:setListener(function ()
				-- body
				-- self._luaset[1]:removeFromParent()
				if func then
					func()
					func = nil
				end
			end)
		end

	end
end

local function create(moduleid)
	-- body

	-- print('准备生成 FightEffect '..moduleid)
	return Utils.calcDeltaTime(function ()
		-- body
		local view = ViewCache:getCache(moduleid)
		if view then
			print('缓存获得 FightEffect '.. moduleid)
			view:reset()
			return view
		else
			-- assert(false, 'moduleid = '..moduleid)
			-- assert(false) 
			print('新创建生成 FightEffect '..moduleid)
			return FightEffectView.new(moduleid)
		end
		
	end, '生成FightEffect'..moduleid..',时间')
end

local function createCache( args, num )
	-- body
	ViewCache:createCache(args, num)
end

local function clean()
	-- body
	ViewCache:clean()
end

local function new( moduleid )
	-- body
	return FightEffectView.new(moduleid)
end

ViewCache:setCreator( function ( moduleid )
	-- body
	return FightEffectView.new(moduleid)
end )

return { create = create,  createCache = createCache, clean = clean, new = new }
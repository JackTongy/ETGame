local TimerHelper = require 'framework.sync.TimerHelper'

local ViewCache = class()

function ViewCache:ctor()
	-- body
	self._cache = {}
end

function ViewCache:setCreator( creator )
	-- body
	self._creator = creator
end

function ViewCache:recycle(view)
	-- body
	-- local root = view:getRootNode()
	-- assert(root)
	if view then
		local key = view:getKey()
		assert(key)
		local array = self._cache[key]
		if not array then
			array = {}
			self._cache[key] = array
		end

		table.insert(array, view)
		view:retain()

		return view
	end
end

function ViewCache:getCache( key )
	-- body
	local array = self._cache[key]
	if array then
		local index = 1
		local view = array[index]

		if view then
			table.remove(array, index)

			TimerHelper.tick(function ()
				-- body
				
				-- if root then
				-- 	print('ViewCache release '..key)
				-- 	root:release()
				-- else
				-- 	debug.catch(true, 'getCache')
				-- end

				local rootNode = view:getRootNode()
				if rootNode and rootNode:isSingleReference() then
					rootNode:cleanup()
				end
				
				view:release()

				return true
			end)

			return view
		end
	end
end

function ViewCache:clean()
	-- body
	for i,v in pairs(self._cache) do
		for ii, vv in ipairs(v) do
			local rootNode = vv:getRootNode()
			if rootNode then
				rootNode:cleanup()
			end
			vv:release()
		end
	end

	self._cache = {}
end

function ViewCache:createCache( ... )
	-- body
	assert(self._creator)
	-- num = num or 1
	local view = self._creator(...)
	
	self:recycle(view)
end

return ViewCache
local RawCFunc = {}

local basic = _G
local self = {}

function RawCFunc.initClass( classname )
	-- body
	assert(classname)
	assert(self[classname] == nil)

	assert(basic[classname])

	self[classname] = {}

	for i,v in pairs( basic[classname] ) do
		if type(v) == 'function' and string.sub(i, 1, 2) ~= '__' then
			print(string.format('RawCFunc	%s:%s', classname, i))
			self[classname][i] = v
		end
	end
end

function RawCFunc.getFunction( classname, functionname )
	-- body
	assert(classname)
	assert(functionname)

	assert(self[classname])
	assert(self[classname][functionname])

	return self[classname][functionname]
end

RawCFunc.initClass('GleeCore')

return RawCFunc
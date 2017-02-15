local bit = require 'framework.libluabit.bit'

local Security = class()

function Security:ctor()
	-- body
	self._value1 = nil
	self._value2 = nil
end

function Security:get()
	-- body
	if self:check() then
		return self._value1
	else
		error('篡改内存数据!')
	end
end

function Security:check()
	-- body
	if self._value1 == nil then
		return true
	end

	return self._value2 == self:calcValue2(self._value1)
end

function Security:calcValue2(value1)
	--校验到3位小数点
	local int = math.floor(value1*1000) * 0x343FD + 0x269EC3
	return bit.band( bit.brshift(int, 0x10) , 0x7FFF )
end

function Security:set( value )
	-- body
	if value == nil then
		self._value1 = nil
		self._value2 = nil
	else
		assert(type(value) == 'number')

		self._value1 = value
		self._value2 = self:calcValue2(value)
	end
end


--test
--[[
print('Security:test')
local data = Security.new()
data:set(1234)
print(data:get())

data:set(1234.99999)
print(data:get())

data:set(nil)
print(data:get())

-- data:set('hello')
-- print(data:get())
--]]

return Security
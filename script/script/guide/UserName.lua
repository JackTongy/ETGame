local playername = require 'playername'
local first 	= nil
local second 	= nil
local third 	= nil 

math.randomseed(os.time())

local function randomName ()
	if not playername then
		return ''
	end

	if not first or not second or not third then
		first = {}
		second = {}
		third = {}

		for k,v in pairs(playername) do
			if v.name1 ~= 'NULL' then
				table.insert(first,v.name1)
			end
			if v.name2 ~= 'NULL' then
				table.insert(second,v.name2)
			end
			if v.name3 ~= 'NULL' then
				table.insert(third,v.name3)
			end
		end
	end

	local fir = tostring(#first > 0 and first[math.random(1,#first)] or '')
	local sec = tostring(#second > 0 and second[math.random(1,#second)] or '')
	local thi = tostring(#third > 0 and third[math.random(1,#third)] or '')
	return string.format('%s%s%s',fir,sec,thi)
end

return {randomName=randomName}
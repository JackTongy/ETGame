-- ActionViewLuaset
local CfgHelper = require 'CfgHelper'
local SkinManager = require 'SkinManager'

--根据角色id获得对应luaset
local XmlCache = require 'XmlCache'

function createActionLuasetById( charctorid )
	-- body
	-- print('createActionLuasetById')
	-- print(charctorid)
	local name = SkinManager.getRoleXMLByCharactorId(charctorid)

	print('charactorId -> rolexml = '..charctorid..' -> '.. name)
	-- 1. find skin by id
	-- local skin = tostring( charctorid2skin( charctorid ) )

	-- ResConverterManager:clear()
	-- for i,v in pairs(resmap) do 
	-- 	ResConverterManager:put(i, string.format(v, skin))
	-- end

	-- 2. find xmlname by id
	-- local name = charctorid2name(charctorid)

	--[[
	生成动作时间大致 40ms+
	--]]
	local luaset = XmlCache.createDyLuaset('hero', name, 'Fight' )

	-- ResConverterManager:clear() 

	return luaset
end

return { createActionLuasetById = createActionLuasetById }
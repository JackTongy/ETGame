-- XmlCache
local Config = require 'Config'
local Factory = XMLFactory:getInstance()
local Utils = require 'framework.helper.Utils'
local FightSettings = require 'FightSettings'

local data_cacheXml = {}


local function getItemCache(  xmlname, group  )
	-- body
	-- assert(group == 'Fight')
	local cache = data_cacheXml
	if group then
		cache = data_cacheXml[group]

		if not cache then
			cache = {}
			data_cacheXml[group] = cache
		end
	end

	local item = cache[xmlname]

	if not item then
		local xml = Factory:setZipFilePath(Config.COCOS_ZIP_DIR..xmlname..".cocos.zip")
		xml = Factory:createDocument(xmlname..".cocos")

		if FightSettings.isLocked() then
			-- debug.catch(true, ' open xml '..xmlname)
		end

		xml:retain()

		item = { xml = xml, map = {} }
		cache[xmlname] = item
	end

	return item
end

--[[
根据xml名称, 获得xml的document, 带cache功能, group带分组(便于下次根据分组来释放)
--]]
local function getXmlCache( xmlname, group )
	-- body
	local item = getItemCache( xmlname, group )
	return item.xml
end

local function getElementCache( elementname, xmlname, group )
	-- body
	local item = getItemCache(xmlname, group)

	local elementMap = item.map

	local element = elementMap[elementname]
	if not element then
		element = Factory:findElementByName(item.xml, elementname)
		element:retain()
		elementMap[elementname] = element
	end

	return element
end

local function releaseItem( item )
	-- body
	item.xml:release()
	for i,v in pairs (item.map) do
		v:release()
	end
end

--[[
传入 group 或者 xml名称, 对改组或该xml清除掉
--]]
local cleanXmlCache
cleanXmlCache = function( grouporxml )
	-- body
	-- assert(grouporxml == 'Fight')

	if grouporxml then

		local value = data_cacheXml[grouporxml]
		if value then
			local mytype = type(value) 
			if mytype == 'table' then
				for xml,item in pairs(value) do 
					releaseItem(item)
				end

				data_cacheXml[grouporxml] = nil


			elseif mytype == 'userdata' then
				releaseItem(value)
				data_cacheXml[grouporxml] = nil
			else
				assert(false, 'Unexpected type '..mytype..' by '..grouporxml)
			end
		else
			print('warning: cleanXmlCache, not found '..grouporxml..' in cache!')
		end
	else
		for i,v in pairs(data_cacheXml) do
			cleanXmlCache(i)
		end
	end
end

local function printWithTabs( tabs, message )
	-- body
	local array = {}
	for i=1,tabs do 
		table.insert(array, "\t")
	end
	table.insert(array, tostring(message))

	print( table.concat(array) )
end

--[[
用来debug当前已经缓存的xml
--]]
local printCacheXml 
printCacheXml =  function(map, tabs )
	-- body
	map = map or data_cacheXml
	tabs = tabs or 0

	for i,v in pairs(map) do
		local mytype = type(v)
		if mytype == 'table' then
			printWithTabs(tabs, 'in->'..i)
			printCacheXml(v, tabs+1)
		elseif mytype == 'userdata' then
			printWithTabs(tabs, i)
		else
			assert(false, 'Unexpected type '..mytype..' by '..i)
		end
	end
end

local function createDyLuaset( elementname, xmlname, groupname )
	-- body
	-- assert(groupname == 'Fight')

	-- local xml = 
	local ele = getElementCache(elementname, xmlname, groupname)
	assert(ele) 
	local cset = Factory:createWithElement(ele)
	local luaset = Utils.toluaSet(cset)
	return luaset
end

return { getXmlCache = getXmlCache, cleanXmlCache = cleanXmlCache, printCacheXml = printCacheXml,createDyLuaset = createDyLuaset }
--print("load gvc_helper")

local function split(str, delimiter)
    str = tostring(str)
    delimiter = tostring(delimiter)
    if (delimiter=='') then return false end
    local pos,arr = 0, {}
    -- for each divider found
    for st,sp in function() return string.find(str, delimiter, pos, true) end do
        table.insert(arr, string.sub(str, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(str, pos))
    return arr
end

local function sum(gvcArray1, gvcArray2)
	local gvcMap1 = {}
	local gvcMap2 = {}
	
	for i,v in pairs (gvcArray1) do
		gvcMap1[v.key] = v
	end
	
	for i,v in pairs (gvcArray2) do
		gvcMap2[v.key] = v
	end
	
	local commonMap = {}
	for i,v in pairs(gvcMap1) do
		if gvcMap2[i] then
			commonMap[i] = true
		end
	end
	
	local gvcArray = {}
	
	--remain1
	for i,v in pairs(gvcMap1) do
		if not commonMap[i] then
			table.insert(gvcArray, v)
		end
	end
	
	--remain2
	for i,v in pairs(gvcMap2) do
		if not commonMap[i] then
			table.insert(gvcArray, v)
		end
	end
	
	for i,v in pairs(commonMap) do
		local gvc1 = gvcMap1[i]
		local gvc2 = gvcMap2[i]
		if gvc1.type == gvc2.type then
			if gvc1.type == 'M' then
				local newGVC = {}
				newGVC.type = 'M'
				newGVC.key = i
				newGVC.newVersion = gvc2.newVersion
				newGVC.oldVersion = gvc1.oldVersion
				newGVC.newSize = gvc2.newSize
				newGVC.oldSize = gvc1.oldSize
				
				table.insert(gvcArray, newGVC)
			else
				error("sum: gvc2.type should be M")
			end
		elseif gvc1.type == 'A' then
			if gvc2.type == 'M' then
				local newGVC = {}
				newGVC.type = 'A'
				newGVC.key = i
				newGVC.newVersion = gvc2.newVersion
				newGVC.newSize = gvc2.newSize
				
				table.insert(gvcArray, newGVC)
			else
				--gvc2.type == 'R' do nothing
			end 
		elseif gvc1.type == 'R' then
			if gvc2.type == 'A' then
				local newGVC = {}
				newGVC.type = 'M'
				newGVC.key = i
				newGVC.newVersion = gvc2.newVersion
				newGVC.oldVersion = gvc1.newVersion
				newGVC.newSize = gvc2.newSize
				newGVC.oldSize = gvc1.newSize
				
				table.insert(gvcArray, newGVC)
			else
				error("sum: gvc2.type should be A")
			end
		elseif gvc1.type == 'M' then
			if gvc2.type == 'R' then
				local newGVC = {}
				newGVC.type = 'R'
				newGVC.key = i
				newGVC.newVersion = gvc1.oldVersion
				newGVC.newSize = gvc2.oldSize
				
				table.insert(gvcArray, newGVC) 
			else
				error("sum: gvc2.type should be R")
			end
		else
			error("sum: unknown type of gvc1 "..gvc1.type)
		end
	end
	
	return gvcArray
end

local function arrayFromString(gvc_content)
	
	local gvcArray = {} 

	if not gvc_content then
		return gvcArray
	end
	
	string.gsub(gvc_content, "A#(%S+)#(%d+)#(%d+)%s*\n", function(relativePath, version, size)
		local gvc = {}
		gvc.key = table.concat( split(relativePath,'\\'), '/')
		gvc.type = 'A'
		gvc.newVersion = version
		gvc.newSize = size
		
		table.insert(gvcArray, gvc)
	end)

	string.gsub(gvc_content, "R#(%S+)#(%d+)#(%d+)%s*\n", function(relativePath, version, size)
		local gvc = {}
		gvc.key = table.concat( split(relativePath,'\\'), '/')
		gvc.type = 'R'
		gvc.newVersion = version
		gvc.newSize = size
		
		table.insert(gvcArray, gvc)
	end)
	
	string.gsub(gvc_content, "M#(%S+)#(%d+)#(%d+)#(%d+)#(%d+)%s*\n", function(relativePath,version,oldVersion,size,oldSize)
		local gvc = {}
		gvc.key = table.concat( split(relativePath,'\\'), '/')
		gvc.type = 'M'
		gvc.newVersion = version
		gvc.oldVersion = oldVersion
		gvc.newSize = size
		gvc.oldSize = oldSize
		
		table.insert(gvcArray, gvc)
	end)

	-- for i,v in pairs(gvcArray) do
	-- 	print("i="..i.."="..v.type)
	-- end
	
	return gvcArray
end

local function arrayToString(array)
	assert(array ~= nil)

	local lines = {}
	local line

	for i, v in pairs(array) do
		if v.type == 'M' then
			line = string.format("M#%s#%d#%d#%d#%d", v.key, v.newVersion, v.oldVersion, v.newSize, v.oldSize)
		elseif v.type == 'A' then
			line = string.format("A#%s#%d#%d", v.key, v.newVersion, v.newSize)
		elseif v.type == 'R' then
			line = string.format("R#%s#%d#%d", v.key, v.newVersion, v.newSize)
		end

		table.insert(lines, line)
	end
	
	table.insert(lines, '\n')
	
	return table.concat(lines,'\n')
end

return {sum = sum, arrayFromString = arrayFromString, arrayToString = arrayToString }


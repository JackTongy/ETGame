
local json = {}

local function is_table_empty( ptable )
	-- body
	if _G.next(ptable) == nil then
		return true
	else 
		return false
	end
end

local function tableReduced( ptable )
	-- body
	if type(ptable) ~= 'table' then
		return 
	end

	for i, v in pairs(ptable) do
		if type(v) == 'table' then
			if is_table_empty(v) then
				ptable[i] = nil
			else 
				tableReduced(v)
			end
		end
	end 
end

function json.encode(var)
	--ensure empty
	tableReduced(var)

	print(var)

    local status, result = pcall(cjson.encode, var)
    if status then return result end

    print("json.encode() - encoding failed: %s", tostring(result))
end

function json.decode(text)
    local status, result = pcall(cjson.decode, text)
    if status then return result end

    print("json.decode() - decoding failed: %s", tostring(result))
end

return require 'framework.basic.MetaHelper'.createShell(json)

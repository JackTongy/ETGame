local Utils = require 'framework.helper.Utils'

-- assert(false)
local FightConfigData

do
	local default = Utils.readTableFromFile('CLoginP')
	local key = tostring(default and default.RoleID)
	FightConfigData = Utils.readTableFromFile('FightConfig'..key)
end

if not FightConfigData then
	FightConfigData = {}
	FightConfigData.Auto_AI = false
	FightConfigData.Accelerate = false
end

-- FightConfigData.Accelerate = false

local Funcs = {}
Funcs.save = function ()
	-- body
	local default = Utils.readTableFromFile('CLoginP')
	local key = tostring(default and default.RoleID)
	Utils.writeTableToFile(FightConfigData, 'FightConfig'..key)
end

setmetatable(FightConfigData,  { __index = Funcs } )

return FightConfigData
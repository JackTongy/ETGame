local charectorConfig = require 'charactorConfig'

local manager = {}

local dict = {}

for k,charactorConfigBasicVo in pairs(charectorConfig) do
	-- if charactorConfigBasicVo.id==charactorId then
	-- 	return charactorConfigBasicVo
	-- end	
	if charactorConfigBasicVo.id then
		dict[charactorConfigBasicVo.id]=charactorConfigBasicVo
	end
	
end


function manager.getCharactorBasicVo( charactorId )
	-- for k,charactorConfigBasicVo in pairs(charectorConfig) do
	-- 	if charactorConfigBasicVo.id==charactorId then
	-- 		return charactorConfigBasicVo
	-- 	end	
	-- end
	local  vo = dict[charactorId]
	assert(vo,'charectorConfig表数据错误:'..tostring(charactorId))
	return vo
end

return manager
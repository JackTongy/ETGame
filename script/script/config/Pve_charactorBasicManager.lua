local pve_charactor = require "pve_charactor"
local pve_charactorBasicManager = {}
pve_charactorBasicManager.dict={}

for k,v in pairs(pve_charactor) do
	pve_charactorBasicManager.dict[pve_charactor.heroid]=v
end


function pve_charactorBasicManager.getPve_CharactorBasicVo(monster_id)
	return pve_charactorBasicManager.dict[monster_id]
end

return pve_charactorBasicManager
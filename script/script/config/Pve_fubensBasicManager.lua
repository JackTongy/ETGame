local pve_fubens = require "pve_fubens"

local pve_fubensBasicManager = {}
pve_fubensBasicManager.dict={}

for k,v in pairs(pve_fubens) do
	pve_fubensBasicManager.dict[v.fubenid]=v
end


function pve_fubensBasicManager.getPve_fubensBasicVo(fuben_id)
	return 	pve_fubensBasicManager.dict[fuben_id]
end

return pve_fubensBasicManager
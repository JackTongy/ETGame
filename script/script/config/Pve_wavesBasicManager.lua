local pve_waves = require 'pve_waves'

local pve_wavesBasicManager = {}
pve_wavesBasicManager.dict={}
for k,v in pairs(pve_waves) do
	if not  pve_wavesBasicManager.dict[v.waveid] then
   	 pve_wavesBasicManager.dict[v.waveid]={}
	end
	table.insert(pve_wavesBasicManager.dict[v.waveid],v)
end

function pve_wavesBasicManager.getPve_wavesBasicVoArr( waveid )
	-- body
	return pve_wavesBasicManager.dict[waveid]
end

return pve_wavesBasicManager

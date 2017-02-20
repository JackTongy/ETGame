local pve_monster = require "pve_monster"
local pve_monsterBasicManager = {}
pve_monsterBasicManager.dict={}

for k,v in pairs(pve_monster) do
	pve_monsterBasicManager.dict[v.heroid]=v
end

function pve_monsterBasicManager.getMonsterBasicVo(monster_id)
	return pve_monsterBasicManager.dict[monster_id]
end

return pve_monsterBasicManager
local pve_teamsBasicManager = {}
pve_teamsBasicManager.dict={}

local pve_teams = require 'pve_teams'
--获取pve 数据
-- function pve_teamsBasicManager.getPveBasicVo(teamId)
-- 	-- body
-- 	pve_teamsBasicManager.initAllData()
-- end

function pve_teamsBasicManager:initAllData(  )
	if  not pve_teamsBasicManager.hasInit then
		pve_teamsBasicManager.hasInit=true
		for k,v in pairs(pve_teams) do
			pve_teamsBasicManager.dict[v.teamid] = v -- pve_teamsBasicManager.stringToArray(v,",")
		end
	end
end

--获取英雄id
function pve_teamsBasicManager.getHeroArray(teamid)
	pve_teamsBasicManager.initAllData()
	return pve_teamsBasicManager.dict[teamid]
end

function pve_teamsBasicManager.stringToArray(str,split_char)
    local sub_str_tab = {};
    while (true) do
        local pos = string.find(str, split_char);
        if (not pos) then
            sub_str_tab[#sub_str_tab + 1] = str;
            break;
        end
        local sub_str = string.sub(str, 1, pos - 1);
        sub_str_tab[#sub_str_tab + 1] = sub_str;
        str = string.sub(str, pos + 1, #str);
    end
    return sub_str_tab;
end

return pve_teamsBasicManager
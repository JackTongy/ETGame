--角色管理器
local serveManager = {}
serveManager.dict={}
function serveManager.addPlayer( serveRoleDyVo )
	serveManager.dict[serveRoleDyVo.playerId]=serveRoleDyVo
end

function serveManager.removePlayer( serveRoleDyVo )
	serveManager.dict[serveRoleDyVo.playerId]=nil
end
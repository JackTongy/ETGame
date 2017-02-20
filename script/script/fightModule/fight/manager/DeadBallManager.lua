local DeadBallManager = {}
local PlayerMap = {}

function DeadBallManager.checkDeadPlayer( playerId )
	-- body
	if playerId then
		PlayerMap[playerId] = PlayerMap[playerId] or 0
		PlayerMap[playerId] = PlayerMap[playerId] + 1
	end
end

function DeadBallManager.getDeadBall( playerId )
	-- body
	if playerId then

		local ret = PlayerMap[playerId] or 0
		PlayerMap[playerId] = nil

		return ret
	end

	return 0
end

return DeadBallManager
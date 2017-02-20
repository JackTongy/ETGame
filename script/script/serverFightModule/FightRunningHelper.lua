require 'TimeOut'

local FightRunningHelper = {}

function FightRunningHelper.delay( func, t )
	-- body
	local timeOut = TimeOut.new(t, function ()
		-- body		
		-- if tolua.isnull(LayerManager.bgLayer) then
		-- 	return true
		-- end
		
		func()
	end)

	timeOut:start()
end

return FightRunningHelper
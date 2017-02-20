local BlacklistFunc = {}
local BlacklistData = {}

function BlacklistFunc.setBlackList( list )
	BlacklistData = list
end

function BlacklistFunc.getBlackList( ... )
	return BlacklistData
end

function BlacklistFunc.clearBlackList( ... )
	BlacklistData = {}
end

function BlacklistFunc.remove( Rid )
	if BlacklistData then
		for i,v in ipairs(BlacklistData) do
			if v.Rid == Rid then
				table.remove(BlacklistData, i)
			end
		end
	end
end

function BlacklistFunc.isInBlacklist( Rid )
	if BlacklistData then
		for i,v in ipairs(BlacklistData) do
			if v.Rid == Rid then
				return true
			end
		end
	end
	return false
end

return BlacklistFunc
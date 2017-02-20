--pve 玩家id生成器

local creator = {}
creator._id = 1

--获取唯一id
function creator.getID()
	creator._id = creator._id + 1
	return creator._id
end

function creator.reset()
	-- body
	creator._id=1
end

return creator


local GridManager = require 'GridManager'

ServeMonsterDyVo = class(ServeRoleDyVo)

function ServeMonsterDyVo:ctor()
	self.entertime 		= 0
	self.enterposition 	= 0
	self.isboss 		= 0
	self.aiType 		= 0 --怪物的ai类型
end

--获取出生后的位置
function ServeMonsterDyVo:getBirthPos()
	return GridManager.getUICenterByIJ( -4, (self.enterposition or 1) - 2  )
end 
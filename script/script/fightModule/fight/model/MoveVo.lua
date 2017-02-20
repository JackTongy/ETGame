--[[

移动数据vo 保存坐标信息 
x  y 
]]

MoveVo=class()

function MoveVo:ctor(x, y)
	self.x= x or 0
	self.y= y or 0
end

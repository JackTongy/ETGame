--[[
	Id = nil
PetId = 神兽ID
Name = 神兽名称
Rate = 神兽概率
PetRate = 5星精灵概率
PetIdList = 备选精灵ID
Cost = 单抽价格
Cost10 = 十连价格
Vip = 所需VIP
fivestarPetList = 5星队伍列表

--]]
local _table = {
	[1] = {	Id = 243,	PetId = 243,	Name = [[雷皇]],	Rate = 0.0300,	PetRate = 0.1500,	PetIdList = {147,133,129,25,63},	Cost = 39,	Cost10 = 360,	Vip = 7,	fivestarPetList = {26,136,135,470,130,149},},
	[2] = {	Id = 244,	PetId = 244,	Name = [[炎帝]],	Rate = 0.0300,	PetRate = 0.1500,	PetIdList = {1,4,7,246,349},	Cost = 39,	Cost10 = 360,	Vip = 7,	fivestarPetList = {6,3,160,248,350,9},},
	[3] = {	Id = 245,	PetId = 245,	Name = [[水君]],	Rate = 0.0300,	PetRate = 0.1500,	PetIdList = {152,123,60,280,304},	Cost = 39,	Cost10 = 360,	Vip = 7,	fivestarPetList = {154,373,212,62,282,306},},
	[4] = {	Id = 483,	PetId = 483,	Name = [[帝牙卢卡]],	Rate = 0.0300,	PetRate = 0.0700,	PetIdList = {333,349,133},	Cost = 99,	Cost10 = 900,	Vip = 9,	fivestarPetList = {},},
	[5] = {	Id = 384,	PetId = 384,	Name = [[裂空座]],	Rate = 0.0300,	PetRate = 0.0700,	PetIdList = {255,147,152},	Cost = 99,	Cost10 = 900,	Vip = 9,	fivestarPetList = {},},
}

return _table

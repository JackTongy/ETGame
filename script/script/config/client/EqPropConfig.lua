--[[
	Id = Id
Prop = 属性
Name = 属性名
Des = 描述
Type = 加成类型
PurleLow = 紫装随机范围
PurleTop = nil
OrangeLow = 橙装随机范围
OrangeTop = nil
GoldLow = 金装随机范围
GoldTop = nil
RedLow = 红装随机范围
RedTop = nil

--]]
local _table = {
	[1] = {	Id = 1,	Prop = 1,	Name = [[攻击]],	Des = [[攻击]],	Type = 1,	PurleLow = 13,	PurleTop = 66,	OrangeLow = 80,	OrangeTop = 200,	GoldLow = 233,	GoldTop = 400,	RedLow = 433,	RedTop = 800,},
	[2] = {	Id = 2,	Prop = 2,	Name = [[伤害]],	Des = [[伤害]],	Type = 1,	PurleLow = 2,	PurleTop = 10,	OrangeLow = 13,	OrangeTop = 33,	GoldLow = 36,	GoldTop = 66,	RedLow = 73,	RedTop = 133,},
	[3] = {	Id = 3,	Prop = 3,	Name = [[防御]],	Des = [[防御]],	Type = 1,	PurleLow = 2,	PurleTop = 10,	OrangeLow = 13,	OrangeTop = 33,	GoldLow = 36,	GoldTop = 66,	RedLow = 73,	RedTop = 133,},
	[4] = {	Id = 4,	Prop = 4,	Name = [[生命]],	Des = [[生命]],	Type = 1,	PurleLow = 13,	PurleTop = 66,	OrangeLow = 80,	OrangeTop = 200,	GoldLow = 233,	GoldTop = 400,	RedLow = 433,	RedTop = 800,},
	[5] = {	Id = 5,	Prop = 5,	Name = [[免伤]],	Des = [[免伤]],	Type = 1,	PurleLow = 2,	PurleTop = 10,	OrangeLow = 13,	OrangeTop = 33,	GoldLow = 36,	GoldTop = 66,	RedLow = 73,	RedTop = 133,},
	[6] = {	Id = 6,	Prop = 6,	Name = [[攻击速度]],	Des = [[攻击速度]],	Type = 2,	PurleLow = 0.0020,	PurleTop = 0.0050,	OrangeLow = 0.0060,	OrangeTop = 0.0100,	GoldLow = 0.0120,	GoldTop = 0.0200,	RedLow = 0.0250,	RedTop = 0.0350,},
	[7] = {	Id = 7,	Prop = 7,	Name = [[破甲]],	Des = [[破甲]],	Type = 1,	PurleLow = 3,	PurleTop = 15,	OrangeLow = 20,	OrangeTop = 50,	GoldLow = 55,	GoldTop = 100,	RedLow = 110,	RedTop = 200,},
	[8] = {	Id = 8,	Prop = 8,	Name = [[暴击倍数]],	Des = [[暴击伤害倍数]],	Type = 2,	PurleLow = 0.0020,	PurleTop = 0.0050,	OrangeLow = 0.0060,	OrangeTop = 0.0100,	GoldLow = 0.0120,	GoldTop = 0.0200,	RedLow = 0.0250,	RedTop = 0.0350,},
	[9] = {	Id = 9,	Prop = 9,	Name = [[绝对防御]],	Des = [[受到攻击时，降低被无视防御的比例]],	Type = 2,	PurleLow = 0.0030,	PurleTop = 0.0060,	OrangeLow = 0.0080,	OrangeTop = 0.0150,	GoldLow = 0.0160,	GoldTop = 0.0250,	RedLow = 0.0300,	RedTop = 0.0500,},
	[10] = {	Id = 10,	Prop = 10,	Name = [[怒气回复]],	Des = [[怒气回复]],	Type = 2,	PurleLow = 0.0020,	PurleTop = 0.0050,	OrangeLow = 0.0060,	OrangeTop = 0.0100,	GoldLow = 0.0110,	GoldTop = 0.0200,	RedLow = 0.0220,	RedTop = 0.0350,},
	[11] = {	Id = 11,	Prop = 11,	Name = [[技能抗性]],	Des = [[技能抗性]],	Type = 2,	PurleLow = 0.0020,	PurleTop = 0.0050,	OrangeLow = 0.0060,	OrangeTop = 0.0100,	GoldLow = 0.0110,	GoldTop = 0.0200,	RedLow = 0.0220,	RedTop = 0.0350,},
	[12] = {	Id = 12,	Prop = 12,	Name = [[技能伤害]],	Des = [[技能伤害]],	Type = 2,	PurleLow = 0.0020,	PurleTop = 0.0050,	OrangeLow = 0.0060,	OrangeTop = 0.0100,	GoldLow = 0.0110,	GoldTop = 0.0200,	RedLow = 0.0220,	RedTop = 0.0350,},
	[13] = {	Id = 13,	Prop = 13,	Name = [[冻结抵抗]],	Des = [[降低受到的冻结持续时间]],	Type = 2,	PurleLow = 0.0050,	PurleTop = 0.0100,	OrangeLow = 0.0120,	OrangeTop = 0.0200,	GoldLow = 0.0210,	GoldTop = 0.0300,	RedLow = 0.0310,	RedTop = 0.0500,},
	[14] = {	Id = 14,	Prop = 14,	Name = [[中毒抵抗]],	Des = [[降低受到的中毒持续时间]],	Type = 2,	PurleLow = 0.0050,	PurleTop = 0.0100,	OrangeLow = 0.0120,	OrangeTop = 0.0200,	GoldLow = 0.0210,	GoldTop = 0.0300,	RedLow = 0.0310,	RedTop = 0.0500,},
	[15] = {	Id = 15,	Prop = 15,	Name = [[缓速抵抗]],	Des = [[降低受到的缓速持续时间]],	Type = 2,	PurleLow = 0.0050,	PurleTop = 0.0100,	OrangeLow = 0.0120,	OrangeTop = 0.0200,	GoldLow = 0.0210,	GoldTop = 0.0300,	RedLow = 0.0310,	RedTop = 0.0500,},
	[16] = {	Id = 16,	Prop = 16,	Name = [[致盲抵抗]],	Des = [[降低受到的致盲持续时间]],	Type = 2,	PurleLow = 0.0050,	PurleTop = 0.0100,	OrangeLow = 0.0120,	OrangeTop = 0.0200,	GoldLow = 0.0210,	GoldTop = 0.0300,	RedLow = 0.0310,	RedTop = 0.0500,},
	[17] = {	Id = 17,	Prop = 17,	Name = [[降怒抵抗]],	Des = [[在受到减少怒气的技能影响时，降低被减少的怒气数值]],	Type = 2,	PurleLow = 0.0050,	PurleTop = 0.0100,	OrangeLow = 0.0120,	OrangeTop = 0.0200,	GoldLow = 0.0210,	GoldTop = 0.0300,	RedLow = 0.0310,	RedTop = 0.0500,},
}

return _table

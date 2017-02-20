--[[
	Id = Id
SlotId = 位置ID
UnlockLv = 解锁条件：玩家等级
UnlockVip = 解锁条件：VIP等级
des = 描述

--]]
local _table = {
	[1] = {	Id = 1,	SlotId = 1,	UnlockLv = 22,	UnlockVip = 0,},
	[2] = {	Id = 2,	SlotId = 2,	UnlockLv = 40,	UnlockVip = 1,	des = [[玩家40级或者VIP1开启哦]],},
	[3] = {	Id = 3,	SlotId = 3,	UnlockLv = 55,	UnlockVip = 3,	des = [[玩家55级或者VIP3开启哦]],},
	[4] = {	Id = 4,	SlotId = 4,	UnlockLv = 70,	UnlockVip = 6,	des = [[玩家70级或者VIP6开启哦]],},
}

return _table

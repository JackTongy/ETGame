--[[
action:
1.Guider_Touch_Event        输出一件触摸事件
2.Guider_Pve_FightPause     暂停或者恢复战斗进程
3.Guider_Next               开启下一个引导
4.Guider_CMBS               超梦变身
5.Guider_CM_ReleaseSkill    超梦大招
6.Guider_Finished           引导结束
7.Guider_Click_AutoFight    引导加速
8.Guider_Play_Effect        播放音效

down, move, up => 0,1,2
--]]
local FightGuiderConfig = require 'FightGuiderConfig'

local zs_t 			= FightGuiderConfig[1].zs_t
local yc_t 			= FightGuiderConfig[1].yc_t
local qs_t 			= FightGuiderConfig[1].qs_t
local zl_skill_t 	= FightGuiderConfig[1].zl_skill_t
local zs1_skill_t 	= FightGuiderConfig[1].zs1_skill_t
local zs2_skill_t 	= FightGuiderConfig[1].zs2_skill_t
local yc1_skill_t 	= FightGuiderConfig[1].yc1_skill_t
local yc2_skill_t 	= FightGuiderConfig[1].yc2_skill_t
local cmbs_t 		= FightGuiderConfig[1].cmbs_t
local cm_skill_t 	= FightGuiderConfig[1].cm_skill_t
local finish_t 		= FightGuiderConfig[1].finish_t

local auto_ai1 		= FightGuiderConfig[1].auto_ai1
local auto_ai2	    = FightGuiderConfig[1].auto_ai2
local auto_ai3 		= FightGuiderConfig[1].auto_ai3


-- local offsetTime 	= 4
-- local time1 		= 09.10 - offsetTime
-- local time2 		= 20.5 - offsetTime
-- local time3 		= 24.5 - offsetTime
-- local time4 		= 39 - offsetTime
-- local timeAuto 		= 40 - offsetTime
-- local time5 		= 46 - offsetTime
-- local time6_0 		= 51 - offsetTime
-- local time6 		= 58 - offsetTime

-- local time7_0 		= 62 - offsetTime
-- --超梦变身
-- local time7 		= 70 - offsetTime
-- --超梦释放大招
-- local time8 		= 76 - offsetTime
-- --结束
-- local time9 		= 77.7 - offsetTime
--[[

1.战士引导时间
2.远程引导时间
3.骑士引导时间
4.自动AI开启时间
5.治疗大招引导时间 (注:大招引导过程是, 先出现人物和文字, 1秒后提示大招按钮)
6.战士1大招时间
7.战士2大招时间

8.远程1大招时间
9.远程2大招时间
10.超梦变身时间
11.超梦大招时间
12.引导渐变黑屏出现, 引导结束

--]]


-- [15] = {	ID = 15,	CID = 13,	PetID = 78,		Content = [[防御型敌人？对付他们是我的专长，看我的！]],	Type = 0,	Sound = [[htp_battle_01.mp3]],},
-- [16] = {	ID = 16,	CID = 14,	PetID = 292,	Content = [[你们这些可笑的法术根本无法突破我完美的防御！]],	Type = 0,	Sound = [[htp_battle_02.mp3]],},
-- [17] = {	ID = 17,	CID = 15,	PetID = 243,	Content = [[又来了个不怕死的。你永远不会有靠近我的机会！让你们看看什么叫做完美的远程攻击！]],	Type = 0,	Sound = [[htp_battle_03.mp3]],},
-- [18] = {	ID = 18,	CID = 16,	PetID = 385,	Content = [[受伤了吗？请放心，我会治疗你们的。]],	Type = 0,	Sound = [[htp_battle_04.mp3]],},
-- [19] = {	ID = 19,	CID = 17,	PetID = 150,	Content = [[够了！我已经给过你们机会了！现在，面对我的终极力量吧！世间万物，将彻底毁灭！]],	Type = 0,	Sound = [[htp_battle_05.mp3]],},
-- [20] = {	ID = 20,	CID = 18,	PetID = 150,	Content = [[你们阻止不了我！黑暗将吞噬一切！]],	Type = 0,	Sound = [[htp_battle_06.mp3]],},


local Guider = {}
Guider.step = {
	-- 战士对话
	{
		time = zs_t,
		init = {
			{ action = 'Guider_Play_Effect',	data = { sound = 'raw/guide/htp_battle_01.mp3' } },
			{ action = 'Guider_Next', 			data = true },
		},
	},

	{
		time = zs_t,
		init = {
			{ action = 'Guider_Pve_FightPause', 		data = true  }
		},

		element = '@Guide1_0',
		triggers = {
			['touchBtn'] = {
				{ action = 'Guider_Next', 			data = true },
			},
		},

		CID = 13,
	},

	{
		time = zs_t,
		init = {
		},

		element = '@Guide1_1',
		triggers = {
			['effect_button'] = {
				{ action = 'Guider_TouchEvent',    	data = { eventType = 0} },
				{ action = 'Guider_TouchEvent',    	data = { eventType = 2} },
				-- { action = 'Guider_Pve_FightPause', 	data = false  },
				{ action = 'Guider_Next', 			data = true },
			},
		},
	},

	{
		time = zs_t,
		init = {
		},

		element = '@Guide1_2',
		triggers = {
			['effect_button'] = {
				{ action = 'Guider_TouchEvent',    	data = { eventType = 0}},
				{ action = 'Guider_TouchEvent',    	data = { eventType = 2}},
				{ action = 'Guider_Pve_FightPause', 	data = false  },
				{ action = 'Guider_Next', 			data = true },
			}
		},
	},

	--远程对话
	{
		time = yc_t,
		init = {
			{ action = 'Guider_Play_Effect',	data = { sound = 'raw/guide/htp_battle_03.mp3' } },
			{ action = 'Guider_Next', 			data = true },
		},
	},
	
	{
		time = yc_t,
		init = {
			{ action = 'Guider_Pve_FightPause', 		data = true  }
		},

		element = '@Guide2_0',
		triggers = {
			['touchBtn'] = {
				{ action = 'Guider_Next', 			data = true },
			},
		},

		CID = 15,
	},

	{
		time = yc_t,
		init = {
		},

		element = '@Guide2_1',
		triggers = {
			['effect_button'] = {
				{ action = 'Guider_TouchEvent',    	data = { eventType = 0} },
				{ action = 'Guider_TouchEvent',    	data = { eventType = 1} },
				{ action = 'Guider_Next', 			data = true },
			},
		},
	},

	{
		time = yc_t,
		init = {
		},

		element = '@Guide2_2',
		triggers = {
			['effect_button'] = {
				{ action = 'Guider_TouchEvent',    	data = { eventType = 1}},
				{ action = 'Guider_TouchEvent',    	data = { eventType = 2}},
				{ action = 'Guider_Pve_FightPause', 	data = false  },
				{ action = 'Guider_Next', 			data = true },
			},
		},
	},

	--骑士对话
	{
		time = qs_t,
		init = {
			{ action = 'Guider_Play_Effect',	data = { sound = 'raw/guide/htp_battle_02.mp3' } },
			{ action = 'Guider_Next', 			data = true },
		},
	},
	
	{
		time = qs_t,
		init = {
			{ action = 'Guider_Pve_FightPause', 		data = true  }
		},
		
		element = '@Guide3_0',
		triggers = {
			['touchBtn'] = {
				{ action = 'Guider_Next', 			data = true },
			},
		},
		CID = 14,
	},

	{
		time = qs_t,
		init = {
		},

		element = '@Guide3_1',
		triggers = {
			['effect_button'] = {
				{ action = 'Guider_TouchEvent',    	data = { eventType = 0} },
				{ action = 'Guider_TouchEvent',    	data = { eventType = 2} },
				{ action = 'Guider_Next', 			data = true },
			},
		},
	},

	{
		time = qs_t,
		init = {
		},

		element = '@Guide3_2',
		triggers = {
			['effect_button'] = {
				{ action = 'Guider_TouchEvent',    	data = { eventType = 0}},
				{ action = 'Guider_TouchEvent',    	data = { eventType = 2}},
				{ action = 'Guider_Pve_FightPause', 	data = false  },
				{ action = 'Guider_Next', 			data = true },
			}
		},
	},

	--治疗大招对话
	-- {
	-- 	time = zl_skill_t,
	-- 	init = {
	-- 		{ action = 'Guider_Play_Effect',	data = { sound = 'raw/guide/htp_battle_04.mp3' } },
	-- 		{ action = 'Guider_Next', 			data = true },
	-- 	},
	-- },

	-- {
	-- 	time = zl_skill_t,
	-- 	init = {
	-- 		{ action = 'Guider_Pve_FightPause', 		data = true  }
	-- 	},

	-- 	element = '@Guide4_0',
	-- 	triggers = {
	-- 		['touchBtn'] = {
	-- 			{ action = 'Guider_Next', 			data = true },
	-- 		},
	-- 	},
	-- 	CID = 16,
	-- },

	-- 治疗大招
	{
		time = zl_skill_t,
		init = {
			{ action = 'Guider_Pve_FightPause', 		data = true  },
		},

		element = '@Guide4_1',
		triggers = {
			['effect_button'] = {
				{ action = 'Guider_Pve_FightPause', 		data = false  },
				{ action = 'Guider_Pve_ReleaseSkill', 	data = { playerId = 6 } },
				{ action = 'Guider_Next', 				data = true },
			},
		},
	},	

	-- 战士1
	{
		time = zs1_skill_t,
		init = {
			{ action = 'Guider_Pve_FightPause', 		data = true  },
		},

		element = '@Guide5_0',
		triggers = {
			['effect_button'] = {
				{ action = 'Guider_Pve_FightPause', 		data = false  },
				{ action = 'Guider_Pve_ReleaseSkill', 	data = { playerId = 4 } },
				{ action = 'Guider_Next', 				data = true },
			},
		},
	},

	-- 战士2
	{
		time = zs2_skill_t,
		init = {
			{ action = 'Guider_Pve_FightPause', 		data = true  },
		},

		element = '@Guide5_1',
		triggers = {
			['effect_button'] = {
				{ action = 'Guider_Pve_FightPause', 	data = false  },
				{ action = 'Guider_Pve_ReleaseSkill', 	data = { playerId = 3 } },
				{ action = 'Guider_Next', 				data = true },
			},
		},
	},

	-- 远程1
	{
		time = yc1_skill_t,
		init = {
			{ action = 'Guider_Pve_FightPause', 		data = true  },
		},

		element = '@Guide6_0',
		triggers = {
			['effect_button'] = {
				{ action = 'Guider_Pve_FightPause', 		data = false  },
				{ action = 'Guider_Pve_ReleaseSkill', 	data = { playerId = 5 } },
				{ action = 'Guider_Next', 				data = true },
			},
		},
	},

	-- 远程2
	{
		time = yc2_skill_t,
		init = {
			{ action = 'Guider_Pve_FightPause', 		data = true  },
		},

		element = '@Guide6_1',
		triggers = {
			['effect_button'] = {
				{ action = 'Guider_Pve_FightPause', 	data = false  },
				{ action = 'Guider_Pve_ReleaseSkill', 	data = { playerId = 7 } },
				{ action = 'Guider_Next', 				data = true },
			},
		},
	},

	-- 78秒, 超梦变身
	{
		time = cmbs_t,
		init = {
			{ action = 'Guider_Play_Effect',	data = { sound = 'raw/guide/htp_battle_05.mp3' } },
			{ action = 'Guider_Next', 			data = true },
		},
	},

	
	{
		time = cmbs_t,
		init = {
			{ action = 'Guider_Pve_FightPause', 	data = true  },
		},

		element = '@Guide7_0',
		triggers = {
			['touchBtn'] = {
				-- { action = 'Guider_Pve_FightPause', 	data = false  },
				{ action = 'Guider_CMBS', 				data = true },
				{ action = 'Guider_Next', 				data = true },
			},
		},
		CID = 17,
	},


	{
		time = cm_skill_t,
		init = {
			{ action = 'Guider_Play_Effect',	data = { sound = 'raw/guide/htp_battle_06.mp3' } },
			{ action = 'Guider_Next', 			data = true },
		},
	},


	-- 超梦大招
	{
		time = cm_skill_t,
		init = {
			{ action = 'Guider_Pve_FightPause', 	data = true  },
		},

		element = '@Guide7_1',
		triggers = {
			['touchBtn'] = {
				{ action = 'Guider_Pve_FightPause', 	data = false  },
				{ action = 'Guider_CM_ReleaseSkill', 	data = true },
				{ action = 'Guider_Next', 				data = true },
			},
		},
		CID = 18,
	},

	-- Guider_Finished
	{
		time = finish_t,
		init = {
			{ action = 'Guider_Finished', 	data = true  },
		},
	},

	-- 自动AI
	{
		time = auto_ai1[1],
		init = {
			{ action = 'Guider_Click_AutoFight', 	data = true },
			{ action = 'Guider_Next', 				data = true },
		},
	},
	{
		time = auto_ai1[2],
		init = {
			{ action = 'Guider_Click_AutoFight', 	data = false },
			{ action = 'Guider_Next', 				data = true },
		},
	},

	{
		time = auto_ai2[1],
		init = {
			{ action = 'Guider_Click_AutoFight', 	data = true },
			{ action = 'Guider_Next', 				data = true },
		},
	},

	{
		time = auto_ai2[2],
		init = {
			{ action = 'Guider_Click_AutoFight', 	data = false },
			{ action = 'Guider_Next', 				data = true },
		},
	},

	{
		time = auto_ai3[1],
		init = {
			{ action = 'Guider_Click_AutoFight', 	data = true },
			{ action = 'Guider_Next', 				data = true },
		},
	},
	{
		time = auto_ai3[2],
		init = {
			{ action = 'Guider_Click_AutoFight', 	data = false },
			{ action = 'Guider_Next', 				data = true },
		},
	},


}

local function t_insert( out_array, item )
	-- body
	if item.time <= 0 then
		return
	end
	
	for i,v in ipairs(out_array) do
		if v.time > item.time then
			table.insert(out_array, i, item)
			return
		end
	end

	table.insert(out_array, item)
	return
end

local function t_sort( in_array )
	-- body
	local out_array = {}
	for i, v in ipairs(in_array) do
		t_insert(out_array, v)
	end

	return out_array
end

Guider.step = t_sort( Guider.step )

return Guider

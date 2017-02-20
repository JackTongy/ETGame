local t = {
	"Playground", -- 游乐园翻翻乐
	"V6Notice", -- 闪电鸟展示礼包
	"Charge7Day", -- 7日充值
	"RoastDuck", -- 烤鸭
	"TimeLimitPet",	-- 限时精灵
	"RoleUpgradeAct", -- 老版开服冲级
	"RoleUpgradeRewardAct",		--开服冲级
	"RoleUpgradeRankAct",		--开服排名
	"LuckyCat",	-- 招财喵喵
	"ChargeDay", 	--天天充值
	"ChargeCost", 	--消耗有礼
	"ChargeGift", 	--充值好礼
	"ChargeACC",		--累计充值
	"HatchEgg", -- 精灵蛋孵化
	"SilverCoinShop", -- 春节神秘商店（消耗银币）
	"LoveOfWater", -- 心之水滴
	"ExChage",		--疯狂兑换
	"fund",		--开服基金
	"loginGift",		--登陆奖励
	"MonDayGift", 	--周一大礼包
	"LuckyMagicBox",	--装备幸运合成
	"EquipBuyDiscount",--装备十连抽打折
	"TownRewardDouble", --副本双倍奖励
	"TrialBox", -- 宝箱大放送
	"LuckWheel", -- 幸运大转盘
	"MCardGift", -- 月卡回馈好礼
	"WellPet", -- 水井
	"DoctorTask", -- 博士任务
	"LuckyLottery", -- 幸运转盘
	"Tuangou",		--跨服团购
	"Card21",		-- 21点
	"ChargeFeedback", --充值反利
	"ChargeSevenDayGifts", --7日连续充值
	"TimeLimitExplore", -- 限时探险
	"DestinyWheel", -- 命运轮盘
	"Wish", 	-- 许愿星
	"CaptureCompe", -- 捕虫大赛
	"ExploreRwdDouble",-- 探宝收益双倍
	"ExploreRobRwdDouble",-- 探宝抢夺收益双倍
	"SeniorGift", -- 感恩回馈好礼
}

local activityType = {}

for i,v in ipairs(t) do
	activityType[v] = i
end

return activityType

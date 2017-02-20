--[[

人物角色常用枚举 

]]
local TypeRole = {}

TypeRole.BigCategory_Role=1

TypeRole.BigCategory_Monster=2




--战士（红） = 1，骑士（蓝） =2 ，远程（黄） = 3，治疗（绿） = 4
--战士
TypeRole.Career_ZhanShi=1
-- 奇士
TypeRole.Career_QiShi=2
-- 远程
TypeRole.Career_YuanCheng=3
-- 治疗
TypeRole.Career_ZiLiao=4



-- 0 代表为不是boss
TypeRole.Monster_NotBoss=0
-- 1 代表为boss
TypeRole.Monster_Boss=1



TypeRole.BloodType_Boss="Boss"

TypeRole.BloodType_Hero="Hero"

TypeRole.BloodType_Monster="Monster"

TypeRole.BloodType_NotFriend="NotFriend"

TypeRole.BloodType_Friend="Friend"





--怪物ai类型
TypeRole.MonsterAIType_0=0

--速度近战型
TypeRole.MonsterAIType_1=1


--获取职业对应的字符串
function TypeRole.getCareerStr( career )
	local str
	if career==TypeRole.Career_ZhanShi then
		str="战士"
	elseif career==TypeRole.Career_QiShi then
		str="骑士"
	elseif career==TypeRole.Career_YuanCheng then
		str="远程"
	elseif career==TypeRole.Career_ZiLiao then
		str="治疗"
	end
	return ""
end




return TypeRole






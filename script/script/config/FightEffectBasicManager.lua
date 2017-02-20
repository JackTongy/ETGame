local fightEffect = require 'fightEffect'

local fightEffectBasicManager = {}

local dict = {}
for k,fightEffectBasicVo in pairs(fightEffect) do
	-- if effectId==fightEffectBasicVo.effectId then
	-- 	table.insert(fightEffectArr,fightEffectBasicVo)
	-- end
	if fightEffectBasicVo.effectId then
		local fightEffectArr=dict[fightEffectBasicVo.effectId] or {}

		table.insert(fightEffectArr,fightEffectBasicVo)
		dict[fightEffectBasicVo.effectId]=fightEffectArr
	end
end


function fightEffectBasicManager.getFightEffectBasicVoArr( effectId )

	-- local fightEffectArr = {}
	-- for k,fightEffectBasicVo in pairs(fightEffect) do
	-- 	if effectId==fightEffectBasicVo.effectId then
	-- 		table.insert(fightEffectArr,fightEffectBasicVo)
	-- 	end
	-- end
	-- return fightEffectArr
	return dict[effectId]
end

return fightEffectBasicManager
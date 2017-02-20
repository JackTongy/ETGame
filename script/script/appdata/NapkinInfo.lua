--[[
Qs	int?	玩家是否有做过问卷调查
Items	Dictionary<string,bool>	其他数据
	Step111 新手引导精灵超越是否走过

	StepOv 新手引导完成记录

]]

local Napkin = {}
local _data

function Napkin.cleanData()
	_data = nil
end

function Napkin.setData( data )
	_data = data
end

function Napkin.getData(  )
	return _data
end

function Napkin.isUsed( key )
	if _data and _data.Items then
		return _data.Items[key]
	end
	return false
end

function Napkin.setValue( key,v )
	if _data and _data.Items then
		_data.Items[key]=v
	end
end

return Napkin
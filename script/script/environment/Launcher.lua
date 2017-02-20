--[[
	存放一些controller初始化时 会做的处理：如网络数据的获取
]]

local Launcher = {}
local _table = {}
local _oper

local socketClient
function Launcher.register( name,func,... )
	assert(name and func,'Launcher.register arg invalid!')
	
	local launch = _table[name] or {}
	launch.name = name
	launch.func = func
	_table[name] = launch

end

function Launcher.doLaunch(oper, name,data,controller,transition,netdata )

	local launch = _table[name]
	if launch then
		_oper = {oper = oper,name=name,data=data,controller=controller,transition=transition,netdata=netdata}
		Launcher.retainOper()
		Launcher.showLoading(function ( ... )
			launch.func(data,oper)
		end)
		
		return true
	end

	return false

end

function Launcher.callNet( data, callback, errcallback,delay,timeout, ptype,flag )
	socketClient = socketClient or require 'SocketClient'
	socketClient.send0(data, callback, errcallback,delay,timeout, ptype,flag)
end

function Launcher.Launching( netData )

	if _oper then
		if _oper.oper == 'push' then
			GleeCore:pushControllerRaw(_oper.name, _oper.data, _oper.controller, _oper.transition,_oper.netdata or netData)
		elseif _oper.oper == 'replace' then
			GleeCore:replaceControllerRaw(_oper.name, _oper.data, _oper.controller, _oper.transition,_oper.netdata or netData)
		elseif _oper.oper == 'popControllerTo0' then
			GleeCore:popControllerTo0Raw(_oper.name, _oper.data, _oper.controller, _oper.transition,_oper.netdata or netData)
		elseif _oper.oper == 'popController0' then
			GleeCore:popController0Raw(_oper.name,_oper.controller,_oper.transition,_oper.netdata or netData)
		elseif _oper.oper == 'showLayer' then
			GleeCore:showLayerRaw(_oper.name,_oper.data,_oper.controller,_oper.transition or netData)
		end
	end
	Launcher.hideLoading()
	Launcher.releaseOper()
	_oper = nil
end

function Launcher.cancel( ... )
	Launcher.hideLoading()
end

-- oper arg's dataType may userData
function Launcher.retainOper( )

	if _oper then
		for k,v in pairs(_oper) do
			if type(v) == 'userdata' then
				v:retain()
			end
		end
	end

end

function Launcher.releaseOper( )
	if _oper then
		for k,v in pairs(_oper) do
			if type(v) == 'userdata' then
				v:release()
			end
		end
	end	
end


function Launcher.clear( )
	_table = {}	
end

function Launcher.netError(data,errMsg)
	Launcher.cancel()
end

--
local TransitionCtrl = require 'DCTransitionFade'

function Launcher.showLoading( callback )
	if _oper and _oper.oper ~= 'showLayer' then
		_oper.transition = nil --取消原先的transition
	--	TransitionCtrl.show(0.2,callback)
		callback()
	else
		callback()
	end
end

function Launcher.hideLoading( ... )
	if _oper and _oper.oper ~= 'showLayer' then
		TransitionCtrl.hide()
	end
end

return Launcher

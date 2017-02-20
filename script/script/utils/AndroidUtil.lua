-- assert(require "framework.basic.Device".platform == "android","Platform Error")
if not CCLuaJavaBridge then
	CCLuaJavaBridge = {}
	local function emptyFunc( ... )
		-- body
		return 1
	end
	setmetatable(CCLuaJavaBridge, { __index = function ( t,k )
		-- body
		return emptyFunc
	end} )
end

local util = {}

util.sdkLogin = function ( ... )
	return CCLuaJavaBridge:callStaticMethod("com/glee/pet/pet_android","sdkLogin",{},"()V")
end

util.sendRoleCreateInfo = function ( name )
	return CCLuaJavaBridge:callStaticMethod("com/glee/pet/pet_android","sendRoleCreateInfo",{name},"(Ljava/lang/String;)V")
end

util.recordEvent = function ( pagename,action,staytime )
	return CCLuaJavaBridge:callStaticMethod("com/glee/pet/pet_android","recordEvent",{pagename,action,staytime},"(Ljava/lang/String;Ljava/lang/String;F)V")
end

--提交角色信息，在玩家成功登陆游戏服获取到角色信息后调用
util.submitRoleInfo = function ( roleId,roleName,roleLevel,coin,vipLevel,guildName,serverName,serverId )
	return CCLuaJavaBridge:callStaticMethod("com/glee/pet/pet_android","submitRoleInfo",{roleId,roleName,roleLevel,coin,vipLevel,guildName,serverName,serverId},"(ILjava/lang/String;IIILjava/lang/String;Ljava/lang/String;I)V")
end

util.pay = function ( proDes,orderId,amount,proId,proName,proPrice,extInfo )
	return CCLuaJavaBridge:callStaticMethod("com/glee/pet/pet_android","pay",{proDes,orderId,amount,proId,proName,proPrice,extInfo},"(Ljava/lang/String;Ljava/lang/String;IILjava/lang/String;FLjava/lang/String;)V")
end

util.exit = function ( ... )
	return CCLuaJavaBridge:callStaticMethod("com/glee/pet/pet_android","exit",{},"()V")
end

util.getChannelID = function ( ... )
	return select(2,CCLuaJavaBridge:callStaticMethod("com/glee/pet/pet_android","getChannelID",{},"()I"))
end

util.getRkChannelID = function ( ... )
	return select(2,CCLuaJavaBridge:callStaticMethod("com/glee/pet/pet_android","getRkChannelID",{},"()I"))
end

util.getPlatformID = function ( ... )
	return select(2,CCLuaJavaBridge:callStaticMethod("com/glee/pet/pet_android","getPlatformID",{},"()I"))
end

util.getUUID = function ( ... )
	return select(2,CCLuaJavaBridge:callStaticMethod("com/glee/pet/pet_android","getUUID",{},"()Ljava/lang/String;"))
end

util.getChannelName = function ( ... )
	return  select(2,CCLuaJavaBridge:callStaticMethod("com/glee/pet/pet_android","getChannelName",{},"()Ljava/lang/String;"))
end

util.getOsVersion = function ( ... )
	return  select(2,CCLuaJavaBridge:callStaticMethod("com/glee/pet/pet_android","getOsVersion",{},"()Ljava/lang/String;"))
end

util.getDeviceName = function ( ... )
	return  select(2,CCLuaJavaBridge:callStaticMethod("com/glee/pet/pet_android","getDeviceName",{},"()Ljava/lang/String;"))
end

util.getNetType = function ( ... )
	return  select(2,CCLuaJavaBridge:callStaticMethod("com/glee/pet/pet_android","getNetType",{},"()Ljava/lang/String;"))
end

util.getImei = function ( ... )
	return  select(2,CCLuaJavaBridge:callStaticMethod("com/glee/pet/pet_android","getImei",{},"()Ljava/lang/String;"))
end

util.getVersionName = function ( ... )
	return  select(2,CCLuaJavaBridge:callStaticMethod("com/glee/pet/pet_android","getVersionName",{},"()Ljava/lang/String;"))
end

--info格式:uid&token&name&ext
--SDK登陆成功回调：返回登陆界面，清除用户信息，向账号服发起登陆请求
function onSdkLoginSuccess( info )
	require "EventCenter".eventInput("OnSdkLoginSuccess",info)
end

--SDK注销回调：返回登陆界面，清除用户信息，重新调用sdkLogin
function onSdkLogout( ... )
	print("-----------onSdkLogout------------")
	local name = GleeCore:getRunningController():getControllerName()
	print(name)

	local AccountInfo = require 'AccountInfo'
	AccountInfo.setSdkUid(nil)
	AccountInfo.setSdkToken(nil)

	if name ~= require 'script.info.Info'.LOGIN then
		require 'framework.helper.MusicHelper'.stopAllEffects()
		GleeCore.reLogin()
	else
		require "EventCenter".eventInput("OnSdkLogout")
	end
end

function onSdkLoginFailed( ... )
	require "EventCenter".eventInput("OnSdkLoginFailed")
end

function onSdkLoginCancel( ... )
	require "EventCenter".eventInput("OnSdkLoginCancel")
end

function onAndroidBackBtnClicked( ... )
end

return util
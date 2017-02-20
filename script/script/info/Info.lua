
local function setProxy( shell, cfg )
	-- body
	assert(shell)
	assert(cfg)

	local path = 'script.info.'..cfg
	package.loaded[path] = nil
	local ptable = require (path)

	setmetatable( shell, { __index = ptable, __newindex = function(t,k,v)
		error('Attempt to new index '..tostring(k)..' error!')
	end})

	---check cfg--
	assert(shell.ACCONFIG, 				'check '..cfg)
	assert(shell.ACCONFIG.SKEY, 		'check '..cfg)
	assert(shell.ACCONFIG.AUTHURL,		'check '..cfg)
	assert(shell.ACCONFIG.INFOURL,		'check '..cfg)
	assert(shell.ACCONFIG.PlatformId,	'check '..cfg)
	assert(shell.ACCONFIG.ChannelId,	'check '..cfg)
	assert(shell.GVC_URL,				'check '..cfg)
	assert(shell.LOGIN,					'check '..cfg)
	assert(shell.MODE,					'check '..cfg)
	assert(shell.LANG_NAME,				'check '..cfg)

	if not ptable.RESPATH then
		ptable.RESPATH = string.format('Local/%s',shell.LANG_NAME)
	end

	return shell
end

-----------------------------------------------------------------------

----安装包版本

local publishVersion = (require 'framework.basic.Device'.platform == 'ios' and (GleeUtils.BundleValue and GleeUtils:BundleValue('CFBundleVersion'))) or (require 'script.utils.AndroidUtil'.getVersionName())

----默认的热更新本地版本
local updateVersion = 0

----使用的配置, 更新地址, Key, 渠道等信息
local cfg = 'IOS_Phone_In'


----登录的模式(develop, update, login), 可以不写, 配置在cfg里面
-- local mode = 'develop'

local Info = {}
Info.UPDATE_VERSION 	= updateVersion
Info.PUBLISH_VERSION 	= publishVersion

Info.CFG_NAME = cfg

setProxy(Info, cfg)

return Info
local IOS_Phone_In = {}

IOS_Phone_In.ACCONFIG = 
{
	SKEY		=	'c9d7614ae19a6021d227b114d6c4f31a',
	AUTHURL		=	'http://api2.server.rk.pk.mosoga.net',
	INFOURL		=	'http://api2.server.rk.pk.mosoga.net',
	PlatformId 	= 	1,
	ChannelId 	=	1,
	ChannelName =	'rekoo',
}

IOS_Phone_In.GVC_URL 	= 'http://test.res.mosoga.net/pokemonx/Pet-GVC-Main/versions'
IOS_Phone_In.GVC_URL2 	= 'http://dev.packages.mosoga.net/pokemonx/Pet-GVC-Main/versions'

IOS_Phone_In.PLATFORM 	= 'IOS'

IOS_Phone_In.LOGIN    	= 'CTestLogin'

IOS_Phone_In.MODE 		= 'develop'

IOS_Phone_In.LANG_NAME 	= 'english'

IOS_Phone_In.RESPATH	= 'Local/english'

local Utils = require 'framework.helper.Utils'
local langset = Utils.readTableFromFile('main/LangSet') or {cur=IOS_Phone_In.LANG_NAME}
IOS_Phone_In.LANG_NAME = string.gsub(langset.cur,'-newip','')
IOS_Phone_In.LANG_NAME = string.gsub(langset.cur,'2','')
IOS_Phone_In.RESPATH   = 'Local/'..tostring(langset.cur)

return IOS_Phone_In
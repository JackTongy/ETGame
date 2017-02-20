local Android_Phone_Out = {}

Android_Phone_Out.ACCONFIG = 
{
	SKEY 			=	'c9d7614ae19a6021d227b114d6c4f31a',
	AUTHURL			=	'http://api2.server.rk.pk.mosoga.net',
	INFOURL			=	'http://api2.server.rk.pk.mosoga.net',
	PlatformId 		=	require 'script.utils.AndroidUtil'.getPlatformID(),
	ChannelId 		=	require 'script.utils.AndroidUtil'.getChannelID(),
	ChannelName 	=	require 'script.utils.AndroidUtil'.getChannelName(),
	Rk_Channel 		= 	require 'script.utils.AndroidUtil'.getRkChannelID(),
}

Android_Phone_Out.GVC_URL 	= 'http://app110.rekoo.net/GVCS/Android_RK/versions'

Android_Phone_Out.PLATFORM 	= 'Android'

Android_Phone_Out.LOGIN     = 'CLoginP'

Android_Phone_Out.MODE 		= 'login'

return Android_Phone_Out
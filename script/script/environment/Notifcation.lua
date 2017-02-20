local Notifcation = {}
local _EnableLocal = true

function Notifcation.cancelLocalNotification( ... )
	NotifcationHelper:cancelLocalNotification()
end

function Notifcation.localNotification(seconds,msg)
	if _EnableLocal and type(seconds) == 'number' and type(msg) == 'string' then
		NotifcationHelper:localNotification(seconds,msg)
	end
end

function Notifcation.setSetting( locale,remote )
	_EnableLocal = locale
end

return Notifcation
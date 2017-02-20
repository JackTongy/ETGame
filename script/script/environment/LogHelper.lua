local TimeManager = require 'TimeManager'
local Indicator = require 'DIndicator'
local EventCenter = require 'EventCenter'
local Utils = require 'framework.helper.Utils'
local Config = require 'Config'

require 'framework.net.Net'

local logfilename = 'debuglog.txt'
local LogHelper = {}
local _records = {}
local _tmp = {}
local _saveLogEnable = false

function LogHelper.recordTime( arg,isrecv)
	-- if arg and arg[1] then
	-- 	if isrecv then
	-- 		table.insert(_records,LogHelper.getOffsetRecordMsg(arg[1].C,_tmp[arg[1]]))
	-- 		_tmp[arg[1]] = nil
	-- 	else
	-- 		_tmp[arg[1]] = TimeManager.getCurrentSeverTime()
	-- 	end
	-- end
end


function LogHelper.saveLog( )
	if _saveLogEnable then
		local content = _records
		local uid = Config.RoleID or 0
		local sid = Config.ServerID or 0
		Utils.writeTableToFile({Ip=Config.SocketAddr,Port=Config.SocketPort,Id=uid,Sid=sid,Log=content},logfilename)
	end
end

function LogHelper.upload(IP,PORT,UID,SID,content,callback )
	
	local m = NetModel.new()
	m:setUrl('http://115.29.199.47:83/log/save')
	m:addArg('op','SaveLog')
	m:addArg('Id',string.format('%s:%s-UID:%s-SID:%s',IP,PORT,UID,SID))
	m:addArg('Log',content)
	Indicator.show()
	m:callNet(function ( datatable,tag,code,errorBuf )
		print('log upload suc!')
		Indicator.hide()
		return callback and callback()
	end)

end

function LogHelper.uploadLog( content,callback )
	local lc = Utils.readTableFromFile(logfilename)
	if lc then
		local UID = tostring(lc.Id)
		local SID = tostring(lc.Sid)
		local IP = tostring(lc.Ip)
		local PORT = tostring(lc.Port)
		LogHelper.upload(IP,PORT,UID,SID,content,callback)
	end
end

function LogHelper.uploadError( msg,callback )
	if msg then
		LogHelper.upload(Config.SocketAddr,Config.SocketPort,Config.RoleID,Config.ServerID,msg,callback)
	end
end

function LogHelper.clearRecords( ... )
	_records = {}
	_tmp = {}
end

function LogHelper.getOffsetRecordMsg( C,time )
	if C and time then
		local offset = TimeManager.getCurrentSeverTime()-time
		local msg = {C,offset}
		return msg
	end
end

function LogHelper.enableSaveLog( enable )
	_saveLogEnable = enable
	if _saveLogEnable then
		EventCenter.addEventFunc("OnAppStatChange", function ( state )
			if state == 1 then
				LogHelper.saveLog()
			end
		end,'LogHelper')
	else
		EventCenter.resetGroup('LogHelper')
	end
end

function LogHelper.showLogViewIfNeed( ... )
	local lc = Utils.readTableFromFile(logfilename)
	if lc and _saveLogEnable and lc.Log and #lc.Log > 0 then
		local content = ''
		
		if lc.Log then
			table.sort(lc.Log,function ( v1,v2 )
				if v1 and v2 then
					return v1[2] > v2[2]
				end
			end)

			local tmp = {}
			for i,v in ipairs(lc.Log) do
				table.insert(tmp,table.concat(v,'-'))
			end

			content = table.concat(tmp,'\n')
		end

		require 'DLuaLogView'
		GleeCore:showLayer('DLuaLogView',{NetCallRecord=true,content=content})
	end
end

return LogHelper
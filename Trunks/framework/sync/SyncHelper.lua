local SyncCore 				= require 'framework.sync.SyncCore'
local SyncServerModule 		= require 'framework.sync.SyncServerModule'
local SyncSetPath 			= require 'framework.sync.SyncSetPath'
local SyncEventCenter 		= require 'framework.sync.SyncEventCenter'
local SyncFileHelper 		= require 'framework.sync.FileHelper'

local SyncHelper = {}

-- basic - test1, test2, test3
-- advanced
-- test

--[[
configFile 配置文件名
mode       模式
func       更新完成的触发
--]]
function SyncHelper.sync( serverModule, serverModuleBase, func )
	-- body 
	assert(serverModule)
	-- assert(func)

	if serverModule == serverModuleBase then
		serverModuleBase = nil
	end

	if serverModuleBase then
		-- assert( serverModule.getUpdateServerUrl() == serverModuleBase.getUpdateServerUrl() )
		-- assert( serverModule.getLocalDir() ~= serverModuleBase.getLocalDir() )
		-- assert( serverModule.getServerVersionUrl() ~= serverModuleBase.getServerVersionUrl() )
	end 

	if serverModuleBase and serverModuleBase.getUpdateServerUrl() == serverModule.getUpdateServerUrl() then

		FileHelper:setWritableRelativePath( serverModuleBase.getLocalDir() )
		local basicVersion = tonumber( SyncFileHelper.read('v.o') ) or 0

		FileHelper:setWritableRelativePath( serverModuleBase.getLocalDir() )
		local advancedVersion = tonumber( SyncFileHelper.read('v.o') ) or 0

		if advancedVersion <= basicVersion then
			SyncFileHelper.remove('') 
		end
	end

	local triggerFunc = function ()
		-- body
		local applyArray = {}
		
		table.insert(applyArray, serverModuleBase)
		table.insert(applyArray, serverModule)

		SyncSetPath.init(applyArray)
		
		print('SyncHelper.sync Completed!')
		
		if func then func() end
	end
	
	SyncEventCenter.resetGroup('Sync')
	SyncEventCenter.addEventFunc('Sync_Finish_Inner', function()
		triggerFunc()
	end, 'Sync')

	-- start to sync!
	SyncCore.sync( serverModule )
end

return SyncHelper
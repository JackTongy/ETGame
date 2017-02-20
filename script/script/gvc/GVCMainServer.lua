local GVC_Config_Data_User = {
	['basic'] 				= { versionFile = '/version.v', 			dir = 'main/' 		},
	['advanced'] 			= { versionFile = '/advanced.v', 			dir = 'advanced/' 	},
}

local GVC_Config_Data_Tester = {
	['basic'] 				= { versionFile = '/version-test.v', 			dir = 'main/' 		},
	['advanced'] 			= { versionFile = '/advanced-test.v', 			dir = 'advanced/' 	},
}


-- local GVC_Config_Data 	= {
-- 	['basic'] 				= { versionFile = '/version.v', 			dir = 'main/' 		},
-- 	['advanced'] 			= { versionFile = '/advanced.v', 			dir = 'advanced/' 	},
-- 	['basic-test'] 			= { versionFile = '/basic-test.v', 			dir = 'basic-test/' 		},
-- 	['advanced-test'] 		= { versionFile = '/advanced-test.v', 		dir = 'advanced-test/' 		},
-- }

local GVC_Config_Data

-- local publish = require 'script.gvc.GVCPublish'
-- local Device = require 'framework.basic.Device'

-- if Device.platform == "android" then
-- 	if publish.mode ~= 'develop' then
-- 		GVC_Config_Data.serverUrl = 'http://app110.rekoo.net/fc_android2/versions'
-- 	else
-- 		GVC_Config_Data.serverUrl = 'http://dev.packages.mosoga.net/pokemonx/Pet-GVC-Android/versions'
-- 	end
-- else
-- 	if publish.mode ~= 'develop' then
-- 		GVC_Config_Data.serverUrl = 'http://dev.packages.mosoga.net/pokemonx/GVCS/pet-ios/versions'
-- 	else
-- 		-- GVC_Config_Data.serverUrl = 'http://dev.packages.mosoga.net/pokemonx/Pet-GVC-Main/versions'
-- 		GVC_Config_Data.serverUrl = 'http://app110.rekoo.net/GVCS/IOS_YueYu_Test/versions'
-- 	end
-- end
GVC_Config_Data = (require 'script.info.Info'.ForTester and GVC_Config_Data_Tester) or GVC_Config_Data_User
GVC_Config_Data.serverUrl = require 'script.info.Info'.GVC_URL
GVC_Config_Data.serverUrl2 = require 'script.info.Info'.GVC_URL2

local function createSyncServerModule( mode, basicVersion )
	-- body
	assert(mode)
	local data = GVC_Config_Data[mode]
	assert(data)
	assert(data.versionFile)
	assert(data.dir)
	
	-- assert(basicVersion)
	
	local SyncServerModule = require 'framework.sync.SyncServerModule'

	local newModule = SyncServerModule.createUpdateModule()

	newModule.setUpdateServerUrl( GVC_Config_Data.serverUrl )
	newModule.setUpdateServerUrl2( GVC_Config_Data.serverUrl2 )

	newModule.setLocalDir( data.dir )
	newModule.setServerVersionFileName( data.versionFile )
	newModule.setName( mode )
	
	newModule.setDefaultLocalVersion( basicVersion )

	return newModule
end

return { createSyncServerModule = createSyncServerModule }
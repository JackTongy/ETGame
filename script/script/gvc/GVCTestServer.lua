local GVCTestServerConfig = {}

-- 
local Test1Config 	= {

	['basic'] 		= { versionFile = '/version.v', 	dir = 'test1_main/' 		},
	['advanced'] 	= { versionFile = '/advanced.v', 	dir = 'test1_advanced/' 	},
	['test'] 		= { versionFile = '/test.v', 		dir = 'test1_test/' 		},

	serverUrl 		= 'http://dev.packages.mosoga.net/pokemonx/Pet-GVC-Cfg0/versions',
}

local Test2Config 	= {
	
	['basic'] 		= { versionFile = '/version.v', 	dir = 'test2_main/' 		},
	['advanced'] 	= { versionFile = '/advanced.v', 	dir = 'test2_advanced/' 	},
	['test'] 		= { versionFile = '/test.v', 		dir = 'test2_test/' 		},

	serverUrl 		= 'http://dev.packages.mosoga.net/pokemonx/Pet-GVC-Cfg1/versions',
}

local Test3Config 	= {
	
	['basic'] 		= { versionFile = '/version.v', 	dir = 'test3_main/' 		},
	['advanced'] 	= { versionFile = '/advanced.v', 	dir = 'test3_advanced/' 	},
	['test'] 		= { versionFile = '/test.v', 		dir = 'test3_test/' 		},
	
	serverUrl 		= 'http://dev.packages.mosoga.net/pokemonx/Pet-GVC-Cfg2/versions',
}

table.insert(GVCTestServerConfig, Test1Config)
table.insert(GVCTestServerConfig, Test2Config)
table.insert(GVCTestServerConfig, Test3Config)

local function createSyncServerModule( index, mode, basicVersion )
	-- body
	assert(index)
	assert(mode)

	local GVC_Config_Data = GVCTestServerConfig[index]
	assert(GVC_Config_Data)
	
	local data = GVC_Config_Data[mode]
	assert(data)
	assert(data.versionFile)
	assert(data.dir)

	local SyncServerModule = require 'framework.sync.SyncServerModule'

	local newModule = SyncServerModule.createUpdateModule()
	
	newModule.setUpdateServerUrl( GVC_Config_Data.serverUrl )
	newModule.setLocalDir( data.dir )
	newModule.setServerVersionFileName( data.versionFile )
	newModule.setName( mode )

	newModule.setDefaultLocalVersion( basicVersion )
	
	return newModule
end

return { createSyncServerModule = createSyncServerModule }
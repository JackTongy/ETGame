--[[
Sample:
--]]
local GVC_Config 	= {

	['basic'] 		= { base = true, 	versionFile = '/version.o', 	dir = 'main/' 		},
	['advanced'] 	= { base = false, 	versionFile = '/advanced.o', 	dir = 'advanced/' 	},
	['test'] 		= { base = false, 	versionFile = '/test.o', 		dir = 'test/' 		},

	serverUrl 		= 'http://dev.packages.mosoga.net/pokemonx/Pet-GVC-Main/versions',
}

return GVC_Config
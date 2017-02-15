
local function createUpdateModule()
	-- body
	local Config = {}

	function Config.setUpdateServerUrl( url )
		-- body
		Config.UpdateServerUrl = url
	end

	function Config.getUpdateServerUrl(  )
		-- body
		return Config.UpdateServerUrl
	end

	function Config.setUpdateServerUrl2( url )
		-- body
		Config.UpdateServerUrl2 = url
	end

	function Config.getUpdateServerUrl2(  )
		-- body
		return Config.UpdateServerUrl2
	end

	function Config.getLocalDir()
		-- body
		return Config.LocalDir
	end

	function Config.setLocalDir( dir )
		-- body
		Config.LocalDir = dir
	end

	function Config.isValid()
		-- body
		return Config.UpdateServerUrl and Config.LocalDir
	end

	function Config.getDefaultLocalVersion( )
		return Config.Default or 0
	end

	function Config.setDefaultLocalVersion( default )
		print('Config setDefaultLocalVersion'..tostring(default))
		Config.Default = default
	end

	function Config.setName( name )
		Config.Name = name
	end

	function Config.getName( )
		return Config.Name or Config.LocalDir
	end

	function Config.setServerVersionFileName( name )
		-- body
		Config.ServerVersionFileName = name
	end

	--------------------------------------------------------------------------------------------------------------------------------------------

	function Config.getServerVersionUrl()
		local url = Config.UpdateServerUrl or Config.UpdateServerUrl2
		return url..(Config.ServerVersionFileName or '/version.v')
	end

	function Config.getServerVersionUrl2()
		local url = Config.UpdateServerUrl2 or Config.UpdateServerUrl
		return url..(Config.ServerVersionFileName or '/version.v')
	end

	function Config.getServerGVCUrl(oldVersion, newVersion)
		return Config.UpdateServerUrl..'/v-'..tostring(newVersion)..'/'..tostring(oldVersion)..'-'..tostring(newVersion)..'.gvc'
	end

	function Config.getServerGVCUrl2(oldVersion, newVersion)
		return (Config.UpdateServerUrl2 or Config.UpdateServerUrl )..'/v-'..tostring(newVersion)..'/'..tostring(oldVersion)..'-'..tostring(newVersion)..'.gvc'
	end

	function Config.getServerFileUrl(versioin, relativePath)
		return Config.UpdateServerUrl..'/v-'..tostring(versioin)..'/'..tostring(relativePath)
	end

	function Config.getServerFileUrl2(versioin, relativePath)
		return (Config.UpdateServerUrl2 or Config.UpdateServerUrl )..'/v-'..tostring(versioin)..'/'..tostring(relativePath)
	end

	return Config
end


return { createUpdateModule = createUpdateModule }
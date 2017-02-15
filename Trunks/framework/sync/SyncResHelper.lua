-------------------------------------------------------------------------------
-- Coroutine safe xpcall and pcall versions
--
-- Encapsulates the protected calls with a coroutine based loop, so errors can
-- be dealed without the usual Lua 5.x pcall/xpcall issues with coroutines
-- yielding inside the call to pcall or xpcall.
--
-- Authors: Roberto Ierusalimschy and Andre Carregal 
-- Contributors: Thomas Harning Jr., Ignacio BurgueÒo, F·bio Mascarenhas
--
-- Copyright 2005 - Kepler Project (www.keplerproject.org)
--
-- $Id: coxpcall.lua,v 1.13 2008/05/19 19:20:02 mascarenhas Exp $
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Implements xpcall with coroutines
-------------------------------------------------------------------------------
local performResume, handleReturnValue
local oldpcall, oldxpcall = pcall, xpcall

function handleReturnValue(err, co, status, ...)
    if not status then
        return false, err(debug.traceback(co, (...)), ...)
    end
    if coroutine.status(co) == 'suspended' then
        return performResume(err, co, coroutine.yield(...))
    else
        return true, ...
    end
end

function performResume(err, co, ...)
    return handleReturnValue(err, co, coroutine.resume(co, ...))
end    

local function coxpcall(f, err, ...)
    local res, co = oldpcall(coroutine.create, f)
    if not res then
        local params = {...}
        local newf = function() return f(unpack(params)) end
        co = coroutine.create(newf)
    end
    return performResume(err, co, ...)
end

-------------------------------------------------------------------------------
-- Implements pcall with coroutines
-------------------------------------------------------------------------------

-- local function id(trace, ...)
--   return ...
-- end

-- local function copcall(f, ...)
--     return coxpcall(f, id, ...)
-- end

-----------------------------------------------------------------


local function __G__TRACKBACK__(msg)  
    print('----------------------------------------')  
    print('LUA ERROR: ' .. tostring(msg) .. '\n')  
    print(debug.traceback())  
    print('----------------------------------------')  
end  

local FileHelper 		= 		require 'framework.sync.FileHelper'
local UrlHelper 		= 		require 'framework.sync.UrlHelper'
local GvcHelper 		= 		require 'framework.sync.GvcHelper'
local TimerHelper 		= 		require 'framework.sync.TimerHelper'

local VersionPath 		= 		'v.o'
local NextVersionPath 	= 		'nv.o'
local StatePath 		= 		's.o'
local GvcPath 			= 		'gvc.o'

------------------------------------------------------------------------------
local start_progress = 5
local download_progress = 95
local syncProgress

------------------------------------------------------------------------------
local localVersion
local localState
local localNextVersion
local localGVC
local serverVersion
local serverGVC

local needDownLoadedSize
local hasDownLoadedSize

local function getProgess()
	if needDownLoadedSize > 0 then
		return start_progress + download_progress*hasDownLoadedSize/needDownLoadedSize
	else
		return start_progress + download_progress*1
	end
end

------------------------------------------------------------------------------
----to be assigned
local paramUpdateServer
--[[
flag,progress,state,error
--]]
local paramListener
------------------------------------------------------------------------------

local defaultLocalVersion

local function getLocalVersion()
	local default = defaultLocalVersion or 0

	local content = FileHelper.read(VersionPath)
	if content then
		local contentVersion = tonumber(content)
		if contentVersion then
			if contentVersion > default then
				return contentVersion
			end
		end
	end
	
	return default
end

local function setLocalVersion(pVersion)
	FileHelper.write(VersionPath, tostring(pVersion))
end

local function getLocalState()
	return FileHelper.read(StatePath)
end

local function getLocalNextVersion()
	local content = FileHelper.read(NextVersionPath)
	if content then
		return tonumber(content)
	end
end

local function getLocalGVC()
	local content = FileHelper.read(GvcPath)
	return GvcHelper.arrayFromString(content)
end

local function setLocalState(pState)
	FileHelper.write(StatePath, tostring(pState))
end

local function setLocalNextVerison(pVersion)
	FileHelper.write(NextVersionPath, tostring(pVersion))
end

local function setLocalGVC(pGVCArray)
	local lines = GvcHelper.arrayToString(pGVCArray)
	FileHelper.write(GvcPath, lines)
end

----------------function------------
local jumpToState

local doInitAll
local doCheck
local doStart
local doDownLoad
local doExecute
local doClean
local doCleanCache
local doFinish

local sync

local coroutine = coroutine
local syncCoroutine
local pause
local resume

pause = function()
	coroutine.yield()
end

resume = function()
	-- xpcall(function()
		
	-- end, __G__TRACKBACK__)
	-- coroutine.resume(syncCoroutine)
	coroutine.resume(syncCoroutine)

	-- performResume(__G__TRACKBACK__, syncCoroutine)
end

------------------------------------------------------------------------------

check = function ( pUpdateServer,  pMakeSureListener)
	-- body
	UrlHelper.tick_clean()

	paramUpdateServer = pUpdateServer
	paramListener = nil

	defaultLocalVersion = pUpdateServer.getDefaultLocalVersion()

	local function func()
		doInitAll()
 		-- paramListener(nil, syncProgress, 'checking...')

 		local errOccured, checkLocal, checkServer = doCheck()

 		-- errOccured()
 		if pMakeSureListener then
 			if errOccured then
 				pMakeSureListener(false)
 			else
 				pMakeSureListener(true, localVersion,localNextVersion,serverVersion,needDownLoadedSize)
 			end
 		end
 	end

 	TimerHelper.countTick(function()
		syncCoroutine = coroutine.create(function()
			coxpcall(function()
				func()
			end, __G__TRACKBACK__)
		end)
	
		----xpcall(main, __G__TRACKBACK__) 
		coroutine.resume(syncCoroutine)
	end, 2)

end

sync = function(pUpdateServer, pListener, pMakeSureListener)
	-- assert(paramUpdateServer == nil and paramListener == nil)

	--close old
	UrlHelper.tick_clean()

	paramUpdateServer = pUpdateServer
	paramListener = pListener

	defaultLocalVersion = pUpdateServer.getDefaultLocalVersion()
	
	-- paramListener = function(...)
		-- pListener(localVersion, localNextVersion, serverVersion ,...)
	-- end

	local function func()
		doInitAll()
 		-- paramListener(nil, syncProgress, 'checking...')

 		local errOccured, checkLocal, checkServer = doCheck()
 		
 		-- errOccured()

 		syncProgress = start_progress

 		if errOccured then
 			return
 		end

 		if pMakeSureListener then
 			if pMakeSureListener(localVersion,localNextVersion,serverVersion,needDownLoadedSize) then
 				--no need to continue
 				return true
 			end
 		end

 		paramListener(nil, syncProgress, 'start')

		if checkLocal then 
		--do local_update first
			jumpToState(localState)
		end

		if checkServer then
		--do server_update second
			paramListener(nil, syncProgress, 'start')

			setLocalState('start')

			if doStart() then
				return error('on doStart')
			end

			paramListener(nil, syncProgress, 'download')

			setLocalState('download')
			
			if doDownLoad() then
				return error('on doDownLoad')
			end
			
			paramListener(nil, syncProgress, 'execute')

			setLocalState('execute')
			doExecute()
			
			paramListener(nil, syncProgress, 'clean')

			setLocalState('clean')
			doClean()
			
			paramListener(nil, syncProgress, 'finish')

			setLocalState('finish')
			--nothing just flag
			doFinish()
			
		end
		
		--final do
		syncProgress = 100
		paramListener(true, syncProgress, 'finally completed!')

		return true
	end

	TimerHelper.countTick(function()
		syncCoroutine = coroutine.create(function()
			coxpcall(function()
				func()
			end, __G__TRACKBACK__)
		end)
	
		----xpcall(main, __G__TRACKBACK__) 
		coroutine.resume(syncCoroutine)
	end, 2)
end

doInitAll = function()
	localVersion = 0
	localState = nil
	localNextVersion = nil
	localGVC = nil
	serverVersion = nil
	serverGVC = nil

	syncProgress = 0

	needDownLoadedSize = 0
	hasDownLoadedSize = 0
end

doCheck = function ()
	-- body
	local errOccured =false

	--server
	local checkServer
	local serverVersionUrl = paramUpdateServer.getServerVersionUrl()
	UrlHelper.url_get(serverVersionUrl, function(content, rescode, err, code)
		--print('doCheckServer callback:'..content)
		if content then
			serverVersion = tonumber(content)
		else
			if paramListener then
				paramListener(false,syncProgress,'server version',string.format('%s error:rescode=%s,err=%s,code=%s',serverVersionUrl, tostring(rescode), tostring(err), tostring(code)))
			end

			errOccured = true
		end
		
		resume()
	end)

	--local 
	local checkLocal = false
	localVersion = getLocalVersion()
	localNextVersion = getLocalNextVersion()
	localState = getLocalState()

	print('localVersion:'..tostring(localVersion))
	print('localNextVersion:'..tostring(localNextVersion))
	print('localState:'..tostring(localState))

	if not localState or localState == 'finish' or localState == 'start' then
		localState = nil
		checkLocal = false
	else
		--localNextVersion = getLocalNextVersion()
		localGVC = getLocalGVC()

		print('localGVC')
		print(localGVC)
		--calc size
		for i,v in pairs (localGVC) do
			if v.type == 'M' or v.type == 'A' then
				needDownLoadedSize = needDownLoadedSize + v.newSize
			end
		end
		checkLocal = true
	end

	pause()

	if errOccured then
		return true, error('failed to get server version')
	end

	-- checkServer = ((localNextVersion or localVersion) ~= serverVersion)
	checkServer = ((localNextVersion or localVersion) < serverVersion)

	--localNextVersion = serverVersion
	if checkServer then
		local serverGVCUrl = paramUpdateServer.getServerGVCUrl(localNextVersion or localVersion, serverVersion)
		UrlHelper.url_get(serverGVCUrl, function(content, rescode, err, code)
			if content then
				serverGVC = GvcHelper.arrayFromString(content)
				--calc size
				for i,v in pairs (serverGVC) do
					if v.type == 'M' or v.type == 'A' then
						needDownLoadedSize = needDownLoadedSize + v.newSize
					end
				end
			else
				errOccured = true
				if paramListener then
					paramListener(false, syncProgress, 'server gvc', string.format('%s error:rescode=%s,err=%s,code=%s',serverGVCUrl, tostring(rescode), tostring(err), tostring(code)))
				end
				print('server gvc:'..string.format('%s error:rescode=%s,err=%s,code=%s',serverGVCUrl, tostring(rescode), tostring(err), tostring(code)))
			end
			resume()
		end)
		
		pause()

		if errOccured then
			return true, error('failed to get server gvc')
		end
	end

	return false, checkLocal , checkServer
end

doStart = function()
	localNextVersion = serverVersion
	--write localNextVersion
	setLocalNextVerison(serverVersion)
	setLocalGVC(serverGVC)
	localGVC = serverGVC
	--clean download
	FileHelper.remove('download')
end

doDownLoad = function() 
	--localGVC
	local errOccured = false
	local downloadNums = 0
	
	for i,v in pairs (localGVC) do
		if v.type == 'M' or v.type == 'A' then
			downloadNums = downloadNums + 1
		end
	end
	
	local loadedNum = 0
	for i,v in pairs (localGVC) do
		if v.type == 'M' or v.type == 'A' then
			--existed local
			if FileHelper.isExisted('download/'..v.key) then
				loadedNum = loadedNum + 1
				hasDownLoadedSize = hasDownLoadedSize + v.newSize

				--download_progress*loadedSize/downLoadSize
				syncProgress = getProgess()
				-- paramListener(nil, syncProgress, 'download', nil, downLoadSize)

				if downloadNums == loadedNum then
					resume()
				end
			else
				local newurl = paramUpdateServer.getServerFileUrl(v.newVersion, v.key)

				UrlHelper.url_get(paramUpdateServer.getServerFileUrl(v.newVersion, v.key), function(content, rescode, err, code)
					if content then
						FileHelper.write('download/'..tostring(v.key), content)
						loadedNum = loadedNum + 1
						hasDownLoadedSize = hasDownLoadedSize + v.newSize

						syncProgress = getProgess()
						paramListener(nil,syncProgress,'download',v.key, needDownLoadedSize)

						if downloadNums == loadedNum then
							resume()
						end
					else

						loadedNum = loadedNum + 1
						hasDownLoadedSize = hasDownLoadedSize + v.newSize

						if not errOccured then
							errOccured = true
							syncProgress = getProgess()
							paramListener(false,syncProgress,'download',string.format('doDownLoad error:file=%s, rescode=%s,err=%s,code=%s',tostring(v.key), tostring(rescode), tostring(err), tostring(code)))
							print('download:'..string.format('doDownLoad error:file=%s, rescode=%s,err=%s,code=%s',tostring(v.key), tostring(rescode), tostring(err), tostring(code)))
							UrlHelper.url_clean()
						end

						if downloadNums == loadedNum then
							resume()
						end

						--error(string.format('doDownLoad error:file=%s, rescode=%s,err=%s,code=%s',tostring(v.key), tostring(rescode), tostring(err), tostring(code)))
					end
				end)
			end
		end
	end
	
	if downloadNums ~= loadedNum then
		pause()
	end

	return errOccured
end

doExecute = function()
	for i,v in pairs(localGVC) do
		--print('v.key='..tostring(v.key))
		if v.type == 'R' then
			FileHelper.remove(v.key)
		elseif v.type == 'M' or v.type == 'A' then 
			FileHelper.copy('download/'..tostring(v.key), tostring(v.key))
		end 
	end	
end 

doClean = function()
	FileHelper.remove('download/')
	localVersion = localNextVersion or localVersion
	setLocalVersion(localVersion)
	
	FileHelper.remove(NextVersionPath)
	FileHelper.remove(GvcPath)
end

doCleanCache = function ()
	-- body
	setLocalState('finish')

	FileHelper.remove('download/')
	
	FileHelper.remove(NextVersionPath)
	FileHelper.remove(GvcPath)
end

doFinish = function()
	--nothing just flag
end

jumpToState = function(pState)
	if pState == 'start' then

		paramListener(nil, syncProgress, 'continue start')

		setLocalState('start')

		if doStart() then
			return error('on jumpToState->doStart')
		end
		
		jumpToState('download')
	elseif pState == 'download' then

		paramListener(nil, syncProgress, 'continue download')

		setLocalState('download')

		if doDownLoad() then
			return error('on jumpToState->doDownLoad')
		end
		
		jumpToState('execute')
	elseif pState == 'execute' then

		paramListener(nil, syncProgress, 'continue execute')

		setLocalState('execute')
		doExecute()
		
		jumpToState('clean')
	elseif pState == 'clean' then
		
		paramListener(nil, syncProgress, 'continue clean')

		setLocalState('clean')
		doClean()
		
		jumpToState('finish')
	elseif pState == 'finish' then

		paramListener(nil, syncProgress, 'continue finish')
		
		setLocalState('finish')
		doFinish()
	end
end

return { sync = sync, check = check, pause = pause, resume = resume, cleanCache = doCleanCache }

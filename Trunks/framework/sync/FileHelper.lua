--print("load file_helper")

local getFullPath
local isExisted
local isFile
local isDirectory
local ensureDirectory
local readFile
local writeFile
local removeFile
local createFile
local copyFile

isDirectory = function(path)
	local f, err = io.open(path, 'r')
	if f then
		local c, err, code = f:read(1)
		if code == 21 then
			f:close()
			return true
		else
			f:close()
			return false, 'NotDirectory'
		end
	elseif err ~= nil and string.find(tostring(err),'Permission') then
		return true --windows phone 8	
	else
		return nil, 'NotExist'
	end
end

ensureDirectory = function(path)
	local is_dir, err = isDirectory(path)
	if not is_dir then
		if err == 'NotDirectory' then
			if not os.remove(path) then error() end
		else
			if string.find(path, '/') then
				local parent_path = string.gsub(path, '/[^/]*$', '')
				ensureDirectory(parent_path)
			end
		end
		local suc, err = lfs.mkdir(path)
		if not suc then
			print(path..':'..err)
			--error(err)
		end
	end
end

local remove_file_name_filter = {
['.'] = true,
['..'] = true,
}

getFullPath = function(relativePath)
	--use FileHelper
	local writable_path = FileHelper:getWritablePath()
	return writable_path .. '/' .. tostring(relativePath)
end

isExisted = function(relativePath)
	local path = getFullPath(relativePath)
	
	local f, err = io.open(path, 'r')
	if f then
		f:close()
		return true
	else
		return false
	end
end

isFile = function(relativePath)
	local path = getFullPath(relativePath)
	
	local f, err = io.open(path, 'r')
	if f then
		local c, err, code = f:read(1)
		if code ~= 21 then
			f:close()
			return true
		else
			f:close()
			return false, 'NotFile'
		end
	else
		return nil, 'NotExist'
	end
end

readFile = function(fpath, abs)
	local path = fpath
	if not abs then
		path = getFullPath(fpath)
	end
	print('readFile:'..fpath)
	local f = io.open(path, 'rb')

	if not f then
		return nil
	end
	local content, err = f:read("*a")
	f:close()
	if not content then
		error(err)
	end

	return content
end

writeFile = function(fpath, content, abs)
	local path = fpath
	if not abs then
		path = getFullPath(fpath)
	end
	--print("write path = "..path)
	--mkdir
	if string.find(path, '/') then
		local parent_path = string.gsub(path, '/[^/]*$', '')
		ensureDirectory(parent_path)
	end

	local vf, err = io.open(path, 'wb')
	if not vf then
		error('Open file ' .. tostring(path) .. ' to write failed!')
		return
	end
	
	vf:write(content)
	vf:flush()
	vf:close()

	--print("write path="..tostring(path))
	-- print("content="..tostring(content))
end

local realRemoveFile
realRemoveFile = function(path)
	--print("remove="..path)
	if isDirectory(path) then
		for fname in lfs.dir(path) do
			--print("fname"..fname)
			if not remove_file_name_filter[fname] then
				local fpath = path .. '/' .. fname
				realRemoveFile(fpath)
			end
		end

		lfs.rmdir(path)
		return
	end
	-- print('remove :'..path)
	os.remove(path)
end

removeFile = function(path)
	local fullpath = getFullPath(path)
	realRemoveFile(fullpath)
end

createFile = function(relativePath)
	local path = getFullPath(relativePath)
	
	local f, err = io.open(path, 'w')
	if not f then
		error('Create file ' .. tostring(path) .. ' failed! ' .. tostring(err))
		return
	end
	f:close()
end

copyFile = function ( from,  to)
	-- body
	local content = readFile(from)
	writeFile(to, content)
end

moveFile = function ( form,to,abs)
	local fpath = form
	local tpath = to
	if not abs then
		fpath = getFullPath(fpath)
		tpath = getFullPath(tpath)
	end
	
	if string.find(tpath, '/') then
		local parent_path = string.gsub(tpath, '/[^/]*$', '')
		ensureDirectory(parent_path)
	end

	local ret = os.rename(fpath,tpath)
	if not ret then
		error('move:'..form..' '..to..' '..tostring(ret))
	end
end

return {create = createFile, remove = removeFile, read = readFile, 
write = writeFile, isDir = isDirectory, isFile = isFile, isExisted = isExisted, copy=copyFile, ensureDir=ensureDirectory,move=moveFile}



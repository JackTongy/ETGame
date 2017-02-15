require "framework.basic.BasicClass"

local DB = class()

function DB:setHandler( handler )
	self._handler = handler
end

function DB:getHandler( )
	return self._handler
end

function DB:setFilename( filename )
	self._filename = filename
end

function DB:getFilename( )
	return self._filename
end

function DB:version( )
	return sqlite3.version()
end

function DB:open( )
	local filename = self:getFilename()
	self._handler = sqlite3.open(filename)
end

function DB:isopen( )
	if self._handler then
		return self._handler:isopen()
	end
	
	return false
end

function DB:close( )
	if self._handler then
		self._handler:close()
		self._handler = nil
	end
end

function DB:dataByName( tablename )
	local sql = "select * from "..tablename
	return self:doQuery(sql)
end

function DB:doQuery( sql )
	assert(sql ~= nil, "sql can not nil!")

	local index = 1
	local result = {}
	for row in self._handler:nrows(sql) do
		result[index] = row
		index = index + 1
	end

	return result
end

---------------------callback(udata, cols, values, names)----------------------
function DB:exec( sql, callback, udata )
	if self._handler then
		self._handler:exec(sql, callback, udata)
	end
end

-------------------------DBHelper-------------------------

local DBHelper = {}

DBHelper.createdb = function( filename )
	
	assert(filename ~= nil , "sqlite must has a filename")

	print("hahahah"..filename)

	local db = DB.new()
	db:setFilename(filename)

	return db
end

return require 'framework.basic.MetaHelper'.createShell(DBHelper)
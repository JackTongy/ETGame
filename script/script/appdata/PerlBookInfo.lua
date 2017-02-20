local PerlBookFunc = {}
local PerlBookData = {}

function PerlBookFunc.cleanData()
	PerlBookData = {}
end

function PerlBookFunc.getBookInfoWithBookId( dbBookId )
	local book = {}
	book.Bid = dbBookId
	book.isPiece = false
	return book
end

function PerlBookFunc.setBooks( books )
	PerlBookData.Books = books or {}
end

function PerlBookFunc.getBooks( ... )
	return PerlBookData.Books or {}
end

function PerlBookFunc.updateBooks( Books )
	for i,v in ipairs(Books) do
		local canFind = false
		for j,m in ipairs(PerlBookData.Books) do
			if m.Id == v.Id then
				PerlBookData.Books[j] = v
				canFind = true
				break
			end
		end
		if not canFind then
			table.insert(PerlBookData.Books, v)
		end
	end
end

function PerlBookFunc.setBookPieces( pieces )
	PerlBookData.BookPieces = pieces or {}
end

function PerlBookFunc.getBookPieces( ... )
	return PerlBookData.BookPieces or {}
end

function PerlBookFunc.updateBookPieces( BookPieces )
	for i,v in ipairs(BookPieces) do
		local canFind = false
		for j,m in ipairs(PerlBookData.BookPieces) do
			if m.Id == v.Id then
				PerlBookData.BookPieces[j] = v
				if v.Amount == 0 then
					table.remove(PerlBookData.BookPieces, j)
				end
				canFind = true
				break
			end
		end
		if not canFind then
			table.insert(PerlBookData.BookPieces, v)
		end
	end
end

function PerlBookFunc.setPerls( perls )
	PerlBookData.Perls = perls or {}
end

function PerlBookFunc.getPerls( ... )
	return PerlBookData.Perls or {}
end

function PerlBookFunc.updatePerls( Perls )
	for i,v in ipairs(Perls) do
		local canFind = false
		for j,m in ipairs(PerlBookData.Perls) do
			if m.Id == v.Id then
				PerlBookData.Perls[j] = v
				canFind = true
				break
			end
		end
		if not canFind then
			table.insert(PerlBookData.Perls, v)
		end
	end
end

function PerlBookFunc.sortPerl( list )
	if list then
		local dbManager = require "DBManager"
		table.sort(list, function ( v1, v2 )
			local dbPerl = dbManager.getInfoPerlConfig(v1.Pid)
			local dbPer2 = dbManager.getInfoPerlConfig(v2.Pid)
			if dbPerl and dbPer2 then
				if dbPerl.color == dbPer2.color then
					if dbPerl.classid == dbPer2.classid then
						return v1.Pid < v2.Pid
					else
						return dbPerl.classid < dbPer2.classid
					end
				else
					return dbPerl.color < dbPer2.color
				end
			end
		end)
	end
end

function PerlBookFunc.getPerlsWithSingle( ... )
	local list = PerlBookFunc.getPerls()
	PerlBookFunc.sortPerl( list )
	local temp = {}
	for i,v in ipairs(list) do
		if v.Amount > 0 then
			for j=1,v.Amount do
				local clone = table.clone(v)
				clone._index = j
				table.insert(temp, clone)
			end
		end
	end
	return temp
end

function PerlBookFunc.removePerls( perls )
	if PerlBookData.Perls and perls then
		for i,v in ipairs(perls) do
			for j=#PerlBookData.Perls,1,-1 do
				if PerlBookData.Perls[j].Id == v.Id then
					PerlBookData.Perls[j].Amount = math.max(PerlBookData.Perls[j].Amount - 1, 0)
					if PerlBookData.Perls[j].Amount == 0 then
						table.remove(PerlBookData.Perls, j)
					end
					break
				end
			end
		end
	end
end

function PerlBookFunc.removeBookPiece( BookPieceId, Amount )
	if PerlBookData.BookPieces and BookPieceId > 0 and Amount > 0 then
		for i,v in ipairs(PerlBookData.BookPieces) do
			if v.Id == BookPieceId then
				PerlBookData.BookPieces[i].Amount = math.max(PerlBookData.BookPieces[i].Amount - Amount, 0)
				if PerlBookData.BookPieces[i].Amount == 0 then
					table.remove(PerlBookData.BookPieces, i)
				end
				break
			end
		end
	end
end

function PerlBookFunc.removeBook( BookId,Amount )
	if PerlBookData.Books and BookId > 0 and Amount > 0 then
		for i,v in ipairs(PerlBookData.Books) do
			if v.Id == BookId then
				PerlBookData.Books[i].Amount = math.max(PerlBookData.Books[i].Amount - Amount, 0)
				if PerlBookData.Books[i].Amount == 0 then
					table.remove(PerlBookData.Books, i)
				end
				break
			end
		end
	end
end


return PerlBookFunc
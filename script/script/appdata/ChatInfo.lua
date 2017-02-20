local ChatData = {}
local ChatFunc = {}

local dbManager = require "DBManager"
local res = require "Res"

local CountLimit = 50

local function getIndex(chatType)
	local index = chatType or 1
	ChatData[index] = ChatData[index] or {}
	return index
end

function ChatFunc.reset( ... )
	ChatData = {}
end

function ChatFunc.addChatInfo(info,chatType)
	local lastChat = ChatFunc.getLastChatInfo(chatType)
	if lastChat and info.Id<=lastChat.Id then
		return false
	else
		local list = ChatData[getIndex(chatType)]
		table.insert(list,info)
		if #list>CountLimit then
			table.remove(list,1)
		end
		return true
	end
end

function ChatFunc.setChatData( list,chatType )
	table.sort(list,function ( a,b )
		return a.Id<b.Id
	end)
	ChatData[getIndex(chatType)] = list
end

function ChatFunc.addChatInfoList( list,chatType )
	table.sort(list,function ( a,b )
		return a.Id<b.Id
	end)
	for i,v in ipairs(list) do
		ChatFunc.addChatInfo(v,chatType)
	end
end

function ChatFunc.getChatData( chatType )
	return ChatData[getIndex(chatType)]
end

function ChatFunc.getChatInfoCount( chatType )
	return #ChatData[getIndex(chatType)]
end

function ChatFunc.getLastChatInfo( chatType )
	local list = ChatData[getIndex(chatType)]
	return list[#list]
end

function ChatFunc.getLastNotificaitonId( ... )
	local list = ChatData[1] or {}
	for i=#list,1,-1 do
		local v = list[i]
		if v.Broadcast then
			return v.Id
		end
	end
	return 0
end

function ChatFunc.createShareContent( shareType,id )
	local str = "[color = %s]%s[/color]"
	local color,name
	local data,dbInfo
	if shareType == 1 then
		data = require "PetInfo".getPetWithId(id)
		dbInfo = dbManager.getCharactor(data.PetId)
		color = res.RankColorStr[res.getFinalAwake(data.AwakeIndex)]
		name = string.format("%s",dbInfo.name)
	elseif shareType == 2 then
		data = require "EquipInfo".getEquipWithId(id)
		dbInfo = dbManager.getInfoEquipment(data.EquipmentId)
		color = res.RankColorStr[dbInfo.color+1]
		name = dbInfo.name
	elseif shareType == 3 then
		data = require "GemInfo".getGemWithId(id)
		dbInfo = dbManager.getInfoGem(data.GemId)
		color = res.RankColorStr[data.Lv]
		name = string.format("%sLv%d",dbInfo.name,data.Lv)
	end
	str = string.format(str,color,name)
	return string.format(res.locString(string.format("Chat$ShareModel%d",shareType)),str)
end

function ChatFunc.createChatListController( list,itemCreateFunc )
	local listNode = list
	local initPosX,initPosY = listNode:getContainer():getPosition()
	local newChatOrder = 0
	local newChatGetList = {}
	local isLoading = false
	local itemCount = 0
	local tickHandlers = {}
	local inited = false

	local function addListItem ( info,order )
		local item = itemCreateFunc(info)
		itemCount = itemCount + 1
		local zOrder = order or itemCount

		if itemCount>50 then
			print("removeOnLimit--------")
			local node = listNode:getContainer():getChildren():lastObject()
			tolua.cast(node,"CCNode")
			listNode:removeListItem(node)
		end
		print("addItem"..zOrder)
		listNode:getContainer():addChild(item,zOrder,itemCount)
	end

	local function startLoadNewChatGet( ... )
		isLoading = false
		for i,v in ipairs(newChatGetList) do
			addListItem(v,newChatOrder)
			newChatOrder = newChatOrder - 1
		end
		newChatGetList = {}
	end

	local function resetPos( ... )
		listNode:getContainer():setPosition(initPosX,initPosY)
	end

	return {
		initWithList = function ( listData )
			listNode:getContainer():removeAllChildrenWithCleanup(true)
			for i = #listData,1,-1 do
				local index = #listData - i
				local v = listData[i]
				if index < 6 then
					addListItem(v)
				else
					isLoading = true
					tickHandlers[#tickHandlers+1] = require "framework.sync.TimerHelper".tick(function ( ... )
						addListItem(v)
						if i == 1 then
							startLoadNewChatGet()
						end
						return true
					end,0.05*(index-6))
				end
			end
			inited = true
		end,
		addChat = function ( data )
			if not inited then
				return
			end
			if isLoading then
				table.insert(newChatGetList,data)
			else
				addListItem(data,newChatOrder)
				newChatOrder = newChatOrder - 1
				if data.Rid==require "UserInfo".getId() then
					resetPos()
				end
			end
		end,
		cancel = function ( ... )
			for _,v in pairs(tickHandlers) do
				require "framework.sync.TimerHelper".cancel(v)
			end
			newChatOrder = 0
			newChatGetList = {}
			isLoading = false
			itemCount = 0
			tickHandlers = {}
			inited = false
		end,
		setVisible = function ( b )
			return listNode:setVisible(b)
		end
	}
end

return ChatFunc

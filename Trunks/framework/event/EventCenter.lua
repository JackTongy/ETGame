--[[
	事件中心
	事件传递可以有两种形式:
	1.组播
	2.广播(默认)   

	example:
	
	local class = {}
	function class:onclick(arg)
		print(arg)
	end
	function class:onclick1(arg)
	  print("1  "..arg)
	end

	EventCenter.addEvent(class,"onclick",class.onclick,"class")

	EventCenter.addEvent0(class,"onclick1","class")

	EventCenter.addEventFunc("onclick",function(arg) print("tmp"..arg) end,"tmp")

	EventCenter.eventInput("onclick","hello event!",{"class","tmp"})

	EventCenter.eventInput("onclick1","hello event!")

	EventCenter.removeEvents(class)

	EventCenter.removeEventFunc("onclick")

	-- print("remove the callback")
	-- EventCenter.eventInput("onclick","hello event!")
	-- EventCenter.eventInput("onclick1","hello event!")

]]

local EventCenter = {}

--[[
	{	
		--广播
		["broadcast"]={
			obj = {["eventname"]=func,...}
			...
		},

		--组播
		["groupname"]={
			obj = {["eventname"]=func,...}
			...		
		},

		...
	}
]]
local Listeners = {}


local function callback( obj,events,eventname,arg )

	local func = events[eventname]
	if func == nil then
		func = eventname
	end

	if type(obj) == "table" and type(func) == "function" then
		return func(obj,arg)
	elseif type(obj) == "table" and type(func) == "string" and obj[func] then
		obj[func](obj,arg)
	elseif type(obj) ~= "table" and type(func) == "function" then
		return func(arg)
	end
end

local function groupCallback(eventname,arg,groupname)
	if groupname then
		local group = Listeners[groupname]
		if group then
			for obj,events in pairs(group) do
				callback(obj,events,eventname,arg)
			end	
		end

		return
	end

	for k,group in pairs(Listeners) do
		for obj,events in pairs(group) do
			callback(obj,events,eventname,arg)
		end
	end
end

local function addEventL( obj,eventname,func,groupname )

	if groupname == nil then
		groupname = "broadcast"
	end

	local group = Listeners[groupname]
	if group then
    if group[obj] == nil then
      group[obj] = {}
    end
		group[obj][eventname] = func
	else
		local newgroup = {}
		setmetatable(newgroup,{__mode = "k"}) --对obj进行弱引用
		newgroup[obj] = {}
    newgroup[obj][eventname] = func
		Listeners[groupname] = newgroup
	end

end

--[[
	移除指定groupname中的对应事件,当groupname为nil时
	遍历所有group
]]
local function removeEventL(obj,eventname,groupname)
	assert(obj and evnetname,"removeEventL arg invalid!")

	if groupname then
		local group = Listeners[groupname]
		if group then
			group[obj][eventname] = nil
		end
	else
		for k,v in pairs(Listeners) do
			v[obj][eventname] = nil
		end
	end
end

local function removeEventsAllInGroup(obj,groupname)
	assert(obj and groupname,"removeEventsAllInGroup arg invalid!")

	Listeners[groupname][obj] = nil		
end

local function removeEventsAll( obj )
	assert(obj,"removeEventsAll arg invalid!")

	for k,v in pairs(Listeners) do
		v[obj] = nil
	end
end

--------------------------------------------------------

--[[
	将信息放入到事件中心
	eventname : 事件名
	arg : 事件参数
	groupname : 指定的事件组名
				nil 时默认为发送广播事件
				指定名称时，则为发送组播事件 可以是table 指定多个groupname {"group1","group2"}
]]
function EventCenter.eventInput(eventname,arg,groupname)
	assert(eventname,"EventCenter.eventInput, eventname is nil!")

	if groupname == nil then
		groupCallback(eventname,arg,nil)
	elseif type(groupname) == "string" then
		groupCallback(eventname,arg,groupname)
	elseif type(groupname) == "table" then
		for k,v in pairs(groupname) do
			groupCallback(eventname,arg,v)
		end
	end
end

--[[
	将obj加入事件监听中心
	obj : table
	eventname : 事件名
	func : 事件响应的回调方法
	groupname : 指定的事件组名
				nil 时默认接收为广播事件
				指定名称时，则接收点对点或是组播信息

]]
function EventCenter.addEvent(obj,eventname,func,groupname)
	assert(obj and eventname and func and type(obj) == "table" and type(func) == "function","EventCenter.addEvent arg invalid!")

	addEventL(obj,eventname,func,groupname)
end

function EventCenter.addEvent0( obj,eventname,groupname )
	assert(obj and eventname and type(obj) == "table","EventCenter.addEvent0 arg invalid!")

	addEventL(obj,eventname,nil,groupname)	
end

--[[
	向事件中心增加一个临时回调函数
	func : 事件响应的回调方法
	groupname : 指定的事件组名
				nil 时默认接收为广播事件
				指定名称时，则接收点对点或是组播信息

]]
function EventCenter.addEventFunc(eventname,func,groupname)
	assert(eventname and func,"EventCenter.addEventFunc arg invalid!")
	
	addEventL(eventname,eventname,func,groupname)
end

--[[
	移除obj对应的事件
	obj : table
	events : table or string事件
			 nil 时为移除全部
			 不为nil时 为移除obj指定的事件
	groupname : 指定的组名
			 nil 时为移除所有
]]
function EventCenter.removeEvents(obj, events,groupname)
	assert(obj and type(obj) == "table","EventCenter.removeEvents obj is nil!")
	
	if events and type(events) == "table" then
		for k,v in pairs(events) do 
			removeEventL(obj,v,groupname)
		end
	elseif events and type(events) == "string" then
		removeEventL(obj,events,groupname)
	elseif events == nil and groupname then
		removeEventsAllInGroup(obj,groupname)
	elseif events == nil and groupname == nil then
		removeEventsAll(obj)	
	end

end

--[[
	移除 eventname groupname 对应该的func (指代临时的回调函数)
	eventname : 事件名
	groupname : 组名
				nil 时移除所有group中eventname 对应func 

]]
function EventCenter.removeEventFunc(eventname,groupname)
	assert(eventname,"EventCenter.removeEventFunc,eventname is nil!")

	if groupname then
		removeEventsAllInGroup(eventname,groupname)
	else
		removeEventsAll(eventname)
	end
end

function EventCenter.removeEventFuncs(eventnames,groupname)
	assert(eventnames and type(eventnames) == "table","EventCenter.removeEventFuncs arg invalid!")

	for k,v in pairs(eventnames) do
		EventCenter.removeEventFunc(k,groupname)
	end
end
--[[
	查看obj对应注册的所有事件
	obj : table
	return :
		{{eventname,groupname},...}
]]
function EventCenter.getEvents(obj)
	assert(obj,"EventCenter.getEvents, arg invalid!")

	local tmp = {}
	for groupname,group in pairs(Listeners) do
		for obj,events in pairs(group) do
			local func = events[eventname]
			if func then
				local item = {}
				item.eventname = eventname
				item.groupname = groupname
				table.insert(tmp,item)
			end
		end
	end

	return tmp
end

return EventCenter
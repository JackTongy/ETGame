local config = require "Config"

TabLayer = class(LuaInterface)

function TabLayer:initWithParentController( pcontroller )
	local elfnodename = self:getElfNodeName()
	assert(elfnodename,"getElfNodeName is nil")

	local factory = pcontroller._factory 
    self._factory = factory

    self._document = pcontroller._document
    
    self._set = pcontroller:createSet(elfnodename)
    self._document = factory:findElementByName(self._document, elfnodename)

    self._parent = pcontroller

    self:setLayer(self._set:getRootElfNode())

    self:onInitXML()

    self:retainMembers()
    self:createGleeEventListener()
end

function TabLayer:initWithParent( parent )
	self:loadXML()
	self._parent = parent
	self._viewSet = self:createLuaSet('@view')
end

function TabLayer:getElfNodeName()
	return self._elfNodeName
end

function TabLayer:setElfNodeName( name )
	self._elfNodeName = name
end

function TabLayer:getViewSet(  )
	return self._viewSet
end

function TabLayer:createGleeEventListener()
	-- body
	self._eventListener = GleeEventListener:createWithTarget(nil)
	self._eventListener:active()
end

function TabLayer:destoryGleeEventListener()
	-- body
	self._eventListener:resign()
end

function TabLayer:onEnter( userData )
	
end

function TabLayer:onLeave( )
	
end

function TabLayer:onRelease(  )
	
end

function TabLayer:loadXmlWithParentController( pcontroller )
	local elfnodename = self:getElfNodeName()
	assert(elfnodename,"getElfNodeName is nil")

	local factory = pcontroller._factory 
    self._factory = factory

    self._document = pcontroller._document
    
    self._set = pcontroller:createSet(elfnodename)
    self._document = factory:findElementByName(self._document, elfnodename)

    self._parent = pcontroller

    self:setLayer(self._set:getRootElfNode())

    self:onInitXML()

    self:retainMembers()
end

function TabLayer:releaseLayer( )
	if self._document then
        self._document:release()
        self._document = nil
    end

    if self._set then
        self._set:release()
        self._set = nil
    end

    local layer = self:getLayer()
    layer:removeFromParent()
    self:setLayer(nil)

end

function TabLayer:revertLayer( pcontroller)
	self:loadXmlWithParentController(pcontroller)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(TabLayer, "TabLayer")


TabController = class(LuaController)

--------------------------------custom code-----------------------------
function TabController:getTabList( )
	if self.tablist == nil then
		self.tablist = {}
	end

	return self.tablist
end

function TabController:releaseTabs( )
	if self.tablist then
		for k,v in pairs(self.tablist) do
			if v.obj then
				v.obj:onRelease()
				v.obj:releaseMembers()
				v.obj:destoryGleeEventListener()
				v.obj = nil
			end
		end
	end
	self.tablist = nil
end

-- function TabController:unregisterTabs()
-- 	self.tablist = nil
-- end

-- function TabController:unregisterTab( tabname )
-- 	self:getTabList()[tabname]=nil
-- end

function TabController:registerTab( tabname,class,tabnode)
	assert(tabname and class and tabnode,"registerTab arg invild!")

	local tab = self:getTabList()[tabname]	
	self:getTabList()[tabname] = tab or {}
	self:getTabList()[tabname].class = class
	self:getTabList()[tabname].tabnode = tabnode
	tabnode:setListener(function (  )
		self:showTab(tabname)
	end)
end

function TabController:setTabRootNode( rootnode )
	self._tabRootNode = rootnode
end

function TabController:showTab( tabname )
	if self._currentTab and self._currentTab == tabname then
		return
	end

	local tablist = self:getTabList()
	local tab = tablist[tabname]
	if tab == nil then
		print('can not found tabname:',tabname)
		return
	end

	for k,v in pairs(tablist) do
		if k ~= tabname then
			self:hideTab(k)
		end
	end

	if tab.obj == nil then
		local tabclass = tab.class
		local obj = tabclass.new()
		obj:setElfNodeName(tabname)
		obj:initWithParentController(self)
		obj:onInit()
		if self._tabRootNode and obj:getLayer() then
			self._tabRootNode:addChild(obj:getLayer())
		end

		tab.obj = obj
	end	

	tab.obj:onEnter(self:getUserData())
	tab.obj:getLayer():setVisible(true)
	self._currentTab = tabname
end

function TabController:hideTab( tabname )
	assert(tabname,"Tabname can not be nil")
	local tab = self:getTabList()[tabname]
	if tab and tab.obj then
		tab.obj:getLayer():setVisible(false)
		tab.obj:onLeave()
	end
end

--  KeepAlive is false will call this
function TabController:releaseLayer()
    --release the tab layers
    if self.tablist then
		for k,v in pairs(self.tablist) do
			if v.obj then
				v.obj:releaseLayer()
			end
		end
	end

	self._currentTabSave = self._currentTab
	self._currentTab = nil
	self:releaseTabs()

    if self._document then
        self._document:release()
        self._document = nil
    end

    if self._set then
        self._set:release()
        self._set = nil
    end
end

function TabController:revertLayer()
    self:loadXML()
    self:registerTabs()

    --revert the tab layer on show

    if self._currentTabSave then
    	self:getTabList()[self._currentTabSave].tabnode:trigger(nil)
    end
end

function TabController:registerTabs( ... )
	
end

function TabController:refreshTab( ... )
	if self:getTabList()[self._currentTab] ~= nil then
		local tabList = self:getTabList()
		tabList[self._currentTab].obj:onEnter()
	end
end
--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(TabController, "TabController")


--TabDialog
require 'framework.interface.LuaLayer'

local constants = require 'framework.basic.Constants'

TabDialog = class(LuaLayer)

function TabDialog:ctor()
	
end

function TabDialog:getIndex()
	-- body
	return self._index or constants.DIALOG_INDEX
end

function TabDialog:close( ... )
	self:releaseTabs()
end

function TabDialog:getTabList( )
	if self.tablist == nil then
		self.tablist = {}
	end

	return self.tablist
end

function TabDialog:releaseTabs( )
	if self.tablist then
		for k,v in pairs(self.tablist) do
			if v.obj then
				v.obj:onRelease()
				v.obj:releaseMembers()
				v.obj = nil
			end
		end
	end
	self.tablist = nil
end

function TabDialog:getType()
	-- body
	return 'Dialog'
end

-- function TabController:unregisterTabs()
-- 	self.tablist = nil
-- end

-- function TabController:unregisterTab( tabname )
-- 	self:getTabList()[tabname]=nil
-- end

function TabDialog:registerTab( tabname,class,tabnode)
	assert(tabname and class and tabnode,"registerTab arg invild!")

	local tab = self:getTabList()[tabname]	
	self:getTabList()[tabname] = tab or {}
	self:getTabList()[tabname].class = class
	self:getTabList()[tabname].tabnode = tabnode
	tabnode:setListener(function (  )
		self:showTab(tabname)
	end)
end

function TabDialog:registerTabDefault( class,tabname )
	
end

function TabDialog:setTabRootNode( rootnode )
	self._tabRootNode = rootnode
end

function TabDialog:showTab( tabname )
	if self._currentTab and self._currentTab == tabname then
		return
	end

	local tablist = self:getTabList()
	local tab = tablist[tabname]
	if tab == nil then
		print('can not found tabname:',tabname)
		return
	end

	for k,v in pairs(tablist) do
		if k ~= tabname then
			self:hideTab(k)
		end
	end

	if tab.obj == nil then
		local tabclass = tab.class
		local obj = tabclass.new()
		obj:initWithParent(self)
		obj:onInit()
		if self._tabRootNode and obj:getViewSet() then
			self._tabRootNode:addChild(obj:getViewSet()[1])
		end

		tab.obj = obj
	end	

	tab.obj:onEnter(self:getUserData())
	tab.obj:getViewSet()[1]:setVisible(true)
	self._currentTab = tabname
end

function TabDialog:hideTab( tabname )
	assert(tabname,"Tabname can not be nil")
	local tab = self:getTabList()[tabname]
	if tab and tab.obj then
		tab.obj:getViewSet()[1]:setVisible(false)
		tab.obj:onLeave()
		-- local viewset = v.obj:getViewSet() 
		-- if viewset then
		-- 	viewset[1]:removeFromParent()
		-- end
	end
end

function TabDialog:registerTabs( ... )
	
end

function TabDialog:refreshTab( ... )
	if self:getTabList()[self._currentTab] ~= nil then
		local tabList = self:getTabList()
		tabList[self._currentTab].obj:onEnter(...)
	end
end

require 'framework.basic.MetaHelper'.classDefinitionEnd(TabDialog, 'TabDialog')

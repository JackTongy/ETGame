local Config = require "Config"
local Utils = require 'framework.helper.Utils'
local Default = require 'Default'
local MusicSettings = require 'MusicSettings'
local CTestSetting = class(LuaController)

function CTestSetting:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."CTestSetting.cocos.zip")
    return self._factory:createDocument("CTestSetting.cocos")
end

--@@@@[[[[
function CTestSetting:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_bg = set:getElfNode("root_bg")
   self._root_list = set:getListNode("root_list")
   self._IPinfo_content = set:getInputTextNode("IPinfo_content")
   self._PORTinfo_content = set:getInputTextNode("PORTinfo_content")
   self._btnSave = set:getClickNode("btnSave")
   self._btnHistory = set:getClickNode("btnHistory")
   self._title = set:getLabelNode("title")
   self._btnSave = set:getClickNode("btnSave")
   self._btnSave_normal_title = set:getLabelNode("btnSave_normal_title")
   self._btnSave_pressed_title = set:getLabelNode("btnSave_pressed_title")
   self._state = set:getLabelNode("state")
   self._root_ftpos2_btnReturn = set:getClickNode("root_ftpos2_btnReturn")
--   self._@title = set:getLabelNode("@title")
--   self._@ip = set:getElfNode("@ip")
--   self._@log = set:getElfNode("@log")
end
--@@@@]]]]

--------------------------------override functions----------------------
function CTestSetting:onInit( userData, netData )
	self._root_ftpos2_btnReturn:setListener(function ()
		GleeCore:popController()
	end)

	self:initView()
end

function CTestSetting:onBack( userData, netData )
	
end

function CTestSetting:onRelease( ... )
	
	local userdata = self:getUserData()
	if userdata and userdata.callback then
		userdata.callback()
	end
	
	self._ctestDefault = nil
end
--------------------------------custom code-----------------------------

function CTestSetting:initView( ... )
	self:addSwitchLang()
	self:addIPSetItem()
	self:addLogSetItem()
	self:addBuffTrigger()
	self:addGuide()
	self:addFPSItem()
	self:addFitSizeItem()
	self:addLogView()
	self:addDirectFightItem0()
	self:addSkillReleaseItem()

	self:addDirectFightItem()

	self:addSound('ui_')
	self:addMusic('ui_')
	self:addSound('fb_')
	self:addMusic('fb_')
	self:addSound('bt_')
	self:addMusic('bt_')

	self:addBattleArrayItem()
end

function CTestSetting:addTitle( name )
	local set = self:createLuaSet('@title')
	set[1]:setString(name)
	self._root_list:getContainer():addChild(set[1])
	self._root_list:layout()
end

function CTestSetting:addIPSetItem(  )

	local default = self:getCTestLoginDefault()
	if not default.IP then
		default.IP = Config.SocketAddr
	end
	
	if not default.PORT then
		default.PORT = Config.SocketPort
	end

	if not default.FIT then
		default.FIT = 'iphone5'
	end


	local history = Utils.readTableFromFile('IPHistory')	
	if history == nil then
		history = {}
		table.insert(history,{"192.168.1.213",3001})
		table.insert(history,{"115.29.199.47",3001})
	end

	self:addTitle("IP设置")
	local ipSet = self:createLuaSet('@ip')
	ipSet["IPinfo_content"]:setText(tostring(default.IP))
	ipSet["PORTinfo_content"]:setText(tostring(default.PORT))
	self._root_list:getContainer():addChild(ipSet[1])
	self._root_list:layout()	
	ipSet['btnSave']:setListener(function ( )
		default.IP = ipSet['IPinfo_content']:getText()
		default.PORT = tonumber(ipSet['PORTinfo_content']:getText())
		Config.SocketAddr = default.IP
		Config.SocketPort = default.PORT
		Utils.writeTableToFile(default, 'CTestLogin')

		self:addToHistory(Config.SocketAddr,Config.SocketPort,history)
		self:toast('保存成功!')
	end)

	ipSet['btnHistory']:setListener(function ( ... )
		
		local selected = 1
		for i,v in ipairs(history) do
			if v[1] == default.IP and v[2] == default.PORT then
				selected = i
				break
			end	
		end

		local selectIpfunc = function ( index )
			default.IP = history[index][1]
			default.PORT = history[index][2]
			ipSet["IPinfo_content"]:setText(tostring(default.IP))
			ipSet["PORTinfo_content"]:setText(tostring(default.PORT))
			Config.SocketAddr = default.IP
			Config.SocketPort = default.PORT
			Utils.writeTableToFile(default, 'CTestLogin')
		end

		require 'DSelect'
		GleeCore:showLayer('DSelect',{callback=selectIpfunc,param=history,selected=selected})
	end)

end

function CTestSetting:addToHistory( ip,port,history)
	
	if ip and port then
		for i,v in ipairs(history) do
		
			if v[1] == ip and v[2] == port then
				return
			end	
		end

		table.insert(history,{ip,port})
		Utils.writeTableToFile(history,'IPHistory')
	end

end

function CTestSetting:addLogSetItem( ... )

	self:addTitle('日志开关')
	local logSet = self:createLuaSet('@log')
	logSet['state']:setString((Default.Debug.log and '开') or '关')
	self._root_list:getContainer():addChild(logSet[1])
	self._root_list:layout()
	logSet['btnSave']:setListener(function ( )
		Default.Debug.log = not Default.Debug.log
		logSet['state']:setString((Default.Debug.log and '开') or '关')
		self:reSetDefault()
		if Default.Debug.log then
			self:toast('日志将输出到本地文件中!')
		end
	end)
end

function CTestSetting:addBuffTrigger( ... )

	self:addTitle('战斗Buff触发开关')
	local set = self:createLuaSet('@log')
	set['state']:setString((Default.Debug.trigger and '100%') or '正常概率' )
	set['title']:setString('Buff触发：')
	self._root_list:getContainer():addChild(set[1])
	self._root_list:layout()
	set['btnSave']:setListener(function (  )
		Default.Debug.trigger = not Default.Debug.trigger
		set['state']:setString((Default.Debug.trigger and '100%') or '正常概率' )
		self:reSetDefault()
	end)

end

function CTestSetting:addFPSItem( ... )
	self:addTitle('FPS开关')
	local set = self:createLuaSet('@log')
	set['state']:setString((Default.Debug.state and '显示') or '关闭' )
	set['title']:setString('FPS状态：')
	self._root_list:getContainer():addChild(set[1])
	self._root_list:layout()
	set['btnSave']:setListener(function (  )
		Default.Debug.state = not Default.Debug.state
		set['state']:setString((Default.Debug.state and '显示') or '关闭' )
		self:reSetDefault()
	end)
end

function CTestSetting:addSkillReleaseItem()
	self:addTitle('无限制大招开关')
	local set = self:createLuaSet('@log')
	set['state']:setString((Default.Debug.release and '打开') or '关闭' )
	set['title']:setString('状态：')
	self._root_list:getContainer():addChild(set[1])
	self._root_list:layout()
	set['btnSave']:setListener(function (  )
		Default.Debug.release = not Default.Debug.release
		set['state']:setString((Default.Debug.release and '打开') or '关闭' )
		self:reSetDefault()
	end)
end

function CTestSetting:addDirectFightItem()
	self:addTitle('直接进入战斗开关')
	local set = self:createLuaSet('@log')
	set['state']:setString((Default.Debug.directFight and '打开') or '关闭' )
	set['title']:setString('状态：')
	self._root_list:getContainer():addChild(set[1])
	self._root_list:layout()
	set['btnSave']:setListener(function (  )
		Default.Debug.directFight = not Default.Debug.directFight
		set['state']:setString((Default.Debug.directFight and '打开') or '关闭' )
		self:reSetDefault()
	end)
end

function CTestSetting:addDirectFightItem0( ... )
	self:addTitle('主界面战斗入口')
	local set = self:createLuaSet('@log')
	set['state']:setString((Default.Debug.EnterFight and '打开') or '关闭' )
	set['title']:setString('状态：')
	self._root_list:getContainer():addChild(set[1])
	self._root_list:layout()
	set['btnSave']:setListener(function (  )
		Default.Debug.EnterFight = not Default.Debug.EnterFight
		set['state']:setString((Default.Debug.EnterFight and '打开') or '关闭' )
		self:reSetDefault()
	end)
end

function CTestSetting:addFitSizeItem( ... )
	local default = self:getCTestLoginDefault()
	if not default.FIT then
		default.FIT = 'iphone5'
	end

	self:addTitle('屏幕适配')
	local set = self:createLuaSet('@log')
	set['state']:setString(default.FIT)
	set['title']:setString('屏幕比例:')
	set['btnSave_normal_title']:setString('更换')
	set['btnSave_pressed_title']:setString('更换')
	self._root_list:getContainer():addChild(set[1])
	self._root_list:layout()
	set['btnSave']:setListener(function ( ... )

		-- if default.FIT == 'iphone5' then
		-- 	CCEGLView:sharedOpenGLView():setDesignResolutionSize(960,640,2)
		-- 	default.FIT = 'iphone4'
		-- elseif default.FIT == 'iphone4' then
		-- 	CCEGLView:sharedOpenGLView():setDesignResolutionSize(1136, 640, 2)	
		-- 	default.FIT = 'iphone5'
		-- end
		
		set['state']:setString(default.FIT)
		Utils.writeTableToFile(default, 'CTestLogin')
	end)
end

function CTestSetting:addGuide( ... )
	local default = self:getCTestLoginDefault()

	self:addTitle('引导开关')
	local set = self:createLuaSet('@log')
	set['state']:setString((default.Guide and '开启') or '关闭' )
	set['title']:setString('引导：')
	self._root_list:getContainer():addChild(set[1])
	self._root_list:layout()
	set['btnSave']:setListener(function (  )
		default.Guide = not default.Guide
		set['state']:setString((default.Guide and '开启') or '关闭' )
		Utils.writeTableToFile(default,'CTestLogin')
	end)
end

function CTestSetting:addLogView( ... )
	local default = self:getCTestLoginDefault()
	self:addTitle('日志弹框')
	local set = self:createLuaSet('@log')
	set['state']:setString((default.LogView and '开启') or '关闭' )
	set['title']:setString('日志弹框：')
	self._root_list:getContainer():addChild(set[1])
	self._root_list:layout()
	set['btnSave']:setListener(function (  )
		default.LogView = not default.LogView
		set['state']:setString((default.LogView and '开启') or '关闭' )
		Utils.writeTableToFile(default,'CTestLogin')
	end)
end

function CTestSetting:reSetDefault( ... )

	Utils.writeTableToFile(Default.Debug, '../Default.lua')

	if Default.Debug.log then
		--打开输出log
		FileHelper:setRedirect(true)
	end

	if Default.Debug.state then
	 	CCDirector:sharedDirector():setDisplayStats(true);
	else
		CCDirector:sharedDirector():setDisplayStats(false);
	end
end


-----music
local DefaultMusicSettings = {}

function CTestSetting:addSound( prefix )
	-- body
	local key = prefix..'sound'
	self:addTitle( string.upper( key ) )
		
	local logSet = self:createLuaSet('@log')
	logSet['title']:setString( string.upper( key ) )
	logSet['state']:setString(((not MusicSettings[prefix]) and '开') or '关')

	self._root_list:getContainer():addChild(logSet[1])
	self._root_list:layout()
	logSet['btnSave']:setListener(function ()
		MusicSettings[key] = not MusicSettings[key]
		logSet['state']:setString(((not MusicSettings[key]) and '开') or '关')

		MusicSettings.flush()
	end)
end

function CTestSetting:addMusic( prefix )
	-- body
	local key = prefix..'music'
	self:addTitle( string.upper( key ) )

	local logSet = self:createLuaSet('@log')
	logSet['title']:setString( string.upper( key ) )
	logSet['state']:setString(((not MusicSettings[key]) and '开') or '关')

	self._root_list:getContainer():addChild(logSet[1])
	self._root_list:layout()
	logSet['btnSave']:setListener(function ()
		MusicSettings[key] = not MusicSettings[key]

		logSet['state']:setString(((not MusicSettings[key]) and '开') or '关')
		
		MusicSettings.flush()
	end)
end

function CTestSetting:getCTestLoginDefault(  )
	self._ctestDefault = self._ctestDefault or Utils.readTableFromFile('CTestLogin') or {RoleID = 1, ServerID = 1,IP=Config.SocketAddr,PORT=Config.SocketPort,FIT='iphone5'}
	return self._ctestDefault
end

function CTestSetting:addBattleArrayItem( ... )
	self:addTitle('阵容模式')
	local set = self:createLuaSet('@log')
	set['state']:setString((Default.Debug.battleArrayMode and '打开') or '关闭' )
	set['title']:setString('受限模式：')
	self._root_list:getContainer():addChild(set[1])
	self._root_list:layout()
	set['btnSave']:setListener(function (  )
		Default.Debug.battleArrayMode = not Default.Debug.battleArrayMode
		set['state']:setString((Default.Debug.battleArrayMode and '打开') or '关闭' )
		self:reSetDefault()
	end)
end

function CTestSetting:addSwitchLang( ... )
	self:addTitle('语言切换')
	local set = self:createLuaSet('@log')
	local curlang = require 'script.info.Info'.LANG_NAME
	set['state']:setString(curlang)
	set['title']:setString('当前语言:')
	set['btnSave_normal_title']:setString('切换')
	set['btnSave_pressed_title']:setString('切换')
	self._root_list:getContainer():addChild(set[1])
	self._root_list:layout()
	set['btnSave']:setListener(function ( ... )
		local selected = 1
		local localpath = string.format('%s/Local',FileHelper:getBundlePath())

		print('lfs.dir:')
		print(localpath)

		local langs={}
		for fname in lfs.dir(localpath) do
			if fname ~= '.' and fname ~= '..' then
				table.insert(langs,fname)		
			end
		end
		
		for i,v in ipairs(langs) do
			if curlang == v then
				selected = i
			end
		end

		local selectlangfunc = function ( index )
			print(index)
			Utils.writeTableToFile({cur=langs[index]},'LangSet')
			os.exit(0)
		end

		require 'DSelect'
		GleeCore:showLayer('DSelect',{title='语言选择',callback=selectlangfunc,param=langs,selected=selected})
	end)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(CTestSetting, "CTestSetting")


--------------------------------register--------------------------------
GleeCore:registerLuaController("CTestSetting", CTestSetting)

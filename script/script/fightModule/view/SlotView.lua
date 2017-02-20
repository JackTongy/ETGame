local EventCenter 			= require 'EventCenter'
local Broadcast 			= require 'framework.net.Broadcast'
local FightEvent 			= require 'FightEvent'
local Utils 				= require 'framework.helper.Utils'
local FightTimer 			= require 'FightTimer'
local RolePlayerManager 	= require 'RolePlayerManager'
local SkillChainManager 	= require 'SkillChainManager'
local RoleSelfManager 		= require 'RoleSelfManager'
local SkinManager 			= require 'SkinManager'
local ActionCameraFactory 	= require 'ActionCameraFactory'
local TimerHelper 			= require 'framework.sync.TimerHelper'
local FightSettings 		= require 'FightSettings'
local TimeOutManager 		= require "TimeOut"
local BallBarView 			= require 'BallBarView'
local Swf 					= require 'framework.swf.Swf'
local CfgHelper 			= require 'CfgHelper'
local StringViewHelper 		= require 'StringViewHelper'
local SelectHeroProxy 		= require 'SelectHeroProxy'

require "TimeOut"

local Default = require 'Default'

local alwaysSkill = Default.Debug and Default.Debug.release
-----------------------------------------------------------------------------------


local SlotView = class( require 'BasicView' )

-- TypeRole.Career_ZhanShi=1
-- -- 奇士
-- TypeRole.Career_QiShi=2
-- -- 远程
-- TypeRole.Career_YuanCheng=3
-- -- 治疗
-- TypeRole.Career_ZiLiao=4

local Career_Name = { '战士', '骑士', '远程', '治疗'}

local Job_Images = { [0]='hei.png', [1]='zhanshi.png', [2]='tanke.png', [3]='dps.png', [4]='zhiliao.png'}
local Small_Job_Images = {'zhanshi_small.png', 'tanke_small.png', 'dps_small.png', 'zhiliao_small.png'}
local Hei_Image = 'hei.png'

local Ball_N_Image = { [0] = NULL, [1] = 'ZD_JN_1.png', [2] = 'ZD_JN_2.png', [3] = 'ZD_JN_3.png',}

local Combo_N_Image = { [1] = 'ZD_1.png', [2] = 'ZD_2.png', [3] = 'ZD_3.png', [4] = 'ZD_4.png', }
local Combo_UP_Image = { [1] = 'ZD_bisha1.png', [2] = 'ZD_bisha2.png', [3] = 'ZD_bisha3.png', [4] = 'ZD_bisha5.png' }

local Pic_Cache = {}

local function getButtonPics( career, point )
	-- body
	--04 black
	--05 治疗
	--06 格挡
	--07 远程
	--08 战士
	local key = tostring(career)..'-'..tostring(point)

	if not Pic_Cache[key] then
		local pic0 = string.format('btn_ZDBSAN_%d_3.png', career)
		local pic1 = 'btn_ZDBSAN_0_3.png'
		local pic2 = 'btn_ZDBSAN_0_3.png'

		local bisha = string.format('btn_ZDBSAN_%d_wenzi.png', career)
		local water = string.format('btn_ZDBSAN_%d.png', career)

		local job = Job_Images[career]
		local small = Small_Job_Images[career]

		local twinkle
		if career >= 1 and career <= 4 then
			twinkle = {}
			for i=1,8 do
				table.insert(twinkle, string.format('jineng%d_%d.png', career, 10000+i))
			end
		end

		local data = { pic0=pic0, pic1=pic1, pic2=pic2, bisha=bisha, water=water, small=small, job=job, twinkle=twinkle}
		Pic_Cache[key] = data
	end

	return Pic_Cache[key]
end



local function getBallImageByCareer( career )
	-- body
	if type(career) == 'number' and career>=1 and career<=4 then
		return Job_Images[career]
	end
	return Hei_Image
end



--[[
	UpdateHandler 1.能量球
				  2.当前角色
					--> 当前角色职业
					--> 需要能量球
					--> 技能名称
					--> 按钮图片
					--> 按钮状态
					--> progress
	
	按钮按下:
		1.等待返回
		2.按钮无效

	技能返回:


	技能释放后
			1.删除能量球
			2.播放ReleaseSkill动画
			3.暂停战斗
			4.聚焦角色
			5.ReleaseSkill动画结束
			6.恢复角色
			7.继续战斗
	


--]]

--[[
0.能量球池子
lock
unlock
isLocked

没有动画
addMagicBall
removeMagicBall

runAnimation

--]]

--[[
1.能量球增加协议

--]]

--[[
2.释放技能
	--
	--
	--
--]]

--[[
S 的定义
1 开场
2 普通发放
3 击杀获得的奖励
pvpOrPve = 'pvp', 'pve'
--]]
function SlotView:ctor( luaset, document )
	-- body
	--luaset -> 战斗全景
	self._luaset = luaset
	self._document = document

	--slotluaset 赌博机

	--releaseSkillluaset -> 释放技能动画
	self._releaseSkillLuaSet = self:getReleaseSkillLuaSet()
	--init the view

	self:init()

	--设置文字
	-- self._roundNodeArray = {
	-- 	self._slotLuaSet['slot_line_round_n1'],
	-- 	self._slotLuaSet['slot_line_round_n2'],
	-- 	self._slotLuaSet['slot_line_round_n3'],
	-- 	self._slotLuaSet['slot_line_round_n4'],
	-- 	self._slotLuaSet['slot_line_round_n5'],
	-- }

	local light2 = AddColorNode:create()
	luaset['uiLayer_rb_button_light2'] = light2
	luaset['uiLayer_rb_button']:addChild(light2)

	local bisha = AddColorNode:create()
	bisha:setResid('btn_ZDBSAN_1_wenzi.png')
	luaset['uiLayer_rb_button_bisha2'] = bisha
	luaset['uiLayer_rb_button']:addChild(bisha)

	local lock = AddColorNode:create()
	lock:setResid('btn_suoding.png')
	luaset['uiLayer_rb_button_lock'] = lock
	luaset['uiLayer_rb_button']:addChild(lock)

	--设置UI文字
	self._uiRoundNodeArray = {
		self._luaset['uiLayer_lt_boshu_llayout_n1'],
		self._luaset['uiLayer_lt_boshu_llayout_n2'],
		self._luaset['uiLayer_lt_boshu_llayout_n3'],
		self._luaset['uiLayer_lt_boshu_llayout_n4'],
		self._luaset['uiLayer_lt_boshu_llayout_n5'],
	}

	self._showSkillState = 'hide'

	self._ballBarView = BallBarView.new(luaset, document)

	--{ career = career }
	EventCenter.addEventFunc(FightEvent.RemoveCareer, function ( data )
		-- body
		self._ballBarView:removeBallByCareer(data.career, 100)
	end)

	self:makeTouXiangCache()
	self:makeActionCache()

end

function SlotView:start(  )
	-- body
	if not self._handler then
		self._handler = FightTimer.tick(function ( dt )
			-- body
			self:update(dt)
		end)
	end
end

function SlotView:stop(  )
	-- body
	if self._handler then
		FightTimer.cancel(self._handler)
		self._handler = nil
	end
end

function SlotView:setSkillLocked()
	-- body
	self._skillLocked = true
end

function SlotView:unLockSkill()
	-- body
	self._skillLocked = false
end

function SlotView:isSkillLocked()
	-- body
	return self._skillLocked
end

function SlotView:makeTouXiangCache(  )
	-- body
	if not self._touxiangCacheMade then
		self._touxiangCacheMade = true

		local heroModuleArray = require 'ServerController'.getServerHeroArray()
		if heroModuleArray then
			for i,v in ipairs(heroModuleArray) do
				local charactorId = v:getBasicId()
				local big2 = SkinManager.getRoleBigIcon2ByCharactorId(charactorId)
				self:showTouXiang(big2[1], big2[2])
			end
		end
	end
end

function SlotView:showTouXiang( resid1, resid2 )
	-- body
	self._touxiangCache = self._touxiangCache or {}

	if not self._touxiangCache[resid1] then
		local luaset = self:createLuaSet(self._document, '@touxiang')
		self._touxiangCache[resid1] = luaset

		luaset['pic']:setResid(resid1)
		luaset['sb_shader']:setResid(resid2)

		self._luaset['uiLayer_rb2_tx']:addChild( luaset[1] )
		-- print('add '..resid1)
	end

	for i, v in pairs(self._touxiangCache) do
		if i == resid1 then
			v[1]:setVisible(true)
		else
			v[1]:setVisible(false)
		end
	end
	
end

function SlotView:getBallNumByType( career )
	-- body
	return self._ballBarView:getBallNumByCareer(career)
end

function SlotView:update( dt )
	-- body
	if self:isDisposed()  then
		return true
	end

	-- self:makeTouXiangCache()

	local info = SelectHeroProxy.getSelectPlayerInfo()

	local images
	local percentage
	local skillName
	local point
	local state 
	local locked = false
	--'empty', 'half', 'full'

	if info then
		skillName = info.skillName
		point = info.point
		images = getButtonPics(info.career, info.point)

		if info.skillId > 0 then
			local have = self:getBallNumByType( info.career )
			if have >= info.point then
				percentage = 100
				state = 'full'
			else
				percentage = 100 * (have / info.point)
				state = 'half'
			end
		else
			--禁用了
			percentage = 0
			state = 'empty'
			locked = true
		end

	else
		images = getButtonPics(0, 0)
		skillName = ''
		point = 0
		percentage = 0
		state = 'empty'
		locked = false
	end

	--setButtonPic
	local isPlayerCan = (info and info.player and info.player:canReleaseBigSkill() )

	self._luaset['uiLayer_rb_button']:setButtonPic(images.pic0, images.pic1, images.pic2)
	self._luaset['uiLayer_rb_button']:setEnabled( isPlayerCan and (alwaysSkill or state == 'full') and (not self:isSkillLocked()) )

	self._luaset['uiLayer_rb_ball']:setResid( images.small ) --small

	local visible = (state ~= 'empty')
	self._luaset['uiLayer_rb_button_light']:setVisible( visible )

	if visible then
		self._luaset['uiLayer_rb_button_light']:setResid( images.water )
		self._luaset['uiLayer_rb_button_light']:setPercentage(percentage)
	end

	self._luaset['uiLayer_rb_button_bisha']:setVisible( visible )
	if visible then
		self._luaset['uiLayer_rb_button_bisha']:setResid( images.bisha )
	end

	self._luaset['uiLayer_rb_num']:setVisible( visible )
	if visible then
		self._luaset['uiLayer_rb_num']:setResid( Ball_N_Image[point] )
	end
	
	self._luaset['uiLayer_rb_#mul']:setVisible( visible )

	-- print('-----skillName-----')
	-- print(skillName)
	self._luaset['uiLayer_rb_label']:setString( skillName )
	-- print('-----skillName-----!')

	self._luaset['uiLayer_rb_button_lock']:setVisible( locked )

	-- local charVo = CfgHelper.getCache('charactorConfig', 'id', info.charactorId)
	-- local heroName = (charVo and charVo.name) or ''
	-- self._luaset['uiLayer_rb_heroName']:setString(heroName)

	if state == 'full' then
		self:runTwinkleAction(true, images.water )
	else
		self:runTwinkleAction(false, images.water )
	end

	-- self:runTwinkleAction(true, '')

	-- info.skillId 
	if info then
		local big2 = SkinManager.getRoleBigIcon2ByCharactorId(info.charactorId)

		self:showTouXiang(big2[1], big2[2])
		-- self._luaset['uiLayer_rb_touxiang_pic']:setResid( big2[1] )
		-- self._luaset['uiLayer_rb_touxiang_sb_shader']:setResid( big2[2] )

		-- print(big2[1])
		-- print(big2[2])

		local skin = SkinManager.charactorToSkin(info.charactorId)
		local txVo = CfgHelper.getCache('BattleCharactor', 'id', tonumber(skin))

		if txVo then
			self._luaset['uiLayer_rb2_tx']:setVisible(true)

			self._luaset['uiLayer_rb2_tx']:setScaleX(txVo.scale)
			self._luaset['uiLayer_rb2_tx']:setScaleY(math.abs(txVo.scale))
			self._luaset['uiLayer_rb2_tx']:setPosition(ccp( txVo.x-1136, 640-txVo.y))
		else
			self._luaset['uiLayer_rb2_tx']:setVisible(false)
		end
	else
		self._luaset['uiLayer_rb2_tx']:setVisible(false)
	end
	
	--更新ball-pool

	-- 英雄头顶,能否释放技能
	local heroMap = RolePlayerManager.getPlayerMapSorted()
	for i,hero in ipairs(heroMap) do

		local charVo = CfgHelper.getCache('charactorConfig', 'id', hero.roleDyVo.basicId)
		assert(charVo)
		local career = charVo.atk_method_system

		local remain = self:getBallNumByType(career)

		local skillId = hero.roleDyVo.skill_id

		local need = 999
		if skillId > 0 then
			local skillBasicVo = CfgHelper.getCache('skill', 'id', skillId)
			need = skillBasicVo.point
		end

		local cloth = hero:getCloth()
		if cloth then
			if need <= remain then
				local chain = SkillChainManager.checkChain(hero.roleDyVo.playerId)

				if chain then
					cloth:setBloodMode(2)
				else
					cloth:setBloodMode(1)
				end
			else
				cloth:setBloodMode(0)
			end
		end
	end

end

--[[
初始化slot相关按钮监听, 以及事件相关协议
--]]
function SlotView:init()
	-- body

	-- EventCenter.addEventFunc(FightEvent.Pve_Slot, function ( data )
	-- 	self:handleSlotMessage(data)
	-- end, 'Fight')

	EventCenter.addEventFunc(FightEvent.TriggerSkill, function ( data )
		--
	end, 'Fight')

	-- fightEvent.Pve_ForceHideSkill
	EventCenter.addEventFunc(FightEvent.Pve_ForceHideSkill, function ( data )

		-- self:forceHideSkill()

	end, 'Fight')

	EventCenter.addEventFunc(FightEvent.Pve_NextWaveComing, function ( data )
		-- body
		self:handleRoundMessage(data)
	end, 'Fight')

	self._luaset['uiLayer_rb_button']:setListener(function (  )
		-- body
		-- send release msg
		self:sendReleaseMsg()
	end)

	----竞技场发来释放大招消息
	EventCenter.addEventFunc(FightEvent.ReleaseSkillInput, function ( data )
		-- body
		local player = RolePlayerManager.getPlayer( data.playerId )
		SelectHeroProxy.setSelectPlayer(player)
		
		self:sendReleaseMsgAnyway()
	end, 'Fight')

end

function SlotView:setTouchable( enable )
	-- body
	NodeHelper:setTouchable(self._luaset['layer'], enable)
end

-- function SlotView:forceHideSkill(  )
-- 	-- body
-- 	--??
-- 	self:setTouchable(true)
-- end

function SlotView:sendReleaseMsg()
	-- body
	local info = SelectHeroProxy.getSelectPlayerInfo()
	if info and not self:isSkillLocked() then
		if alwaysSkill or info.skillId > 0 and info.point <= self:getBallNumByType(info.career) then
			require 'framework.helper.MusicHelper'.playEffect( require 'Res'.Sound.bt_explosive )

			print('准备释放技能!!!!!!')

			self:setSkillLocked()
			self:setTouchable(false)

			EventCenter.eventInput(FightEvent.ReleaseSkill, { skillId=info.skillId, dyId=info.playerId } )

			--响应取消.
			--移除能量球.
			-- if not alwaysSkill then
				self._ballBarView:removeBallByCareer(info.career, info.point)
			-- end

			self:showSkill()
		end
	end
end

---用于竞技场
function SlotView:sendReleaseMsgAnyway()
	-- body
	local info = SelectHeroProxy.getSelectPlayerInfo()

	-- assert(info)
	assert(not self:isSkillLocked())

	if info and not self:isSkillLocked() then
		---自己才释放
		if info.player and info.player:isOwnerTeam() then
			print('准备释放技能!!!!!!')
			self:setSkillLocked()
			self:setTouchable(false)
			self:showSkill()
		end

		EventCenter.eventInput(FightEvent.ReleaseSkill, { skillId=info.skillId, dyId=info.playerId } )		
	end
end

function SlotView:runCamera( dx, dy )
	-- body
	local action = ActionCameraFactory.createAction( dx, dy )
	self._luaset['layer']:runAction( action )

	-- self._luaset['layer_bgLayer']:runAction( action:clone() )
	-- self._luaset['layer_bgSkillLayer']:runAction(makeAction())
	-- self._luaset['layer_touchLayer']:runAction(makeAction())
	-- self._luaset['layer_roleLayer']:runAction(makeAction())
	-- self._luaset['layer_touchLayerAbove']:runAction(makeAction())
	-- self._luaset['layer_skyLayer']:runAction(makeAction())
	-- self._luaset['layer_specialLayer']:runAction(makeAction())
	-- self._luaset['layer_fightTextLayer']:runAction(makeAction())
end

function SlotView:showSkill()
	local info = SelectHeroProxy.getSelectPlayerInfo()
	-- assert(info)

	if info then
		FightSettings.pause()

		local blackNode = self._luaset['layer_bgLayer_black']
		blackNode:runElfAction(self._luaset['ActionBlackInOut']:clone())

		local maxScale = 1.7
		local delayTime = 1.5
		local winSize = {
			width = require 'Global'.getWidth(),
			height = require 'Global'.getHeight(),
		}
		
		local targetCenter = { x=836-1136/2, y=230 - 640/2 }
		-- local targetCenter = { x=0, y=0 }

		local node = info.player:getRootNode()
		local playerPosition = NodeHelper:getPositionInScreen( node )
		local center = { x=winSize.width/2, y=winSize.height/2}

		local offsetScale1 = maxScale
		local offset1 = { x= -offsetScale1*(playerPosition.x-center.x), y =-offsetScale1*(playerPosition.y-center.y) }

		offset1.x = offset1.x + targetCenter.x
		offset1.y = offset1.y + targetCenter.y

		self:runCamera( offset1.x, offset1.y )

		local root = self._releaseSkillLuaSet[1]
		
		self._releaseSkillLuaSet['root_downBar_#label']:setString( info.skillName ) 

		self._releaseSkillLuaSet['root_#shield']:setVisible(true)

		root:setListener(function ()
			-- body
			-- root:setVisible(true)
		end)

		-- self:runWithDelay(function ( ... )
		-- 	-- body
		-- 	FightSettings.resume()
		-- end, delayTime)

		TimerHelper.tick(function ( ... )
			-- body
			FightSettings.resume()
			return true
		end, delayTime)
		

		--no longer needed
		-- TimeOutManager.addDelay(delayTime)

		-- timeOut1:start()

		-- self:runWithDelay(function ( ... )
		-- 	-- body
		-- 	self:unLockSkill()
		-- 	self:setTouchable(true)
		-- end, delayTime + 1)

		local timeOut2 = TimeOut.new(delayTime+1,function (  )
			-- body
			self:unLockSkill()
			self:setTouchable(true)
		end)
		timeOut2:start()

		root:setVisible(true)
		root:runAnimate(0, 2000,'#KeyStorage_show')

		local big2 = SkinManager.getRoleBigIcon2ByCharactorId(info.charactorId)
		-- self._releaseSkillLuaSet['root_pic_image']:setResid( big2[1] )
		-- self._releaseSkillLuaSet['root_pic_image0']:setResid( big2[1] )
		-- self._releaseSkillLuaSet['root_pic_image1']:setResid( big2[1] )
		-- self._releaseSkillLuaSet['root_pic_image2']:setResid( big2[1] )
		local offsetVo = CfgHelper.getCache('BattleCharactor', 'id', info.charactorId)

		-- assert()

		if offsetVo then
			local Global = require 'Global'
			local offsetX = -(-72.15) - ( Global.getWidth()/2 - offsetVo.info_x )
			local offsetY = -(-9.75) +   ( Global.getHeight()/2 - offsetVo.info_y )

			self._releaseSkillLuaSet['root_#pic']:setPosition(ccp(offsetX, offsetY))
		end

		local nodeMap = {
			[1] = self._releaseSkillLuaSet['root_pic_image2'],
			[2] = self._releaseSkillLuaSet['root_pic_image1'],
			[3] = self._releaseSkillLuaSet['root_pic_image0'],
			[4] = self._releaseSkillLuaSet['root_pic_image'],
		} 
		for i,node in ipairs(nodeMap) do
			node:setResid(big2[1])
			node:setVisible(false)
		end

		local mySwf = Swf.new('Swf_DaZhao', nodeMap)
		mySwf:play()

		local length = SkillChainManager.getChainLength( info.playerId )
		if length <= 1 then
			self._releaseSkillLuaSet['root_pic_image_combo']:setVisible(false)
		else
			self._releaseSkillLuaSet['root_pic_image_combo']:setVisible(true)

			length = length - 1
			length = math.min(length, 4)

			self._releaseSkillLuaSet['root_pic_image_combo_llayout1_num']:setResid( Combo_UP_Image[length] )
			self._releaseSkillLuaSet['root_pic_image_combo_llayout2_num']:setResid( Combo_N_Image[length] )
		end

	else

		print('------------------------------------')
		print('showSkill error:')
		print(data)

		print('already have '..self:getBallNumByType(data.career))
		print('------------------------------------')

	end

end

function SlotView:handleRoundMessage( data )
	-- body
	--waveIndex, maxWaveIndex, isboss
	if not RoleSelfManager.isPvp then
		local str = string.format('%d/%d', data.waveIndex, data.maxWaveIndex)

		-- StringViewHelper.setRoundBigString(self._roundNodeArray, str)

		StringViewHelper.setRoundSmallString(self._uiRoundNodeArray, str)
	end
end

function SlotView:getReleaseSkillLuaSet()
	-- body
	if not self._releaseSkillLuaSet then
		self._releaseSkillLuaSet = self:createLuaSet(self._document, '@ReleaseSkill')
		self._releaseSkillLuaSet[1]:setVisible(false)
		self._luaset['uiLayer_labels']:addChild( self._releaseSkillLuaSet[1], 100 )

		if RoleSelfManager.isPvp then
			local node = self._releaseSkillLuaSet['slot_#line']
			if node and not tolua.isnull(node) then
				node:setVisible(false)
				node:removeFromParent()
			end
		end
	end

	return self._releaseSkillLuaSet
end


function SlotView:makeActionCache()
	-- body
	if not self._twinkleActionCached then

		local SwfActionFactory = require 'framework.swf.SwfActionFactory'
		local tableData = require 'ActionBiSha'

		local a1 = SwfActionFactory.createPureAction(tableData.array[1])
		local a2 = SwfActionFactory.createPureAction(tableData.array[2])

		local action1 = CCRepeatForever:create(a1)
		local action2 = CCRepeatForever:create(a2)

		self._luaset['uiLayer_rb_button_light2']:runElfAction(action1)
		self._luaset['uiLayer_rb_button_bisha2']:runElfAction(action2)

		self._twinkleActionCached = true
	end
end


function SlotView:runTwinkleAction(enable, image)
	-- body
	self:makeActionCache()

	enable = (enable and true) or false 

	if enable ~= self._twinkleenable then
		self._twinkleenable = enable 
		if enable then
			self._luaset['uiLayer_rb_button_light2']:setVisible(true)
			self._luaset['uiLayer_rb_button_bisha2']:setVisible(true)
		else
			self._luaset['uiLayer_rb_button_light2']:setVisible(false)
			self._luaset['uiLayer_rb_button_bisha2']:setVisible(false)
		end
	end

	self._luaset['uiLayer_rb_button_light2']:setResid(image)
end

---------------------------------------ping test------------------------------------

local Client = require 'SocketClientPvp'
local TimeManager = require 'TimeManager'

function SlotView:compareTime( )
	-- body
	local timedata = { C='Ping' }

	local time1 = SystemHelper:currentTimeMillis()

	Client:send(timedata, function ( netdata )
		-- print(netdata)
		-- body
		local now = SystemHelper:currentTimeMillis() --SystemHelper:currentTimeMillis()

		print('发送的时间:'..time1)
		print('服务器时间:'..netdata.D.T)
		print('接收的时间:'..now)
		print('时间的差值:'..(now/2+time1/2-netdata.D.T))
		print('传输的时间:'..(now-time1))
		print('调节值:'..TimeManager._adjust2ServerTime)
		

		-- local lasttimeout = timeout
		-- local currtimeout = (now - last)/2

		-- if currtimeout < lasttimeout then
		-- 	timeout = currtimeout
		-- 	print('set timeout:'..timeout)
		-- 	print("netdata.D.T="..netdata.D.T)
		-- 	print("last="..last)
		-- 	timeManager.setLoginSeverTime( netdata.D.T+timeout )
		-- end
		
	end)
end

return SlotView


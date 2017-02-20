local Config = require "Config"
local Res = require 'Res'
local netModel = require 'netModel'
local SwfActionFactory = require 'framework.swf.SwfActionFactory'
local AppData = require "AppData"

local DTrialReward = class(LuaDialog)

function DTrialReward:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DTrialReward.cocos.zip")
    return self._factory:createDocument("DTrialReward.cocos")
end

--@@@@[[[[
function DTrialReward:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getJoint9Node("bg")
    self._bg_tips = set:getLabelNode("bg_tips")
    self._bg_rewardLayout = set:getLinearLayoutNode("bg_rewardLayout")
    self._bg_rewardLayout_reward1 = set:getColorClickNode("bg_rewardLayout_reward1")
    self._bg_rewardLayout_reward1_normal_box = set:getElfNode("bg_rewardLayout_reward1_normal_box")
    self._bg_rewardLayout_reward1_normal_gift = set:getElfNode("bg_rewardLayout_reward1_normal_gift")
    self._bg_rewardLayout_reward1_normal_gift_light = set:getElfNode("bg_rewardLayout_reward1_normal_gift_light")
    self._bg_rewardLayout_reward1_normal_gift_content = set:getElfNode("bg_rewardLayout_reward1_normal_gift_content")
    self._bg_rewardLayout_reward1_normal_gift_content_bg = set:getElfNode("bg_rewardLayout_reward1_normal_gift_content_bg")
    self._bg_rewardLayout_reward1_normal_gift_content_icon = set:getElfNode("bg_rewardLayout_reward1_normal_gift_content_icon")
    self._bg_rewardLayout_reward1_normal_gift_content_pet = set:getElfNode("bg_rewardLayout_reward1_normal_gift_content_pet")
    self._bg_rewardLayout_reward1_normal_gift_content_frame = set:getElfNode("bg_rewardLayout_reward1_normal_gift_content_frame")
    self._bg_rewardLayout_reward1_normal_gift_content_piece = set:getElfNode("bg_rewardLayout_reward1_normal_gift_content_piece")
    self._bg_rewardLayout_reward1_normal_gift_count = set:getLabelNode("bg_rewardLayout_reward1_normal_gift_count")
    self._bg_rewardLayout_reward1_normal_gift_isSuit = set:getSimpleAnimateNode("bg_rewardLayout_reward1_normal_gift_isSuit")
    self._bg_rewardLayout_reward1_normal_gift_starLayout = set:getLayoutNode("bg_rewardLayout_reward1_normal_gift_starLayout")
    self._bg_rewardLayout_reward1_normal_gift_name = set:getLabelNode("bg_rewardLayout_reward1_normal_gift_name")
    self._bg_rewardLayout_reward2 = set:getColorClickNode("bg_rewardLayout_reward2")
    self._bg_rewardLayout_reward2_normal_box = set:getElfNode("bg_rewardLayout_reward2_normal_box")
    self._bg_rewardLayout_reward2_normal_gift = set:getElfNode("bg_rewardLayout_reward2_normal_gift")
    self._bg_rewardLayout_reward2_normal_gift_light = set:getElfNode("bg_rewardLayout_reward2_normal_gift_light")
    self._bg_rewardLayout_reward2_normal_gift_content = set:getElfNode("bg_rewardLayout_reward2_normal_gift_content")
    self._bg_rewardLayout_reward2_normal_gift_content_bg = set:getElfNode("bg_rewardLayout_reward2_normal_gift_content_bg")
    self._bg_rewardLayout_reward2_normal_gift_content_icon = set:getElfNode("bg_rewardLayout_reward2_normal_gift_content_icon")
    self._bg_rewardLayout_reward2_normal_gift_content_pet = set:getElfNode("bg_rewardLayout_reward2_normal_gift_content_pet")
    self._bg_rewardLayout_reward2_normal_gift_content_frame = set:getElfNode("bg_rewardLayout_reward2_normal_gift_content_frame")
    self._bg_rewardLayout_reward2_normal_gift_content_piece = set:getElfNode("bg_rewardLayout_reward2_normal_gift_content_piece")
    self._bg_rewardLayout_reward2_normal_gift_count = set:getLabelNode("bg_rewardLayout_reward2_normal_gift_count")
    self._bg_rewardLayout_reward2_normal_gift_isSuit = set:getSimpleAnimateNode("bg_rewardLayout_reward2_normal_gift_isSuit")
    self._bg_rewardLayout_reward2_normal_gift_starLayout = set:getLayoutNode("bg_rewardLayout_reward2_normal_gift_starLayout")
    self._bg_rewardLayout_reward2_normal_gift_name = set:getLabelNode("bg_rewardLayout_reward2_normal_gift_name")
    self._bg_rewardLayout_reward3 = set:getColorClickNode("bg_rewardLayout_reward3")
    self._bg_rewardLayout_reward3_normal_box = set:getElfNode("bg_rewardLayout_reward3_normal_box")
    self._bg_rewardLayout_reward3_normal_gift = set:getElfNode("bg_rewardLayout_reward3_normal_gift")
    self._bg_rewardLayout_reward3_normal_gift_light = set:getElfNode("bg_rewardLayout_reward3_normal_gift_light")
    self._bg_rewardLayout_reward3_normal_gift_content = set:getElfNode("bg_rewardLayout_reward3_normal_gift_content")
    self._bg_rewardLayout_reward3_normal_gift_content_bg = set:getElfNode("bg_rewardLayout_reward3_normal_gift_content_bg")
    self._bg_rewardLayout_reward3_normal_gift_content_icon = set:getElfNode("bg_rewardLayout_reward3_normal_gift_content_icon")
    self._bg_rewardLayout_reward3_normal_gift_content_pet = set:getElfNode("bg_rewardLayout_reward3_normal_gift_content_pet")
    self._bg_rewardLayout_reward3_normal_gift_content_frame = set:getElfNode("bg_rewardLayout_reward3_normal_gift_content_frame")
    self._bg_rewardLayout_reward3_normal_gift_content_piece = set:getElfNode("bg_rewardLayout_reward3_normal_gift_content_piece")
    self._bg_rewardLayout_reward3_normal_gift_count = set:getLabelNode("bg_rewardLayout_reward3_normal_gift_count")
    self._bg_rewardLayout_reward3_normal_gift_isSuit = set:getSimpleAnimateNode("bg_rewardLayout_reward3_normal_gift_isSuit")
    self._bg_rewardLayout_reward3_normal_gift_starLayout = set:getLayoutNode("bg_rewardLayout_reward3_normal_gift_starLayout")
    self._bg_rewardLayout_reward3_normal_gift_name = set:getLabelNode("bg_rewardLayout_reward3_normal_gift_name")
    self._bg_confirm = set:getClickNode("bg_confirm")
    self._bg_confirm_title = set:getLabelNode("bg_confirm_title")
    self._bg_tryLayer = set:getElfNode("bg_tryLayer")
    self._bg_tryLayer_btnOk = set:getClickNode("bg_tryLayer_btnOk")
    self._bg_tryLayer_btnOk_title = set:getLabelNode("bg_tryLayer_btnOk_title")
    self._bg_tryLayer_btnTry = set:getClickNode("bg_tryLayer_btnTry")
    self._bg_tryLayer_btnTry_title = set:getLabelNode("bg_tryLayer_btnTry_title")
    self._bg_tryLayer_layout1_text = set:getLabelNode("bg_tryLayer_layout1_text")
    self._ActionRewardLight = set:getElfAction("ActionRewardLight")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DTrialReward:onInit( userData, netData )
	self.seniorRewardMode = userData and userData.seniorReward or false
	
	self._bg_confirm:setListener(function ( ... )
	    Res.doActionDialogHide(self._bg, self)
	end)
	self:setBoxListener()
	self:updateDialog()
	self._bg_confirm:setVisible(true)
	self._bg_tryLayer:setVisible(false)
	Res.doActionDialogShow(self._bg)
end

function DTrialReward:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

local ScaleDataRate = 1
local ScaleData= {
    [1] = { f = 1, v = false},
    [2] = { f = 7,  s = {ScaleDataRate*1.00/2.58, ScaleDataRate*1.00/2.58},   a = 0, v = true },
    [3] = { f = 8,  s = {ScaleDataRate*1.63/2.58, ScaleDataRate*1.63/2.58},   a = 92 },
    [4] = { f = 9,  s = {ScaleDataRate*2.12/2.58, ScaleDataRate*2.12/2.58},   a = 164 },
    [5] = { f = 10, s = {ScaleDataRate*2.47/2.58, ScaleDataRate*2.47/2.58},   a = 215 },
    [6] = { f = 11, s = {ScaleDataRate*2.69/2.58, ScaleDataRate*2.69/2.58},   a = 246 },
    [7] = { f = 12, s = {ScaleDataRate*2.76/2.58, ScaleDataRate*2.76/2.58},   a = 255 },
    [8] = { f = 13, s = {ScaleDataRate*2.58/2.58, ScaleDataRate*2.58/2.58},    },
}

local RewardBoxBGData = {
    [1] = { f = 1,  i = 'N_ZD_diaoluo_baoxiang1.png', v = true },
    [1] = { f = 8,  i = 'N_ZD_diaoluo_baoxiang2.png'},
    --[1] = { f = 10,  i = 'N_ZD_diaoluo_baoxiang2.png', v = false}
}

-- local RewardBallBGData = {
--     [1] = { f = 1,  i = 'N_ZD_diaoluo_qiu.png', v = true },
--     [1] = { f = 8,  i = 'N_ZD_diaoluo_qiu2.png'},
-- }

function DTrialReward:updateDialog()
    for i = 1, 3 do
        self[string.format('_bg_rewardLayout_reward%d_normal_gift', i)]:stopAllActions()
        self[string.format('_bg_rewardLayout_reward%d_normal_box', i)]:stopAllActions()
        self[string.format('_bg_rewardLayout_reward%d_normal_gift', i)]:setVisible(false)
        self[string.format('_bg_rewardLayout_reward%d_normal_box', i)]:setVisible(true)
        self[string.format('_bg_rewardLayout_reward%d_normal_box', i)]:setResid("N_ZD_diaoluo_baoxiang1.png")
        self[string.format('_bg_rewardLayout_reward%d', i)]:setEnabled(true)
    end
end

function DTrialReward:setBoxListener()
	local rewardCost = require "DBManager".getInfoDefaultConfig("AdvBuyBoxCost").Value
    for i = 1, 3 do
        ----[[
        self[string.format('_bg_rewardLayout_reward%d', i)]:setListener(function()
        	if self.seniorRewardGetting and AppData.getUserInfo().getCoin() < rewardCost then
        		require "Toolkit".showDialogOnCoinNotEnough()
        	else
	            self:send(netModel.getModelAdvReward(self.seniorRewardGetting),function ( data )
	                if data and data.D then
	                	if data.D.Adventure.CurrentType ~= 0 then
	                		self._bg_tips:setVisible(false)
	                        for j = 1, 3 do
	                            self[string.format('_bg_rewardLayout_reward%d', j)]:setEnabled(false)
	                        end

	                        self:getUserData().callBack(data.D.Adventure)
	                        AppData.updateResource(data.D.Resource)
	                        --print('msg:-----------------------data.D')
	                        --print(data.D)
	                        self:refreshReward(i, data.D.Reward, true)
	                        self:playAnimate(i, true)
	                        self:runWithDelay(function( ... )
	                            local index = 1
	                            for j = 1, 3 do
	                                if j ~= i then
	                                    --print('msg:------------coming other rewards   index: '..tostring(index))
	                                    self:refreshReward(j, data.D.Rwds[index], true)
	                                    self:playAnimate(j)
	                                    index = index + 1
	                                end
	                            end
	                        end, 0.5, self._bg_tryLayer)
					if self.seniorRewardMode then
					      self._bg_confirm:setVisible(false)
					      self._bg_tryLayer:setVisible(true)
					    	self._bg_tryLayer_layout1_text:setString(rewardCost)
						self._bg_tryLayer_btnTry:setListener(function ( ... )
							self.seniorRewardMode = false
							self.seniorRewardGetting = true

							self._bg_tryLayer:stopAllActions()
							self._bg_tips:setVisible(true)
							self:updateDialog()
					   	      self._bg_confirm:setVisible(true)
					            self._bg_tryLayer:setVisible(false)
						end)

						self._bg_tryLayer_btnOk:setListener(function ( ... )
							Res.doActionDialogHide(self._bg, self)
						end)
					end
	                	else -- 试炼数据已被重置
	                		self:getUserData().callBack(data.D.Adventure)
	                		Res.doActionDialogHide(self._bg, self)
	                	end
	                end
	            end)    		
        	end
        end)
        --]]
        --[[
        self[string.format('_bg_rewardLayout_reward%d', i)]:setListener(function()
           self:playAnimate(i, true)
           self:runWithDelay(function( ... )
                for j = 1, 3 do
                    if j ~= i then
                        self:playAnimate(j)
                    end
                end
            end, 0.5)
        end)
        --]]
    end
end

function DTrialReward:refreshReward(index, reward, lightVisible)
    -- if not data.Rwds or not data.Reward then return end
    -- local reward = data.Rwds
    -- table.insert(reward, data.Reward)
    if not reward or not next(reward) then return self:toast('reward nil') end
    local list = Res.getRewardResList(reward)
    if not list then return self:toast('list nil') end
    
    -- print('msg:--------------------reward')
    -- print(reward)
    -- print('msg:-----------------getreward format')
    -- print(list)
    self:refreshItem(index, list[1], lightVisible)
end

function DTrialReward:refreshItem(index, data, lightVisible)
    -- self[string.format('_bg_rewardLayout_reward%d_normal_gift_light', index)]:setVisible(lightVisible)
    self[string.format('_bg_rewardLayout_reward%d_normal_gift_content_bg', index)]:setResid(data.bg)
    self[string.format('_bg_rewardLayout_reward%d_normal_gift_content_frame', index)]:setResid(data.frame)
    --self[string.format('_bg_rewardLayout_reward1_normal_gift_count', index)]:setString(data.count)
    self[string.format('_bg_rewardLayout_reward%d_normal_gift_name', index)]:setString(string.format('%sx%d', data.name, data.count))

    if data.type == "Pet" or data.type == "PetPiece" then
        self[string.format('_bg_rewardLayout_reward%d_normal_gift_content_pet', index)]:setVisible(true)
        self[string.format('_bg_rewardLayout_reward%d_normal_gift_content_icon', index)]:setVisible(false)
        self[string.format('_bg_rewardLayout_reward%d_normal_gift_content_pet', index)]:setResid(data.icon)
    else
        self[string.format('_bg_rewardLayout_reward%d_normal_gift_content_pet', index)]:setVisible(false)
        self[string.format('_bg_rewardLayout_reward%d_normal_gift_content_icon', index)]:setVisible(true)
        self[string.format('_bg_rewardLayout_reward%d_normal_gift_content_icon', index)]:setResid(data.icon)
    end
    self[string.format('_bg_rewardLayout_reward%d_normal_gift_content_piece', index)]:setVisible(data.isPiece)
end

function DTrialReward:playAnimate(index, lightVisible)
    if lightVisible then
        self[string.format('_bg_rewardLayout_reward%d_normal_gift_light', index)]:runAction( self._ActionRewardLight:clone() )
    else
        self[string.format('_bg_rewardLayout_reward%d_normal_gift_light', index)]:setVisible(false)
    end
    -- box
    self[string.format('_bg_rewardLayout_reward%d_normal_box', index)]:runAction( SwfActionFactory.createAction( RewardBoxBGData ) )
    -- icon
    self[string.format('_bg_rewardLayout_reward%d_normal_gift', index)]:runAction( SwfActionFactory.createAction( ScaleData ) )
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DTrialReward, "DTrialReward")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DTrialReward", DTrialReward)



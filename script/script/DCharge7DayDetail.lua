local Config = require "Config"
local res = require "Res"
local netModel = require "netModel"

local DCharge7DayDetail = class(LuaDialog)

function DCharge7DayDetail:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DCharge7DayDetail.cocos.zip")
    return self._factory:createDocument("DCharge7DayDetail.cocos")
end

--@@@@[[[[
function DCharge7DayDetail:onInitXML()
    local set = self._set
   self._clickBg = set:getClickNode("clickBg")
   self._bg = set:getJoint9Node("bg")
   self._bg_list = set:getListNode("bg_list")
   self._bg_list_container_title = set:getElfNode("bg_list_container_title")
   self._bg_list_container_title_text = set:getLabelNode("bg_list_container_title_text")
   self._bg_list_container_title1 = set:getElfNode("bg_list_container_title1")
   self._bg_list_container_title1_layoutTitle = set:getLinearLayoutNode("bg_list_container_title1_layoutTitle")
   self._bg_list_container_title1_layoutTitle_valueName = set:getLabelNode("bg_list_container_title1_layoutTitle_valueName")
   self._bg_list_container_title2 = set:getElfNode("bg_list_container_title2")
   self._bg_list_container_title2_layoutTitle = set:getLinearLayoutNode("bg_list_container_title2_layoutTitle")
   self._bg_list_container_title2_layoutTitle_valueTime = set:getLabelNode("bg_list_container_title2_layoutTitle_valueTime")
   self._bg_list_container_title3 = set:getElfNode("bg_list_container_title3")
   self._bg_list_container_title3_layoutTitle = set:getLinearLayoutNode("bg_list_container_title3_layoutTitle")
   self._rewardTitle = set:getLabelNode("rewardTitle")
   self._rewardContent1 = set:getLabelNode("rewardContent1")
   self._rewardContent2 = set:getLabelNode("rewardContent2")
   self._layoutTitle = set:getLinearLayoutNode("layoutTitle")
   self._valueDetail = set:getLabelNode("valueDetail")
   self._layoutTitle = set:getLinearLayoutNode("layoutTitle")
   self._valueDes = set:getLabelNode("valueDes")
--   self._@layoutReward = set:getLinearLayoutNode("@layoutReward")
--   self._@title4 = set:getElfNode("@title4")
--   self._@valueDetail = set:getElfNode("@valueDetail")
--   self._@title5 = set:getElfNode("@title5")
--   self._@valueDes = set:getElfNode("@valueDes")
end
--@@@@]]]]

--------------------------------override functions----------------------
local Launcher = require 'Launcher'
Launcher.register("DCharge7DayDetail", function ( userData )
	Launcher.callNet(netModel.getModelCharge7DayDetail(),function ( data )
     		Launcher.Launching(data) 
   	end)
end)


function DCharge7DayDetail:onInit( userData, netData )
	res.doActionDialogShow(self._bg)
	self._clickBg:setListener(function ( ... )
		res.doActionDialogHide(self._bg, self)
	end)

	self:updateLayer(netData)

end

function DCharge7DayDetail:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DCharge7DayDetail:updateLayer( data )
	print(data)
	if data and data.D then 
		self.datalist = data.D.Data or {}
		self._bg_list_container_title1_layoutTitle_valueName:setString(string.format(res.locString("DCharge7DayDetail$valueName"), #self.datalist))
		local actData = require "ActivityInfo".getDataByType(19)
		print("wwww:" .. actData.OpenAt)
		print("wwww:" .. actData.CloseAt)
		self._bg_list_container_title2_layoutTitle_valueTime:setString(string.format("%s-%s",self:formatTime(actData.OpenAt),self:formatTime(actData.CloseAt)))
		for i,reward in ipairs(self.datalist) do
			print(i,reward)
			local money1 = reward.Money1
			local reward1 = reward.Reward1
			local money2 = reward.Money2
			local reward2 = reward.Reward2
			local rewardList1 = res.getRewardResList( reward1 )
			local rewardList2 = res.getRewardResList( reward2 )
			local rewardItem1 = self:getRewardItem(rewardList1)
			local rewardItem2 = self:getRewardItem(rewardList2)
			local layoutReward = self:createLuaSet("@layoutReward")
			layoutReward["rewardTitle"]:setString(string.format(res.locString("DCharge7DayDetail$titleDays"), i))
			local rewardDetail1 = string.format(res.locString('Activity$Charge7DayS1'), money1)  .. rewardItem1
			local rewardDetail2 = string.format(res.locString('Activity$Charge7DayS1'), money2)  .. rewardItem2
			layoutReward["rewardContent1"]:setString(rewardDetail1)
			layoutReward["rewardContent2"]:setString(rewardDetail2)
			
			self._bg_list:getContainer():addChild(layoutReward[1])

		end
	end

	local title4 = self:createLuaSet("@title4")
	local valueDetail = self:createLuaSet("@valueDetail")
	local title5 = self:createLuaSet("@title5")
	local valueDes1 = self:createLuaSet("@valueDes")
	local valueDes2 = self:createLuaSet("@valueDes")
	valueDes1["valueDes"]:setString(res.locString("DCharge7DayDetail$valueDes1"))
	valueDes2["valueDes"]:setString(res.locString("DCharge7DayDetail$valueDes2"))
	self._bg_list:getContainer():addChild(title4[1])
	self._bg_list:getContainer():addChild(valueDetail[1])
	self._bg_list:getContainer():addChild(title5[1])
	self._bg_list:getContainer():addChild(valueDes1[1])
	self._bg_list:getContainer():addChild(valueDes2[1])
end

function DCharge7DayDetail:getRewardItem( rewardList )
	local rewardItem = ""

	for i,v in ipairs(rewardList) do
		print(i,v)
		local rewardName = v.name
		local rewardCount = v.count
		rewardItem = rewardItem .. "," .. rewardName .."*" .. rewardCount
	end

	return rewardItem
end

function DCharge7DayDetail:formatTime( time )
	local timestamp = require 'TimeManager'.getTimestamp(time)
  	local ldt = os.date('*t',timestamp)
  	local ret = require 'LangAdapter'.selectLangkv({German=function ( ... )
      return string.format(res.locString('Activity$DateFormat1'),ldt.day,ldt.month,ldt.hour)
  	end})

  	return ret or string.format(res.locString('Activity$DateFormat1'),ldt.month,ldt.day,ldt.hour)
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DCharge7DayDetail, "DCharge7DayDetail")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DCharge7DayDetail", DCharge7DayDetail)

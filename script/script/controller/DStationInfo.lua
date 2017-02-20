local Config = require "Config"
local Res = require "Res"

local DStationInfo = class(LuaDialog)

function DStationInfo:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DStationInfo.cocos.zip")
    return self._factory:createDocument("DStationInfo.cocos")
end

--@@@@[[[[
function DStationInfo:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getJoint9Node("bg")
    self._bg_leftBG = set:getElfNode("bg_leftBG")
    self._bg_leftBG_BG_TOP = set:getElfNode("bg_leftBG_BG_TOP")
    self._bg_leftBG_BG_TOP_identify = set:getElfNode("bg_leftBG_BG_TOP_identify")
    self._bg_leftBG_BG_TOP_identify_icon = set:getElfNode("bg_leftBG_BG_TOP_identify_icon")
    self._bg_leftBG_BG_TOP_identify_frame = set:getElfNode("bg_leftBG_BG_TOP_identify_frame")
    self._bg_leftBG_BG_TOP_name = set:getLabelNode("bg_leftBG_BG_TOP_name")
    self._bg_leftBG_BG_TOP_power = set:getLinearLayoutNode("bg_leftBG_BG_TOP_power")
    self._bg_leftBG_BG_TOP_power_number = set:getLabelNode("bg_leftBG_BG_TOP_power_number")
    self._bg_leftBG_BG_TOP_leader = set:getLinearLayoutNode("bg_leftBG_BG_TOP_leader")
    self._bg_leftBG_BG_TOP_leader_name = set:getLabelNode("bg_leftBG_BG_TOP_leader_name")
    self._bg_leftBG_BG_BOTTOM = set:getElfNode("bg_leftBG_BG_BOTTOM")
    self._bg_leftBG_BG_BOTTOM_identify = set:getElfNode("bg_leftBG_BG_BOTTOM_identify")
    self._bg_leftBG_BG_BOTTOM_identify_icon = set:getElfNode("bg_leftBG_BG_BOTTOM_identify_icon")
    self._bg_leftBG_BG_BOTTOM_identify_frame = set:getElfNode("bg_leftBG_BG_BOTTOM_identify_frame")
    self._bg_leftBG_BG_BOTTOM_belongTo = set:getLabelNode("bg_leftBG_BG_BOTTOM_belongTo")
    self._bg_leftBG_BG_BOTTOM_btnCancel = set:getClickNode("bg_leftBG_BG_BOTTOM_btnCancel")
    self._bg_leftBG_BG_BOTTOM_btnCancel_des = set:getLabelNode("bg_leftBG_BG_BOTTOM_btnCancel_des")
    self._bg_leftBG_BG_BOTTOM_teamPower = set:getLabelNode("bg_leftBG_BG_BOTTOM_teamPower")
    self._bg_leftBG_BG_BOTTOM_powerNum = set:getLabelNode("bg_leftBG_BG_BOTTOM_powerNum")
    self._bg_leftBG_btnOperate = set:getClickNode("bg_leftBG_btnOperate")
    self._bg_leftBG_btnOperate_des = set:getLabelNode("bg_leftBG_btnOperate_des")
    self._bg_leftBG_benefit = set:getElfNode("bg_leftBG_benefit")
    self._bg_leftBG_benefit_union = set:getLabelNode("bg_leftBG_benefit_union")
    self._bg_leftBG_benefit_personal = set:getLabelNode("bg_leftBG_benefit_personal")
    self._bg_leftBG_continuous = set:getLabelNode("bg_leftBG_continuous")
    self._bg_leftBG_debuff = set:getLabelNode("bg_leftBG_debuff")
    self._bg_rightBG = set:getElfNode("bg_rightBG")
    self._bg_rightBG_list = set:getListNode("bg_rightBG_list")
    self._leader = set:getLinearLayoutNode("leader")
    self._leader_name = set:getLabelNode("leader_name")
    self._identify = set:getElfNode("identify")
    self._identify_icon = set:getElfNode("identify_icon")
    self._identify_frame = set:getElfNode("identify_frame")
    self._name = set:getLabelNode("name")
    self._power = set:getLinearLayoutNode("power")
    self._power_number = set:getLabelNode("power_number")
--    self._@cell = set:getElfNode("@cell")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DStationInfo:onInit( userData, netData )
	Res.doActionDialogShow(self._bg)

    self._clickBg:setListener(function ()
        Res.doActionDialogHide(self._bg, self)
    end)

    self:updateDialog()
end

function DStationInfo:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DStationInfo:updateDialog( ... )
    -- self._bg_leftBG_BG_TOP = set:getElfNode("bg_leftBG_BG_TOP")
    -- self._bg_leftBG_BG_TOP_identify = set:getElfNode("bg_leftBG_BG_TOP_identify")
    -- self._bg_leftBG_BG_TOP_identify_icon = set:getElfNode("bg_leftBG_BG_TOP_identify_icon")
    -- self._bg_leftBG_BG_TOP_identify_frame = set:getElfNode("bg_leftBG_BG_TOP_identify_frame")
    -- self._bg_leftBG_BG_TOP_name = set:getLabelNode("bg_leftBG_BG_TOP_name")
    -- self._bg_leftBG_BG_TOP_power = set:getLinearLayoutNode("bg_leftBG_BG_TOP_power")
    -- self._bg_leftBG_BG_TOP_power_number = set:getLabelNode("bg_leftBG_BG_TOP_power_number")
    -- self._bg_leftBG_BG_TOP_leader = set:getLinearLayoutNode("bg_leftBG_BG_TOP_leader")
    -- self._bg_leftBG_BG_TOP_leader_name = set:getLabelNode("bg_leftBG_BG_TOP_leader_name")
    -- self._bg_leftBG_BG_BOTTOM = set:getElfNode("bg_leftBG_BG_BOTTOM")
    -- self._bg_leftBG_BG_BOTTOM_identify = set:getElfNode("bg_leftBG_BG_BOTTOM_identify")
    -- self._bg_leftBG_BG_BOTTOM_identify_icon = set:getElfNode("bg_leftBG_BG_BOTTOM_identify_icon")
    -- self._bg_leftBG_BG_BOTTOM_identify_frame = set:getElfNode("bg_leftBG_BG_BOTTOM_identify_frame")
    -- self._bg_leftBG_BG_BOTTOM_belongTo = set:getLabelNode("bg_leftBG_BG_BOTTOM_belongTo")
    -- self._bg_leftBG_BG_BOTTOM_btnCancel = set:getClickNode("bg_leftBG_BG_BOTTOM_btnCancel")
    -- self._bg_leftBG_BG_BOTTOM_btnCancel_des = set:getLabelNode("bg_leftBG_BG_BOTTOM_btnCancel_des")
    -- self._bg_leftBG_BG_BOTTOM_teamPower = set:getLabelNode("bg_leftBG_BG_BOTTOM_teamPower")
    -- self._bg_leftBG_BG_BOTTOM_powerNum = set:getLabelNode("bg_leftBG_BG_BOTTOM_powerNum")
    -- self._bg_leftBG_btnOperate = set:getClickNode("bg_leftBG_btnOperate")
    -- self._bg_leftBG_btnOperate_des = set:getLabelNode("bg_leftBG_btnOperate_des")
    -- self._bg_leftBG_benefit = set:getElfNode("bg_leftBG_benefit")
    -- self._bg_leftBG_benefit_union = set:getLabelNode("bg_leftBG_benefit_union")
    -- self._bg_leftBG_benefit_personal = set:getLabelNode("bg_leftBG_benefit_personal")
    -- self._bg_leftBG_continuous = set:getLabelNode("bg_leftBG_continuous")
    -- self._bg_leftBG_debuff = set:getLabelNode("bg_leftBG_debuff")

    self._bg_leftBG_BG_TOP_identify_icon:setResid('card_007.png')
    self._bg_leftBG_BG_TOP_identify_frame:setResid('N_ZB_biankuang2.png')
    self._bg_leftBG_BG_TOP_name:setString('公会名称')
    self._bg_leftBG_BG_TOP_power_number:setString('  '..tostring(1200))
    self._bg_leftBG_BG_TOP_leader_name:setString('  '..'会长名字')
    
    self._bg_leftBG_benefit_union:setString('公会资金+505451/天')
    self._bg_leftBG_benefit_personal:setString('个人贡献+505451/天')

    self._bg_leftBG_continuous:setString('连续守卫X次')
    self._bg_leftBG_debuff:setString('(守卫队伍攻击/防御下降为90%)')

    self._bg_leftBG_btnOperate:setListener(function()
        GleeCore:showLayer("DStationFormation")
    end)

    self._bg_leftBG_BG_BOTTOM_btnCancel:setListener(function()
        self:toast('撤回队伍！')
    end)

    math.randomseed(tostring(os.time()):reverse():sub(1, 6))  
    local randNum = tonumber(math.random(1000) % 2)
    if randNum == 0 then
        self._bg_leftBG_btnOperate:setVisible(true)
        self._bg_leftBG_BG_BOTTOM:setVisible(false)
    else
        self._bg_leftBG_btnOperate:setVisible(false)
        self._bg_leftBG_BG_BOTTOM:setVisible(true)

        self._bg_leftBG_BG_BOTTOM_identify_icon:setResid('card_006.png')
        self._bg_leftBG_BG_BOTTOM_identify_frame:setResid('N_ZB_biankuang2.png')
        self._bg_leftBG_BG_BOTTOM_belongTo:setString('编队1')
        --self._bg_leftBG_BG_BOTTOM_teamPower
        self._bg_leftBG_BG_BOTTOM_powerNum:setString('10000')
    end

    for i = 1, randNum + 5 do
        self:createCell()
    end
end

function DStationInfo:createCell()
    -- self._leader = set:getLinearLayoutNode("leader")
    -- self._leader_name = set:getLabelNode("leader_name")
    -- self._identify = set:getElfNode("identify")
    -- self._identify_icon = set:getElfNode("identify_icon")
    -- self._identify_frame = set:getElfNode("identify_frame")
    -- self._name = set:getLabelNode("name")
    -- self._power = set:getLinearLayoutNode("power")
    -- self._power_number = set:getLabelNode("power_number")

    local cellSet = self:createLuaSet('@cell')
    self._bg_rightBG_list:getContainer():addChild(cellSet[1])
    cellSet['identify_icon']:setResid('card_005.png')
    cellSet['identify_frame']:setResid('N_ZB_biankuang2.png')
    cellSet['name']:setString('敌对公会名称')
    cellSet['leader_name']:setString('sillyb会长')
    cellSet['power_number']:setString('101210')
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DStationInfo, "DStationInfo")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DStationInfo", DStationInfo)



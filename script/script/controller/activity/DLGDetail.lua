local Config = require "Config"

local DLGDetail = class(LuaDialog)
local Res = require "Res"
local AppData = require 'AppData'

function DLGDetail:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DLGDetail.cocos.zip")
    return self._factory:createDocument("DLGDetail.cocos")
end

--@@@@[[[[
function DLGDetail:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._bg = set:getJoint9Node("bg")
    self._bg_btnClose = set:getButtonNode("bg_btnClose")
    self._bg_title_text = set:getLabelNode("bg_title_text")
    self._bg_date_time = set:getLabelNode("bg_date_time")
    self._bg_list = set:getListNode("bg_list")
--    self._@content = set:getLabelNode("@content")
end
--@@@@]]]]

--------------------------------override functions----------------------
function DLGDetail:onInit( userData, netData )
    Res.doActionDialogShow(self._bg)
	self._bg_btnClose:setListener(function ( ... )
        Res.doActionDialogHide(self._bg, self)
    end)
    self._clickBg:setListener(function()
        Res.doActionDialogHide(self._bg, self)
    end)
    self:updateDialog(userData)
end

function DLGDetail:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DLGDetail:updateDialog(data)
    if data and data.dateTime then
        print(data.dateTime)
        self._bg_date_time:setString(data.dateTime)
    end
    if data and data.info then
        for k, v in pairs(data.info.Data) do
            local reslist = Res.getRewardsNRList(v)
            local str = string.format(Res.locString('DCharge7DayDetail$titleDays'), k)
            str = str..': '
            for k1, v1 in pairs(reslist) do
                --local str = string.format('面包*1，橙装宝箱*1，金币*10w')
                if k1 == 1 then
                    str = string.format('%s%s*%d', str, v1.name, v1.amount)
                else
                    str = string.format('%s，%s*%d', str, v1.name, v1.amount)
                end
            end
            local set = self:createLuaSet('@content')
            set[1]:setString(str)
            self._bg_list:getContainer():addChild(set[1])
        end
    end
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DLGDetail, "DLGDetail")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DLGDetail", DLGDetail)



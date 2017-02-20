local Config = require "Config"
local Res = require 'Res'
local AppData = require 'AppData'
local netModel = require 'netModel'
local Toolkit = require 'Toolkit'

local DGuildSetting = class(LuaDialog)

function DGuildSetting:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DGuildSetting.cocos.zip")
    return self._factory:createDocument("DGuildSetting.cocos")
end

--@@@@[[[[
function DGuildSetting:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_bg1 = set:getElfNode("root_bg1")
   self._root_bg1_title = set:getLabelNode("root_bg1_title")
   self._root_bg1_btnOk = set:getClickNode("root_bg1_btnOk")
   self._root_bg1_btnOk_title = set:getLabelNode("root_bg1_btnOk_title")
   self._root_bg1_btnCancel = set:getClickNode("root_bg1_btnCancel")
   self._root_bg1_btnCancel_title = set:getLabelNode("root_bg1_btnCancel_title")
   self._root_bg1_editbg = set:getElfNode("root_bg1_editbg")
   self._root_bg1_layout_item1 = set:getTabNode("root_bg1_layout_item1")
   self._root_bg1_layout_item1_title = set:getLabelNode("root_bg1_layout_item1_title")
   self._root_bg1_layout_item2 = set:getTabNode("root_bg1_layout_item2")
   self._root_bg1_layout_item2_title = set:getLabelNode("root_bg1_layout_item2_title")
   self._root_bg1_layout_item3 = set:getTabNode("root_bg1_layout_item3")
   self._root_bg1_layout_item3_title = set:getLabelNode("root_bg1_layout_item3_title")
   self._root_bg1_layout_item4 = set:getTabNode("root_bg1_layout_item4")
   self._root_bg1_layout_item4_title = set:getLabelNode("root_bg1_layout_item4_title")
   self._root_bg1_btn = set:getButtonNode("root_bg1_btn")
   self._root_bg1_icon = set:getElfNode("root_bg1_icon")
   self._root_bg1_icon_bg = set:getElfNode("root_bg1_icon_bg")
   self._root_bg1_icon_icon = set:getElfNode("root_bg1_icon_icon")
   self._root_bg1_icon_pz = set:getElfNode("root_bg1_icon_pz")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DGuildSetting:onInit( userData, netData )
	
  self._root_bg1_btnCancel:setListener(function ( ... )
    Res.doActionDialogHide(self._root, self)
  end)
  Res.doActionDialogShow(self._root)

  self:adjustEditBox()
  self:updateLayer()

  require 'LangAdapter'.LabelNodeAutoShrink(self._root_bg1_btnCancel_title,110)
  require 'LangAdapter'.LabelNodeAutoShrink(self._root_bg1_btnOk_title,110)
end

function DGuildSetting:onBack( userData, netData )
	
end

function DGuildSetting:close( ... )
  local userData = self:getUserData()
  return userData and userData.callback and userData.callback()
end
--------------------------------custom code-----------------------------

function DGuildSetting:updateLayer( ... )
  self._root_bg1_layout_item2_title:setString(Res.locString('Guild$lvlimit1'))
  self._root_bg1_layout_item3_title:setString(Res.locString('Guild$lvlimit2'))
  self._root_bg1_layout_item4_title:setString(Res.locString('Guild$lvlimit3'))

  local guildinfo = AppData.getGuildInfo().getData()

  local t = {
    [20] = self._root_bg1_layout_item2,
    [40] = self._root_bg1_layout_item3,
    [60] = self._root_bg1_layout_item4,
  }
  local tab = t[guildinfo.JoinLv]
  tab = tab or self._root_bg1_layout_item1
  tab:trigger(nil)
  self._root_bg1_layout_item1:setListener(function ( ... )
    self:newLimitLv(0)
  end)
  self._root_bg1_layout_item2:setListener(function ( ... )
    self:newLimitLv(20)
  end)
  self._root_bg1_layout_item3:setListener(function ( ... )
    self:newLimitLv(40)
  end)
  self._root_bg1_layout_item4:setListener(function ( ... )
    self:newLimitLv(60)
  end)

  require 'Toolkit'.setClubIcon(self._root_bg1_icon,guildinfo.Pic)
  self._root_bg1_btn:setListener(function ( ... )
    GleeCore:showLayer("DClubIconChoose",{Listener = function ( id )
      self:newPic(id)
      require 'Toolkit'.setClubIcon(self._root_bg1_icon,id)
    end})
  end)

  self._root_bg1_btnOk:setListener(function ( ... )
    self:saveSetting()  
  end)

  if self._inputText then
    if string.len(tostring(guildinfo.Des)) >= 0 then
      self._inputText:setString(tostring(guildinfo.Des),tostring(guildinfo.Des))  
    end
  end

end

function DGuildSetting:adjustEditBox( ... )

  local inputText = InputTextNode:create(Res.locString('Guild$Noticeph'), "FZY4JW--GB1-0", 20,0xc67015ff)
  inputText:setDimensions(CCSizeMake(300.0,70.0))
  inputText:setLimitNum(30)
  self._root_bg1_editbg:addChild(inputText)
  
  inputText:setFontFillColor(ccc3(198,112,21), true)
  inputText:setColorSpaceHolder(ccc3(255, 255, 255))
  -- inputText:setLimitNum(5)

  self._inputText = inputText
end

function DGuildSetting:newLimitLv( Lv )
  self._LimitLv = Lv
end

function DGuildSetting:newPic( pic )
  self._Pic = pic
end

function DGuildSetting:newNotice( text )
  if text then
    local len = string.utf8len(text)
    if len > 31 then
      self:toast(Res.locString('Guild$toast1'))
      return false
    end

    local ret,word = Toolkit.isLegal(text)
    if not ret then
      self:toast(tostring(Res.locString('Guild$toast2'))..word)
      return false
    end
  end
  self._Notice = text 
  return true
end

--net 
function DGuildSetting:saveSetting( ... )
  local guildinfo = AppData.getGuildInfo().getData()
  local notice = self._inputText:getString()
  if (notice == nil and guildinfo.Des and string.len(guildinfo.Des)) or notice ~= guildinfo.Des then
    if not self:newNotice(notice) then
      return
    end
  end

  if self._LimitLv or self._Pic or self._Notice then
    local Lv = self._LimitLv or guildinfo.JoinLv
    local Pic = self._Pic or guildinfo.Pic
    local Des = self._Notice or guildinfo.Des
    self:send(netModel.getModelGuildSave( guildinfo.Id,Lv,Pic,Des ),function ( data )
      AppData.getGuildInfo().setData(data.D.Guild)
      self:toast(Res.locString('Guild$toast3'))
      self._root_bg1_btnCancel:trigger(nil)
    end)
  else
    self._root_bg1_btnCancel:trigger(nil)
  end
end
--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DGuildSetting, "DGuildSetting")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DGuildSetting", DGuildSetting)

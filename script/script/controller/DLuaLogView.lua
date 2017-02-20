local Config = require "Config"
local LogHelper = require 'LogHelper'

local DLuaLogView = class(LuaDialog)

function DLuaLogView:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DLuaLogView.cocos.zip")
    return self._factory:createDocument("DLuaLogView.cocos")
end

--@@@@[[[[
function DLuaLogView:onInitXML()
    local set = self._set
   self._root = set:getElfNode("root")
   self._root_bg1 = set:getJoint9Node("root_bg1")
   self._root_bg1_list_container_content = set:getLabelNode("root_bg1_list_container_content")
   self._root_title = set:getLabelNode("root_title")
   self._root_btnfeedback = set:getClickNode("root_btnfeedback")
   self._root_btnfeedback_title = set:getLabelNode("root_btnfeedback_title")
   self._root_btnExit = set:getClickNode("root_btnExit")
   self._root_btnExit_title = set:getLabelNode("root_btnExit_title")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DLuaLogView:onInit( userData, netData )
  local constants = require 'framework.basic.Constants'
  self._index = constants.GUIDE_INDEX+1

  -- require 'Res'.doActionDialogShow(self._root)
  if userData and userData.custom then
    if userData.content then
      self._root_bg1_list_container_content:setString(userData.content)
    end
    
    if userData.leftbtn then
      self._root_btnExit_title:setString(userData.leftbtn)
      self._root_btnExit:setVisible(true)
      self._root_btnExit:setListener(function ( ... )
        return userData.leftcallback and userData.leftcallback()
      end)
    else
      self._root_btnExit:setVisible(false)
    end

    if userData.rightbtn then
      self._root_btnfeedback_title:setString(userData.rightbtn)
      self._root_btnfeedback:setVisible(true)
      self._root_btnfeedback:setListener(function ( ... )
        self:close()
      end)
    else
      self._root_btnfeedback:setVisible(false)
    end

  elseif userData and userData.NetCallRecord then
    if userData.content then
      self._root_bg1_list_container_content:setString(userData.content)
    end
    self._root_btnExit_title:setString('上传')
    self._root_btnfeedback_title:setString('取消')
    self._root_btnExit:setListener(function ( ... )
      LogHelper.uploadLog(userData.content,function ( ... )
        self:toast('上传成功！')
        LogHelper.clearRecords()
        LogHelper.saveLog()
        self:close()
      end)
    end)
    self._root_btnfeedback:setListener(function ( ... )
      self:close()
    end)
	elseif userData and type(userData) == 'table' then
    local msgs = table.concat( userData, "\n")
    self._root_bg1_list_container_content:setString(msgs)
    self._root_btnExit:setListener(function ( ... )
      os.exit(0)
    end)
    self._root_btnfeedback:setListener(function ( ... )
      LogHelper.uploadError(msgs,function ( ... )
        self:toast('反馈成功！')
        self._root_btnfeedback:setEnabled(false)
      end)
    end)
    self._root_btnExit_title:setString('关闭程序')
    self._root_btnfeedback_title:setString('反馈')
  end


end

function DLuaLogView:onBack( userData, netData )
	
end

function DLuaLogView:close( ... )
  local userData = self:getUserData()
  return userData.callback and userData.callback()
end
--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DLuaLogView, "DLuaLogView")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DLuaLogView", DLuaLogView)

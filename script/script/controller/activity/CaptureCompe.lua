local Config = require "Config"
local res = require "Res"
local dbManager = require "DBManager"
local equipFunc = require "EquipInfo"
local appData = require 'AppData'
local CaptureCompe = class(LuaDialog)
local TimeManager = require 'TimeManager'

function CaptureCompe:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."CaptureCompe.cocos.zip")
    return self._factory:createDocument("CaptureCompe.cocos")
end

--@@@@[[[[
function CaptureCompe:onInitXML()
    local set = self._set
   self._bg_bg1 = set:getElfNode("bg_bg1")
   self._bg_bg1_active = set:getElfNode("bg_bg1_active")
   self._bg_bg2 = set:getElfNode("bg_bg2")
   self._bg_bg2_bg = set:getElfNode("bg_bg2_bg")
   self._bg_bg2_des1 = set:getLabelNode("bg_bg2_des1")
   self._bg_bg2_linear_elf_des2 = set:getLabelNode("bg_bg2_linear_elf_des2")
   self._bg_bg2_linear_des3 = set:getLabelNode("bg_bg2_linear_des3")
   self._bg_bg2_datetime = set:getLabelNode("bg_bg2_datetime")
--   self._@view = set:getElfNode("@view")
end
--@@@@]]]]

--------------------------------override functions----------------------
--[[
function CaptureCompe:onInit( userData, netData )
	
end

function CaptureCompe:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(CaptureCompe, "CaptureCompe")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("CaptureCompe", CaptureCompe)
]]

local PNames = 
{
  [1]=res.locString('PetCC$_Prop1'),
  [2]=res.locString('PetCC$_Prop2'),
  [3]=res.locString('PetCC$_Prop3'),
  [4]=res.locString('PetCC$_Prop4'),
  [5]=res.locString('PetCC$_Prop5'),
  [6]=res.locString('PetCC$_Prop6'),
  [7]=res.locString('PetCC$_Prop7'),
  [8]=res.locString('PetCC$_Prop8'),
  [9]=res.locString('PetCC$_Prop9'),
}

local getTime = function ( datetime )
  local item0 = res.Split(datetime,' ')
  local item1 = res.Split(item0[1],'-')
  local item2 = res.Split(item0[2],':')

  return string.format('%d:%s',tonumber(item2[1])+8,item2[2])
end

local isOpen = function (from,to)
  
  return TimeManager.currtimeIn(from,to)

end

local update
update = function ( self,view )
  
  local compe = appData.getActivityInfo().getOther('Compe')
  if compe then
    local content
    local from
    local to
    
    for i,v in ipairs(compe.Props) do
      if i == 1 then
        content = PNames[v]
      else
        content = string.format('%s、%s',PNames[v],content)
      end
    end

    from=getTime(compe.From)
    to=getTime(compe.To)

    view['bg_bg2_des1']:setString(string.format(res.locString('PetCC$_Content'),content))
    view['bg_bg2_linear_des3']:setString(string.format('%d%%!!',compe.Rate*100))
    view['bg_bg2_datetime']:setString(string.format('%s %s-%s',res.locString('PetCC$_OpenTime'),from,to))
    view['bg_bg1_active']:setVisible(isOpen(compe.From,compe.To))

  end

end

return {update = update}

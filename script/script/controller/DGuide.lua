local Config = require "Config"
local AppData = require 'AppData'
local Res = require 'Res'
local DBManager = require 'DBManager'
local PointManager = require 'PointManager'
local netModel = require 'netModel'
local GuideHelper = require 'GuideHelper'

local DGuide = class(LuaDialog)

function DGuide:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DGuide.cocos.zip")
    return self._factory:createDocument("DGuide.cocos")
end

--@@@@[[[[
function DGuide:onInitXML()
	local set = self._set
    self._root = set:getElfNode("root")
    self._shield = set:getShieldNode("shield")
    self._bg = set:getElfNode("bg")
    self._bg_btn = set:getButtonNode("bg_btn")
    self._bg_role = set:getElfNode("bg_role")
    self._bg_bg = set:getElfNode("bg_bg")
    self._bg_name = set:getLabelNode("bg_name")
    self._bg_content = set:getRichLabelNode("bg_content")
    self._bg_n = set:getElfNode("bg_n")
    self._bg = set:getElfNode("bg")
    self._bg_input = set:getInputTextNode("bg_input")
    self._bg_random = set:getClickNode("bg_random")
    self._bg_btnConfrim = set:getClickNode("bg_btnConfrim")
    self._bg_btnConfrim_title = set:getLabelNode("bg_btnConfrim_title")
    self._shield = set:getShieldNode("shield")
    self._shader = set:getElfNode("shader")
    self._shader_sb_circle = set:getElfNode("shader_sb_circle")
    self._shader_rect = set:getRectangleNode("shader_rect")
    self._effect = set:getElfNode("effect")
    self._effect_shield = set:getShieldNode("effect_shield")
    self._effect_YD_zhezhao1 = set:getElfNode("effect_YD_zhezhao1")
    self._effect_YD_zhezhao2 = set:getElfNode("effect_YD_zhezhao2")
    self._effect_YD_jiantou = set:getElfNode("effect_YD_jiantou")
    self._effect_btn = set:getButtonNode("effect_btn")
    self._shield = set:getShieldNode("shield")
    self._shader = set:getElfNode("shader")
    self._shader_sb_circle = set:getElfNode("shader_sb_circle")
    self._shader_rect = set:getRectangleNode("shader_rect")
    self._effect = set:getElfNode("effect")
    self._effect_YD_zhezhao1 = set:getElfNode("effect_YD_zhezhao1")
    self._effect_YD_zhezhao2 = set:getElfNode("effect_YD_zhezhao2")
    self._effect_YD_jiantou = set:getElfNode("effect_YD_jiantou")
    self._effect_btn = set:getButtonNode("effect_btn")
    self._Jump = set:getElfAction("Jump")
--    self._@Dialogue = set:getElfNode("@Dialogue")
--    self._@InputName = set:getElfNode("@InputName")
--    self._@ClickPoint = set:getElfNode("@ClickPoint")
--    self._@shield = set:getShieldNode("@shield")
--    self._@ClickPoint1 = set:getElfNode("@ClickPoint1")
end
--@@@@]]]]

--------------------------------override functions----------------------

function DGuide:onInit( userData, netData )
  local constants = require 'framework.basic.Constants'
  self._index = constants.GUIDE_INDEX
	self:initDTypes()

  self._offPetName = require 'AccountHelper'.isItemOFF('PetName')
  self._offCIDs = {[10]=true,[51]=true,[53]=true}
  
  if userData and userData.CID then
    local stepData = {Dtype=1,Dialogue=DBManager.getDialogue(userData.CID),callback=userData.callback,initcall=userData.initcall}
    self:updateLayer(stepData)
  end
  
end

function DGuide:getShieldBelow( )
  return false
end

function DGuide:getType()
  return 'guideLayer'
end

function DGuide:onBack( userData, netData )
	
end

function DGuide:close( ... )

  if self._layerlist then
    for k,v in pairs(self._layerlist) do
      if k ~= name then
        v[1]:release()
      end
    end
  end

end
--------------------------------custom code-----------------------------

function DGuide:updateLayer( stepData )
  if stepData == nil or stepData.Dtype == nil then
    return
  end

  local dfunc = self.Dtypes[stepData.Dtype]
  if dfunc then
    dfunc(self,stepData)
  else
    print('can not found DType:'..stepData.Dtype)
  end

end

function DGuide:initDTypes( ... )

  if self.Dtypes == nil then
    self.Dtypes = {
      [1] = self.Dialogue,
      [2] = self.InputName,
      [5] = self.ClickPoint,
      [4] = self.shield,
      [3] = self.ClickPoint1,
    }
  end

  self._layerlist = {}

end

function DGuide:Dialogue( stepData )
  if self:isDialogueIgnore(stepData) then
    return
  end

  local exit = self:isLayerExist('@Dialogue')
  local set = self:getLayerAndCleanOther('@Dialogue')
  local Dialogue = stepData.Dialogue
  local callback = stepData.callback
  if Dialogue then
    local PetID = (Dialogue.PetID == -1 and AppData.getUserInfo().getLeaderPetID()) or Dialogue.PetID
    local name = (PetID == 0 and Res.locString('Guide$Name1')) 
    if PetID ~= 0 then
      local dbpet = DBManager.getCharactor(PetID)
      name = dbpet.name
    end
    
    local ccfg = DBManager.getGuideRoleCfg(string.format('%03d',PetID))
    if ccfg then
      local pos = ccp(ccfg.x-568,320-ccfg.y)
      set['bg_role']:setPosition(pos)
      set['bg_role']:setScaleX(ccfg.scale)
      set['bg_role']:setScaleY(math.abs(ccfg.scale))
    end
    set['bg_role']:setResid(Res.getPetWithPetId(PetID))
    set['bg_name']:setString(tostring(name))
    set['bg_content']:setString(tostring(Dialogue.Content))

    require 'LangAdapter'.selectLangkv({Arabic=function ( ... )
      set['bg_content']:setDimensions(CCSizeMake(700,0))
      require 'LangAdapter'.LabelNodeAutoShrink(set['bg_content'],nil,100)
      set['bg_content']:setFontSize(25)
    end})
    
  end
  
  set['bg_n']:runElfAction(self._Jump:clone())
  set['bg_btn']:setEnabled(true)
  set['bg_btn']:setListener(function ( ... )
    if callback then
      set['bg_btn']:setEnabled(false)
      self:runWithDelay(callback,0.1)      
    end  
  end)

  if not exit or stepData.FadeIn then
    local du = stepData.FadeIn or 0.5
    set['bg']:setColorf(1,1,1,0)
    set['bg_btn']:setVisible(false)
    local actions = CCArray:create()
    actions:addObject(CCFadeIn:create(du))
    actions:addObject(CCCallFunc:create(function ( ... )
      self:playsound(Dialogue and Dialogue.Sound)
      set['bg_btn']:setVisible(true)
      if stepData and stepData.initcall then
        stepData.initcall()
      end
    end))
    set['bg']:runElfAction(CCSequence:create(actions))
  else
    self:playsound(Dialogue and Dialogue.Sound)
  end

  require 'LangAdapter'.LabelNodeAutoShrink(set['bg_btnConfrim_title'],120)
  
end

function DGuide:playsound( filename )
  if filename and filename ~= 0 then
    print('DGuide:playsound'..filename)
    require 'framework.helper.MusicHelper'.stopAllEffects()
    require 'framework.helper.MusicHelper'.playEffect(string.format('raw/guide/%s',filename))
  end
end


function DGuide:getUtf8StringSub(str,sublen)
    local len  = #str
    local left = len
    local cnt  = 0
    local arr  = {0, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc}
    while left ~= 0 do
        local tmp = string.byte(str, -left)
        local i   = #arr
        while arr[i] do
            if tmp >= arr[i] then
                left = left - i
                break
            end
            i = i - 1
        end
        cnt = cnt + 1
        if cnt == sublen then
          return string.sub(str,1,len-left)
        end
    end
    return str
end

function DGuide:isInvalid( str )
  local ret = string.gsub(str,'^[a-zA-Z0-9_\128-\254]+','')
  return string.len(ret) == 0
end

function DGuide:InputName( ... )
  local set = self:getLayerAndCleanOther('@InputName')  
  local inputnode = set['bg_input']
  local UserName = require 'UserName'
  inputnode:setText(UserName.randomName())
  inputnode:setKeyBoardListener(function ( event )
    
    if event == -2 then
      local text = inputnode:getText()
      if string.len(text) == 0 then
        set['bg_btnConfrim']:setEnabled(false)
      else
        set['bg_btnConfrim']:setEnabled(true)
        -- if string.utf8len(text) > 7 then
        --   local substring = self:getUtf8StringSub(text,7)
        --   inputnode:setText(substring)
        -- end

        -- if self:isInvalid(inputnode:getText()) then
        --   set['bg_btnConfrim']:setEnabled(true)
        -- else
        --   set['bg_btnConfrim']:setEnabled(false)
        --   self:toast('请使用中文、英文或数字进行命名！')
        -- end
      end
    end
  end)
  -- inputnode:setMaxLength(7)

  set['bg_random']:setListener(function ( ... )  
    inputnode:setText(UserName.randomName())  
    set['bg_btnConfrim']:setEnabled(true)
  end)
  set['bg_btnConfrim']:setListener(function ( ... )
    local text = inputnode:getText()
    if text == nil or string.len(text) == 0 then
      self:toast(Res.locString('PetDetail$NAMENOTEMPTY'))
      return
    end

    self:send(netModel.getRoleRename(text),function ( data )
      if data.D and data.D.Role then
        local userinfo = AppData.getUserInfo()
        userinfo.setName(data.D.Role.Name)
        require 'AccountHelper'.sendPlayerName()
        GuideHelper:check('NameOK')
        require "AndroidUtil".sendRoleCreateInfo(data.D.Role.Name)
        require 'BIHelper'.scribeLog('创建角色')
      end
    end)

  end)

  require 'LangAdapter'.selectLang(nil,nil,function ( ... )
    set['bg_random']:setVisible(false)
    inputnode:setText('')
  end)
end

function DGuide:ClickPoint( stepData )
  local set = self:getLayerAndCleanOther('@ClickPoint')
  set['effect_YD_jiantou']:runElfAction(self._Jump:clone())

  local delayfunc = function ( ... )
    print('delayfunc...')
    local point = stepData.point or 'nil'
    if type(point) == 'string' then
      local pinfo = PointManager:getPointInNode(point,self._root)
      if pinfo == nil then
        set[1]:setVisible(false)
        self:guideErrorStop(stepData,'没有找到与'..point..'相关的坐标！')
        return
      end
      point = {pinfo.pinn.x,pinfo.pinn.y}      

      -- local size = pinfo.psize
      -- if (not size) or (size.width == 50 and size.height == 50) then
      --   size = {width=110,height=110}
      -- end
      -- print(string.format('TouchBound:%d,%d',size.width,size.height))
      -- local x = size.width/2
      -- local y = size.height/2
      -- set['effect_shield']:addTouchBoundPoint(-x,-y)
      -- set['effect_shield']:addTouchBoundPoint(x,-y)
      -- set['effect_shield']:addTouchBoundPoint(-x,y)
      -- set['effect_shield']:addTouchBoundPoint(x,y)
    end
    
    if stepData.offset then
      point[1] = point[1] + stepData.offset[1]
      point[2] = point[2] + stepData.offset[2]
    end
    
  
    point = ccp(point[1],point[2])
    set['shader_sb_circle']:setPosition(point)
    set['effect']:setPosition(point)
    self:jiantouAdjust(set['effect_YD_jiantou'],point)
    
  end
  
  set['shield']:setVisible(true)
  set['shader_sb_circle']:setVisible(false)
  set['effect']:setVisible(false)

  self:runWithDelay(function ( ... )
    delayfunc()
    set['shader_sb_circle']:setVisible(true)
    set['effect']:setVisible(true)
    set['shield']:setVisible(false)
  end,0.2,set[1])

  set['effect_btn']:setListener(function ( ... )  
    print('effect_btn')
    set['shield']:setVisible(true)
    self:runWithDelay(function ( ... )
      set['shield']:setVisible(false)
    end,0.5,set[1])
  end)

end

function DGuide:ClickPoint1( stepData )
  local set = self:getLayerAndCleanOther('@ClickPoint1')
  set['effect_YD_jiantou']:runElfAction(self._Jump:clone())

  local node
  local delayfunc = function ( ... )
    print('delayfunc...')
    local point = stepData.point or 'nil'
    if type(point) == 'string' then
      local pinfo = PointManager:getPointInNode(point,self._root)
      if pinfo == nil then
        set[1]:setVisible(false)
        self:guideErrorStop(stepData,'没有找到与'..point..'相关的坐标！')
        return
      end
      node = pinfo.node
      point = {pinfo.pinn.x,pinfo.pinn.y}          
      if not node or not node.trigger then
        self:ClickPoint(stepData)
        return
      end
    end
    
    point = ccp(point[1],point[2])
    set['shader_sb_circle']:setPosition(point)
    set['effect']:setPosition(point)
    self:jiantouAdjust(set['effect_YD_jiantou'],point)
  end

  set['shader_sb_circle']:setVisible(false)
  set['effect']:setVisible(false)
  local enable = true
  set['effect_btn']:setListener(function ( ... )
    set['shader_sb_circle']:setVisible(false)
    set['effect']:setVisible(false)
    self:runWithDelay(function ( ... )
      enable = true  
      set['shader_sb_circle']:setVisible(true)
      set['effect']:setVisible(true)
    end,3,set[1])

    if node and enable then
      local pinfo = PointManager:getPointInNode(stepData.point,self._root)
      local point = stepData.point
      if pinfo == nil then
        set[1]:setVisible(false)
        self:guideErrorStop(stepData,'没有找到与'..point..'相关的坐标！')
        return
      end
      node = pinfo.node
      if node and ( (node.isEnabled and not node:isEnabled()) or not node:isVisible()) then
        set[1]:setVisible(false)
        self:guideErrorStop(stepData,'按钮失效'..point)
      end
      node:trigger(nil)
    end
    enable = false

    if stepData and stepData.Action == nil then
      return stepData.callback and stepData.callback()
    end
  end)

  self:runWithDelay(function ( ... )
    delayfunc()
    set['shader_sb_circle']:setVisible(true)
    set['effect']:setVisible(true)
  end,0.2,set[1])
end

function DGuide:jiantouAdjust( node,point )

  local wsize = CCDirector:sharedDirector():getWinSize()
  local csize = CCSizeMake(200,200)--(326,326)
  local lx = -wsize.width/2   + csize.width/2
  local rx = wsize.width/2    - csize.width/2
  local ty = wsize.height/2   - csize.height/2
  local by = -wsize.height/2  + csize.height/2

  -- print(string.format('lx:%d rx:%d ty:%d by:%d',lx,rx,ty,by))
  print(string.format('point:(%d,%d)',point.x,point.y))
  --[[
              roate   jx  jy   x, y
    top       0       0   10
    bottom    180     0   -10
    left      -90     -10 0
    right     90      10  0
    
    TR        45      5  5
    TL        -45     -5  5
    BL        -135    -5 -5
    BR        135     -5  5 
  ]]

  --jiantou 相对中心点所在位置
  local T = {
    AAAA={0,0,10,0,112},
    AAAB={0,0,10,0,112},
    BAAA={90,10,0,112,0},--right
    ABAA={-90,-10,0,-112,0},--left
    AABA={180,0,-10,0,-112},--bottom
    BABA={135,-5,5,84,-84},--BR
    BAAB={45,5,5,84,84},--TR
    ABAB={-45,5,-5,-84,84},--TL
    ABBA={-135,-5,-5,-84,-84},--BL
  }
  --屏幕内的条件
  local lxa = point.x > lx and 'A' or 'B'
  local rxa = point.x < rx and 'A' or 'B'
  local tya = point.y < ty and 'A' or 'B'
  local bya = point.y > by and 'A' or 'B'
  local key = string.format('%s%s%s%s',lxa,rxa,tya,bya)

  local cfg = T[key]
  if cfg then
    node:setPosition(ccp(cfg[4],cfg[5]))
    node:setRotation(cfg[1])
    node:stopAllActions()
    local actions = CCArray:create()
    actions:addObject(CCMoveBy:create(0.3,ccp(cfg[2],cfg[3])))
    actions:addObject(CCMoveBy:create(0.3,ccp(-cfg[2],-cfg[3])))
    local repeataction = CCRepeatForever:create(CCSequence:create(actions))
    node:runElfAction(repeataction)
  else
    print('can not found the cfg:'..key)
  end

end

function DGuide:shield( stepData )
  local set = self:getLayerAndCleanOther('@shield')
  if stepData and stepData.dealy then
    local callback = stepData.callback
    self:runWithDelay(function ( ... )
      if callback then
        callback()
      end
    end,tonumber(stepData.dealy),set[1])
  end
end
--
function DGuide:cleanOther( name )
  assert(name)
  
  local set = nil
  for k,v in pairs(self._layerlist) do
    if k ~= name then
      print('remove:'..name)
      v[1]:setVisible(false)
      v[1]:removeAllChildrenWithCleanup(true)
      v[1]:release()
    else
      set = v
    end
  end

  self._layerlist={}
  self._layerlist[name]=set

  self._root:removeAllChildrenWithCleanup(true)
end

function DGuide:getLayerWithName( name )
  assert(name)

  local set = self._layerlist[name]
  if set == nil then
    set = self:createLuaSet(name)
    if set then
      layer = set[1]
      layer:retain()
    end
  end

  if layer then
    layer:setVisible(true)
    self._root:addChild(layer)
    self._layerlist[name]=set
    self._root:visit()
  end

  return set
end

function DGuide:getLayerAndCleanOther( name )
  assert(name)

  self:cleanOther(name)

  return self:getLayerWithName(name)
end

function DGuide:isLayerExist( name )
  assert(name)

  return self._layerlist and self._layerlist[name]
end

function DGuide:guideErrorStop(stepData, msg )
  -- self:toast(tostring(msg))
  local callback = stepData.callback
  return callback and callback('error')  
end

function DGuide:isDialogueIgnore( stepData )
  if self._offPetName and self._offCIDs and self._offCIDs[stepData.CID] then
    local callback = stepData.callback
    if callback then
      self:runWithDelay(function ( ... )
        callback()
      end)
    end
    return true
  end
  return false
end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DGuide, "DGuide")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DGuide", DGuide)

local UIHelper = {}
--@@@@[[[[
function UIHelper:onInitXML()
    local set = self._set
    self._KeyStorage_bg_Position = set:getElfNode("KeyStorage_bg_Position")
    self._KeyStorage_bg_Color = set:getElfNode("KeyStorage_bg_Color")
    self._KeyStorage_bg_Scale = set:getElfNode("KeyStorage_bg_Scale")
    self._bg = set:getJoint9Node("bg")
--    self._@toast = set:getElfMotionNode("@toast")
end
--@@@@]]]]
--no used above
--------------------------------override functions----------------------
local config = require 'Config'
local utils = require 'framework.helper.Utils'

local factory = XMLFactory:getInstance()
factory:setZipFilePath(config.COCOS_ZIP_DIR.."UIHelper.cocos.zip")
local document = factory:createDocument("UIHelper.cocos")
document:retain()

local WinSize = CCDirector:sharedDirector():getWinSize()

local runing = false
local msgs = {}
local push
local pop

local kTagToast = 9999
local toastLayer

local function getToastLayer()
    -- body
    if not toastLayer then
        toastLayer = ElfLayer:create()
        CCDirector:sharedDirector():getRunningScene():addChild(toastLayer,9999,kTagToast)
    end

    return toastLayer
end

local function createToast( msg )
      local element = factory:findElementByName(document, '@toast')
      assert(element) 

      local cset = factory:createWithElement(element)
      local luaset = utils.toluaSet(cset)
      luaset['#label']:setString(msg)
      local size = luaset['#label']:getContentSize()
      if size.height > 88 then
        luaset['bg']:setContentSize(CCSizeMake(size.width+10,size.height+10))
      end
      return luaset[1]
end

local function hidden( ... )
      -- local node = CCDirector:sharedDirector():getRunningScene()
      local node = getToastLayer()
      local toastNode = node:getChildByTag(kTagToast)
      if toastNode then
            toastNode:removeFromParentAndCleanup(true)
      end
end

local function toast2( msg )
      hidden()
      local toastNode = createToast(msg)

      toastNode:runAnimate( toastNode:getLoopStart(), toastNode:getLoopEnd() )
      toastNode:setListener(function (  )
            toastNode:removeFromParent()
      end)

      getToastLayer():addChild(toastNode,9999,kTagToast)
end

local function toast( ccnode, msg )
    push(ccnode,msg)
end

local function show( ccnode,msg )

  runing = true

  local toastNode = createToast(msg)

    toastNode:runAnimate( toastNode:getLoopStart(), toastNode:getLoopEnd() )
    toastNode:setListener(function (  )
      if ccnode then
        ccnode:release()
      end
      toastNode:removeFromParent()
      pop()
    end)
    ccnode:addChild(toastNode,9999,kTagToast)
    NodeHelper:setPositionInScreen(toastNode, ccp(WinSize.width/2, WinSize.height/2))
end

pop = function ( )

  if #msgs > 0 then

    local item = msgs[#msgs]
    show(item.node,item.msg)
    table.remove(msgs,#msgs)
  else
    runing = false
  end

end

push = function ( ccnode,msg )
  
  if ccnode then
    ccnode:retain()
  end

  local item = {node=ccnode,msg=msg}
  table.insert(msgs,item)

  if not runing then
    pop()
  end

end

return { toast = toast,hidden = hidden,toast2 = toast2 }



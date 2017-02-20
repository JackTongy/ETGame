--[[
    战斗场景层级

]]
local layerManager = {}

local GridManager = require 'GridManager'
--[[
初始化游戏中的各个层级
bglayer   背景地面层
bgSkillLayer      背景特效层
roleLayer      角色层
skySkillLayer  天空特效层
specailLayer   特写层
uiLayer      ui层
]]
-- function layerManager.initLayer(bglayer,bgSkillLayer,roleLayer,skySkillLayer,specailLayer,uiLayer,fightTextlayer)
--    layerManager.bgLayer=bglayer
--    layerManager.bgSkillLayer=bgSkillLayer
--    layerManager.roleLayer=roleLayer
--    layerManager.skySkillLayer=skySkillLayer
--    layerManager.specailLayer=specailLayer
--    layerManager.uiLayer = uiLayer

-- end

function layerManager.initLayer( obj, luaset )
   -- body
   layerManager.bgLayer          = obj.bgLayer
   layerManager.bgSkillLayer     = obj.bgSkillLayer
   layerManager.roleLayer        = obj.roleLayer
   layerManager.skyLayer         = obj.skyLayer
   layerManager.specialLayer     = obj.specialLayer
   layerManager.uiLayer          = obj.uiLayer
   layerManager.fightTextLayer   = obj.fightTextLayer
   layerManager.touchLayer       = obj.touchLayer
   layerManager.touchLayerAbove  = obj.touchLayerAbove
   layerManager.topLayer         = obj.topLayer

   layerManager._luaset = luaset

   print('layerManager.initLayer scale='..GridManager.getScaleX())
end

function layerManager.reset()
   -- body
   layerManager.bgLayer = nil
   layerManager.bgSkillLayer = nil

   layerManager.roleLayer = nil

   layerManager.skyLayer = nil
   layerManager.specialLayer = nil
   layerManager.uiLayer = nil
   layerManager.fightTextLayer = nil
   layerManager.touchLayer = nil
   layerManager.touchLayerAbove = nil

   layerManager._luaset = nil
end

--进行水平翻转
function layerManager.setFlipX( scaleX )
   local finalScaleX = scaleX * GridManager.getScaleX();
   print('layerManager.setFlipX='..finalScaleX)


   -- layerManager.bgSkillLayer:setScaleX(finalScaleX)
   -- layerManager.specialLayer:setScaleX(finalScaleX)
   -- layerManager.skySkillLayer:setScaleX(finalScaleX)
   if layerManager.roleLayer then
      layerManager.touchLayer:setScaleX(math.abs(finalScaleX))
      layerManager.roleLayer:setScaleX(finalScaleX)
      layerManager.skyLayer:setScaleX(finalScaleX)
   end
   -- layerManager.touchLayer:setScaleX(scaleX)
   -- layerManager.touchLayerAbove:setScaleX(scaleX)
end

--作用于全屏
local rate = 1.5
local Earth_Shake_Action_Data = {
   [1] = { f = 1, p = {0, 0} },
   [2] = { f = 2,   p = {-4.00*rate, -4*rate} },
   [3] = { f = 3,   p = {-14*rate, -14*rate} },
   [4] = { f = 4,   p = {-4.00*rate, 6*rate} },
   [5] = { f = 5,   p = {4*rate, -4*rate} },
   [6] = { f = 6,   p = {0, 0} },
}

local sRate = 0.5
local Slight_Earth_Shake_Action_Data = {
   [1] = { f = 1,   p = {0, 0} },
   [2] = { f = 2,   p = {  -4.00*sRate, -4*sRate} },
   [3] = { f = 3,   p = {  -8*sRate,  -8*sRate} },
   [4] = { f = 4,   p = {  -4.00*sRate, 6*sRate} },
   [5] = { f = 5,   p = {  4*sRate,    -4*sRate} },
   [6] = { f = 6,   p = {0, 0} },
}

function createQuakeAction()
   -- body
   local action = require 'framework.swf.SwfActionFactory'.createAction(Earth_Shake_Action_Data,nil,nil, 15)
   return action
end

function layerManager.playEarthQuake()
   -- body
   if layerManager._luaset and not tolua.isnull(layerManager._luaset[1]) then

      local action = require 'framework.swf.SwfActionFactory'.createAction(Earth_Shake_Action_Data,nil,nil, 15)
      -- local action2 = action:clone()
      -- layerManager._luaset['layer']:runAction(action)
      -- layerManager._luaset['uiLayer']:runAction(action2)

      local scene = CCDirector:sharedDirector():getRunningScene()
      assert(scene)

      scene:runAction(action)

   end

end

function layerManager.playSlightEarthQuake()
   -- body
   if layerManager._luaset and not tolua.isnull(layerManager._luaset[1]) then

      local action = require 'framework.swf.SwfActionFactory'.createAction(Slight_Earth_Shake_Action_Data,nil,nil, 15)
      -- local action2 = action:clone()
      -- layerManager._luaset['layer']:runAction(action)
      -- layerManager._luaset['uiLayer']:runAction(action2)

      local scene = CCDirector:sharedDirector():getRunningScene()
      assert(scene)

      scene:runAction(action)

   end

end

return layerManager








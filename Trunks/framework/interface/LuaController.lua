require 'framework.interface.LuaInterface'
--require "Net"

local luaLayerManager = require 'framework.interface.LuaLayerManager'

LuaController = class(LuaInterface)

function LuaController:ctor()
    self._state = -1 --born
end

function LuaController:setLayer( layer )
    self._layer = layer
    local target = self:getTarget()
    if target then
        target:setLayer(layer)
    else
        target = self:createTarget()
        target:setLayer(layer)
    end
end

function LuaController:createTarget()
    
    assert(self:getTarget() == nil , "LuaController already has a target!")

    local target = GleeController:create()
    target:setControllerName(self:getName())
    self:setTarget(target)

    target:registerScriptHandler(function( state, enable )
        self:onState(state, enable)
    end)

    return target
end

function LuaController:retainMembers()
    -- body
    self._document:retain()
    self._set:retain()
    self._controller:retain()
end

function LuaController:releaseMembers()
    -- body
    if self._document then
        self._document:release()
        self._document = nil
    end

    if self._set then
        self._set:release()
        self._set = nil
    end

    if self._controller then
        self._controller:release()
        self._controller = nil
    end

    self:unregisterEvents()

    
    local size = collectgarbage('count')
    if tonumber(size) > 9000 then
        collectgarbage('collect')
    end
    -- print('after luaCtrl releaseMembers, memory size = '..size)
    -- GleeToast:showMsg(tostring(size/1024.0))
end

function LuaController:releaseLayer()
    -- body
    if self._document then
        self._document:release()
        self._document = nil
    end

    if self._set then
        self._set:release()
        self._set = nil
    end

end

function LuaController:revertLayer()
    self:loadXML()    
end

function LuaController:setTarget(target)
    self._controller = target
end

function LuaController:getTarget()
    -- body
    return self._controller
end

---------------------------State Delegate C++---------------------------
function LuaController:addStateListener( listener )
    -- body
    local listCreator = require "framework.basic.List"
    if not self._stateListenerList then
        self._stateListenerList = listCreator('new')
    end

    self._stateListenerList('add', listener)
end

function LuaController:removeStateListener( listener )
    -- body
    assert(self._stateListenerList ~= nil, "LuaController:removeStateListener->_stateListenerList should not be nil! ")

    self._stateListenerList('remove', listener)
end

function LuaController:removeAllStateListeners()
    -- body
    if self._stateListenerList then
        self._stateListenerList('clear')
    end
end


--[[
1.func的执行当前仅当
(1)网络返回 
(2)已经过netCallbackTimeThreshold延迟后
2.NetView的显示当且仅当
(1)过场动画后
(2)func执行前
--]]

function LuaController:callNetLazy( netModel, func, netCallbackTimeThreshold)
    -- body
    assert(netModel ~= nil)

    -- tOnInit = 1,
    -- tOnEnter,
    -- tOnInTransitionStart,
    -- tOnInTransitionEnd,
    -- tOnBack,
    -- tOnLeave,
    -- tOnOutTransitionStart,
    -- tOnOutTransitionEnd,
    -- tOnRelease,
    -- tDidReceiveMemoryWarning,
    -- tIsKeepAlive,
    -- tSetEnabled
    --self:setEnabled(false)
    
    -- local beforeStates = {[tOnInit]=true, [tOnEnter]=true, [tOnInTransitionStart]=true}
    local beforeStates = {[tOnInit]=true, [tOnEnter]=true, [tOnInTransitionStart]=true, [tOnBack] = true}

    if beforeStates[self._state] then

        local shouldHideNetViewAfterNetCallback = false
        local shouldShowNetViewAfterTransition = true

        local onInTransitionEndDid

        local callbaclArgs

        local listener
        listener = function(state)
            if state == tOnInTransitionEnd then
                if shouldShowNetViewAfterTransition then
                    print("tOnInTransitionEnd...")
                    self:showNetView()
                    shouldHideNetViewAfterNetCallback = true
                end
                
                onInTransitionEndDid = true

                if callbaclArgs then
                    print('net callbacked just trigger it on tOnInTransitionEnd')
                    func(callbaclArgs.datatable,callbaclArgs.tag,callbaclArgs.code,callbaclArgs.errorBuf)
                end

                self:removeStateListener(listener)
            end
        end

        self:addStateListener(listener)


        netCallbackTimeThreshold = netCallbackTimeThreshold or 0
        local netCallbackTimeThresholdReached
        local callNetDataStore

        --重新封装callnet
        local function innerCallback(datatable, tag, code, errorBuf)
            -- body
            if onInTransitionEndDid then
                print('onInTransitionEndDid, just callback ')
                func(datatable, tag, code, errorBuf)
            else
                callbaclArgs = callbaclArgs or {}
                callbaclArgs.datatable = datatable
                callbaclArgs.tag = tag
                callbaclArgs.code = code
                callbaclArgs.errorBuf = errorBuf
            end

            shouldShowNetViewAfterTransition = false
            if shouldHideNetViewAfterNetCallback then
                self:hideNetView()
            end
        end

        local function handleTime()
            -- body
            netCallbackTimeThresholdReached = true

            if netCallbackTimeThresholdReached and callNetDataStore then
                innerCallback(callNetDataStore.datatable, callNetDataStore.tag, callNetDataStore.code, callNetDataStore.errorBuf)
            end
        end

        local function handleNet( datatable, tag, code, errorBuf )
            -- body
            callNetDataStore = callNetDataStore or {}
            callNetDataStore.datatable = datatable
            callNetDataStore.tag = tag
            callNetDataStore.code = code
            callNetDataStore.errorBuf = errorBuf

            if netCallbackTimeThresholdReached and callNetDataStore then
                innerCallback(callNetDataStore.datatable, callNetDataStore.tag, callNetDataStore.code, callNetDataStore.errorBuf)
            end
        end

        self:runWithDelay(handleTime, netCallbackTimeThreshold)

        netModel:callNet(handleNet)
    else
        self:showNetView()

        netModel:callNet(func, function()
            self:hideNetView()
        end)
    end
end

function LuaController:callNet( netModel, func )
    -- body
    assert(netModel ~= nil)

    -- tOnInit = 1,
    -- tOnEnter,
    -- tOnInTransitionStart,
    -- tOnInTransitionEnd,
    -- tOnBack,
    -- tOnLeave,
    -- tOnOutTransitionStart,
    -- tOnOutTransitionEnd,
    -- tOnRelease,
    -- tDidReceiveMemoryWarning,
    -- tIsKeepAlive,
    -- tSetEnabled
    --self:setEnabled(false)

    local beforeStates = {[tOnInit]=true, [tOnEnter]=true, [tOnInTransitionStart]=true}

    if beforeStates[self._state] then

        local shouldHideNetViewAfterNetCallback = false
        local shouldShowNetViewAfterTransition = true

        local listener
        listener = function(state)
            if state == tOnInTransitionEnd then
                if shouldShowNetViewAfterTransition then
                    print("tOnInTransitionEnd...")
                    self:showNetView()
                    shouldHideNetViewAfterNetCallback = true
                end
                self:removeStateListener(listener)
            end
        end

        self:addStateListener(listener)

        netModel:callNet(func, function()
            shouldShowNetViewAfterTransition = false
            if shouldHideNetViewAfterNetCallback then
                self:hideNetView()
            end
        end)
    else
        self:showNetView()

        netModel:callNet(func, function()
            self:hideNetView()
        end)
    end
end

--[[
notice:　it will be error if isKeepAlive return false
         the reason is that controllermanager will release the layer of this controller when it onLeave
--]]
function LuaController:onState(state, enable)
    ------ do listener first ------
    local list = self._stateListenerList
    if list then
        list('for_each', function(func)
            return func(state, enable) 
        end)
    end
    -------------------------------
    self._state = state

    if state == tOnInit then
        self:onInit( self:getUserData(), self:getNetData() )
    elseif state == tOnEnter then

        --refresh touches onenter
        luaLayerManager.refresh()
        --print('refresh touches:'..tostring(self:getName()))
        --self:setEnabled(true)

        self:onEnter()

    elseif state == tOnInTransitionStart then
        self:onInTransitionStart()
    elseif state == tOnInTransitionEnd then
        self:onInTransitionEnd()

        luaLayerManager.refresh()
        
    elseif state == tOnBack then
        if not self:isKeepAlive() then
            --恢复加载视图
            self:revertLayer()
            self._controller:release() --引用计数减1
        end

        self:onBack( self:getUserData(), self:getNetData() )
    elseif state == tOnLeave then
        self:onLeave()
        if not self:isKeepAlive() then
            self:releaseLayer()
        end
    elseif state == tOnOutTransitionStart then
        self:onOutTransitionStart()
    elseif state == tOnOutTransitionEnd then
        self:onOutTransitionEnd()
    elseif state == tOnRelease then
        self:releaseMembers()
        self:onRelease()
    elseif state == tDidReceiveMemoryWarning then
        self:didReceiveMemoryWarning()
    elseif state == tIsKeepAlive then
        return self:isKeepAlive()
    elseif state == tSetEnabled then
        self:setEnabled(enable)
    elseif state == tGetTargetName then
        self:getTargetName(enable)
    end

    return 0
end 

function LuaController:onEnter()
end

function LuaController:onInTransitionStart()
end

function LuaController:onInTransitionEnd()
end

function LuaController:onLeave()
    --
end

function LuaController:onOutTransitionStart()
end

function LuaController:onOutTransitionEnd()
end

function LuaController:onRelease()

end

function LuaController:didReceiveMemoryWarning()

end

function LuaController:isKeepAlive()
    return true
end

function LuaController:getTargetName(param)
    
end
---------------------------------------------

function LuaController:registerEventLC(event,func)
    -- body
    assert(event and func and type(event) == "number" and type(func) == "function","registerEvent arg invalid!")
    
    local target = self:getTarget()
    assert(target, "LuaController Must Have A Target!")

    target:registerEvent(event,func)
end

require 'framework.basic.MetaHelper'.classDefinitionEnd(LuaController, 'LuaController')


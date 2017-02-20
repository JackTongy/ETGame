local Config = require "Config"
local Res = require "Res"
local DBManager = require "DBManager"
local AppData = require 'AppData'
local netModel = require 'netModel'

local FundAmtReward = require 'FundCntRewardConfig'
local FundLvRewards = require 'FundLvRewardConfig'

local fund = class(LuaDialog)

function fund:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."fund.cocos.zip")
    return self._factory:createDocument("fund.cocos")
end

--@@@@[[[[
function fund:onInitXML()
    local set = self._set
   self._bg_price_title = set:getLabelNode("bg_price_title")
   self._bg_btnBuy = set:getClickNode("bg_btnBuy")
   self._bg_btnBuy_title = set:getLabelNode("bg_btnBuy_title")
   self._bg_des1 = set:getRichLabelNode("bg_des1")
   self._bg_text = set:getLabelNode("bg_text")
   self._bg_text1 = set:getLabelNode("bg_text1")
   self._bg_welfare = set:getElfNode("bg_welfare")
   self._bg_welfare_gift = set:getColorClickNode("bg_welfare_gift")
   self._bg_welfare_gift_normal_content = set:getElfNode("bg_welfare_gift_normal_content")
   self._bg_welfare_gift_normal_content_pzbg = set:getElfNode("bg_welfare_gift_normal_content_pzbg")
   self._bg_welfare_gift_normal_content_icon = set:getElfNode("bg_welfare_gift_normal_content_icon")
   self._bg_welfare_gift_normal_content_pz = set:getElfNode("bg_welfare_gift_normal_content_pz")
   self._bg_welfare_gift_normal_content_piece = set:getElfNode("bg_welfare_gift_normal_content_piece")
   self._bg_welfare_gift_normal_count = set:getLabelNode("bg_welfare_gift_normal_count")
   self._bg_welfare_gift_normal_isSuit = set:getSimpleAnimateNode("bg_welfare_gift_normal_isSuit")
   self._bg_welfare_gift_normal_starLayout = set:getLayoutNode("bg_welfare_gift_normal_starLayout")
   self._bg_welfare_gift_normal_flag = set:getElfNode("bg_welfare_gift_normal_flag")
   self._bg_welfare_name_name = set:getLabelNode("bg_welfare_name_name")
   self._bg_welfare_name_value = set:getLabelNode("bg_welfare_name_value")
   self._bg_welfare_condition = set:getLabelNode("bg_welfare_condition")
   self._bg_welfare_progress = set:getLinearLayoutNode("bg_welfare_progress")
   self._bg_welfare_progress_title = set:getLabelNode("bg_welfare_progress_title")
   self._bg_welfare_progress_value = set:getLabelNode("bg_welfare_progress_value")
   self._bg_welfare_btnGet = set:getClickNode("bg_welfare_btnGet")
   self._bg_welfare_btnGet_title = set:getLabelNode("bg_welfare_btnGet_title")
   self._bg_list = set:getListNode("bg_list")
   self._bg = set:getElfNode("bg")
   self._gift = set:getColorClickNode("gift")
   self._gift_normal_content = set:getElfNode("gift_normal_content")
   self._gift_normal_content_pzbg = set:getElfNode("gift_normal_content_pzbg")
   self._gift_normal_content_icon = set:getElfNode("gift_normal_content_icon")
   self._gift_normal_content_pz = set:getElfNode("gift_normal_content_pz")
   self._gift_normal_content_piece = set:getElfNode("gift_normal_content_piece")
   self._gift_normal_count = set:getLabelNode("gift_normal_count")
   self._gift_normal_isSuit = set:getSimpleAnimateNode("gift_normal_isSuit")
   self._gift_normal_starLayout = set:getLayoutNode("gift_normal_starLayout")
   self._gift_normal_flag = set:getElfNode("gift_normal_flag")
   self._name = set:getLabelNode("name")
   self._condition = set:getLabelNode("condition")
   self._btnGet = set:getClickNode("btnGet")
   self._btnGet_title = set:getLabelNode("btnGet_title")
--   self._@view = set:getElfNode("@view")
--   self._@starss = set:getElfNode("@starss")
--   self._@cell = set:getElfNode("@cell")
--   self._@starss = set:getElfNode("@starss")
end
--@@@@]]]]

--------------------------------override functions----------------------
function fund:onInit( userData, netData )
	
end

function fund:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

local function getCellSet(view, index)
    if not view.cellSets then
        view.cellSets = {}
    end

    if not view.cellSets[index] then
        local set = view.createLuaSet('@cell')
        require 'LangAdapter'.LabelNodeAutoShrink(set['btnGet_title'],110)
        view['bg_list']:getContainer():addChild(set[1])
        table.insert(view.cellSets, set)
    end

    return view.cellSets[index]
end

local function refreshReward(headStr, cellSet, v)
    --print('msg:--------------cellSet: '..tostring(headStr))
    --print(cellSet)
    cellSet[string.format('%sgift', headStr)]:setEnabled(false)
    cellSet[string.format('%sgift_normal_content_icon', headStr)]:setResid(v.icon)
    cellSet[string.format('%sgift_normal_content_pz', headStr)]:setResid(v.frame)
    cellSet[string.format('%sgift_normal_content_pzbg', headStr)]:setResid(v.bg)
    cellSet[string.format('%sgift_normal_count', headStr)]:setString(string.format('x%s',tostring(v.count)))
    local color = Res.rankColor4F[v.pzindex or 1]
    -- if cellSet[1] and v.showfunc then
    --     cellSet[1]:setListener(v.showfunc)
    -- else
    --     cellSet[1]:setEnabled(false)
    -- end
    if v.type == 'PetPiece' then
        cellSet[string.format('%sgift_normal_content_icon', headStr)]:setScale(1.5)
        cellSet[string.format('%sgift_normal_content_piece', headStr)]:setVisible(true)
    end
    if v.type == 'Pet' then
        cellSet[string.format('%sgift_normal_content_icon', headStr)]:setScale(1.5)
    end
end

local updateLayer

local function refreshList(self, view, data, buy)
    local Utils = require 'framework.helper.Utils'

    local FundLvReward = Utils.copyTable( FundLvRewards )

    table.sort(FundLvReward, function(v1, v2)
        local received1 = false
        local received2 = false
        for k1, v in pairs(data) do
            if v == v1.Lv then
                received1 = true
            end

            if v == v2.Lv then
                received2 = true
            end
        end
        if received1 ~= received2 then
            return received2
        else
            return v1.Lv < v2.Lv
        end
    end)

    for k = 1,#FundLvReward do
        local set = getCellSet(view, k)
        --
        refreshReward("", set, {icon = 'TY_jinglingshi_da.png', frame = "", bg = "", count = FundLvReward[k].Coin})
        set['name']:setString(string.format(Res.locString('Activity$FundX'), FundLvReward[k].Lv))
        set['condition']:setString(string.format(Res.locString('Activity$FundConditionXLv'), FundLvReward[k].Lv))
        -- 可以领取
        local received = false
        for k1, v in pairs(data) do
            if v == FundLvReward[k].Lv then
                received = true
                break
            end
        end
        if buy and not received and AppData.getUserInfo().getLevel() >= FundLvReward[k].Lv then
            set['bg']:setResid('KFJJ_liebiao2.png')
            set['btnGet_title']:setString(Res.locString('Global$Receive'))
            set['btnGet']:setEnabled(true)
            set['btnGet']:setListener(function()
                self:send(netModel.getModelFundLvRwdGet(FundLvReward[k].Lv), function(netdata)
                    if netdata and netdata.D then
                        if netdata.D.Resource then
                            AppData.updateResource(netdata.D.Resource)
                        end
                        Res.doActionGetReward(netdata.D.Reward)
                        updateLayer(self, view, netdata.D)
                    end
                end)
            end)
        else
            if not buy and AppData.getUserInfo().getLevel() >= FundLvReward[k].Lv then
                set['bg']:setResid('KFJJ_liebiao2.png')
                set['btnGet_title']:setString(Res.locString('Global$Receive'))
                set['btnGet']:setEnabled(true)
                set['btnGet']:setListener(function()
                    self:toast(Res.locString('Activity$FundToastBuyFirst'))
                end)
            else
                set['bg']:setResid('KFJJ_liebiao1.png')
                if buy and AppData.getUserInfo().getLevel() >= FundLvReward[k].Lv then
                    set['btnGet_title']:setString(Res.locString('Global$ReceiveFinish'))
                else
                    set['btnGet_title']:setString(Res.locString('Global$Receive'))
                end
                set['btnGet']:setEnabled(false)
            end
        end
    end

    view['bg_list']:layout()
end

updateLayer = function(self, view, data)
    require 'LangAdapter'.fontSize(view['bg_des1'],nil,nil,15,15,nil,nil,nil,nil,15)
    require 'LangAdapter'.fontSize(view['bg_text'],nil,nil,15,15,15,nil,nil,nil,14)
    require 'LangAdapter'.fontSize(view['bg_text1'],nil,nil,15,nil,15,nil,nil,nil,15)
    require 'LangAdapter'.LabelNodeAutoShrink(view['bg_welfare_condition'],300) 
    require 'LangAdapter'.LabelNodeAutoShrink(view['bg_welfare_progress_title'],220) 
    require 'LangAdapter'.LabelNodeAutoShrink(view['bg_welfare_name_value'],150) 
    require 'LangAdapter'.LabelNodeAutoShrink(view['bg_welfare_name_name'],150) 
    require 'LangAdapter'.LabelNodeAutoShrink(view['bg_des1'],450)
    require 'LangAdapter'.LabelNodeAutoShrink(view['bg_btnBuy_title'],120)
    require 'LangAdapter'.LabelNodeAutoShrink(view['bg_welfare_btnGet_title'],110)

    require 'LangAdapter'.LabelNodeSetHorizontalAlignmentIfArabic(view['bg_text'])
    require 'LangAdapter'.LabelNodeSetHorizontalAlignmentIfArabic(view['bg_text1'])
    require 'LangAdapter'.selectLang(nil,nil,nil,nil,nil,nil,nil,nil,function ( ... )
    	view['bg_des1']:setAnchorPoint(ccp(1,0.5))
    	view['bg_des1']:setPosition(ccp(140,177.14285))
    	view['bg_text']:setPosition(ccp(-300,148.57143))
    	view['bg_text1']:setPosition(ccp(-300,110))
    end)

    view['bg_des1']:setString(string.format(Res.locString('Activity$FundDes1'), 5000))
    if data.Fund.Buy then
        view['bg_btnBuy']:setEnabled(false)
        view['bg_btnBuy_title']:setString(Res.locString('Global$Bought'))
    else
        view['bg_btnBuy']:setEnabled(true)
        view['bg_btnBuy_title']:setString(Res.locString('Activity$FundBuy'))
    end
    view['bg_price_title']:setString('1000')
    view['bg_btnBuy']:setListener(function( ... )
        if AppData.getUserInfo().getVipLevel() >= 3 then
            require 'Toolkit'.useCoinConfirm(function ( ... )
                self:send(netModel.getModelFundBuy(), function(netdata)
                    if netdata and netdata.D then
                        updateLayer(self, view, netdata.D)

                        AppData.getUserInfo().setCoin(AppData.getUserInfo().getCoin() - 1000)
                        require 'EventCenter'.eventInput("UpdateGoldCoin")
                    end
                end)
            end)
        else
            self:toast(Res.locString('Activity$FundVipLvLimit'))
        end
    end)

    local amountRewardIndex = 1
    if data.Fund.CntRewardGots and next(data.Fund.CntRewardGots) then
        amountRewardIndex = #data.Fund.CntRewardGots + 1
    end
    local realIndex = amountRewardIndex
    if amountRewardIndex > #FundAmtReward then
        view['bg_welfare_btnGet']:setEnabled(false)
        view['bg_welfare_btnGet_title']:setString(Res.locString('Global$ReceiveFinish'))
        amountRewardIndex = #FundAmtReward
    end
    --print('msg:--------------------#data.Fund.CntRewardGots: '..tostring(#data.Fund.CntRewardGots))
    --print(string.format('amountRewardIndex  %d     #FundAmtReward  %d', amountRewardIndex, #FundAmtReward))


    local amtReward = FundAmtReward[amountRewardIndex]
    local DBReward = DBManager.getReward(amtReward.RewardId)
    local info = Res.getDetailByDBReward(DBReward[1])

    refreshReward("bg_welfare_", view, info)
    view['bg_welfare_name_name']:setString(info.name)
    view['bg_welfare_condition']:setString(string.format(Res.locString('Activity$FundConditionX'), amtReward.Cnt))
    view['bg_welfare_progress_value']:setString(string.format(' %d/%d', data.Fund.BuyCnt, amtReward.Cnt))

    -- if amountRewardIndex > #FundAmtReward then
    --     view['bg_welfare_btnGet']:setEnabled(false)
    --     view['bg_welfare_btnGet_title']:setString(Res.locString('Global$ReceiveFinish'))

    --     amountRewardIndex = #FundAmtReward
    -- else
    if amountRewardIndex == realIndex then
        if data.Fund.BuyCnt >= amtReward.Cnt then
            view['bg_welfare']:setResid('KFJJ_liebiao2.png')
            view['bg_welfare_btnGet']:setEnabled(true)
            view['bg_welfare_progress_value']:setFontFillColor(ccc4f(0.078431, 0.564706, 0, 1.0), true)
        else
            view['bg_welfare']:setResid('KFJJ_liebiao1.png')
            view['bg_welfare_btnGet']:setEnabled(false)
            view['bg_welfare_progress_value']:setFontFillColor(ccc4f(0.886275, 0.231373, 0, 1.0), true)
        end
    end

    view['bg_welfare_btnGet']:setListener(function()
        self:send(netModel.getModelFundCntRwdGet(FundAmtReward[amountRewardIndex].Cnt), function(netdata)
            if netdata and netdata.D then
                if netdata.D.Resource then
                    AppData.updateResource(netdata.D.Resource)
                end
                Res.doActionGetReward(netdata.D.Reward)
                updateLayer(self, view, netdata.D)

                --print('msg:-----------------netData.D')
                --print(netData.D)
            end
        end)
    end)

    refreshList(self, view, data.Fund.LvRewardGots, data.Fund.Buy)
end

-- self._bg = set:getElfNode("bg")
-- self._gift = set:getColorClickNode("gift")
-- self._gift_normal_content = set:getElfNode("gift_normal_content")
-- self._gift_normal_content_pzbg = set:getElfNode("gift_normal_content_pzbg")
-- self._gift_normal_content_icon = set:getElfNode("gift_normal_content_icon")
-- self._gift_normal_content_pz = set:getElfNode("gift_normal_content_pz")
-- self._gift_normal_content_piece = set:getElfNode("gift_normal_content_piece")
-- self._gift_normal_count = set:getLabelNode("gift_normal_count")
-- self._gift_normal_isSuit = set:getSimpleAnimateNode("gift_normal_isSuit")
-- self._gift_normal_starLayout = set:getLayoutNode("gift_normal_starLayout")
-- self._gift_normal_flag = set:getElfNode("gift_normal_flag")
-- self._name = set:getLabelNode("name")
-- self._condition = set:getLabelNode("condition")
-- self._btnGet = set:getClickNode("btnGet")
-- self._btnGet_title = set:getLabelNode("btnGet_title")

--------------------------------class end-------------------------------
local update = function (self, view, data)
    if data and data.D then
        updateLayer(self, view, data.D)
        --checkRedPoint(self)
    end
end

local getNetModel = function ( )
    return netModel.getModelFundGet()
end

return {getNetModel = getNetModel, update=update}



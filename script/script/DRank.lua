local Config = require "Config"
local DBManager = require "DBManager"
local NetModel = require 'netModel'
local Res = require 'Res'
local AppData = require 'AppData'
local Toolkit = require 'Toolkit'
-- local TimeManager = require 'TimeManager'
local UnlockManager = require 'UnlockManager'
local DRank = class(LuaDialog)

local historyData = {}

function DRank:createDocument()
    self._factory:setZipFilePath(Config.COCOS_ZIP_DIR.."DRank.cocos.zip")
    return self._factory:createDocument("DRank.cocos")
end

--@@@@[[[[
function DRank:onInitXML()
	local set = self._set
    self._clickBg = set:getClickNode("clickBg")
    self._root = set:getElfNode("root")
    self._root_bg = set:getElfNode("root_bg")
    self._root_page1 = set:getElfNode("root_page1")
    self._root_page1_BG_layout_pet1 = set:getColorClickNode("root_page1_BG_layout_pet1")
    self._root_page1_BG_layout_pet1_normal_elf_frame = set:getElfNode("root_page1_BG_layout_pet1_normal_elf_frame")
    self._root_page1_BG_layout_pet1_normal_elf_icon = set:getElfNode("root_page1_BG_layout_pet1_normal_elf_icon")
    self._root_page1_BG_layout_pet1_normal_starLayout = set:getLayoutNode("root_page1_BG_layout_pet1_normal_starLayout")
    self._root_page1_BG_layout_pet2 = set:getColorClickNode("root_page1_BG_layout_pet2")
    self._root_page1_BG_layout_pet2_normal_elf_frame = set:getElfNode("root_page1_BG_layout_pet2_normal_elf_frame")
    self._root_page1_BG_layout_pet2_normal_elf_icon = set:getElfNode("root_page1_BG_layout_pet2_normal_elf_icon")
    self._root_page1_BG_layout_pet2_normal_starLayout = set:getLayoutNode("root_page1_BG_layout_pet2_normal_starLayout")
    self._root_page1_BG_layout_pet3 = set:getColorClickNode("root_page1_BG_layout_pet3")
    self._root_page1_BG_layout_pet3_normal_elf_frame = set:getElfNode("root_page1_BG_layout_pet3_normal_elf_frame")
    self._root_page1_BG_layout_pet3_normal_elf_icon = set:getElfNode("root_page1_BG_layout_pet3_normal_elf_icon")
    self._root_page1_BG_layout_pet3_normal_starLayout = set:getLayoutNode("root_page1_BG_layout_pet3_normal_starLayout")
    self._root_page1_BG_layout_pet4 = set:getColorClickNode("root_page1_BG_layout_pet4")
    self._root_page1_BG_layout_pet4_normal_elf_frame = set:getElfNode("root_page1_BG_layout_pet4_normal_elf_frame")
    self._root_page1_BG_layout_pet4_normal_elf_icon = set:getElfNode("root_page1_BG_layout_pet4_normal_elf_icon")
    self._root_page1_BG_layout_pet4_normal_starLayout = set:getLayoutNode("root_page1_BG_layout_pet4_normal_starLayout")
    self._root_page1_BG_layout_pet5 = set:getColorClickNode("root_page1_BG_layout_pet5")
    self._root_page1_BG_layout_pet5_normal_elf_frame = set:getElfNode("root_page1_BG_layout_pet5_normal_elf_frame")
    self._root_page1_BG_layout_pet5_normal_elf_icon = set:getElfNode("root_page1_BG_layout_pet5_normal_elf_icon")
    self._root_page1_BG_layout_pet5_normal_starLayout = set:getLayoutNode("root_page1_BG_layout_pet5_normal_starLayout")
    self._root_page1_BG_describe = set:getLabelNode("root_page1_BG_describe")
    self._root_page1_BG_list = set:getListNode("root_page1_BG_list")
    self._normal_bg = set:getElfNode("normal_bg")
    self._pressed_bg = set:getElfNode("pressed_bg")
    self._rankIcon = set:getElfNode("rankIcon")
    self._rankLabel = set:getLabelNode("rankLabel")
    self._name = set:getLabelNode("name")
    self._power = set:getLabelNode("power")
    self._level = set:getLabelNode("level")
    self._illustrate = set:getLabelNode("illustrate")
    self._root_page1_BG_top = set:getElfNode("root_page1_BG_top")
    self._root_page1_BG_top_power = set:getLabelNode("root_page1_BG_top_power")
    self._root_page1_BG_top_level = set:getLabelNode("root_page1_BG_top_level")
    self._root_page1_BG_top_illustrate = set:getLabelNode("root_page1_BG_top_illustrate")
    self._root_page1_BG_bottom = set:getColorClickNode("root_page1_BG_bottom")
    self._root_page1_BG_bottom_normal_none = set:getLabelNode("root_page1_BG_bottom_normal_none")
    self._root_page1_BG_bottom_normal_rankLabel = set:getLabelNode("root_page1_BG_bottom_normal_rankLabel")
    self._root_page1_BG_bottom_normal_name = set:getLabelNode("root_page1_BG_bottom_normal_name")
    self._root_page1_BG_bottom_normal_power = set:getLabelNode("root_page1_BG_bottom_normal_power")
    self._root_page1_BG_bottom_normal_level = set:getLabelNode("root_page1_BG_bottom_normal_level")
    self._root_page1_BG_bottom_normal_arrow = set:getElfNode("root_page1_BG_bottom_normal_arrow")
    self._root_page1_BG_bottom_normal_illustrate = set:getLabelNode("root_page1_BG_bottom_normal_illustrate")
    self._root_page1_top = set:getElfNode("root_page1_top")
    self._root_page1_top_pet2 = set:getColorClickNode("root_page1_top_pet2")
    self._root_page1_top_pet2_normal_icon = set:getElfNode("root_page1_top_pet2_normal_icon")
    self._root_page1_top_pet2_normal_name = set:getLabelNode("root_page1_top_pet2_normal_name")
    self._root_page1_top_pet3 = set:getColorClickNode("root_page1_top_pet3")
    self._root_page1_top_pet3_normal_icon = set:getElfNode("root_page1_top_pet3_normal_icon")
    self._root_page1_top_pet3_normal_name = set:getLabelNode("root_page1_top_pet3_normal_name")
    self._root_page1_top_pet1 = set:getColorClickNode("root_page1_top_pet1")
    self._root_page1_top_pet1_normal_icon = set:getElfNode("root_page1_top_pet1_normal_icon")
    self._root_page1_top_pet1_normal_name = set:getLabelNode("root_page1_top_pet1_normal_name")
    self._root_page3 = set:getElfNode("root_page3")
    self._root_page3_bg_list = set:getListNode("root_page3_bg_list")
    self._bg = set:getElfNode("bg")
    self._rank = set:getLabelNode("rank")
    self._icon = set:getElfNode("icon")
    self._name = set:getLinearLayoutNode("name")
    self._name_icon = set:getElfNode("name_icon")
    self._name_text = set:getLabelNode("name_text")
    self._leader = set:getLabelNode("leader")
    self._member = set:getLabelNode("member")
    self._power = set:getLabelNode("power")
    self._root_page3_bg_none = set:getLabelNode("root_page3_bg_none")
    self._root_page3_bottom = set:getElfNode("root_page3_bottom")
    self._root_page3_bottom_none = set:getLabelNode("root_page3_bottom_none")
    self._root_page3_bottom_rank = set:getLabelNode("root_page3_bottom_rank")
    self._root_page3_bottom_icon = set:getElfNode("root_page3_bottom_icon")
    self._root_page3_bottom_name = set:getLinearLayoutNode("root_page3_bottom_name")
    self._root_page3_bottom_name_icon = set:getElfNode("root_page3_bottom_name_icon")
    self._root_page3_bottom_name_text = set:getLabelNode("root_page3_bottom_name_text")
    self._root_page3_bottom_leader = set:getLabelNode("root_page3_bottom_leader")
    self._root_page3_bottom_member = set:getLabelNode("root_page3_bottom_member")
    self._root_page3_bottom_power = set:getLabelNode("root_page3_bottom_power")
    self._root_page2 = set:getElfNode("root_page2")
    self._root_page2_BG_list = set:getListNode("root_page2_BG_list")
    self._normal_pet1 = set:getColorClickNode("normal_pet1")
    self._normal_pet1_normal_elf_frame = set:getElfNode("normal_pet1_normal_elf_frame")
    self._normal_pet1_normal_elf_icon = set:getElfNode("normal_pet1_normal_elf_icon")
    self._normal_pet1_normal_starLayout = set:getLayoutNode("normal_pet1_normal_starLayout")
    self._normal_rankIcon = set:getElfNode("normal_rankIcon")
    self._normal_rankLabel = set:getLabelNode("normal_rankLabel")
    self._normal_pet2 = set:getColorClickNode("normal_pet2")
    self._normal_pet2_normal_icon = set:getElfNode("normal_pet2_normal_icon")
    self._normal_name = set:getLabelNode("normal_name")
    self._normal_quality = set:getLinearLayoutNode("normal_quality")
    self._normal_quality_value = set:getLabelNode("normal_quality_value")
    self._normal_level = set:getLinearLayoutNode("normal_level")
    self._normal_level_value = set:getLabelNode("normal_level_value")
    self._normal_owner = set:getLinearLayoutNode("normal_owner")
    self._normal_owner_value = set:getLabelNode("normal_owner_value")
    self._normal_equip1 = set:getColorClickNode("normal_equip1")
    self._normal_equip1_normal_elf_frame = set:getElfNode("normal_equip1_normal_elf_frame")
    self._normal_equip1_normal_elf_icon = set:getElfNode("normal_equip1_normal_elf_icon")
    self._normal_rankIcon = set:getElfNode("normal_rankIcon")
    self._normal_rankLabel = set:getLabelNode("normal_rankLabel")
    self._normal_pet2 = set:getColorClickNode("normal_pet2")
    self._normal_pet2_normal_icon = set:getElfNode("normal_pet2_normal_icon")
    self._normal_level = set:getLinearLayoutNode("normal_level")
    self._normal_level_value = set:getLabelNode("normal_level_value")
    self._normal_owner = set:getLinearLayoutNode("normal_owner")
    self._normal_owner_value = set:getLabelNode("normal_owner_value")
    self._normal_quality = set:getLabelNode("normal_quality")
    self._normal_name = set:getLabelNode("normal_name")
    self._root_page2_bottom = set:getElfNode("root_page2_bottom")
    self._root_page2_bottom_page = set:getLabelNode("root_page2_bottom_page")
    self._root_page2_bottom_turnRight = set:getButtonNode("root_page2_bottom_turnRight")
    self._root_page2_bottom_turnLeft = set:getButtonNode("root_page2_bottom_turnLeft")
    self._root_title = set:getElfNode("root_title")
    self._root_title_content = set:getLabelNode("root_title_content")
    self._root_close = set:getButtonNode("root_close")
    self._root_tabs = set:getLinearLayoutNode("root_tabs")
    self._root_tabs_tab1 = set:getTabNode("root_tabs_tab1")
    self._root_tabs_tab1_normal_des = set:getLabelNode("root_tabs_tab1_normal_des")
    self._root_tabs_tab1_pressed_des = set:getLabelNode("root_tabs_tab1_pressed_des")
    self._root_tabs_tab2 = set:getTabNode("root_tabs_tab2")
    self._root_tabs_tab2_normal_des = set:getLabelNode("root_tabs_tab2_normal_des")
    self._root_tabs_tab2_pressed_des = set:getLabelNode("root_tabs_tab2_pressed_des")
    self._root_tabs_tab3 = set:getTabNode("root_tabs_tab3")
    self._root_tabs_tab3_normal_des = set:getLabelNode("root_tabs_tab3_normal_des")
    self._root_tabs_tab3_pressed_des = set:getLabelNode("root_tabs_tab3_pressed_des")
    self._root_tabs_tab4 = set:getTabNode("root_tabs_tab4")
    self._root_tabs_tab4_normal_des = set:getLabelNode("root_tabs_tab4_normal_des")
    self._root_tabs_tab4_pressed_des = set:getLabelNode("root_tabs_tab4_pressed_des")
    self._root_tabs_tab5 = set:getTabNode("root_tabs_tab5")
    self._root_tabs_tab5_normal_des = set:getLabelNode("root_tabs_tab5_normal_des")
    self._root_tabs_tab5_pressed_des = set:getLabelNode("root_tabs_tab5_pressed_des")
    self._root_tabs_tab6 = set:getTabNode("root_tabs_tab6")
    self._root_tabs_tab6_normal_des = set:getLabelNode("root_tabs_tab6_normal_des")
    self._root_tabs_tab6_pressed_des = set:getLabelNode("root_tabs_tab6_pressed_des")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@cellClick = set:getTabNode("@cellClick")
--    self._@itemRank = set:getElfNode("@itemRank")
--    self._@cellPet = set:getColorClickNode("@cellPet")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@starss = set:getElfNode("@starss")
--    self._@cellEquip = set:getColorClickNode("@cellEquip")
end
--@@@@]]]]


local Launcher = require 'Launcher'

Launcher.register('DRank',function(userData)
    if UnlockManager:isUnlock("ranklist") then
        -- print('msg:-------------------------historyData')
        -- print(historyData)
        if not historyData or not next(historyData) then
            Launcher.callNet(NetModel.getRanks(),function (data)
                Launcher.Launching(data.D)
            end)
        else
            Launcher.Launching(historyData)
        end
    else
        return GleeCore:toast(UnlockManager:getUnlockConditionMsg("ranklist"))
    end
end)

--------------------------------override functions----------------------
function DRank:onInit( userData, netData )
    Res.doActionDialogShow(self._root)
    self._root_page1_BG_bottom:setEnabled(false)
    assert(netData)

    self.ranks = netData
	self._clickBg:setListener(function ( ... )
        Res.doActionDialogHide(self._root, self)
        historyData = {}
    end)
    self._root_close:setTriggleSound(Res.Sound.back)
    self._root_close:setListener(function (  )
        Res.doActionDialogHide(self._root, self)
        historyData = {}
    end)

    -- self._root_page1_top_pet1:setEnabled(false)
    -- self._root_page1_top_pet2:setEnabled(false)
    -- self._root_page1_top_pet3:setEnabled(false)

    self:setTabListener()

    -- print('msg:-------------------------netData')
    -- print(netData)

    if netData and netData.tabIndex then
        self.tabIndex = netData.tabIndex
    else
        self.tabIndex = 1
    end

    if not self.tabIndex then
        self.tabIndex = 1
    end

    if self.tabIndex < 1 or self.tabIndex > 4 then
        self.tabIndex = 1
    end
    
    self[string.format('_root_tabs_tab%d', self.tabIndex)]:trigger(nil)

    	require 'LangAdapter'.selectLang(nil, nil, nil, nil, function ( ... )
    		self._root_page1_BG_describe:setAnchorPoint(ccp(0.5,0.5))
		self._root_page1_BG_describe:setRotation(90)
		self._root_page1_BG_describe:setPosition(ccp(-50.0,155.7143))
		for i=1,6 do
			self[string.format('_root_tabs_tab%d_normal_des', i)]:setFontSize(20)
			self[string.format('_root_tabs_tab%d_pressed_des', i)]:setFontSize(20)
		end

        self._root_tabs_tab3_normal_des:setFontSize(17)
        self._root_tabs_tab3_pressed_des:setFontSize(17)
	end)
end

function DRank:onBack( userData, netData )
	
end

--------------------------------custom code-----------------------------

function DRank:setTabListener( ... )
    for i = 1, 6 do
        self[string.format('_root_tabs_tab%d', i)]:setListener(function()
            self.tabIndex = i
            if i < 5 then
                self._root_page1:setVisible(true)
                self._root_page2:setVisible(false)
                self._root_page3:setVisible(false)
                -- hide sets
                if self.sets and next(self.sets) then
                    for i = 1, #self.sets do
                        self.sets[i][1]:setVisible(false)
                        self.sets[i][1]:setScale(0)
                    end
                end
                -- refresh
                self:updateDialog1(i)

                self._root_title_content:setString(Res.locString(string.format('DRank$_top_TITLE%d', i)))

                --self:runWithDelay(function()
                    self:selectHistoryCell()
                --end, 0.02)
            elseif i == 5 then
                self._root_page1:setVisible(false)
                self._root_page2:setVisible(false)
                self._root_page3:setVisible(true)
                self._root_title_content:setString(Res.locString('DRank$_top_TITLE5'))--string.format('DRank$_top_TITLE%d', i)))
                self:updateDialog3()
            else
                self._root_page1:setVisible(false)
                self._root_page2:setVisible(true)
                self:updateDialog2(i)
            end
        end)
    end
end

function DRank:getData(index)
    if index == 1 then
        return self.ranks.RankPowers, self.ranks.MyRankPower
    elseif index == 2 then
        return self.ranks.RankLevels, self.ranks.MyRankLevel
    elseif index == 3 then
        return self.ranks.RankCollects, self.ranks.MyRankCollect
    elseif index == 4 then
        -- print('msg:-------------------')
        -- print(self.ranks)
        return self.ranks.RankProcesses, self.ranks.MyRankProcess
    elseif index == 5 then
        --return self.ranks.RankEquips
    elseif index == 6 then
        --return self.ranks.RankCollects, self.ranks.MyRankCollect
    end
end

function DRank:selectHistoryCell()
    if not historyData.preCellIndex and self.sets and next(self.sets) then
        self._root_page1_BG_list:layout()
        return self.sets[1][1]:trigger(nil)
    end

    if self.sets and self.sets[historyData.preCellIndex] then

        self.sets[historyData.preCellIndex][1]:trigger(nil)
        local record = historyData.preCellIndex - 1
        self:runWithDelay(function()
            self._root_page1_BG_list:alignTo(record)
        end, 0.2)
    end
    historyData.preCellIndex = nil
end

function DRank:updateDialog1(index)
    --refresh top
    local data, myRank = self:getData(index)
    for i = 1, 3 do
        if i <= #data then
            self[string.format('_root_page1_top_pet%d_normal_icon', i)] :setResid(Res.getPetIcon(data[i].PetId))
            self[string.format('_root_page1_top_pet%d_normal_name', i)] :setString(data[i].Name)
            self[string.format('_root_page1_top_pet%d', i)] :setListener(function()
                self._root_page1_BG_list:alignTo(i - 1)
                self.sets[i][1]:trigger(nil)
            end)
        end
    end
    --refresh bottom
    --local myRank = data[1]
    if myRank then
        self._root_page1_BG_bottom_normal_rankLabel:getParent():setVisible(true)
        -- self._root_page1_BG_bottom_normal_name:setVisible(true)
        -- self._root_page1_BG_bottom_normal_power:setVisible(true)
        -- self._root_page1_BG_bottom_normal_level:setVisible(true)
        -- self._root_page1_BG_bottom_normal_illustrate:setVisible(true)
        -- self._root_page1_BG_bottom_normal_arrow:setVisible(true)
        self._root_page1_BG_bottom_normal_none:setVisible(false)
    else
        self._root_page1_BG_bottom_normal_rankLabel:getParent():setVisible(false)
        -- self._root_page1_BG_bottom_normal_rankLabel:setVisible(false)
        -- self._root_page1_BG_bottom_normal_name:setVisible(false)
        -- self._root_page1_BG_bottom_normal_power:setVisible(false)
        -- self._root_page1_BG_bottom_normal_level:setVisible(false)
        -- self._root_page1_BG_bottom_normal_illustrate:setVisible(false)
        -- self._root_page1_BG_bottom_normal_arrow:setVisible(false)
        self._root_page1_BG_bottom_normal_none:setVisible(true)
    end

    if myRank then
        self._root_page1_BG_bottom_normal_rankLabel:setString(tostring(myRank.Rank))
        self._root_page1_BG_bottom_normal_name:setString(myRank.Name)
    end

     if index == 4 then
        self._root_page1_BG_top_power:setString(Res.locString('DRank$_star_amount'))
        self._root_page1_BG_top_level:setString(Res.locString('DRank$_titleFUCK'))

        if myRank then
            local DBTitle = DBManager.getInfoTitleConfig(myRank.TitleId)
            self._root_page1_BG_bottom_normal_power:setString(tostring(myRank.Stars))
            self._root_page1_BG_bottom_normal_level:setString(tostring(DBTitle.Name))
        end
    elseif index == 2 then
        self._root_page1_BG_top_power:setString(Res.locString('DRank$_level'))
        self._root_page1_BG_top_level:setString(Res.locString('DRank$_power'))

        if myRank then
            self._root_page1_BG_bottom_normal_power:setString(tostring(myRank.Lv))
            self._root_page1_BG_bottom_normal_level:setString(tostring(myRank.Pwr))
        end
    elseif index == 1 then
        self._root_page1_BG_top_power:setString(Res.locString('DRank$_power'))
        self._root_page1_BG_top_level:setString(Res.locString('DRank$_level'))
        if myRank then
            self._root_page1_BG_bottom_normal_power:setString(tostring(myRank.Pwr))
            self._root_page1_BG_bottom_normal_level:setString(tostring(myRank.Lv))
        end
    elseif index == 3 then
        self._root_page1_BG_top_power:setString(Res.locString('DRank$_level'))
        self._root_page1_BG_top_level:setString(Res.locString('DRank$_illustrate'))

        if myRank then
            self._root_page1_BG_bottom_normal_power:setString(tostring(myRank.Lv))
            self._root_page1_BG_bottom_normal_level:setString(tostring(myRank.PetIdCnt))
        end
    end
	require 'LangAdapter'.fontSize(self._root_page1_BG_bottom_normal_level, nil, nil, nil, nil, nil, nil, nil, 24)

    -- if index ~= 3 then
    --     self._root_page1_BG_top_power:setVisible(true)
    --     self._root_page1_BG_top_level:setVisible(true)
    --     self._root_page1_BG_top_illustrate:setVisible(false)

    --     self._root_page1_BG_bottom_normal_power:setVisible(true)
    --     self._root_page1_BG_bottom_normal_level:setVisible(true)
    --     self._root_page1_BG_bottom_normal_illustrate:setVisible(false)
        

       
    -- else
    --     -- self._root_page1_BG_top_power:setVisible(false)
    --     -- self._root_page1_BG_top_level:setVisible(false)
    --     -- self._root_page1_BG_top_illustrate:setVisible(true)
    --     -- self._root_page1_BG_bottom_normal_power:setVisible(false)
    --     -- self._root_page1_BG_bottom_normal_level:setVisible(false)
    --     -- self._root_page1_BG_bottom_normal_illustrate:setVisible(true)
    --     self._root_page1_BG_bottom_normal_illustrate:setString(myRank.PetIdCnt)
    -- end
    if myRank then
        -- print('msg:---------------------myRank.LastRank')
        -- print(myRank.LastRank)
        if myRank.LastRank == -1 then
            self._root_page1_BG_bottom_normal_arrow:setVisible(false)
        else
            self._root_page1_BG_bottom_normal_arrow:setVisible(true)
            if myRank.LastRank < myRank.Rank then
                self._root_page1_BG_bottom_normal_arrow:setResid('PHB_LB_jiantou2.png')
            elseif myRank.LastRank > myRank.Rank then
                self._root_page1_BG_bottom_normal_arrow:setResid('PHB_LB_jiantou1.png')
            else
                self._root_page1_BG_bottom_normal_arrow:setVisible(false)
            end
        end
    end

    self:refreshList(data, index)
    --refresh left
    --self:runWithDelay(function()
    --    self._root_page1_BG_list:layout()
    --end, 0.1)
    
end

function DRank:updateDialog2(index)
    local data = self:getData(index)
    

    local page = #data / 10 + #data % 10
    self._root_page2_bottom_page:setString(string.format('1/%d', page))

    if index == 3 or index == 4 then
        --self:refreshPetList(data)

        self._root_page2_bottom_turnRight:setListener(function()
            if not self.petPageBegin then 
                self.petPageBegin = 1
                self.petPageBegin = 10
                self.petPage = 1
            else
                if self.petPage >= page then
                    return self:toast(Res.locString('DRank$_final_page'))
                end
                self.petPageBegin = self.petPageBegin + 10
                self.petPageBegin = self.petPageBegin + 10
                self.petPage = self.petPage + 1
                -- if self.petPage > page then
                --     self.petPageBegin = 1
                --     self.petPageBegin = 10
                --     self.petPage = 1
                -- end
            end
            self._root_page2_bottom_page:setString(string.format('%d/%d', self.petPage, page))

            self:refreshPetList(data, self.petPageBegin, self.petPageBegin)
        end)
        self._root_page2_bottom_turnLeft:setListener(function()
            if not self.petPageBegin then 
                self.petPageBegin = 1
                self.petPageBegin = 10
                self.petPage = 1
            else
                if self.petPage <= 1 then
                    return self:toast(Res.locString('DRank$_first_page'))
                end
                self.petPageBegin = self.petPageBegin - 10
                self.petPageBegin = self.petPageBegin - 10
                self.petPage = self.petPage - 1
            end

            self._root_page2_bottom_page:setString(string.format('%d/%d', self.petPage, page))

            self:refreshPetList(data, self.petPageBegin, self.petPageBegin)
        end)
        self._root_page2_bottom_turnRight:trigger(nil)
    else
        self._root_page2_bottom_turnRight:setListener(function()
            if not self.equipPageBegin then 
                self.equipPageBegin = 1
                self.equipPageBegin = 10
                self.equipPage = 1
            else
                if self.equipPage >= page then
                    return self:toast(Res.locString('DRank$_final_page'))
                end
                self.equipPageBegin = self.equipPageBegin + 10
                self.equipPageBegin = self.equipPageBegin + 10
                self.equipPage = self.equipPage + 1
            end

            self._root_page2_bottom_page:setString(string.format('%d/%d', self.equipPage, page))

            self:refreshEquipList(data, self.equipPageBegin, self.equipPageBegin)
        end)

        self._root_page2_bottom_turnLeft:setListener(function()
            if not self.equipPageBegin then 
                self.equipPageBegin = 1
                self.equipPageBegin = 10
                self.equipPage = 1
            else
                if self.petPage <= 1 then
                    return self:toast(Res.locString('DRank$_first_page'))
                end
                self.equipPageBegin = self.equipPageBegin - 10
                self.equipPageBegin = self.equipPageBegin - 10
                self.equipPage = self.equipPage - 1
            end

            self._root_page2_bottom_page:setString(string.format('%d/%d', self.equipPage, page))

            self:refreshEquipList(data, self.equipPageBegin, self.equipPageBegin)
        end)

        self._root_page2_bottom_turnRight:trigger(nil)
    end

    
    self._root_page2_bottom_turnRight:setListener(function()
        -- body
    end)
    self._root_page2_bottom_turnLeft:setListener(function()
        -- body
    end)

end

function DRank:getSetv1(index)
    if not self.sets then
        self.sets = {}
    end

    if not self.sets[index] then
        local set = self:createLuaSet('@cellClick')
        table.insert(self.sets, set)
        self._root_page1_BG_list:getContainer():addChild(set[1])
    end

    return self.sets[index]
end

function DRank:getSetv2(index)
    if not self.setsv2 then
        self.setsv2 = {}
    end

    if not self.setsv2[index] then
        local set = self:createLuaSet('@cellPet')
        table.insert(self.setsv2, set)
        self._root_page1_BG_list:getContainer():addChild(set[1])
    end

    return self.setsv2[index]
end

function DRank:getSetv3(index)
    if not self.setsv3 then
        self.setsv3 = {}
    end

    if not self.setsv3[index] then
        local set = self:createLuaSet('@cellEquip')
        table.insert(self.setsv3, set)
        self._root_page1_BG_list:getContainer():addChild(set[1])
    end

    return self.setsv3[index]
end

function DRank:refreshList(data, rankType)

    -- if not historyData or not next(historyData) then
    --     historyData.record = true
    --     for k, v in pairs(data) do
    --         if k < 6 then
    --             self:refreshCell(k, v, rankType)
    --         else
    --             self:runWithDelay(function()
                    
    --                 if self.tabIndex ~= rankType then
    --                     return
    --                 end

    --                 self:refreshCell(k, v, rankType)
    --                 if self.tabIndex ~= rankType then
    --                     return
    --                 end
    --             end, k * 0.1)
    --         end
    --     end
    -- else
        for k, v in pairs(data) do
            self:refreshCell(k, v, rankType)
        end
    --end
end

function DRank:refreshPetList(data, begin, endPos)
    for k, v in pairs(data) do
        self:refreshPetCell(k, v)
    end
end

function DRank:refreshEquipList(data, begin, endPos)
    for k, v in pairs(data) do
        self:refreshEquipCell(k, v)
    end
end

function DRank:refreshCell(index, data, rankType)
    local set = self:getSetv1(index)
    set[1]:setVisible(true)
    set[1]:setScale(1)
    --set[1]:setMaxMove(10)
    if index % 2 == 1 then
        set['normal_bg']:setResid('PHB_LB_bg2.png')

    else
        set['normal_bg']:setResid('')
        set['pressed_bg']:setResid('')
    end

    if index < 4 then
        set['rankIcon']:setResid(string.format('PHB_PM%d.png', index))
        set['rankIcon']:setVisible(true)
    else
        set['rankLabel']:setString(data.Rank)--(false)
        set['rankIcon']:setVisible(false)
    end

    set['name']:setString(data.Name)

    if rankType == 4 then
        local DBTitle = DBManager.getInfoTitleConfig(data.TitleId)
        set['power']:setString(tostring(data.Stars))
        set['level']:setString(tostring(DBTitle.Name))
    elseif rankType == 2 then
        set['power']:setString(tostring(data.Lv))
        set['level']:setString(tostring(data.Pwr))
    elseif rankType == 1 then
        set['power']:setString(tostring(data.Pwr))
        set['level']:setString(tostring(data.Lv))
    elseif rankType == 3 then
        set['power']:setString(tostring(data.Lv))
        set['level']:setString(tostring(data.PetIdCnt))
    end

    set[1]:setListener(function()
        self:cellClicked(data.Rid, data.Name, index)
        print('msg:----------------------data.Rid:  '..tostring(data.Rid))
    end)

    -- if index == 1 then
    --     set[1]:trigger(nil)
    -- end
end

function DRank:cellClicked(userID, name, index)
    for k, v in pairs(self.ranks.TempTeams) do
        if userID == v.Rid then
            return self:refreshArmy(userID, name, v, index)
        end
    end
    
    -- get data by call net
    self:send(NetModel.getTempTeamInfo(userID), function (netdata)
    --Launcher.callNet(NetModel.getTempTeamInfo(userID),function (netdata)
        print('msg:-------------------userID: '..tostring(userID))
        table.insert(self.ranks.TempTeams, netdata.D.TempTeam)
        --return data.D.TempTeam
        return self:refreshArmy(userID, name, netdata.D.TempTeam, index)
    end)
end

function DRank:refreshPetCell(index, data)
    local set = self:getSetv2(index)
    set[1]:setEnabled(false)
    set['normal_pet2']:setEnabled(false)
    if index < 4 then
        set['normal_rankIcon']:setVisible(true)
        set['normal_rankLabel']:setVisible(false)
        set['normal_rankIcon']:setResid(string.format('PHB_PM%d.png', index))
    else
        set['normal_rankIcon']:setVisible(false)
        set['normal_rankLabel']:setVisible(true)
        set['normal_rankLabel']:setString(tostring(index))
    end

    local DBPet = DBManager.getCharactor(data.RankPetId)
    local pet = AppData.getPetInfo().getPetInfoByPetId(data.RankPetId , data.RankPetAwk)
    set['normal_pet1_normal_elf_frame']:setResid(Res.getPetIconFrame(pet))
    set['normal_pet1_normal_elf_icon']:setResid(Res.getPetIcon(data.RankPetId))
    -- show pet detail
    set['normal_pet1']:setListener(function()
        GleeCore:showLayer("DPetDetailV",{PetInfo = pet})
    end)

    set['normal_name']:setString(data.RankPetName)
    set['normal_quality_value']:setString(DBPet.quality)
    set['normal_level_value']:setString(data.RankPetLv)
    set['normal_owner_value']:setString(data.Name)

    set['normal_pet2_normal_icon']:setResid(Res.getPetIcon(data.PetId))
end

function DRank:refreshEquipCell(index, data)
    local set = self:getSetv2(index)
    set[1]:setEnabled(false)
    set['normal_pet2']:setEnabled(false)
    if index < 4 then
        set['normal_rankIcon']:setVisible(true)
        set['normal_rankLabel']:setVisible(false)
        set['normal_rankIcon']:setResid(string.format('PHB_PM%d.png', index))
    else
        set['normal_rankIcon']:setVisible(false)
        set['normal_rankLabel']:setVisible(true)
        set['normal_rankLabel']:setString(tostring(index))
    end

    local DBEquip = DBManager.getInfoEquipment(data.EquipId)
    set['normal_equip1_normal_elf_frame']:setResid(Res.getEquipIconFrame(DBEquip))
    set['normal_equip1_normal_elf_icon']:setResid(Res.getEquipIcon(data.EquipId))
    -- show pet detail
    set['normal_equip1']:setListener(function()
        GleeCore:showLayer("DEquipDetail",{nEquip = AppData.getEquipInfo().getEquipInfoByEquipmentID(data.EquipId)})
    end)

    set['normal_name']:setString(data.RankPetName)
    set['normal_quality_value']:setString(DBPet.quality)
    set['normal_level_value']:setString(data.RankPetLv)
    set['normal_owner_value']:setString(data.Name)

    set['normal_pet2_normal_icon']:setResid(Res.getPetIcon(data.PetId))
end

-- Rid Int 玩家 ID
-- Pets Dictionary<int,int> 精灵 ID，觉醒阶数
-- function DRank:getArmyData(userID)
    
-- end

function DRank:refreshArmy(userID, name, data, index)
    --local data = self:getArmyData(userID)
    if not data then return end
    --self._root_page1_BG_describe:setString(string.format(Res.locString('DRank$_X_ARMY'), name))
    for i = 1, 5 do
        if i > #data.Pets then
            self[string.format('_root_page1_BG_layout_pet%d', i)]:setVisible(false)
        else
            self[string.format('_root_page1_BG_layout_pet%d', i)]:setVisible(true)
            self[string.format('_root_page1_BG_layout_pet%d', i)]:setListener(function()
                -- jump to team view  getTeamDetailsInfo
                self:send(NetModel.getTeamDetailsInfo(userID), function (netdata)
                    local param = {}
                    param.Team = netdata.D.Team
                    param.Pets = netdata.D.Pets--{unpack(pets)}
                    param.Equips = netdata.D.Equipments
                    param.Mibaos = netdata.D.Mibaos
                    param.Gems = netdata.D.Gems
                    param.Partners = netdata.D.Partners
                    param.Lv = netdata.D.Lv
                    param.Runes = netdata.D.Runes
                    for k, v in ipairs(netdata.D.PartnerPets) do
                        table.insert(param.Pets, v)
                    end
                    param.CloseFunc = function ( ... )
                        require "framework.sync.TimerHelper".tick(function ( ... )
                            historyData = self.ranks
                            historyData.tabIndex = self.tabIndex
                            historyData.preCellIndex = index
                            GleeCore:showLayer("DRank")--{tabIndex = self.tabIndex, preCellUserID = userID})
                            return true
                        end)
                    end
                    GleeCore:closeAllLayers()
                    GleeCore:pushController("CTeam",param, nil, Res.getTransitionFade())
                end)
            end)
            local pet = AppData.getPetInfo().getPetInfoByPetId(data.Pets[i].PetId , data.Pets[i].Awake)
            self[string.format('_root_page1_BG_layout_pet%d_normal_elf_frame', i)]:setResid(Res.getPetIconFrame(pet))
            self[string.format('_root_page1_BG_layout_pet%d_normal_elf_icon', i)]:setResid(Res.getPetIcon(data.Pets[i].PetId))
            require 'PetNodeHelper'.updateStarLayout(self[string.format('_root_page1_BG_layout_pet%d_normal_starLayout', i)], DBManager.getCharactor(data.Pets[i].PetId))
        end
    end
end

--------------------------------guild rank-------------------------------start

function DRank:getSetv4(index)
    if not self.setsv4 then
        self.setsv4 = {}
    end

    if not self.setsv4[index] then
        local set = self:createLuaSet('@itemRank')
        table.insert(self.setsv4, set)
        self._root_page3_bg_list:getContainer():addChild(set[1])
    end

    return self.setsv4[index]
end

function DRank:callGuildRankData( ... )
    -- body
    
end

function DRank:updateDialog3()
    local refresh = function(data)
        if data and data.D and data.D.Guilds and next(data.D.Guilds) then
            self._root_page3_bg_none:setVisible(false)
        --            Guild Guild 公会信息
        -- Top Int 排行
        -- Name String 会长名称
        -- Guilds List<GuildDetail> Top30
            local ranks = data.D.Guilds --guildinfo.getRanks().Guilds
            --local list = self._viewSet['bg_list']
            --list:stopAllActions()
            --list:getContainer():removeAllChildrenWithCleanup(true)
            for i, v in ipairs(ranks) do
                local set = self:getSetv4(i) --self:createLuaSet('@itemRank')
                --list:getContainer():addChild(set[1])  
                if i < 10 then
                  self:refreshGuildRank(set,v,i)
                else
                  self:runWithDelay(function ( ... )
                    self:refreshGuildRank(set, v, i)
                  end,(i-10)*0.1)
                end
            end
            for i = #ranks + 1, #self.setsv4 do
                self.setsv4[i][1]:setScale(0)
            end

            --list:layout()
            self:refreshSelfRank(data.D)
        else
            self._root_page3_bg_none:setVisible(true)
            self._root_page3_bottom_none:setVisible(true)
        end
    end
    if self.guildRankData == nil then
        self:send(NetModel.getModelGuildGetRanks(), function(data)
            --print('msg:----------------')
            --print(data)
            --data.D.Guilds = {}
            self.guildRankData = data
            refresh(data)
        end)
    else
        refresh(self.guildRankData)
    end
    --local guildinfo = AppData.getGuildInfo()
end

function DRank:refreshGuildRank(set, v, i)
    set[1]:setScale(1)
    set['bg']:setVisible(i % 2 ~= 0)
    if i <= 3 then
        set['icon']:setResid(string.format('paiming_tubiao%d.png',i))
    end
    set['rank']:setString(string.format('NO.%d',i))
    Toolkit.setClubIcon(set['name_icon'],v.Pic)  
    set['name_text']:setString(tostring(v.Title))
    set['power']:setString(tostring(v.Power))
    set['leader']:setString(tostring(v.Name))

    local lvcfg = DBManager.getGuildlv(v.Lv)
    set['member']:setString(string.format('%s/%s',tostring(v.Number),tostring(lvcfg.number)))
end
-- self._root_page3_bottom = set:getElfNode("root_page3_bottom")
-- self._root_page3_bottom_none = set:getLabelNode("root_page3_bottom_none")
-- self._root_page3_bottom_rank = set:getLabelNode("root_page3_bottom_rank")
-- self._root_page3_bottom_icon = set:getElfNode("root_page3_bottom_icon")
-- self._root_page3_bottom_name = set:getLinearLayoutNode("root_page3_bottom_name")
-- self._root_page3_bottom_name_icon = set:getElfNode("root_page3_bottom_name_icon")
-- self._root_page3_bottom_name_text = set:getLabelNode("root_page3_bottom_name_text")
-- self._root_page3_bottom_leader = set:getLabelNode("root_page3_bottom_leader")
-- self._root_page3_bottom_member = set:getLabelNode("root_page3_bottom_member")
-- self._root_page3_bottom_power = set:getLabelNode("root_page3_bottom_power")
function DRank:refreshSelfRank(guildinfo)
    local rank = guildinfo.Top
    local pname = guildinfo.Name
    local guild = guildinfo.Guild
    if guild == nil then
        self._root_page3_bottom_none:setVisible(true)
        return
    else
        self._root_page3_bottom_none:setVisible(false)
    end

    if rank <= 3 then
    self._root_page3_bottom_icon:setResid(string.format('paiming_tubiao%d.png', rank))
    end
    self._root_page3_bottom_rank:setString(string.format('NO.%d', rank))
    Toolkit.setClubIcon(self._root_page3_bottom_name_icon, guild.Pic)
    self._root_page3_bottom_name_text:setString(tostring(guild.Title))
    self._root_page3_bottom_power:setString(tostring(guild.Power))
    self._root_page3_bottom_leader:setString(tostring(pname))

    local lvcfg = DBManager.getGuildlv(guild.Lv)
    local memcnt = string.format('%s/%s',tostring(guild.Number),tostring(lvcfg.number))
    self._root_page3_bottom_member:setString(memcnt)
end

--------------------------------guild rank-------------------------------end

--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DRank, "DRank")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DRank", DRank)



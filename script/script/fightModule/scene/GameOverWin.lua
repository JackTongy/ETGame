local config            = require "Config"
local ServerController  = require 'ServerController'
local ActionView        = require 'ActionView'
local RoleSelfManager   = require 'RoleSelfManager'
local FightSettings     = require 'FightSettings'
local SkinManager       = require 'SkinManager'
local BloodView         = require 'BloodView'
local EventCenter       = require 'EventCenter'
local Swf               = require 'framework.swf.Swf'
local SwfActionFactory  = require 'framework.swf.SwfActionFactory'
local XmlCache          = require 'XmlCache'
local TimerHelper       = require 'framework.sync.TimerHelper'
local Res               = require 'Res'
local CfgHelper         = require 'CfgHelper'
local FightEvent        = require 'FightEvent'
local AppData           = require 'AppData'
local DBManager         = require 'DBManager'

local _table = {}
_table.array = {}

--35, 41, 47
----- depth = 20 -----
--战斗绿色按钮1
_table.array[1] = {
  [1] = { f = 1, p = {-202.95, -44.00},  s = {4.13, 4.13}, a = 0,  v = true },
  [2] = { f = 2, p = {-202.95, -43.95},  s = {3.51, 3.51}, a = 51 },
  [3] = { f = 3, s = {2.88, 2.88}, a = 102 },
  [4] = { f = 4, s = {2.25, 2.25}, a = 154 },
  [5] = { f = 5, p = {-202.95, -44.00},  s = {1.63, 1.63}, a = 205 },
  [6] = { f = 6, p = {-202.95, -44.00},  s = {1.00, 1.00}, a = 255},
  [7] = { f = 7, p = {-204.40, -44.60},  s = {1.06, 1.06} },
  [8] = { f = 8, p = {-205.85, -45.20},  s = {1.13, 1.13} },
  [9] = { f = 9, p = {-204.40, -44.65},  s = {1.06, 1.06} },
  [10] = { f = 10,  p = {-202.95, -44.00} },
}

-------
--文字爆炸
_table.array[2] = {
  [1] = { f = 1,  p = {-202.95, -44.00}, i = 'energy_explode_1.png',  v = true },
  [2] = { f = 2,  i = 'energy_explode_2.png',},
  [3] = { f = 3,  i = 'energy_explode_3.png',},
  [4] = { f = 4,  i = 'energy_explode_4.png',},
  [5] = { f = 5,  i = 'energy_explode_5.png',},
  [6] = { f = 6,  i = 'energy_explode_6.png',},
  [7] = { f = 7,  i = 'energy_explode_7.png',},
  [8] = { f = 8,  i = 'energy_explode_8.png',},
  [9] = { f = 9,  i = 'energy_explode_9.png',},
  [10] = { f = 10,  i = 'energy_explode_10.png',},
  [11] = { f = 11,  i = 'energy_explode_11.png',},
  [12] = { f = 12,  i = 'energy_explode_12.png',},
  [13] = { f = 13,  i = 'energy_explode_13.png',},
  [14] = { f = 14,  i = 'energy_explode_14.png',},
  [15] = { f = 15,  i = 'energy_explode_15.png',},
  [16] = { f = 16,  i = 'energy_explode_16.png',},
  [17] = { f = 17,  i = 'energy_explode_17.png',},
  [18] = { f = 18,  i = 'energy_explode_18.png',},
  [19] = { f = 19,  i = 'energy_explode_19.png',},
  [20] = { f = 20,  i = 'energy_explode_20.png',},
  [21] = { f = 21,  v = false,},
}

----- depth = 27 -----
--战斗绿色按钮2
_table.array[3] = {
  [1] = { f = 1, p = {0.90, -44.00}, s = {4.13, 4.13}, a = 0,  v = true },
  [2] = { f = 2, p = {0.95, -44.05}, s = {3.50, 3.50}, a = 51 },
  [3] = { f = 3, s = {2.88, 2.88}, a = 102 },
  [4] = { f = 4, p = {0.95, -44.00}, s = {2.25, 2.25}, a = 154 },
  [5] = { f = 5, p = {0.95, -44.05}, s = {1.63, 1.63}, a = 205 },
  [6] = { f = 6, p = {0.90, -44.00}, s = {1.00, 1.00}, a = 255},
  [7] = { f = 7, p = {0.20, -44.30}, s = {1.06, 1.06} },
  [8] = { f = 8, p = {-0.50, -44.60},  s = {1.11, 1.11} },
  [9] = { f = 9, p = {0.15, -44.30}, s = {1.06, 1.06} },
  [10] = { f = 10,  p = {0.90, -44.00} },
}

-------
--文字爆炸
_table.array[4] = {
  [1] = { f = 1,  p = {0.90, -44.00}, i = 'energy_explode_1.png',  v = true },
  [2] = { f = 2,  i = 'energy_explode_2.png',},
  [3] = { f = 3,  i = 'energy_explode_3.png',},
  [4] = { f = 4,  i = 'energy_explode_4.png',},
  [5] = { f = 5,  i = 'energy_explode_5.png',},
  [6] = { f = 6,  i = 'energy_explode_6.png',},
  [7] = { f = 7,  i = 'energy_explode_7.png',},
  [8] = { f = 8,  i = 'energy_explode_8.png',},
  [9] = { f = 9,  i = 'energy_explode_9.png',},
  [10] = { f = 10,  i = 'energy_explode_10.png',},
  [11] = { f = 11,  i = 'energy_explode_11.png',},
  [12] = { f = 12,  i = 'energy_explode_12.png',},
  [13] = { f = 13,  i = 'energy_explode_13.png',},
  [14] = { f = 14,  i = 'energy_explode_14.png',},
  [15] = { f = 15,  i = 'energy_explode_15.png',},
  [16] = { f = 16,  i = 'energy_explode_16.png',},
  [17] = { f = 17,  i = 'energy_explode_17.png',},
  [18] = { f = 18,  i = 'energy_explode_18.png',},
  [19] = { f = 19,  i = 'energy_explode_19.png',},
  [20] = { f = 20,  i = 'energy_explode_20.png',},
  [21] = { f = 21,  v = false,},
}

----- depth = 34 -----
--战斗绿色按钮3
_table.array[5] = {
  [1] = { f = 1, p = {204.95, -44.05}, s = {4.10, 4.10}, a = 0,  v = true },
  [2] = { f = 2, p = {204.95, -44.00}, s = {3.48, 3.48}, a = 51 },
  [3] = { f = 3, p = {205.00, -44.00}, s = {2.86, 2.86}, a = 102 },
  [4] = { f = 4, p = {204.95, -44.05}, s = {2.24, 2.24}, a = 154 },
  [5] = { f = 5, s = {1.62, 1.62}, a = 205 },
  [6] = { f = 6, p = {204.95, -44.05}, s = {1.00, 1.00}, a = 255},
  [7] = { f = 7, p = {203.95, -44.50}, s = {1.06, 1.06} },
  [8] = { f = 8, p = {202.90, -44.90}, s = {1.11, 1.11} },
  [9] = { f = 9, p = {203.95, -44.55}, s = {1.06, 1.06} },
  [10] = { f = 10,  p = {204.95, -44.05} },
}

-------
--文字爆炸
_table.array[6] = {
  [1] = { f = 1,  p = {204.95, -44.05}, i = 'energy_explode_1.png',  v = true },
  [2] = { f = 2,  i = 'energy_explode_2.png',},
  [3] = { f = 3,  i = 'energy_explode_3.png',},
  [4] = { f = 4,  i = 'energy_explode_4.png',},
  [5] = { f = 5,  i = 'energy_explode_5.png',},
  [6] = { f = 6,  i = 'energy_explode_6.png',},
  [7] = { f = 7,  i = 'energy_explode_7.png',},
  [8] = { f = 8,  i = 'energy_explode_8.png',},
  [9] = { f = 9,  i = 'energy_explode_9.png',},
  [10] = { f = 10,  i = 'energy_explode_10.png',},
  [11] = { f = 11,  i = 'energy_explode_11.png',},
  [12] = { f = 12,  i = 'energy_explode_12.png',},
  [13] = { f = 13,  i = 'energy_explode_13.png',},
  [14] = { f = 14,  i = 'energy_explode_14.png',},
  [15] = { f = 15,  i = 'energy_explode_15.png',},
  [16] = { f = 16,  i = 'energy_explode_16.png',},
  [17] = { f = 17,  i = 'energy_explode_17.png',},
  [18] = { f = 18,  i = 'energy_explode_18.png',},
  [19] = { f = 19,  i = 'energy_explode_19.png',},
  [20] = { f = 20,  i = 'energy_explode_20.png',},
  [21] = { f = 21,  v = false,},
}


local PopUpActionData = {
   [1] = { f = 11, p = {0, -213.65},  a = 0,   v = true },
   [2] = { f = 12, p = {0, -199.40},  a = 64 },
   [3] = { f = 13, p = {0, -185.15},  a = 128 },
   [4] = { f = 14, p = {0, -170.90},  a = 192 },
   [5] = { f = 15, p = {0, -156.65},  a = 255 },
   [6] = { f = 16, p = {0, -156.15},  s = {1.03, 1.03} },
   [7] = { f = 17, p = {0, -155.65},  s = {1.05, 1.05} },
   [8] = { f = 18, p = {0, -155.15},  s = {1.08, 1.08} },
   [9] = { f = 19, p = {0, -154.65},  s = {1.10, 1.10} },
   [10] = { f = 20, p = {0, -154.15},  s = {1.13, 1.13} },
   [11] = { f = 21, p = {0, -153.65},  s = {1.15, 1.15} },
   [12] = { f = 22, p = {0, -153.15},  s = {1.18, 1.18} },
   [13] = { f = 23, p = {0, -152.65},  s = {1.20, 1.20} },
   [14] = { f = 24, p = {0, -152.15},  s = {1.23, 1.23} },
   [15] = { f = 25, p = {0, -151.65},  s = {1.25, 1.25} },
   [16] = { f = 26, p = {0, -144.75},  s = {1.17, 1.17} },
   [17] = { f = 27, p = {0, -137.90},  s = {1.08, 1.08} },
   [18] = { f = 28, p = {0, -131.00}, s = {1, 1} },
   [19] = { f = 29, p = {0, -131.25} },
   [20] = { f = 30, p = {0, -131.50} },
   [21] = { f = 31, p = {0, -131.75} },
   [22] = { f = 32, p = {0, -132.00} },
}

for i,v in ipairs(PopUpActionData) do
   v.p[2] = v.p[2] + (-45 + 213.65)
end

local GameOverWin = class(LuaController)

function GameOverWin:createDocument()
    self._factory:setZipFilePath(config.COCOS_ZIP_DIR.."GameOverWin.cocos.zip")
    return self._factory:createDocument("GameOverWin.cocos")
end

--@@@@[[[[
function GameOverWin:onInitXML()
    local set = self._set
   self._bg = set:getElfNode("bg")
   self._bg_pic1 = set:getElfNode("bg_pic1")
   self._bg_pic2 = set:getElfNode("bg_pic2")
   self._layer = set:getElfNode("layer")
   self._layer_shade = set:getRectangleNode("layer_shade")
   self._title = set:getElfNode("title")
   self._title_bg = set:getElfNode("title_bg")
   self._title_light = set:getElfNode("title_light")
   self._title_explode = set:getElfNode("title_explode")
   self._title_zdsl = set:getElfNode("title_zdsl")
   self._dialog = set:getElfNode("dialog")
   self._dialog_gray = set:getElfNode("dialog_gray")
   self._dialog_titleL = set:getLabelNode("dialog_titleL")
   self._dialog_expR = set:getLabelNode("dialog_expR")
   self._dialog_progress = set:getProgressNode("dialog_progress")
   self._dialog_expM = set:getLabelNode("dialog_expM")
   self._dialog_levelUp = set:getElfNode("dialog_levelUp")
   self._dialog_condition1_gray = set:getElfGrayNode("dialog_condition1_gray")
   self._dialog_condition2_gray = set:getElfGrayNode("dialog_condition2_gray")
   self._dialog_condition3_gray = set:getElfGrayNode("dialog_condition3_gray")
   self._dialog_explode1 = set:getElfNode("dialog_explode1")
   self._dialog_explode2 = set:getElfNode("dialog_explode2")
   self._dialog_explode3 = set:getElfNode("dialog_explode3")
   self._dialog_condition1 = set:getElfGrayNode("dialog_condition1")
   self._dialog_condition2 = set:getElfGrayNode("dialog_condition2")
   self._dialog_condition3 = set:getElfGrayNode("dialog_condition3")
   self._dialog_getCoins = set:getLabelNode("dialog_getCoins")
   self._dialog_up = set:getLinearLayoutNode("dialog_up")
   self._dialog_up_percent = set:getLabelNode("dialog_up_percent")
   self._heroBar = set:getLayoutNode("heroBar")
   self._bg = set:getElfNode("bg")
   self._icon = set:getElfNode("icon")
   self._kuang = set:getElfNode("kuang")
   self._level = set:getLabelNode("level")
   self._progress = set:getProgressNode("progress")
   self._label = set:getLabelNode("label")
   self._levelUp = set:getElfNode("levelUp")
   self._rewardBar = set:getLayoutNode("rewardBar")
   self._box = set:getElfNode("box")
   self._explode = set:getSimpleAnimateNode("explode")
   self._light = set:getElfNode("light")
   self._icon = set:getElfNode("icon")
   self._box = set:getElfNode("box")
   self._explode = set:getSimpleAnimateNode("explode")
   self._light = set:getElfNode("light")
   self._icon = set:getElfNode("icon")
   self._dialog = set:getElfNode("dialog")
   self._dialog_bg = set:getJoint9Node("dialog_bg")
   self._dialog_powerLimit_arr = set:getElfNode("dialog_powerLimit_arr")
   self._dialog_powerLimit_num2 = set:getLabelNode("dialog_powerLimit_num2")
   self._dialog_powerLimit_num = set:getLabelNode("dialog_powerLimit_num")
   self._dialog_friendLimit_arr = set:getElfNode("dialog_friendLimit_arr")
   self._dialog_friendLimit_num2 = set:getLabelNode("dialog_friendLimit_num2")
   self._dialog_friendLimit_num = set:getLabelNode("dialog_friendLimit_num")
   self._dialog_power_arr = set:getElfNode("dialog_power_arr")
   self._dialog_power_num2 = set:getLabelNode("dialog_power_num2")
   self._dialog_power_num = set:getLabelNode("dialog_power_num")
   self._dialog_level_num2 = set:getLabelNode("dialog_level_num2")
   self._dialog_level_num = set:getLabelNode("dialog_level_num")
   self._line = set:getElfNode("line")
   self._title = set:getElfNode("title")
   self._dialog = set:getElfNode("dialog")
   self._dialog_gray = set:getElfNode("dialog_gray")
   self._dialog_titleL = set:getLabelNode("dialog_titleL")
   self._dialog_expR = set:getLabelNode("dialog_expR")
   self._dialog_progress = set:getProgressNode("dialog_progress")
   self._dialog_expM = set:getLabelNode("dialog_expM")
   self._dialog_condition1_gray = set:getElfGrayNode("dialog_condition1_gray")
   self._dialog_condition2_gray = set:getElfGrayNode("dialog_condition2_gray")
   self._dialog_condition3_gray = set:getElfGrayNode("dialog_condition3_gray")
   self._dialog_explode1 = set:getElfNode("dialog_explode1")
   self._dialog_explode2 = set:getElfNode("dialog_explode2")
   self._dialog_explode3 = set:getElfNode("dialog_explode3")
   self._dialog_condition1 = set:getElfGrayNode("dialog_condition1")
   self._dialog_condition2 = set:getElfGrayNode("dialog_condition2")
   self._dialog_condition3 = set:getElfGrayNode("dialog_condition3")
   self._dialog_up = set:getElfNode("dialog_up")
   self._dialog_up_percent = set:getLabelNode("dialog_up_percent")
   self._dialog_getCoins = set:getLabelNode("dialog_getCoins")
   self._dialog_honorNum = set:getLabelNode("dialog_honorNum")
   self._rewardBar = set:getLayoutNode("rewardBar")
   self._box = set:getElfNode("box")
   self._explode = set:getSimpleAnimateNode("explode")
   self._light = set:getElfNode("light")
   self._icon = set:getElfNode("icon")
   self._box = set:getElfNode("box")
   self._explode = set:getSimpleAnimateNode("explode")
   self._light = set:getElfNode("light")
   self._icon = set:getElfNode("icon")
   self._layer_fake_result = set:getElfNode("layer_fake_result")
   self._layer_fake_result_rewardBar = set:getLayoutNode("layer_fake_result_rewardBar")
   self._box = set:getElfNode("box")
   self._explode = set:getSimpleAnimateNode("explode")
   self._light = set:getElfNode("light")
   self._icon = set:getElfNode("icon")
   self._box = set:getElfNode("box")
   self._explode = set:getSimpleAnimateNode("explode")
   self._light = set:getElfNode("light")
   self._icon = set:getElfNode("icon")
   self._dialog = set:getElfNode("dialog")
   self._dialog_gray = set:getElfNode("dialog_gray")
   self._dialog_titleL = set:getLabelNode("dialog_titleL")
   self._dialog_expR = set:getLabelNode("dialog_expR")
   self._dialog_progress = set:getProgressNode("dialog_progress")
   self._dialog_expM = set:getLabelNode("dialog_expM")
   self._dialog_levelUp = set:getElfNode("dialog_levelUp")
   self._dialog_getCoins = set:getLabelNode("dialog_getCoins")
   self._heroBar = set:getLayoutNode("heroBar")
   self._bg = set:getElfNode("bg")
   self._icon = set:getElfNode("icon")
   self._kuang = set:getElfNode("kuang")
   self._level = set:getLabelNode("level")
   self._progress = set:getProgressNode("progress")
   self._label = set:getLabelNode("label")
   self._levelUp = set:getElfNode("levelUp")
   self._rewardBar = set:getLayoutNode("rewardBar")
   self._box = set:getElfNode("box")
   self._explode = set:getSimpleAnimateNode("explode")
   self._light = set:getElfNode("light")
   self._icon = set:getElfNode("icon")
   self._box = set:getElfNode("box")
   self._explode = set:getSimpleAnimateNode("explode")
   self._light = set:getElfNode("light")
   self._icon = set:getElfNode("icon")
   self._dialog = set:getElfNode("dialog")
   self._dialog_gray = set:getElfNode("dialog_gray")
   self._dialog_titleL = set:getLabelNode("dialog_titleL")
   self._dialog_expR = set:getLabelNode("dialog_expR")
   self._dialog_progress = set:getProgressNode("dialog_progress")
   self._dialog_expM = set:getLabelNode("dialog_expM")
   self._dialog_levelUp = set:getElfNode("dialog_levelUp")
   self._dialog_getCoins = set:getLabelNode("dialog_getCoins")
   self._dialog_stars_s1 = set:getElfNode("dialog_stars_s1")
   self._dialog_stars_s1_b = set:getElfNode("dialog_stars_s1_b")
   self._dialog_stars_s1_f = set:getAddColorNode("dialog_stars_s1_f")
   self._dialog_stars_s3 = set:getElfNode("dialog_stars_s3")
   self._dialog_stars_s3_b = set:getElfNode("dialog_stars_s3_b")
   self._dialog_stars_s3_f = set:getAddColorNode("dialog_stars_s3_f")
   self._dialog_stars_s2 = set:getElfNode("dialog_stars_s2")
   self._dialog_stars_s2_b = set:getElfNode("dialog_stars_s2_b")
   self._dialog_stars_s2_f = set:getAddColorNode("dialog_stars_s2_f")
   self._dialog_details = set:getLabelNode("dialog_details")
   self._heroBar = set:getLayoutNode("heroBar")
   self._bg = set:getElfNode("bg")
   self._icon = set:getElfNode("icon")
   self._kuang = set:getElfNode("kuang")
   self._level = set:getLabelNode("level")
   self._progress = set:getProgressNode("progress")
   self._label = set:getLabelNode("label")
   self._levelUp = set:getElfNode("levelUp")
   self._rewardBar = set:getLayoutNode("rewardBar")
   self._box = set:getElfNode("box")
   self._explode = set:getSimpleAnimateNode("explode")
   self._light = set:getElfNode("light")
   self._icon = set:getElfNode("icon")
   self._box = set:getElfNode("box")
   self._explode = set:getSimpleAnimateNode("explode")
   self._light = set:getElfNode("light")
   self._icon = set:getElfNode("icon")
   self._nextButton = set:getButtonNode("nextButton")
   self._prevLoad = set:getElfNode("prevLoad")
   self._llayout_pic = set:getElfNode("llayout_pic")
   self._llayout_num = set:getLabelNode("llayout_num")
   self._pic = set:getElfNode("pic")
   self._label = set:getLabelNode("label")
   self._llayout_label = set:getLabelNode("llayout_label")
   self._llayout_name = set:getLabelNode("llayout_name")
   self._llayout_label2 = set:getLabelNode("llayout_label2")
   self._llayout_label1 = set:getLabelNode("llayout_label1")
   self._llayout_order = set:getLabelNode("llayout_order")
   self._llayout2_icon = set:getElfNode("llayout2_icon")
   self._llayout2_num = set:getLabelNode("llayout2_num")
   self._llayout2_honor = set:getLabelNode("llayout2_honor")
   self._llayout_name = set:getLabelNode("llayout_name")
   self._llayout2_icon = set:getElfNode("llayout2_icon")
   self._llayout2_num = set:getLabelNode("llayout2_num")
   self._llayout2_honor = set:getLabelNode("llayout2_honor")
   self._llayout_num = set:getLabelNode("llayout_num")
   self._llayout_num = set:getLabelNode("llayout_num")
   self._llayout_num = set:getLabelNode("llayout_num")
   self._llayout_label = set:getLabelNode("llayout_label")
   self._llayout_label1 = set:getLabelNode("llayout_label1")
   self._llayout_gold = set:getLabelNode("llayout_gold")
   self._llayout_num = set:getLabelNode("llayout_num")
   self._llayout_num = set:getLabelNode("llayout_num")
   self._llayout2_label = set:getLabelNode("llayout2_label")
   self._llayout2_icon = set:getElfNode("llayout2_icon")
   self._llayout2_num = set:getLabelNode("llayout2_num")
   self._llayout2_icon1 = set:getElfNode("llayout2_icon1")
   self._llayout2_num1 = set:getLabelNode("llayout2_num1")
   self._stars_s1 = set:getElfNode("stars_s1")
   self._stars_s1_b = set:getElfNode("stars_s1_b")
   self._stars_s1_f = set:getAddColorNode("stars_s1_f")
   self._stars_s3 = set:getElfNode("stars_s3")
   self._stars_s3_b = set:getElfNode("stars_s3_b")
   self._stars_s3_f = set:getAddColorNode("stars_s3_f")
   self._stars_s2 = set:getElfNode("stars_s2")
   self._stars_s2_b = set:getElfNode("stars_s2_b")
   self._stars_s2_f = set:getAddColorNode("stars_s2_f")
   self._details = set:getLabelNode("details")
   self._llayout = set:getLinearLayoutNode("llayout")
   self._llayout_name = set:getLabelNode("llayout_name")
   self._llayout2_des = set:getLabelNode("llayout2_des")
   self._llayout = set:getLinearLayoutNode("llayout")
   self._llayout_name = set:getLabelNode("llayout_name")
   self._llayout2_label = set:getLabelNode("llayout2_label")
   self._llayout2_icon = set:getElfNode("llayout2_icon")
   self._llayout2_des = set:getLabelNode("llayout2_des")
   self._label = set:getLabelNode("label")
   self._llayout = set:getLinearLayoutNode("llayout")
   self._label = set:getLabelNode("label")
   self._llayout = set:getLinearLayoutNode("llayout")
   self._dialog = set:getElfNode("dialog")
   self._dialog_getCoins = set:getLabelNode("dialog_getCoins")
   self._dialog_details = set:getLabelNode("dialog_details")
   self._llayout_harm = set:getLabelNode("llayout_harm")
   self._ActionLight = set:getElfAction("ActionLight")
   self._ActionFadeIn = set:getElfAction("ActionFadeIn")
   self._ActionLeftIn = set:getElfAction("ActionLeftIn")
   self._ActionRightIn = set:getElfAction("ActionRightIn")
   self._ActionScaleOut = set:getElfAction("ActionScaleOut")
   self._ActionRewardLight = set:getElfAction("ActionRewardLight")
--   self._<FULL_NAME1> = set:getElfNode("@winDialog")
--   self._<FULL_NAME1> = set:getElfNode("@result")
--   self._<FULL_NAME1> = set:getElfNode("@hero")
--   self._<FULL_NAME1> = set:getElfNode("@rewardToolItem")
--   self._<FULL_NAME1> = set:getElfNode("@rewardPetItem")
--   self._<FULL_NAME1> = set:getElfNode("@playerPromote")
--   self._<FULL_NAME1> = set:getElfNode("@championResult")
--   self._<FULL_NAME1> = set:getElfNode("@rewardToolItem")
--   self._<FULL_NAME1> = set:getElfNode("@rewardPetItem")
--   self._<FULL_NAME1> = set:getElfNode("@rewardToolItem")
--   self._<FULL_NAME1> = set:getElfNode("@rewardPetItem")
--   self._<FULL_NAME1> = set:getElfNode("@newResult")
--   self._<FULL_NAME1> = set:getElfNode("@hero")
--   self._<FULL_NAME1> = set:getElfNode("@rewardToolItem")
--   self._<FULL_NAME1> = set:getElfNode("@rewardPetItem")
--   self._<FULL_NAME1> = set:getElfNode("@newResultWithStars")
--   self._<FULL_NAME1> = set:getElfNode("@hero")
--   self._<FULL_NAME1> = set:getElfNode("@rewardToolItem")
--   self._<FULL_NAME1> = set:getElfNode("@rewardPetItem")
--   self._<FULL_NAME1> = set:getLabelNode("@tip")
--   self._<FULL_NAME1> = set:getElfNode("@GldReward")
--   self._<FULL_NAME1> = set:getElfNode("@EqmReward")
--   self._<FULL_NAME1> = set:getElfNode("@item")
--   self._<FULL_NAME1> = set:getElfNode("@DmdReward")
--   self._<FULL_NAME1> = set:getElfNode("@MatReward")
--   self._<FULL_NAME1> = set:getElfNode("@ArenaReward")
--   self._<FULL_NAME1> = set:getElfNode("@LeagueReward")
--   self._<FULL_NAME1> = set:getElfNode("@CMReward")
--   self._<FULL_NAME1> = set:getElfNode("@SDNReward")
--   self._<FULL_NAME1> = set:getElfNode("@BossReward")
--   self._<FULL_NAME1> = set:getElfNode("@ThiefReward")
--   self._<FULL_NAME1> = set:getElfNode("@CatReward")
--   self._<FULL_NAME1> = set:getElfNode("@TrainReward")
--   self._<FULL_NAME1> = set:getElfNode("@StarLv")
--   self._<FULL_NAME1> = set:getElfNode("@GuildMatchReward")
--   self._<FULL_NAME1> = set:getElfNode("@GuildBossReward")
--   self._<FULL_NAME1> = set:getElfNode("@GuildFubenReward")
--   self._<FULL_NAME1> = set:getElfNode("@RemainsReward")
--   self._<FULL_NAME1> = set:getElfNode("@tc_npc")
--   self._<FULL_NAME1> = set:getElfNode("@tc_boss")
end
--@@@@]]]]

--------------------------------override functions----------------------
--[[
1 close, 8 open
1 explode

--]]
local ScaleDataRate = 0.6
local ScaleData= {
    [1] = { f = 1, v = false},
    [2] = { f = 7,  s = {ScaleDataRate*1.00/2.58, ScaleDataRate*1.00/2.58},   a = 0, v = true },
    [3] = { f = 8,  s = {ScaleDataRate*1.63/2.58, ScaleDataRate*1.63/2.58},   a = 92 },
    [4] = { f = 9,  s = {ScaleDataRate*2.12/2.58, ScaleDataRate*2.12/2.58},   a = 164 },
    [5] = { f = 10, s = {ScaleDataRate*2.47/2.58, ScaleDataRate*2.47/2.58},   a = 215 },
    [6] = { f = 11, s = {ScaleDataRate*2.69/2.58, ScaleDataRate*2.69/2.58},   a = 246 },
    [7] = { f = 12, s = {ScaleDataRate*2.76/2.58, ScaleDataRate*2.76/2.58},   a = 255 },
    [8] = { f = 13, s = {ScaleDataRate*2.58/2.58, ScaleDataRate*2.58/2.58},    },
}

local RewardBoxBGData = {
    [1] = { f = 1,  i = 'N_ZD_diaoluo_baoxiang1.png', v = true },
    [1] = { f = 8,  i = 'N_ZD_diaoluo_baoxiang2.png'},
}

local RewardBallBGData = {
    [1] = { f = 1,  i = 'N_ZD_diaoluo_qiu.png', v = true },
    [1] = { f = 8,  i = 'N_ZD_diaoluo_qiu2.png'},
}

function GameOverWin:onInit( userData, netData )

    GleeCore:closeAllLayers()
    FightSettings.resume()

    self._callback = userData and userData.callback
  	print('GameOverWin')
  	print(userData)

    self:initBg()

    self:initWinDialog()

    self:runWithDelay(function ()
        -- body
        self:initChampion(userData)
    end, 0.8)
    
    self:initTest(userData)
    self:initFuBen(userData)
    self:initFuBenBoss(userData)
    self:initForFubenThief(userData)

    -- self:initForFubenCat(userData)
    -- self:initChampion(userData)
    
    self:initBossBattle(userData)
    
    self:initCMBossBattle(userData)
    self:initSDNBossBattle(userData)

    -- 活动副本
    self:initActRaid(userData)
    self:initArena(userData)

    self:initLeague(userData)

    --无尽试练
    self:initTrain(userData)

    self:initGuildMatch(userData)
    self:initGuildBoss(userData)
    self:initGuildFuben(userData)
    self:initLimitFuben(userData)
    self:initGuildFubenRob(userData)
    self:initGuildFubenRevenge(userData)
    self:initRemainsFuben(userData)
    self:initFriend(userData)
end

function GameOverWin:initBg()
    -- body
    local resid1, resid2 = require 'BattleBgManager'.getLastBgResid()
    self._bg_pic1:setResid(resid1)
    self._bg_pic2:setResid(resid2)
    
    CCDirector:sharedDirector():getScheduler():setTimeScale( 1 )
end

function GameOverWin:doNext()
    -- body
    self._autoTimeProgress = 0

    local func = self._todoList[1]
    if func then
        table.remove(self._todoList, 1)
        func()
    end
end

function GameOverWin:initToDoList(todoList)
	-- body
    require 'framework.helper.MusicHelper'.playEffect( require 'Res'.Sound.bt_win )
    require 'framework.helper.MusicHelper'.stopBackgroundMusic()

	self._todoList = todoList

	local finnalFunc
    finnalFunc = function ()
        -- body
        CCDirector:sharedDirector():getScheduler():setTimeScale( 1 )

        GleeCore:popController()
        FightSettings.unLock()

        -- require 'framework.helper.MusicHelper'.setBackgroundMusicVolume(1)
    end

    table.insert(todoList, finnalFunc)

    -- 
    self:runWithDelay(function ()
        -- body
        if self._nextButton then
            self._nextButton:setListener(function ()
               -- body
               self:doNext()
            end)
        end
    end, 1)
    
    assert(not self._updateHandler)

    -- self._updateHandler = TimerHelper.tick(function ( dt )
    --     -- body
    --     if self:isDisposed() then
    --         return true
    --     end

    --     self._autoTimeProgress = (self._autoTimeProgress or 0) + dt
    --     if self._autoTimeProgress > 3 and #self._todoList > 1 then
    --         self:doNext()
    --     end
    -- end)

    if #self._todoList > 1 then
        self:doNext()
    end
end


function GameOverWin:initWinDialog()
	-- body
	local win_luaset = self:createLuaSet('@winDialog')
    win_luaset[1]:setVisible(true)
    self._layer:addChild(win_luaset[1])

    win_luaset['title_bg']:setVisible(false)
    win_luaset['title_light']:setVisible(false)
    win_luaset['title_explode']:setVisible(false)
    win_luaset['title_zdsl']:setVisible(false)

	local nodeMap = {
      [1] = self._layer_shade,
      [2] = win_luaset['title_zdsl'],
      [3] = win_luaset['title_explode'],
      -- [4] = win_luaset['dialog'],
    }

    local swf = Swf.new('Swf_ZhanDouJieSuan', nodeMap)
    swf:play()

    self:runWithDelay(function ()
        -- body
        require 'framework.helper.MusicHelper'.playEffect( require 'Res'.Sound.star )
    end, 0.5)

    win_luaset['title_light']:runAction(self._ActionLight:clone())

    self._win_luaset = win_luaset
end

function GameOverWin:initActRaid( userData )
    -- body
    if userData and userData.mode == 'ActRaid' then

        local todoList = {}
        local resizefunc = function ( set )
          if set and set['llayout_#size#lableget'] then
            local size = set['llayout_#size#lableget']:getContentSize()
            set['llayout_#size']:setContentSize(CCSizeMake(size.width+10,size.height))
          end
        end

        local func 
        func = function ( ... )
            -- body
            local data = userData.data
            local mytype = userData.type
            
            if mytype == 1 then
                ---金币
                local myluaset = self:createLuaSet('@GldReward')
                self._layer:addChild(myluaset[1])
                myluaset[1]:setVisible(true)

                myluaset['llayout_num']:setString(''..data.golds )
                self:addStartLvSet(data.stars)
            elseif mytype == 2 then
                --装备
                local myluaset = self:createLuaSet('@EqmReward')
                self._layer:addChild(myluaset[1])
                myluaset[1]:setVisible(true)
                resizefunc(myluaset)

                for i,equipInfo in ipairs(data.equipments) do

                    local nodeluaseu = self:createLuaSet('@item')
                    myluaset['#llayout']:addChild(nodeluaseu[1])

                    local pic = nodeluaseu['pic']
                    Res.setEquipIconNew( pic,equipInfo, false )
                    local scale = 0.75 * 0.7
                    pic:setScale( scale )

                    nodeluaseu[1]:setWidth( 110*0.75 + 10 )
                    nodeluaseu[1]:setHeight( 110*0.75 )

                    local name = CfgHelper.getCache('equipment', 'equipmentid', equipInfo.EquipmentId, 'name') 
                    nodeluaseu['label']:setString(tostring(name))

                    local colorIndex = CfgHelper.getCache('equipment', 'equipmentid', equipInfo.EquipmentId, 'color') 
                    local color = Res.getMaterialColor(colorIndex)
                    nodeluaseu['label']:setFontFillColor(color, true)
                end

                -- Res.setEquipIconNew( ElfNode:create(),equipInfo,showAdd )
                myluaset['#llayout']:layout()
                self:addStartLvSet(data.stars)
            elseif mytype == 3 then
                --宝石
                local myluaset = self:createLuaSet('@DmdReward')
                self._layer:addChild(myluaset[1])
                myluaset[1]:setVisible(true)

                --[[
                resizefunc(myluaset)
                for i,gem in ipairs(data.gems) do

                    local nodeluaseu = self:createLuaSet('@item')
                    myluaset['#llayout']:addChild(nodeluaseu[1])

                    local pic = nodeluaseu['pic']
                    Res.setGemDetail( pic, gem )
                    local scale = 0.7
                    pic:setScale( scale )
                    
                    local name = CfgHelper.getCache('gem', 'gemid', gem.GemId, 'name') 
                    nodeluaseu['label']:setString(tostring(name)..'Lv'..gem.Lv)

                end
                ]]
                userData.data.Materials = userData.data.materials
                require 'RewardViewHelper'.BattleRewardShow(self,userData.data,myluaset['#llayout'])

                -- Res.setEquipIconNew( ElfNode:create(),equipInfo,showAdd )
                myluaset['#llayout']:layout()
              elseif mytype >= 4 and mytype <= 8 then
                --进化石
                local myluaset = self:createLuaSet('@MatReward')
                self._layer:addChild(myluaset[1])
                myluaset[1]:setVisible(true)
                resizefunc(myluaset)
                self:addStartLvSet(data.stars)
                
                for i,mat in ipairs(data.materials) do

                    local nodeluaseu = self:createLuaSet('@item')
                    myluaset['#llayout']:addChild(nodeluaseu[1])

                    local pic = nodeluaseu['pic']
                    Res.setNodeAndNameWithMaterialNetData( pic, mat, mat.Amount )
                    local scale = 0.7
                    pic:setScale( scale )
                    
                    -- local name = CfgHelper.getCache('gem', 'gemid', gem.GemId, 'name') 
                    -- nodeluaseu['label']:setString(tostring(name)..'Lv'..gem.Lv)

                end
                -- Res.setEquipIconNew( ElfNode:create(),equipInfo,showAdd )
                
            end
        end
        table.insert(todoList, func)

        self:initToDoList(todoList)
        XmlCache.cleanXmlCache('Fight')
    end
end

function GameOverWin:initFuBen( userData )
    -- body
    if userData and userData.mode == 'fuben' then

        local resultSet
        local playerPromoteSet

        local todoList = {}

        resultSet = self:createLuaSet('@newResult')
        resultSet[1]:setVisible(true)
        resultSet[1]:setColorf(1,1,1,0)
        resultSet[1]:runAction(self._ActionFadeIn:clone())
        self._layer:addChild(resultSet[1])

        
        if userData.Result then
            -- self.condition = { 1, 0, 1 }
            -- self.addMoney = 0
            -- self.totalMoney = 0
            -- self.addExp = 0
            -- self.totalExp = 0
            -- self.nextExp = 0 --下一个等级的经验值
            local redoFunc = nil
            do
                local result_luaset = resultSet
                local func
                func = function ()
                    -- body
                    local timeRate = 1
                    local result = userData.Result

                    result_luaset['dialog_expR']:setString('+ '..result.addExp)
                    result_luaset['dialog_expM']:setString(''..result.totalExp..'/'..result.nextExp)

                    --
                    result_luaset['dialog_progress']:setPercentageInTime(100*result.lastExpRate, 0*timeRate)
                    self:runWithDelay(function ()
                        -- body
                        if tolua.isnull(result_luaset[1]) then return end

                        local nextPercent = (100*result.addLv) + 100*result.totalExp/result.nextExp
                        if result.totalExp == 0 then
                            nextPercent = nextPercent + 0.01
                        end
                        
                        if nextPercent > 100 then
                           self:runWithDelay(function ( ... )
                                -- body
                                local swfaction = SwfActionFactory.createAction( PopUpActionData,nil,nil,20/timeRate )
                                result_luaset['dialog_levelUp']:runAction(swfaction)
                            end, 0.4*timeRate)
                        end

                        result_luaset['dialog_progress']:setPercentageInTime( nextPercent , 0.5*timeRate)

                        -- end
                        --经验条音效
                        if timeRate >= 0.9 then
                            require 'framework.helper.MusicHelper'.playEffect( require 'Res'.Sound.bar )
                        end

                    end, (23/20)*timeRate)
            
                    result_luaset['dialog_getCoins']:setString( tostring(  result.addMoney ) )

                    local reward = userData.Result.Reward
                    if reward then
                        -- rewardBar['rewardBar']
                        
                        -- winData.Result.Reward.PetPieces     = netData.D.Result.Reward.PetPieces
                        -- winData.Result.Reward.Pets          = netData.D.Result.Reward.Pets
                        -- winData.Result.Reward.Materials     = netData.D.Result.Reward.Materials
                        -- winData.Result.Reward.Equipments    = netData.D.Result.Reward.Equipments

                        -- fade in out
                        local rewardArr = {}
                        if reward.Materials then
                            print('reward.Materials')
                            for _i, _v in ipairs(reward.Materials) do
                                print(_v)
                                table.insert(rewardArr, { data = _v, type = 'Materials' } )
                            end
                        end
                        if reward.Equipments then
                            print('reward.Equipments')
                            for _i, _v in ipairs(reward.Equipments) do
                                print(_v)
                                table.insert(rewardArr, { data = _v, type = 'Equipments' } )
                            end
                        end
                        if reward.PetPieces then
                            print('reward.PetPieces')
                            for _i, _v in ipairs(reward.PetPieces) do
                                print(_v)
                                table.insert(rewardArr, { data = _v, type = 'PetPieces' } )
                            end
                        end
                        if reward.Pets then
                            print('reward.Pets')
                            for _i, _v in ipairs(reward.Pets) do
                                print(_v)
                                table.insert(rewardArr, { data = _v, type = 'Pets' } )
                            end
                        end

                        local rewardNum = #rewardArr

                        for i,v in ipairs(rewardArr) do
                            -- 
                            self:runWithDelay(function ()
                                local rewardItem
                                if v.type == 'Equipments' then
                                    rewardItem = self:createLuaSet('@rewardToolItem')
                                    Res.setNodeNameWithEquipNetData( rewardItem['icon'], v.data, v.data.Amount )
                                    v.isPet = false
                                elseif v.type == 'Materials' then
                                    rewardItem = self:createLuaSet('@rewardToolItem')
                                    -- setNodeAndNameWithMaterialNetData
                                    -- setNodeWithMaterialNetData
                                    Res.setNodeAndNameWithMaterialNetData( rewardItem['icon'], v.data, v.data.Amount )
                                    v.isPet = false
                                elseif v.type == 'PetPieces' then
                                    rewardItem = self:createLuaSet('@rewardPetItem')
                                    Res.setNodeNameWithPetPieceNetData( rewardItem['icon'], v.data, v.data.Amount )
                                    v.isPet = true
                                elseif v.type == 'Pets' then
                                    rewardItem = self:createLuaSet('@rewardPetItem')
                                    Res.setNodeNameWithPetNetData( rewardItem['icon'], v.data, v.data.Amount )
                                    v.isPet = true
                                end
                                assert(rewardItem)
                                
                                rewardItem['icon']:setVisible(false)
                                v.set = rewardItem
                                rewardItem[1]:setColorf(1,1,1,0)
                                result_luaset['rewardBar']:addChild( rewardItem[1] )

                                self:runWithDelay(function ()
                                    -- body
                                    local fadeIn = CCFadeIn:create(0.5)
                                    rewardItem[1]:runAction(fadeIn)
                                end, (i*10)/20*timeRate)
                               
                            end, (25)/20*timeRate)
                            
                        end
                        
                        -- open rewards
                        self:runWithDelay(function ()
                            -- body
                            for i,v in ipairs(rewardArr) do
                                -- explode
                                v.set['explode']:setVisible(true)
                                -- light
                                v.set['light']:runAction( self._ActionRewardLight:clone() )
                                -- box
                                if v.isPet then
                                    v.set['box']:runAction( SwfActionFactory.createAction( RewardBallBGData ) ) 
                                else
                                    v.set['box']:runAction( SwfActionFactory.createAction( RewardBoxBGData ) ) 
                                end
                                
                                -- icon
                                v.set['icon']:runAction( SwfActionFactory.createAction( ScaleData ) )
                            end
                        end, (25 + rewardNum*10 + 10)/20*timeRate)

                        self:runWithDelay(function ( ... )
                            -- body
                            for i,v in ipairs(todoList) do
                                if v == redoFunc then
                                    table.remove(todoList, i)
                                end
                            end
                        end, (25 + rewardNum*10 + 10)/20*timeRate)

                    end
                end

                -- 正常完成
                table.insert(todoList, function ()
                    -- body
                    func(1)
                end)

                -- 立即完成
                redoFunc = function ()
                    -- body
                    CCDirector:sharedDirector():getScheduler():setTimeScale( 1000 )
                    self:runWithDelay(function ()
                        CCDirector:sharedDirector():getScheduler():setTimeScale( 1 )
                    end, 0)
                end

                table.insert(todoList, redoFunc)
            end
        end

        -- 
        if userData.PlayerPromote then
            local func
            func = function ()
                -- body
                -- if resultSet then
                --     resultSet[1]:removeFromParent()
                --     resultSet = nil
                -- end

                -- if self._win_luaset then
                -- 	self._win_luaset[1]:removeFromParent()
                -- 	self._win_luaset = nil
                -- end

                local playerPromoteVo = userData.PlayerPromote
                playerPromoteSet = self:createLuaSet('@playerPromote')
                playerPromoteSet[1]:setVisible(true)
                self._layer:addChild(playerPromoteSet[1])
                -- self.level = {10, 11}
                -- self.power = {110, 150} --体力
                -- self.powerLimit = { 150, 160 }
                -- self.friendLimit = { 30, 35 }
                playerPromoteSet['dialog_level_num']:setString(''..playerPromoteVo.level[1])
                playerPromoteSet['dialog_level_num2']:setString(''..playerPromoteVo.level[2])

                playerPromoteSet['dialog_power_num']:setString(''..playerPromoteVo.power[1])
                playerPromoteSet['dialog_power_num2']:setString(''..playerPromoteVo.power[2])

                playerPromoteSet['dialog_powerLimit_num']:setString(''..playerPromoteVo.powerLimit[1])
                playerPromoteSet['dialog_powerLimit_num2']:setString(''..playerPromoteVo.powerLimit[2])

                playerPromoteSet['dialog_friendLimit_num']:setString(''..playerPromoteVo.friendLimit[1])
                playerPromoteSet['dialog_friendLimit_num2']:setString(''..playerPromoteVo.friendLimit[2])

                playerPromoteSet['dialog']:runAction(self._ActionScaleOut:clone())
                playerPromoteSet['line']:runAction(self._ActionRightIn:clone())
                playerPromoteSet['title']:runAction(self._ActionLeftIn:clone())

            end

            table.insert(todoList, func)
        end

        self:initToDoList(todoList)
        XmlCache.cleanXmlCache('Fight')
    end
end

function GameOverWin:initFuBenBoss( userData )
    -- body
    if userData and userData.mode == 'fuben_boss' then

        local resultSet
        local playerPromoteSet

        local todoList = {}

        resultSet = self:createLuaSet('@newResultWithStars')
        resultSet[1]:setVisible(true)
        resultSet[1]:setColorf(1,1,1,0)
        resultSet[1]:runAction(self._ActionFadeIn:clone())
        self._layer:addChild(resultSet[1])

        
        if userData.Result then
            -- self.condition = { 1, 0, 1 }
            -- self.addMoney = 0
            -- self.totalMoney = 0
            -- self.addExp = 0
            -- self.totalExp = 0
            -- self.nextExp = 0 --下一个等级的经验值
            local redoFunc = nil
            do
                local result_luaset = resultSet
                local func
                func = function ()
                    -- body
                    -- body
                    local timeRate = 1
                    local result = userData.Result

                    result_luaset['dialog_expR']:setString('+ '..result.addExp)
                    result_luaset['dialog_expM']:setString(''..result.totalExp..'/'..result.nextExp)

                    --
                    result_luaset['dialog_progress']:setPercentageInTime(100*result.lastExpRate, 0*timeRate)
                    self:runWithDelay(function ()
                        -- body
                        if tolua.isnull(result_luaset[1]) then return end

                        local nextPercent = (100*result.addLv) + 100*result.totalExp/result.nextExp
                        if result.totalExp == 0 then
                            nextPercent = nextPercent + 0.01
                        end
                        
                        if nextPercent > 100 then
                           self:runWithDelay(function ( ... )
                                -- body
                                local swfaction = SwfActionFactory.createAction( PopUpActionData,nil,nil,20/timeRate )
                                result_luaset['dialog_levelUp']:runAction(swfaction)
                            end, 0.4*timeRate)
                        end

                        result_luaset['dialog_progress']:setPercentageInTime( nextPercent , 0.5*timeRate)

                        -- end
                        --经验条音效
                        if timeRate >= 0.9 then
                            require 'framework.helper.MusicHelper'.playEffect( require 'Res'.Sound.bar )
                        end

                    end, (23/20)*timeRate)
            
                    result_luaset['dialog_getCoins']:setString( tostring(  result.addMoney ) )

                    -- stars
                    self:runWithDelay(function ()
                        result.stars = result.stars or 3
                        for i=1, result.stars do
                            local action = SwfActionFactory.createAction( require 'Swf_XingXing2'.array[i+1],nil,nil,20/timeRate )
                            local node = result_luaset[string.format('dialog_stars_s%d_f', i)]
                            node:runAction(action)

                            -- action:setListener(function ()
                            --     -- body
                            --     require 'framework.helper.MusicHelper'.playEffect( require 'Res'.Sound.ui_clear_stars )
                            -- end)  
                            if i==1 then
                                require 'framework.helper.MusicHelper'.playEffect( require 'Res'.Sound.ui_clear_stars )
                            elseif i==2 then
                                self:runWithDelay(function ( ... )
                                    -- body
                                    require 'framework.helper.MusicHelper'.playEffect( require 'Res'.Sound.ui_clear_stars )
                                end, 0.2)
                            elseif i==3 then
                                self:runWithDelay(function ( ... )
                                    -- body
                                    require 'framework.helper.MusicHelper'.playEffect( require 'Res'.Sound.ui_clear_stars )
                                end, 0.4)
                            end

                            if i==1 then
                                local details = {
                                [1] = Res.locString('Battle$PetDieMany'),--'(多个精灵阵亡)',
                                [2] = Res.locString('Battle$PetDieOne'),--'(一个精灵阵亡)',
                                [3] = Res.locString('Battle$PetDieNone')--'(没有精灵阵亡)'
                                }
                                result_luaset['dialog_details']:setString(tostring(details[result.stars]))
                            end
                        end



                    end, (35/20)*timeRate)
                    

                    local reward = userData.Result.Reward
                    if reward then
                        -- rewardBar['rewardBar']
                        
                        -- winData.Result.Reward.PetPieces     = netData.D.Result.Reward.PetPieces
                        -- winData.Result.Reward.Pets          = netData.D.Result.Reward.Pets
                        -- winData.Result.Reward.Materials     = netData.D.Result.Reward.Materials
                        -- winData.Result.Reward.Equipments    = netData.D.Result.Reward.Equipments

                        -- fade in out
                        local rewardArr = {}
                        if reward.Materials then
                            print('reward.Materials')
                            for _i, _v in ipairs(reward.Materials) do
                                print(_v)
                                table.insert(rewardArr, { data = _v, type = 'Materials' } )
                            end
                        end
                        if reward.Equipments then
                            print('reward.Equipments')
                            for _i, _v in ipairs(reward.Equipments) do
                                print(_v)
                                table.insert(rewardArr, { data = _v, type = 'Equipments' } )
                            end
                        end
                        if reward.PetPieces then
                            print('reward.PetPieces')
                            for _i, _v in ipairs(reward.PetPieces) do
                                print(_v)
                                table.insert(rewardArr, { data = _v, type = 'PetPieces' } )
                            end
                        end
                        if reward.Pets then
                            print('reward.Pets')
                            for _i, _v in ipairs(reward.Pets) do
                                print(_v)
                                table.insert(rewardArr, { data = _v, type = 'Pets' } )
                            end
                        end

                        local rewardNum = #rewardArr

                        for i,v in ipairs(rewardArr) do
                            -- 
                            self:runWithDelay(function ()
                                local rewardItem
                                if v.type == 'Equipments' then
                                    rewardItem = self:createLuaSet('@rewardToolItem')
                                    Res.setNodeNameWithEquipNetData( rewardItem['icon'], v.data, v.data.Amount )
                                    v.isPet = false
                                elseif v.type == 'Materials' then
                                    rewardItem = self:createLuaSet('@rewardToolItem')
                                    Res.setNodeAndNameWithMaterialNetData( rewardItem['icon'], v.data, v.data.Amount )
                                    v.isPet = false
                                elseif v.type == 'PetPieces' then
                                    rewardItem = self:createLuaSet('@rewardPetItem')
                                    Res.setNodeNameWithPetPieceNetData( rewardItem['icon'], v.data, v.data.Amount )
                                    v.isPet = true
                                elseif v.type == 'Pets' then
                                    rewardItem = self:createLuaSet('@rewardPetItem')
                                    Res.setNodeNameWithPetNetData( rewardItem['icon'], v.data, v.data.Amount )
                                    v.isPet = true
                                end
                                assert(rewardItem)
                                
                                rewardItem['icon']:setVisible(false)
                                v.set = rewardItem
                                rewardItem[1]:setColorf(1,1,1,0)
                                result_luaset['rewardBar']:addChild( rewardItem[1] )

                                self:runWithDelay(function ()
                                    -- body
                                    local fadeIn = CCFadeIn:create(0.5)
                                    rewardItem[1]:runAction(fadeIn)
                                end, (i*10)/20*timeRate)
                               
                            end, (25)/20*timeRate)
                            
                        end
                        
                        -- open rewards
                        self:runWithDelay(function ()
                            -- body
                            for i,v in ipairs(rewardArr) do
                                -- explode
                                v.set['explode']:setVisible(true)
                                -- light
                                v.set['light']:runAction( self._ActionRewardLight:clone() )
                                -- box
                                if v.isPet then
                                    v.set['box']:runAction( SwfActionFactory.createAction( RewardBallBGData ) ) 
                                else
                                    v.set['box']:runAction( SwfActionFactory.createAction( RewardBoxBGData ) ) 
                                end
                                
                                -- icon
                                v.set['icon']:runAction( SwfActionFactory.createAction( ScaleData ) )
                            end


                        end, (25 + rewardNum*10 + 10)/20*timeRate)

                        self:runWithDelay(function ( ... )
                            -- body
                            for i,v in ipairs(todoList) do
                                if v == redoFunc then
                                    table.remove(todoList, i)
                                end
                            end
                        end, (25 + rewardNum*10 + 10)/20*timeRate)

                    end
                end

                -- 正常完成
                table.insert(todoList, function ()
                    -- body
                    func(1)
                end)

                -- 立即完成
                redoFunc = function ()
                    -- body
                    CCDirector:sharedDirector():getScheduler():setTimeScale( 1000 )
                    self:runWithDelay(function ()
                        CCDirector:sharedDirector():getScheduler():setTimeScale( 1 )
                    end, 0)
                end

                self:runWithDelay(function ( ... )
                    -- body
                    for i,v in ipairs(todoList) do
                        if v == redoFunc then
                            table.remove(todoList, i)
                        end
                    end
                end, (55)/20*1)

                table.insert(todoList, redoFunc)
            end
        end

        -- 
        if userData.PlayerPromote then
            local func
            func = function ()
                -- body
                -- if resultSet then
                --     resultSet[1]:removeFromParent()
                --     resultSet = nil
                -- end

                -- if self._win_luaset then
                --  self._win_luaset[1]:removeFromParent()
                --  self._win_luaset = nil
                -- end

                local playerPromoteVo = userData.PlayerPromote
                playerPromoteSet = self:createLuaSet('@playerPromote')
                playerPromoteSet[1]:setVisible(true)
                self._layer:addChild(playerPromoteSet[1])
                -- self.level = {10, 11}
                -- self.power = {110, 150} --体力
                -- self.powerLimit = { 150, 160 }
                -- self.friendLimit = { 30, 35 }
                playerPromoteSet['dialog_level_num']:setString(''..playerPromoteVo.level[1])
                playerPromoteSet['dialog_level_num2']:setString(''..playerPromoteVo.level[2])

                playerPromoteSet['dialog_power_num']:setString(''..playerPromoteVo.power[1])
                playerPromoteSet['dialog_power_num2']:setString(''..playerPromoteVo.power[2])

                playerPromoteSet['dialog_powerLimit_num']:setString(''..playerPromoteVo.powerLimit[1])
                playerPromoteSet['dialog_powerLimit_num2']:setString(''..playerPromoteVo.powerLimit[2])

                playerPromoteSet['dialog_friendLimit_num']:setString(''..playerPromoteVo.friendLimit[1])
                playerPromoteSet['dialog_friendLimit_num2']:setString(''..playerPromoteVo.friendLimit[2])

                playerPromoteSet['dialog']:runAction(self._ActionScaleOut:clone())
                playerPromoteSet['line']:runAction(self._ActionRightIn:clone())
                playerPromoteSet['title']:runAction(self._ActionLeftIn:clone())

            end

            table.insert(todoList, func)
        end

        self:initToDoList(todoList)
        XmlCache.cleanXmlCache('Fight')
    end
end


function GameOverWin:initChampion( userData )
    -- body
    if userData and userData.mode == 'champion' then

        local resultSet
        local playerPromoteSet

        local todoList = {}
        local team = userData.Team
        
        resultSet = self:createLuaSet('@championResult')
        resultSet[1]:setVisible(true)
        self._layer:addChild(resultSet[1])
        
        local vnfunc = function ( ... )
          resultSet['dialog_condition1_gray_#bmfont1']:setFontSize(15)
          resultSet['dialog_condition2_gray_#bmfont2']:setFontSize(15)
          resultSet['dialog_condition3_gray_#bmfont3']:setFontSize(15)
          resultSet['dialog_condition1_#bmfont1']:setFontSize(15)
          resultSet['dialog_condition2_#bmfont2']:setFontSize(15)
          resultSet['dialog_condition3_#bmfont3']:setFontSize(15)
        end

        local espt = function ( ... )
          resultSet['dialog_condition1_gray_#bmfont1']:setFontSize(20)
          resultSet['dialog_condition2_gray_#bmfont2']:setFontSize(20)
          resultSet['dialog_condition3_gray_#bmfont3']:setFontSize(20)
          resultSet['dialog_condition1_#bmfont1']:setFontSize(20)
          resultSet['dialog_condition2_#bmfont2']:setFontSize(20)
          resultSet['dialog_condition3_#bmfont3']:setFontSize(20)
        end

        require 'LangAdapter'.selectLang(nil,nil,nil,nil,nil,espt,espt,nil,nil,vnfunc)
        require 'LangAdapter'.selectLangkv({Indonesia=vnfunc,vn=vnfunc})

        local ccfadein = CCFadeIn:create(0.5)
        resultSet[1]:runAction(ccfadein)

        local result_luaset = resultSet

        assert(userData)
        if userData then
            -- self.condition = { 1, 0, 1 }
            -- self.addMoney = 0
            -- self.totalMoney = 0
            -- self.addExp = 0
            -- self.totalExp = 0
            -- self.nextExp = 0 --下一个等级的经验值
            local func
            func = function ()
                -- body
                local timeRate = 1
                
                local result = userData

                local count = 0
                for i=1, 3 do
                    if result.condition[i] == 1 then 
                        self:runWithDelay(function ()
                            -- body
                            if tolua.isnull(result_luaset[1]) then return end
                            
                            local swfaction1 = SwfActionFactory.createAction(_table.array[(i-1)*2+1])
                            local swfaction2 = SwfActionFactory.createAction(_table.array[(i-1)*2+2])

                            result_luaset['dialog_condition'..i]:runAction( swfaction1 )
                            result_luaset['dialog_explode'..i]:runAction( swfaction2 )

                            require 'framework.helper.MusicHelper'.playEffect( require 'Res'.Sound.reward )

                        end, (35+6*count)/20 )
  
                        count = count + 1 
                    end
                end

                local percent = '0%'
                if count == 0 then
                elseif count == 1 then percent = string.format('0%%s', Res.locString('Global$coin')) --'0%硬币'
                elseif count == 2 then percent = string.format('100%%s', Res.locString('Global$coin')) --'100%硬币'
                elseif count == 3 then percent = string.format('200%%s', Res.locString('Global$coin')) --'200%硬币'
                end 

                resultSet['dialog_up_percent']:setString(percent)
                resultSet['dialog_expR']:setString('+ 0')
                resultSet['dialog_expM']:setString(''..result.totalExp..'/'..result.nextExp)
                
                --
                result_luaset['dialog_progress']:setPercentageInTime(100*result.totalExp/result.nextExp, 0)

                --60%UP
                local base = 5
                local max = result.addHonor

                local moneyBase = result.addMoney
                local moneyMax = result.addMoney
                if count == 2 then
                    moneyBase = moneyBase/2
                elseif count == 3 then
                    moneyBase = moneyBase/3
                end

                local count = 20
                result_luaset['dialog_getCoins']:setString( tostring( math.floor(moneyBase) ) )
                result_luaset['dialog_up_percent']:setString(percent)
                result_luaset['dialog_honorNum']:setString( tostring(base) )
                
                for i=1, count do
                    self:runWithDelay(function ()
                        -- body
                        if tolua.isnull(result_luaset[1]) then return end

                        result_luaset['dialog_getCoins']:setString( tostring( math.floor((moneyMax-moneyBase)*i/count + moneyBase) ) )
                        result_luaset['dialog_honorNum']:setString( tostring( math.floor((max-base)*i/count + base) ) )
                    end, 65/20 + i/20)
                end

                self:runWithDelay(function ()
                    -- body
                    if tolua.isnull(result_luaset[1]) then return end
                    local action = CCFadeIn:create(0.5)
                    result_luaset['dialog_up']:runAction(action)
                end, 65/20)

                local reward = userData.Reward
                if reward then
                    -- rewardBar['rewardBar']
                    
                    -- winData.Result.Reward.PetPieces     = netData.D.Result.Reward.PetPieces
                    -- winData.Result.Reward.Pets          = netData.D.Result.Reward.Pets
                    -- winData.Result.Reward.Materials     = netData.D.Result.Reward.Materials
                    -- winData.Result.Reward.Equipments    = netData.D.Result.Reward.Equipments

                    -- fade in out
                    local rewardArr = {}
                    if reward.Materials then
                        print('reward.Materials')
                        for _i, _v in ipairs(reward.Materials) do
                            print(_v)
                            table.insert(rewardArr, { data = _v, type = 'Materials' } )
                        end
                    end
                    if reward.Equipments then
                        print('reward.Equipments')
                        for _i, _v in ipairs(reward.Equipments) do
                            print(_v)
                            table.insert(rewardArr, { data = _v, type = 'Equipments' } )
                        end
                    end
                    if reward.PetPieces then
                        print('reward.PetPieces')
                        for _i, _v in ipairs(reward.PetPieces) do
                            print(_v)
                            table.insert(rewardArr, { data = _v, type = 'PetPieces' } )
                        end
                    end
                    if reward.Pets then
                        print('reward.Pets')
                        for _i, _v in ipairs(reward.Pets) do
                            print(_v)
                            table.insert(rewardArr, { data = _v, type = 'Pets' } )
                        end
                    end

                    local rewardNum = #rewardArr

                    for i,v in ipairs(rewardArr) do
                        -- 
                        self:runWithDelay(function ()
                            local rewardItem
                            if v.type == 'Equipments' then
                                rewardItem = self:createLuaSet('@rewardToolItem')
                                Res.setNodeNameWithEquipNetData( rewardItem['icon'], v.data, v.data.Amount )
                                v.isPet = false
                            elseif v.type == 'Materials' then
                                rewardItem = self:createLuaSet('@rewardToolItem')
                                Res.setNodeAndNameWithMaterialNetData( rewardItem['icon'], v.data, v.data.Amount )
                                v.isPet = false
                            elseif v.type == 'PetPieces' then
                                rewardItem = self:createLuaSet('@rewardPetItem')
                                Res.setNodeNameWithPetPieceNetData( rewardItem['icon'], v.data, v.data.Amount )
                                v.isPet = true
                            elseif v.type == 'Pets' then
                                rewardItem = self:createLuaSet('@rewardPetItem')
                                Res.setNodeNameWithPetNetData( rewardItem['icon'], v.data, v.data.Amount )
                                v.isPet = true
                            end
                            assert(rewardItem)
                            
                            rewardItem['icon']:setVisible(false)
                            v.set = rewardItem
                            rewardItem[1]:setColorf(1,1,1,0)
                            result_luaset['rewardBar']:addChild( rewardItem[1] )

                            self:runWithDelay(function ()
                                -- body
                                local fadeIn = CCFadeIn:create(0.5)
                                rewardItem[1]:runAction(fadeIn)
                            end, (i*10)/20*timeRate)
                           
                        end, (65)/20*timeRate)
                        
                    end
                    
                    -- open rewards
                    self:runWithDelay(function ()
                        -- body
                        for i,v in ipairs(rewardArr) do
                            -- explode
                            v.set['explode']:setVisible(true)
                            -- light
                            v.set['light']:runAction( self._ActionRewardLight:clone() )
                            -- box
                            if v.isPet then
                                v.set['box']:runAction( SwfActionFactory.createAction( RewardBallBGData ) ) 
                            else
                                v.set['box']:runAction( SwfActionFactory.createAction( RewardBoxBGData ) ) 
                            end
                            
                            -- icon
                            v.set['icon']:runAction( SwfActionFactory.createAction( ScaleData ) )
                        end
                    end, (65 + rewardNum*10 + 10)/20*timeRate)

                    -- self:runWithDelay(function ( ... )
                    --     -- body
                    --     for i,v in ipairs(todoList) do
                    --         if v == redoFunc then
                    --             table.remove(todoList, i)
                    --         end
                    --     end
                    -- end, (65 + rewardNum*10 + 10 + 20)/20*timeRate)

                end

            end

            table.insert(todoList, func)
        end

        self:initToDoList(todoList)
        XmlCache.cleanXmlCache('Fight')

    end
end

function GameOverWin:initTest( userData )
    -- body
    if not userData or userData.mode == 'test' then
        
        local todoList = {}
        self:initToDoList(todoList)
        XmlCache.cleanXmlCache('Fight')
    end
end

-- function GameOverWin:initBossBattle( userData )
-- 	-- body
--     if userData and userData.mode == 'bossBattle' then
--     	local luaset = self:createLuaSet('@tip')
--     	local info = string.format('输出伤害:%d(%.3f%%)    成功击杀Boss!', math.floor(userData.hurtValue), userData.hurtPercent )
--     	luaset[1]:setString(info)
--     	luaset[1]:runAction(self._ActionFadeIn:clone())

--     	self._layer:addChild(luaset[1])
        
--         local todoList = {}
--         self:initToDoList(todoList)
--         XmlCache.cleanXmlCache('Fight')
--     end
-- end

function GameOverWin:initBossBattle( userData )
  -- body
    if userData and userData.mode == 'bossBattle' then
        local luaset = self:createLuaSet('@tip')
        local info = string.format('%s:%d(%.3f%%)    %s', Res.locString('Battle$DPS'), math.floor(userData.hurtValue), userData.hurtPercent, Res.locString('Battle$killBoss') )
        luaset[1]:setString(info)
        luaset[1]:runAction(self._ActionFadeIn:clone())

        self._layer:addChild(luaset[1])

        local myPetPiece

        local reward = userData.Reward
        if reward then
            local rewardArr = {}
            if reward.Materials then
                print('reward.Materials')
                for _i, _v in ipairs(reward.Materials) do
                    print(_v)
                    table.insert(rewardArr, { data = _v, type = 'Materials' } )
                end
            end
            if reward.Equipments then
                print('reward.Equipments')
                for _i, _v in ipairs(reward.Equipments) do
                    print(_v)
                    table.insert(rewardArr, { data = _v, type = 'Equipments' } )
                end
            end
            if reward.PetPieces then
                print('reward.PetPieces')
                for _i, _v in ipairs(reward.PetPieces) do
                    print(_v)
                    table.insert(rewardArr, { data = _v, type = 'PetPieces' } )
                end

                myPetPiece = reward.PetPieces[1]
            end

            if reward.Pets then
                print('reward.Pets')
                for _i, _v in ipairs(reward.Pets) do
                    print(_v)
                    table.insert(rewardArr, { data = _v, type = 'Pets' } )
                end
            end

            local rewardNum = #rewardArr
            local timeRate = 1

            for i,v in ipairs(rewardArr) do
                -- 
                self:runWithDelay(function ()
                    local rewardItem
                    if v.type == 'Equipments' then
                        rewardItem = self:createLuaSet('@rewardToolItem')
                        Res.setNodeNameWithEquipNetData( rewardItem['icon'], v.data, v.data.Amount )
                        v.isPet = false
                    elseif v.type == 'Materials' then
                        rewardItem = self:createLuaSet('@rewardToolItem')
                        Res.setNodeAndNameWithMaterialNetData( rewardItem['icon'], v.data, v.data.Amount )
                        v.isPet = false
                    elseif v.type == 'PetPieces' then
                        rewardItem = self:createLuaSet('@rewardPetItem')
                        Res.setNodeNameWithPetPieceNetData( rewardItem['icon'], v.data, v.data.Amount )
                        v.isPet = true
                    elseif v.type == 'Pets' then
                        rewardItem = self:createLuaSet('@rewardPetItem')
                        Res.setNodeNameWithPetNetData( rewardItem['icon'], v.data, v.data.Amount )
                        v.isPet = true
                    end
                    assert(rewardItem)
                    
                    rewardItem['icon']:setVisible(false)
                    v.set = rewardItem
                    rewardItem[1]:setColorf(1,1,1,0)
                    self._layer_fake_result_rewardBar:addChild( rewardItem[1] )

                    self:runWithDelay(function ()
                        -- body
                        local fadeIn = CCFadeIn:create(0.5)
                        rewardItem[1]:runAction(fadeIn)
                    end, (i*10)/20*timeRate)
                   
                end, (10)/20*timeRate)
                
            end

            -- open rewards
            self:runWithDelay(function ()
                -- body
                for i,v in ipairs(rewardArr) do
                    -- explode
                    v.set['explode']:setVisible(true)
                    -- light
                    v.set['light']:runAction( self._ActionRewardLight:clone() )
                    -- box
                    if v.isPet then
                        v.set['box']:runAction( SwfActionFactory.createAction( RewardBallBGData ) ) 
                    else
                        v.set['box']:runAction( SwfActionFactory.createAction( RewardBoxBGData ) ) 
                    end
                    
                    -- icon
                    v.set['icon']:runAction( SwfActionFactory.createAction( ScaleData ) )
                end
            end, (10 + rewardNum*10 + 10)/20*timeRate)


        end

        local todoList = {}
        self:initToDoList(todoList)
        XmlCache.cleanXmlCache('Fight')

        print('myPetPiece')
        print(myPetPiece)

        print('userData')
        print(userData)

        if myPetPiece then
            myPetPiece.isPieces = true

            self._nextButton:setListener(function ()
                -- body
                local finalFunc = function ()
                    -- body
                    CCDirector:sharedDirector():getScheduler():setTimeScale( 1 )
                    GleeCore:popController()
                    FightSettings.unLock()
                end
                
                local dialogData = {}
                dialogData.callback = finalFunc
                dialogData.pets = { myPetPiece }
                
                GleeCore:showLayer('DPetAcademyEffectV3', dialogData)
            end)
            self._nextButton = nil
        end


    end
end

function GameOverWin:initCMBossBattle( userData )
  -- body
    if userData and userData.mode == 'CMBossBattle' then
        local luaset = self:createLuaSet('@CMReward')
        luaset['llayout_num']:setString( tostring(math.floor(userData.hurtValue)) )
        require 'LangAdapter'.selectLang(nil,nil,nil,function ( ... )
          luaset['llayout_#label']:setScaleX(0)
          luaset['llayout_#label1']:setString('에게')
          luaset['llayout_#label3']:setString('데미지를 입혔다! Boss 격살 성공!')
        end)

        luaset[1]:runAction(self._ActionFadeIn:clone())
        self._layer:addChild(luaset[1])

        local todoList = {}
        self:initToDoList(todoList)
        XmlCache.cleanXmlCache('Fight')
    end
end

function GameOverWin:initSDNBossBattle( userData )
  -- body
    if userData and userData.mode == 'SDNBossBattle' then
        local luaset = self:createLuaSet('@SDNReward')
        luaset['llayout_num']:setString( tostring(math.floor(userData.hurtValue)) )
        require 'LangAdapter'.selectLang(nil,nil,nil,function ( ... )
          luaset['llayout_#label']:setScaleX(0)
          luaset['llayout_#label1']:setString('에게')
          luaset['llayout_#label3']:setString('데미지를 입혔다! Boss 격살 성공!')
        end)
        luaset[1]:runAction(self._ActionFadeIn:clone())
        self._layer:addChild(luaset[1])

        local todoList = {}
        self:initToDoList(todoList)
        XmlCache.cleanXmlCache('Fight')
    end
end


function GameOverWin:initArena( userData )
    -- body
    if userData and userData.mode == 'arena' then
        local reward = require 'ServerRecord'.getArenaReward()

        assert(reward)

        if reward then
        	local luaset = self:createLuaSet('@ArenaReward')
        	
            local n = require 'ServerRecord'.getArenaOrder()
            if n ~= 0 then
                luaset['llayout_order']:setString( string.format('%s%s!', Res.locString('Battle$RankUpTo'), tostring(require 'ServerRecord'.getArenaOrder())) )
            else
                luaset['llayout_order']:setString(Res.locString('Battle$RankStable'))
            end

        	luaset['llayout_name']:setString( tostring(require 'ServerRecord'.getArenaEnemyName()) )
        	
        	luaset['llayout2_num']:setString( tostring(reward.Gold) )
        	luaset['llayout2_honor']:setString( string.format('%s+%s', Res.locString('Global$Honor'), tostring(reward.Honor)) )
        	require "MATHelper":Change(6, reward.Honor, 0)

          require 'LangAdapter'.selectLang(nil,nil,nil,function ( ... )
            luaset['llayout_label']:setScaleX(0)
            luaset['llayout_label2']:setString('와의')
          end)
    	    luaset[1]:runAction(self._ActionFadeIn:clone())
    	    self._layer:addChild(luaset[1])
        end

        -- EventCenter.eventInput(FightEvent.ArenaGameOver, reward)

        local todoList = {}
        self:initToDoList(todoList)
        XmlCache.cleanXmlCache('Fight')
    end
end

function GameOverWin:initFriend( userData )
  if userData and userData.mode == 'friend' then
      local luaset = self:createLuaSet('@ArenaReward')
    
      luaset['llayout_order']:setString('')
      luaset['llayout_name']:setString( tostring(require 'ServerRecord'.getArenaEnemyName()) )
      
      luaset['#llayout2']:setVisible(false)
      
      luaset[1]:runAction(self._ActionFadeIn:clone())
      self._layer:addChild(luaset[1])
    
      -- EventCenter.eventInput(FightEvent.ArenaGameOver, reward)

      local todoList = {}
      self:initToDoList(todoList)
      XmlCache.cleanXmlCache('Fight')
    end
end

-- 
function GameOverWin:initLeague( userData )
    -- body
    if userData and userData.mode == 'league' then
        local reward = require 'ServerRecord'.getLeagueReward()

        print('initLeague')
        print(reward)

        assert(reward)

        if reward then
          local luaset = self:createLuaSet('@LeagueReward')
          
          luaset['llayout_name']:setString( tostring(require 'ServerRecord'.getArenaEnemyName()) )
          
          luaset['llayout2_num']:setString( tostring(reward.D.Honor) )
          luaset['llayout2_honor']:setString( string.format('%s+%s', Res.locString('Battle$score'), tostring(reward.D.Score)) )

          require 'LangAdapter'.selectLang(nil,nil,nil,function ( ... )
            luaset['llayout_#label']:setScaleX(0)
            luaset['llayout_#label1']:setString('님에게 승리했습니다!')
          end)

          luaset[1]:runAction(self._ActionFadeIn:clone())
          self._layer:addChild(luaset[1])
        end

        -- EventCenter.eventInput(FightEvent.ArenaGameOver, reward)

        local todoList = {}
        self:initToDoList(todoList)
        XmlCache.cleanXmlCache('Fight')
    end
end

function GameOverWin:initTrain( userData )

    if userData and userData.mode == 'train' then
      if userData and userData.D.Adventure.CurrentType == 0 then

        self:runWithDelay(function ( ... )
          local todoList = {}
          self:initToDoList(todoList)
          XmlCache.cleanXmlCache('Fight')
          if self._nextButton then
            self._nextButton:trigger(nil)
          end
        end)
      else
        local luaset = self:createLuaSet('@TrainReward')
        luaset[1]:setVisible(true)
        luaset['llayout2_num']:setString( tostring(userData.D.Star))
        luaset['llayout_num']:setString(tostring(userData.D.Adventure.CurrentStage - 1))
        luaset['llayout2_num1']:setString(tostring(userData.D.Coin))
        local visible = userData.D.Coin and userData.D.Coin > 0
        luaset['llayout2_num1']:setVisible(visible)
        luaset['llayout2_icon1']:setVisible(visible)
        
        userData.Lost = userData.Lost or 0
        if userData.Lost == 0 then
          luaset['llayout2_label']:setString(Res.locString('Battle$TrainReward1'))
        elseif userData.Lost == 1 then
          luaset['llayout2_label']:setString(Res.locString('Battle$TrainReward2'))
        else
          luaset['llayout2_label']:setString(Res.locString('Battle$TrainReward3'))
        end

        luaset[1]:runAction(self._ActionFadeIn:clone())
        self._layer:addChild(luaset[1])

        local todoList = {}
        self:initToDoList(todoList)
        XmlCache.cleanXmlCache('Fight')
      end
    end
end

function GameOverWin:initGuildMatch( userData )
  if userData and userData.mode == 'guildmatch' then
    local luaset = self:createLuaSet('@GuildMatchReward')
    luaset[1]:setVisible(true)
    local enemyname = require 'ServerRecord'.getArenaEnemyName()
    if enemyname then
      luaset['llayout_name']:setString(tostring(enemyname))
    else
      luaset['llayout']:setVisible(false)
    end

    require 'LangAdapter'.selectLang(nil,nil,nil,function ( ... )
      luaset['llayout_#label']:setScaleX(0)
      luaset['llayout_#label1']:setString('와의 결투에서 승리했습니다!')
    end)

    luaset['llayout2_des']:setString(string.format(Res.locString('GuildBattle$guildmatchret'),tostring(userData.AtkHarms),tostring(userData.D.AtkHonor)))

    luaset[1]:runAction(self._ActionFadeIn:clone())
    self._layer:addChild(luaset[1])
    local todoList = {}
    self:initToDoList(todoList)
    XmlCache.cleanXmlCache('Fight')
  end
end

function GameOverWin:initGuildBoss( userData )
  if userData and userData.mode == 'guildboss' then
    local luaset = self:createLuaSet('@GuildMathBoss')
    luaset[1]:setVisible(true)

    local enemyname = require 'ServerRecord'.getArenaEnemyName()
    if enemyname then
      luaset['llayout_name']:setString(tostring(enemyname))
    else
      luaset['llayout']:setVisible(false)
    end

    luaset['llayout2_des']:setString(tostring(userData.D.Coin))

    require 'LangAdapter'.selectLang(nil,nil,nil,function ( ... )
      luaset['llayout_#label']:setScaleX(0)
      luaset['llayout_#label1']:setString('와의 결투에서 승리했습니다!')
    end)

    luaset[1]:runAction(self._ActionFadeIn:clone())
    self._layer:addChild(luaset[1])

    local todoList = {}
    self:initToDoList(todoList)
    XmlCache.cleanXmlCache('Fight')
  end
end

function GameOverWin:initGuildFuben( userData )
  if userData and userData.mode == 'guildfuben' then
    local luaset = self:createLuaSet('@GuildFubenReward')
    luaset[1]:setVisible(true)

    require 'RewardViewHelper'.BattleRewardShow(self,userData.D.Reward,luaset['llayout'])

    luaset[1]:runAction(self._ActionFadeIn:clone())
    self._layer:addChild(luaset[1])

    local todoList = {}
    self:initToDoList(todoList)
    XmlCache.cleanXmlCache('Fight')
  end
end


function GameOverWin:initRemainsFuben( userData )
  if userData and userData.mode == 'RemainsFuben' then
    local luaset = self:createLuaSet('@RemainsReward')
    luaset[1]:setVisible(true)

    require 'RewardViewHelper'.BattleRewardShow(self,userData.D.Reward,luaset['llayout'])

    luaset[1]:runAction(self._ActionFadeIn:clone())
    self._layer:addChild(luaset[1])

    local todoList = {}
    self:initToDoList(todoList)
    XmlCache.cleanXmlCache('Fight')
  end
end

function GameOverWin:initLimitFuben( userData )
  if userData and userData.mode == 'limit_fuben' then
    self:addStartLvSet(userData.stars)
    local luaset = self:createLuaSet('@GuildFubenReward')
    luaset[1]:setVisible(true)

    luaset['label']:setVisible(false)
    userData.D.Reward.ExploreStone = userData.D.Score
    require 'RewardViewHelper'.BattleRewardShow(self,userData.D.Reward,luaset['llayout'])

    luaset[1]:runAction(self._ActionFadeIn:clone())
    self._layer:addChild(luaset[1])

    local todoList = {}
    self:initToDoList(todoList)
    XmlCache.cleanXmlCache('Fight')
  end
end

function GameOverWin:initGuildFubenRob( userData )
  if userData and userData.mode == 'guildfuben_rob' then
    local luaset = self:createLuaSet('@GuildFubenReward')
    luaset[1]:setVisible(true)

    luaset['label']:setString(Res.locString('GuildBattle$GuildFubenRobWin'))
    require 'RewardViewHelper'.BattleRewardShow(self,userData.D.Reward,luaset['llayout'])

    luaset[1]:runAction(self._ActionFadeIn:clone())
    self._layer:addChild(luaset[1])

    local todoList = {}
    self:initToDoList(todoList)
    XmlCache.cleanXmlCache('Fight')
  end
end

function GameOverWin:initGuildFubenRevenge( userData )
  if userData and userData.mode == 'guildfuben_revenge' then
    local luaset = self:createLuaSet('@GuildFubenReward')
    luaset[1]:setVisible(true)

    luaset['label']:setString(Res.locString('GuildBattle$GuildFubenRevengeWin'))
    require 'RewardViewHelper'.BattleRewardShow(self,userData.D.Reward,luaset['llayout'])

    luaset[1]:runAction(self._ActionFadeIn:clone())
    self._layer:addChild(luaset[1])

    local todoList = {}
    self:initToDoList(todoList)
    XmlCache.cleanXmlCache('Fight')
  end
end

function GameOverWin:initForFubenThief( userData )
    -- body
    if userData and userData.mode == 'fuben_thief' then

        local luaset = self:createLuaSet('@ThiefReward')
        luaset['llayout_gold']:setString(tostring(userData.gold))

        require 'LangAdapter'.selectLang(nil,nil,nil,function ( ... )
          luaset['llayout_label']:setString('')
          luaset['llayout_label1']:setString(require 'Res'.locString('Battle$SAnumber17')..'!') 
        end)
        
        luaset[1]:runAction(self._ActionFadeIn:clone())
        self._layer:addChild(luaset[1])

        local todoList = {}
        self:initToDoList(todoList)
        XmlCache.cleanXmlCache('Fight')
    end
end

-- function GameOverWin:initForFubenCat( userData )
--     -- body
--     if userData and userData.type == 'fuben_cat' then
--         -- assert(false)

--         local luaset = self:createLuaSet('@ThiefReward')
--         luaset['llayout_gold']:setString(tostring(userData.gold))

--         luaset[1]:runAction(self._ActionFadeIn:clone())
--         self._layer:addChild(luaset[1])
--     end
-- end


function GameOverWin:addStartLvSet( stars )

  local set = self:createLuaSet('@StarLv')
  self._layer:addChild(set[1])
  set[1]:setVisible(true)
  local timeRate = 1

  self:runWithDelay(function ()
    stars = stars or 3
    for i=1, stars do
        local action = SwfActionFactory.createAction( require 'Swf_XingXing2'.array[i+1],nil,nil,20/timeRate )
        local node = set[string.format('stars_s%d_f', i)]
        node:runAction(action)

        -- action:setListener(function ()
        --     -- body
        --     require 'framework.helper.MusicHelper'.playEffect( require 'Res'.Sound.ui_clear_stars )
        -- end)
        if i==1 then
            require 'framework.helper.MusicHelper'.playEffect( require 'Res'.Sound.ui_clear_stars )
        elseif i==2 then
            self:runWithDelay(function ( ... )
                -- body
                require 'framework.helper.MusicHelper'.playEffect( require 'Res'.Sound.ui_clear_stars )
            end, 0.2)
        elseif i==3 then
            self:runWithDelay(function ( ... )
                -- body
                require 'framework.helper.MusicHelper'.playEffect( require 'Res'.Sound.ui_clear_stars )
            end, 0.4)
        end

        if i==1 then
             local details = {
            [1] = Res.locString('Battle$PetDieMany'),--'(多个精灵阵亡)',
            [2] = Res.locString('Battle$PetDieOne'),--'(一个精灵阵亡)',
            [3] = Res.locString('Battle$PetDieNone')--'(没有精灵阵亡)'
            }
            set['details']:setString(tostring(details[stars]))
        end
    end
  end, (35/20)*timeRate)

end


function GameOverWin:onBack( userData, netData )
	
end

function GameOverWin:onRelease( ... )
    require 'FightTimer'.reset()
    require 'LayerManager'.reset()
    require 'FightController':reset()
    EventCenter.resetGroup('Fight')

    require 'GuideHelper':check('BattleEnd')
    if self._callback then
        self._callback()
    end

    local data = {
        mode = require 'ServerRecord'.getMode(),
        isWin = true,
        userData = self:getUserData()
    }
     
    EventCenter.eventInput("OnBattleCompleted", data)

    require 'ServerRecord'.reset()
end
--------------------------------custom code-----------------------------


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(GameOverWin, "GameOverWin")


--------------------------------register--------------------------------
GleeCore:registerLuaController("GameOverWin", GameOverWin)



print = CSharpPrint or print

local mySeed = os.time()

local function __G__TRACKBACK__(msg)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(msg) .. "\n")
    print(debug.traceback())
    print("----------------------------------------")
end

local function Entry()

	local Init4CSharp 			= require 'script.serverFightModule.csharp.Init4CSharp'

	local RequireMap = require 'script.RequireMap'
	Debug = require 'script.serverFightModule.csharp.Debug'
	Debug.setRequireMap(RequireMap)

--~ 	require 'framework.basic.Debug'
	require 'framework.basic.Constants'
	require 'framework.basic.BasicClass'
	require 'framework.basic.MetaHelper'
	require "framework.basic.List"
	require "framework.basic.IO"
	require "framework.basic.String"
	require "framework.basic.Table"
	require "framework.basic.Localize"
	require "framework.basic.Device"
	require "framework.basic.DB"

	require 'framework.interface.LuaInterface'
	require 'framework.interface.LuaController'
	require 'framework.interface.LuaDialog'
	require 'framework.interface.LuaMenu'
	require 'framework.interface.LuaNetView'
	require "framework.net.Net"
	require "framework.event.EventCenter"
	require "framework.helper.Utils"
	require 'framework.helper.MusicHelper'

	local EventObserver 		= require 'EventObserver'
	local Json 					= require 'script.serverFightModule.csharp.LuaJson'
	local EventCenter 			= require 'EventCenter'
	local FightEvent 			= require 'FightEvent'
	local PetListConverter 		= require 'PetListConverter'

	require 'FakeReleaseSkill'

	--local CSHARP_INPUT_TEAMS = [[{"Teams":[{"Rid":-2537,"TeamId":1,"PetIdList":[14769,14788,14809,14830,14847],"BenchPetId":14868,"Active":true,"CaptainPetId":14809,"CombatPower":3935,"IsAtk":false,"IsDef":true,"Id":2468},{"Rid":776,"TeamId":1,"PetIdList":[34433,34434,34453,34454,34455],"BenchPetId":0,"Active":true,"CaptainPetId":34433,"CombatPower":441066,"IsAtk":true,"IsDef":true,"Id":5553}],"Pets":[{"PetId":104,"Name":"��������","Star":3,"Lv":17,"Atk":1024,"Def":500,"Hp":958,"HpMax":0,"Exp":0,"Crit":0.4,"HpP":13.0,"AtkP":14.0,"AtkMethod":1,"Prop":7,"Grade":1,"Intimacy":0,"Potential":1,"AwakeIndex":1,"Fetter":[],"MoveSpeed":175.0,"AtkTime":1.0,"Power":569,"MotiCnt":0,"ResCnt":0,"Sv":0.0,"Fv":0.0,"Cv":1.5,"Bd":0,"HpR":0.0,"Gb":{},"NeedBadge":false,"Archived":false,"Id":14769},{"PetId":588,"Name":"�Ǹǳ�","Star":2,"Lv":17,"Atk":872,"Def":400,"Hp":710,"HpMax":0,"Exp":0,"Crit":0.4,"HpP":10.0,"AtkP":12.0,"AtkMethod":1,"Prop":2,"Grade":1,"Intimacy":0,"Potential":0,"AwakeIndex":1,"Fetter":[],"MoveSpeed":177.0,"AtkTime":1.0,"Power":461,"MotiCnt":0,"ResCnt":0,"Sv":0.0,"Fv":0.0,"Cv":1.5,"Bd":0,"HpR":0.0,"Gb":{},"NeedBadge":false,"Archived":false,"Id":14788},{"PetId":71,"Name":"��ʳ��","Star":5,"Lv":17,"Atk":2574,"Def":700,"Hp":2420,"HpMax":0,"Exp":0,"Crit":0.4,"HpP":30.0,"AtkP":32.0,"AtkMethod":1,"Prop":2,"Grade":1,"Intimacy":0,"Potential":1,"AwakeIndex":1,"Fetter":[],"MoveSpeed":185.0,"AtkTime":1.0,"Power":1441,"MotiCnt":0,"ResCnt":0,"Sv":0.0,"Fv":0.0,"Cv":1.5,"Bd":0,"HpR":0.0,"Gb":{},"NeedBadge":false,"Archived":false,"Id":14809},{"PetId":13,"Name":"���ǳ�","Star":2,"Lv":17,"Atk":816,"Def":400,"Hp":776,"HpMax":0,"Exp":0,"Crit":0.4,"HpP":11.0,"AtkP":11.0,"AtkMethod":1,"Prop":2,"Grade":1,"Intimacy":0,"Potential":0,"AwakeIndex":1,"Fetter":[],"MoveSpeed":180.0,"AtkTime":1.0,"Power":455,"MotiCnt":0,"ResCnt":0,"Sv":0.0,"Fv":0.0,"Cv":1.5,"Bd":0,"HpR":0.0,"Gb":{},"NeedBadge":false,"Archived":false,"Id":14830},{"PetId":304,"Name":"�ɿɶ���","Star":3,"Lv":17,"Atk":1120,"Def":900,"Hp":1222,"HpMax":0,"Exp":0,"Crit":0.0,"HpP":17.0,"AtkP":15.0,"AtkMethod":2,"Prop":7,"Grade":1,"Intimacy":0,"Potential":1,"AwakeIndex":1,"Fetter":[],"MoveSpeed":180.0,"AtkTime":2.0,"Power":488,"MotiCnt":0,"ResCnt":0,"Sv":0.0,"Fv":0.0,"Cv":1.5,"Bd":0,"HpR":0.0,"Gb":{},"NeedBadge":false,"Archived":false,"Id":14847},{"PetId":36,"Name":"Ƥ����","Star":4,"Lv":17,"Atk":1692,"Def":200,"Hp":1262,"HpMax":0,"Exp":0,"Crit":0.0,"HpP":16.0,"AtkP":21.0,"AtkMethod":4,"Prop":2,"Grade":1,"Intimacy":0,"Potential":1,"AwakeIndex":1,"Fetter":[],"MoveSpeed":176.0,"AtkTime":4.0,"Power":597,"MotiCnt":0,"ResCnt":0,"Sv":0.0,"Fv":0.0,"Cv":1.5,"Bd":0,"HpR":0.0,"Gb":{},"NeedBadge":false,"Archived":false,"Id":14868},{"PetId":3,"Name":"���ܻ�","Star":5,"Lv":90,"Atk":117999,"Def":14121,"Hp":103182,"HpMax":0,"Exp":0,"Crit":0.0,"HpP":29.68,"AtkP":43.46,"AtkMethod":3,"Prop":2,"Grade":5,"Intimacy":0,"Potential":86,"AwakeIndex":13,"Fetter":[],"MoveSpeed":229.2224,"AtkTime":3.0,"Power":71894,"MotiCnt":4,"ResCnt":0,"Sv":1121.54,"Fv":966.32,"Cv":1.5,"Bd":0,"HpR":0.0,"Gb":{},"NeedBadge":true,"Fruits":{"204":12,"403":12,"206":8,"205":10,"404":10,"405":8},"Archived":false,"Id":34433},{"PetId":153,"Name":"�¹�Ҷ","Star":4,"Lv":90,"Atk":125003,"Def":15149,"Hp":115984,"HpMax":0,"Exp":0,"Crit":0.0,"HpP":29.0,"AtkP":26.0,"AtkMethod":2,"Prop":2,"Grade":5,"Intimacy":0,"Potential":90,"AwakeIndex":8,"Fetter":[96,269],"MoveSpeed":224.79,"AtkTime":2.0,"Power":79229,"MotiCnt":0,"ResCnt":0,"Sv":1140.21,"Fv":854.32,"Cv":1.5,"Bd":0,"HpR":0.0,"Gb":{},"NeedBadge":true,"Fruits":{"204":12,"403":12,"206":8,"205":10,"404":10,"405":8},"Archived":false,"Id":34434},{"PetId":242,"Name":"�Ҹ���","Star":5,"Lv":90,"Atk":126303,"Def":14263,"Hp":113081,"HpMax":0,"Exp":0,"Crit":0.0,"HpP":19.0,"AtkP":27.0,"AtkMethod":4,"Prop":7,"Grade":5,"Intimacy":0,"Potential":90,"AwakeIndex":6,"Fetter":[],"MoveSpeed":225.4208,"AtkTime":4.0,"Power":76246,"MotiCnt":0,"ResCnt":0,"Sv":1138.51,"Fv":948.2,"Cv":1.5,"Bd":0,"HpR":0.0,"Gb":{},"NeedBadge":true,"Fruits":{"204":12,"205":10,"503":12,"206":8,"505":8,"504":10},"Archived":false,"Id":34453},{"PetId":160,"Name":"������","Star":5,"Lv":90,"Atk":127903,"Def":14691,"Hp":115882,"HpMax":0,"Exp":0,"Crit":0.4,"HpP":36.0,"AtkP":40.0,"AtkMethod":1,"Prop":6,"Grade":5,"Intimacy":0,"Potential":90,"AwakeIndex":5,"Fetter":[],"MoveSpeed":234.432,"AtkTime":1.0,"Power":99013,"MotiCnt":0,"ResCnt":0,"Sv":1154.94,"Fv":944.16,"Cv":1.5,"Bd":0,"HpR":0.0,"Gb":{},"NeedBadge":true,"Fruits":{"303":12,"205":10,"206":8,"305":8,"304":10,"204":12},"Archived":false,"Id":34454},{"PetId":136,"Name":"����","Star":5,"Lv":90,"Atk":127888,"Def":14671,"Hp":115687,"HpMax":0,"Exp":0,"Crit":0.4,"HpP":35.0,"AtkP":38.0,"AtkMethod":1,"Prop":8,"Grade":5,"Intimacy":0,"Potential":90,"AwakeIndex":4,"Fetter":[],"MoveSpeed":230.5248,"AtkTime":1.0,"Power":98799,"MotiCnt":0,"ResCnt":0,"Sv":1139.93,"Fv":969.48,"Cv":1.5,"Bd":0,"HpR":0.0,"Gb":{},"NeedBadge":true,"Fruits":{"204":12,"205":10,"206":8,"703":12,"704":10,"705":8},"Archived":false,"Id":34455}]}]]
--~ 	print('C_GLOBAL_INPUT_TEAMS:')
--~ 	print(C_GLOBAL_INPUT_TEAMS)

	local info = Json.decode( CSHARP_INPUT_TEAMS )

	local data = {}
	data.data = {}
	local petList, enemyList = PetListConverter.getPetsInfo(info)
	data.data.petList = petList
	data.data.enemyList = enemyList
	data.data.seed = mySeed
	data.type = "arena"

	local result = EventCenter.eventInput( FightEvent.LogicBattleStart, data )

	print()

	return result
end

local f, r = xpcall(Entry, __G__TRACKBACK__)
return r and r.isWin, mySeed

-- local mode = require 'script.gvc.GVCPublish'.mode
-- if mode == 'develop' then
-- 	require "CTestLogin"
-- 	GleeCore:replaceController("CTestLogin")
-- else
-- 	require "CLoginP"
-- 	GleeCore:replaceController("CLoginP")
-- end
require 'BattleStoryA'

local login = require 'script.info.Info'.LOGIN
assert(login)
GleeCore:replaceController( login )

-- GleeCore:replaceController('CWorldMap2')
-- GleeCore:replaceController("CTestLogin")
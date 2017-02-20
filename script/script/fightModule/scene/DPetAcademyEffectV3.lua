local Class = require 'framework.basic.BasicClass'
local DPetAcademyEffectV2 = require 'DPetAcademyEffectV2'

local DPetAcademyEffectV3 = class( DPetAcademyEffectV2 )


function DPetAcademyEffectV3:onInit( userData, netData )
	-- body
	Class[ DPetAcademyEffectV2 ].onInit(self, userData, netData)

	assert(userData.callback)

	-- local node = ElfNode:create()
	-- node:setResid('N_ND_sp.png')
	-- node:setPosition( ccp(-59,-129) )
	-- node:setOrder(10000)
	-- self._root_one:addChild(node, 1000)

	self._root_one_other_btnOnce:setVisible(false)

	local x,y = self._root_one_other_btnConfirm:getPosition()
	self._root_one_other_btnConfirm:setPosition( ccp(0,y) )

	self._root_one_other_btnConfirm:setListener(function ()
		-- body
		self:close()
		
		if userData and userData.callback then
			userData.callback()
		end
	end)

	self._root_one_other_btnConfirm = {}
	self._root_one_other_btnConfirm.setListener = function ()
		-- body
	end

end


--------------------------------class end-------------------------------
require 'framework.basic.MetaHelper'.classDefinitionEnd(DPetAcademyEffectV3, "DPetAcademyEffectV3")


--------------------------------register--------------------------------
GleeCore:registerLuaLayer("DPetAcademyEffectV3", DPetAcademyEffectV3)
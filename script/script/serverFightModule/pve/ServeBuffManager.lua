-- buff管理器
ServeBuffManager=class(  )
function ServeBuffManager:ctor( )
   self._dict={}
end

function ServeBuffManager:addBuff(buffDyVo )
	if  self._dict[buffDyVo.buffType]  then
		self._dict[buffDyVo.buffType].merge(buffDyVo)
	else
    	self._dict[buffDyVo.buffType]=buffDyVo
	end
end

function ServeBuffManager:removeBuff( buffDyVo )
  	self._dict[buffDyVo.buffType]=nil
end
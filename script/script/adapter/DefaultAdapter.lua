local DefaultAdapter = {}

function DefaultAdapter.adapt()
	-- body    
	print('DefaultAdapter.adapt')
	
	local size = CCEGLView:sharedOpenGLView():getFrameSize()

	local whr = size.width/size.height
	local whr_1136 = 1136/640
	local whr_960 = 960/640

	if math.abs(whr - whr_1136 ) <= math.abs(whr - whr_960) then
		CCEGLView:sharedOpenGLView():setDesignResolutionSize(1136,640,0)
	else
		CCEGLView:sharedOpenGLView():setDesignResolutionSize(960,640,0)
	end
end

return DefaultAdapter
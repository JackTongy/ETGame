local PlaygroundFunc = {}
local PlaygroundData = {}

function PlaygroundFunc.cleanData()
	PlaygroundData = {}
end

function PlaygroundFunc.setPlayground( Playground )
	PlaygroundData.Playground = Playground
end

function PlaygroundFunc.getPlayground( ... )
	return PlaygroundData.Playground
end

return PlaygroundFunc
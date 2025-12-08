--This file contains different custom functions that might get helpful during work on other scripts

function Prefix(entity)
	--Fix for prefixes in prefabs
	return entity:GetName():sub(1,entity:GetName():find("%a")-1)
end

function DelayFunction(Entity, f,flDelay)
	--Delay by given time
	FixInt(flDelay, 0)
	Entity:SetThink(function() f() return nil end,UniqueString("Delay"),flDelay)
end

function FixInt(parameter, defaultValue)
	if type(parameter) == "string" or parameter == nil
		then
			parameter = defaultValue
	end
end

function LerpEntityBy(TargetEntity, MoveX, MoveY, MoveZ)
	local fDesiredDuration = 15
	local fElapsedTime = 0
	local vStartingOrigin = TargetEntity:GetOrigin()
	local vFinalOrigin = Vector(vStartingOrigin.x + MoveX, vStartingOrigin.y + MoveY, vStartingOrigin.z + MoveZ)
	local percentageComplete = 0
	TargetEntity:SetThink(function()
		fElapsedTime = fElapsedTime + FrameTime()
		percentageComplete = fElapsedTime / fDesiredDuration

		TargetEntity:SetOrigin(LerpVectors(vStartingOrigin, vFinalOrigin , percentageComplete))
		if (percentageComplete >= 1)
		then 
			TargetEntity:Kill()
			return nil
		else
			return 0.02
		end
	 end, UniqueString("LerpingThink"), 0)
end
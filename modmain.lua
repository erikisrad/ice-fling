KnownModIndex = GLOBAL.KnownModIndex

PrefabFiles = 
{
	"range"
}

if GetModConfigData("Time") == "short" then
	GLOBAL.TUNING.RANGE_CHECK_TIME = 10
end

if GetModConfigData("Time") == "default" then
	GLOBAL.TUNING.RANGE_CHECK_TIME = 30
end

if GetModConfigData("Time") == "long" then
	GLOBAL.TUNING.RANGE_CHECK_TIME = 60
end

if GetModConfigData("Time") == "longer" then
	GLOBAL.TUNING.RANGE_CHECK_TIME = 240
end

if GetModConfigData("Time") == "longest" then
	GLOBAL.TUNING.RANGE_CHECK_TIME = 480
end

if GetModConfigData("Time") == "always" then
	GLOBAL.TUNING.RANGE_CHECK_TIME = 1
end

GLOBAL.TUNING.RANGE_INDICATOR = 1.55

if (KnownModIndex:IsModEnabled("workshop-482119182")) then
	RangeMod = GLOBAL.GetModConfigData("RangeMod", "workshop-482119182")
		if RangeMod == 0.5 then
			GLOBAL.TUNING.RANGE_INDICATOR = 1.1
		elseif RangeMod == 0.6 then
			GLOBAL.TUNING.RANGE_INDICATOR = 1.2
		elseif RangeMod == 0.7 then
			GLOBAL.TUNING.RANGE_INDICATOR = 1.3
		elseif RangeMod == 0.8 then
			GLOBAL.TUNING.RANGE_INDICATOR = 1.4
		elseif RangeMod == 0.9 then
			GLOBAL.TUNING.RANGE_INDICATOR = 1.50
		elseif RangeMod == 1.1 then
			GLOBAL.TUNING.RANGE_INDICATOR = 1.65
		elseif RangeMod == 1.2 then
			GLOBAL.TUNING.RANGE_INDICATOR = 1.70
		elseif RangeMod == 1.3 then
			GLOBAL.TUNING.RANGE_INDICATOR = 1.78
		elseif RangeMod == 1.4 then
			GLOBAL.TUNING.RANGE_INDICATOR = 1.84
		elseif RangeMod == 1.5 then
			GLOBAL.TUNING.RANGE_INDICATOR = 1.92
		elseif RangeMod == 1.6 then
			GLOBAL.TUNING.RANGE_INDICATOR = 1.98
		elseif RangeMod == 1.7 then
			GLOBAL.TUNING.RANGE_INDICATOR = 2.03
		elseif RangeMod == 1.8 then
			GLOBAL.TUNING.RANGE_INDICATOR = 2.09
		elseif RangeMod == 1.9 then
			GLOBAL.TUNING.RANGE_INDICATOR = 2.15
		elseif RangeMod == 2.0 then
			GLOBAL.TUNING.RANGE_INDICATOR = 2.2
		end	
end

function IceFlingOnRemove(inst)
	local pos = GLOBAL.Point(inst.Transform:GetWorldPosition())
	local range_indicators = GLOBAL.TheSim:FindEntities(pos.x,pos.y,pos.z, 2, {"range_indicator"})
	for i,v in ipairs(range_indicators) do
		if v:IsValid() then
			v:Remove()
		end
	end
end

function getstatus_mod(inst, viewer)
	local pos = GLOBAL.Point(inst.Transform:GetWorldPosition())
	local range_indicators = GLOBAL.TheSim:FindEntities(pos.x,pos.y,pos.z, 2, {"range_indicator"})
	if #range_indicators < 1 then
		local range = GLOBAL.SpawnPrefab("range_indicator")
		range.Transform:SetPosition(pos.x, pos.y, pos.z)
	end
    return inst.components.fueled ~= nil and inst.components.fueled.currentfuel / inst.components.fueled.maxfuel <= .25 and "LOWFUEL" or "ON"
end
	
function IceFlingPostInit(inst)
	if inst and inst.components.inspectable then
		inst.components.inspectable.getstatus = getstatus_mod
	end
	inst:ListenForEvent("onremove", IceFlingOnRemove)
end

AddPrefabPostInit("lightning_rod", IceFlingPostInit)
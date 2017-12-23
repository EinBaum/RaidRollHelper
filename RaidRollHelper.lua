local maxTimeDiff = 5
local lastRRtime = nil
local lastRRstr = nil

local frame = CreateFrame("frame")
frame:RegisterEvent("CHAT_MSG_SYSTEM")
frame:SetScript("OnEvent", function()
	if not (arg1 and lastRRtime and lastRRstr) then return end
	if GetTime() - lastRRtime > maxTimeDiff then return end

	local roll = strmatch(arg1, lastRRstr)
	local name = UnitName("raid" .. roll)

	if name then
		SendChatMessage(format("RR Winner: [%d] %s", roll, name), "RAID")
	else
		DEFAULT_CHAT_FRAME:AddMessage(format("No player on slot %d.", roll))
	end

	lastRRtime = nil
	lastRRstr = nil
end)

SLASH_RRH1 = "/rr"
SLASH_RRH2 = "/raidroll"
SlashCmdList["RRH"] = function(msg)
	if false then return end

	local high = GetNumRaidMembers()
	if high == 0 then return end

	lastRRtime = GetTime()
	lastRRstr = UnitName("player") .. " rolls (.-) %(1%-" .. high .. "%)"
	RandomRoll(1, high)
end

--[[
function rrprint()
	local str = ""
	for i = 1, GetNumRaidMembers() do
		local name = UnitName("raid"..i)
		if name then
			str = str .. "[" .. i .. "]: " .. name .. " " 
		end
	end

	SendChatMessage(str, "RAID")
end
]]

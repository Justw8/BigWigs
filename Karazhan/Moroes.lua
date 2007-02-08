﻿------------------------------
--      Are you local?      --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Moroes"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local enrageannounced

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Moroes",

	engage_cmd = "engage",
	engage_name = "Engage",
	engage_desc = "Warn when Moroes is pulled",

	vanish_cmd = "vanish",
	vanish_name = "Vanish",
	vanish_desc = "Warn when Moroes Vanishe's",

	blind_cmd = "blind",
	blind_name = "Blind",
	blind_desc = "Notify of Blinded players",

	enrage_cmd = "enrage",
	enrage_name = "Enrage",
	enrage_desc = "Warn when Moroes becomes enraged",

	vanish_trigger1 = "You rang?",
	vanish_trigger2 = "Now, where was I? Oh, yes...",
	vanish_message = "Vanished! Next in ~35sec!",
	vanish_warning = "Vanish Soon!",
	vanish_bar = "Next Vanish",

	blind_trigger = "^([^%s]+) ([^%s]+) afflicted by Blind",
	blind_message = "%s is Blinded!",

	engage_trigger = "Hm, unannounced visitors. Preparations must be made...",
	engage_message = "Moroes Engaged - Vanish in ~35sec!",

	enrage_trigger = "%s becomes enraged!",
	enrage_message = "Enrage!",
	enrage_warning = "Enrage Soon!",

	you = "you",
} end)

L:RegisterTranslations("deDE", function() return {
	engage_cmd = "engage",
	engage_name = "Engage",
	engage_desc = "Warn when Moroes is pulled",

	vanish_cmd = "vanish",
	vanish_name = "Vanish",
	vanish_desc = "Warn when Moroes Vanishe's",

	blind_cmd = "blind",
	blind_name = "Blind",
	blind_desc = "Notify of Blinded players",

	enrage_cmd = "enrage",
	enrage_name = "Enrage",
	enrage_desc = "Warn when Moroes becomes enraged",

	vanish_trigger1 = "Ihr habt gel\195\164utet?",
	vanish_trigger2 = "Nun, wo war ich? Ah, ja...",
	vanish_message = "Vanished! Next in ~35sec!",
	vanish_warning = "Vanish Soon!",
	vanish_bar = "Next Vanish",

	blind_trigger = "^([^%s]+) ([^%s]+) .* Blenden",
	blind_message = "%s is Blinded!",

	engage_trigger = "Hm, unangek\195\188ndigte Besucher.*",
	engage_message = "Moroes Engaged - Vanish in ~35sec!",

	enrage_trigger = "%s wird w\195\188tend!",
	enrage_message = "Enrage!",
	enrage_warning = "Enrage Soon!",

	you = "Ihr",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

BigWigsMoroes = BigWigs:NewModule(boss)
BigWigsMoroes.zonename = AceLibrary("Babble-Zone-2.2")["Karazhan"]
BigWigsMoroes.enabletrigger = boss
BigWigsMoroes.toggleoptions = {"engage", "vanish", "blind", -1, "enrage", "bosskill"}
BigWigsMoroes.revision = tonumber(string.sub("$Revision$", 12, -3))

------------------------------
--      Initialization      --
------------------------------

function BigWigsMoroes:OnEnable()
	enrageannounced = nil

	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "BlindEvent")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", "BlindEvent")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", "BlindEvent")

	self:RegisterEvent("UNIT_HEALTH")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")

	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	self:RegisterEvent("BigWigs_RecvSync")
	self:TriggerEvent("BigWigs_ThrottleSync", "MoroesBlind", 3)
end

------------------------------
--      Event Handlers      --
------------------------------

function BigWigsMoroes:CHAT_MSG_MONSTER_YELL(msg)
	if self.db.profile.vanish and (msg == L["vanish_trigger1"] or msg == L["vanish_trigger2"]) then
		self:TriggerEvent("BigWigs_Message", L["vanish_message"], "Urgent", nil, "Alert")
		self:NextVanish()
	elseif self.db.profile.engage and msg == L["engage_trigger"] then
		self:TriggerEvent("BigWigs_Message", L["engage_message"], "Attention")
		self:NextVanish()
	end
end

function BigWigsMoroes:NextVanish()
	self:TriggerEvent("BigWigs_StartBar", self, L["vanish_bar"], 35, "Interface\\Icons\\Ability_Vanish")
	self:ScheduleEvent("BigWigs_Message", 30, L["vanish_warning"], "Attention")
end

function BigWigsMoroes:CHAT_MSG_MONSTER_EMOTE(msg)
	if self.db.profile.enrage and msg == L["enrage_trigger"] then
		self:TriggerEvent("BigWigs_Message", L["enrage_message"], "Important", nil, "Alarm")
	end
end

function BigWigsMoroes:UNIT_HEALTH(msg)
	if UnitName(msg) == boss then
		local health = UnitHealth(msg)
		if health > 30 and health <= 34 and not enrageannounced then
			if self.db.profile.enrage then
				self:TriggerEvent("BigWigs_Message", L["enrage_warning"], "Positive", nil, "Info")
			end
			enrageannounced = true
		elseif health > 40 and enrageannounced then
			enrageannounced = nil
		end
	end
end

function BigWigsMoroes:BlindEvent(msg)
	local bplayer, btype = select(3, msg:find(L["blind_trigger"]))
	if bplayer then
		if bplayer == L["you"] then
			bplayer = UnitName("player")
		end
		self:TriggerEvent("BigWigs_SendSync", "MoroesBlind "..bplayer)
	end
end

function BigWigsMoroes:BigWigs_RecvSync( sync, rest, nick )
	if sync == "MoroesBlind" and rest then
		local player = rest
		if player == UnitName("player") and self.db.profile.blind then
		self:TriggerEvent("BigWigs_Message", string.format(L["blind_message"], bplayer), "Attention")
		end
	end
end

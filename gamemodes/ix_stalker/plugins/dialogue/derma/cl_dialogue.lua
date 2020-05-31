local PANEL = {}
local gradient = ix.util.GetMaterial("vgui/gradient-d")

function PANEL:Init()
	self.loading = true

	self.ANIM_SPEED = 0.25

	gui.EnableScreenClicker(true)

	self:Dock(BOTTOM)
	self:DockMargin(ScrW() * 0.25, 0, ScrW() * 0.25, ScrH()*0.05)
	self:SetTall(ScrH() * 0.9)
	self:SetAlpha(0)
	self:AlphaTo(255, self.ANIM_SPEED)

	self.chatbox = self:Add("DScrollPanel")
	self.chatbox:Dock(TOP)
	self.chatbox:SetTall(ScrH() * 0.53)
	self.chatbox:DockMargin(ScrW()*0.023, ScrH()*0.048, ScrW()*0.023, ScrH()*0.02)
	self:InvalidateLayout(true)
	self:InvalidateChildren(true)

	self.options = self:Add("DScrollPanel")
	self.options:Dock(FILL)
	self.options:DockMargin(ScrW()*0.021, ScrH()*0.03, ScrW()*0.021, ScrH()*0.02)
end

function PANEL:Think()
	if self.loading then
		if self.target and self.treeID then
			self.tree = ix.dialogue.list[self.treeID].tree
			self:startTopic("GREETING")

			self.loading = false
		end
	end

	--[[
	if input.IsKeyDown(KEY_TAB) then
		self:exit()
	end
	--]]
end

function PANEL:targetName()
	return self.target.PrintName or "Unknown"
end

function PANEL:startTopic(topicID)
	topic = self.tree[topicID]

	self.options:Clear()

	--Run pre-callback, if there is one
	if isfunction(topic.preCallback) then
		topic.preCallback(topic, LocalPlayer(), self.target)
		net.Start("ixPreCallback")
		net.WriteString(self.treeID)
		net.WriteString(topicID)
		net.WriteEntity(self.target)
		net.SendToServer()
	end

	if topic.statement != "" then
		self:dialogue(LocalPlayer():GetCharacter():GetName(), topic.statement, true)
	end

	self:dialogue(self:targetName(), topic.response, true, ix.config.Get("chatColor"), topicID)
end

function PANEL:dialogue(name, message, instant, color, topicID)
	self.nametitle = self.chatbox:Add("DLabel")
	self.nametitle:Dock(TOP)
	self.nametitle:DockMargin(0, 0, 0, 4)
	self.nametitle:SetFont("stalkerregulartitlefont")
	self.nametitle:SetWrap(true)
	self.nametitle:SetAutoStretchVertical(true)
	self.nametitle:SetText("")

	self.message = self.chatbox:Add("DLabel")
	self.message:Dock(TOP)
	self.message:DockMargin(ScrW()*0.01, 0, 0, 4)
	self.message:SetFont("ixSmallFont")
	self.message:SetWrap(true)
	self.message:SetAutoStretchVertical(true)
	self.message:SetText("")

	local function scrollToBottom()
		self.chatbox:GetVBar():AnimateTo(self.chatbox:GetCanvas():GetTall(), 0.1, 0.1)
	end
	
	scrollToBottom()

	if name == LocalPlayer():GetCharacter():GetName() then
		self.nametitle:SetTextColor(Color(150, 200, 150))
	else
		self.nametitle:SetTextColor(Color(206, 108, 86))
	end

	if color then		
		self.message:SetTextColor(color)
	end



	local parseMessage = "''"..message.."''"

	if instant then
		self.nametitle:SetText(name)
		self.message:SetText(parseMessage)

		if topicID then
			topic = self.tree[topicID]
			--Run post-callback, if there is one
			if isfunction(topic.postCallback) then
				topic.postCallback(topic, LocalPlayer(), self.target)
				net.Start("ixPostCallback")
				net.WriteString(self.treeID)
				net.WriteString(topicID)
				net.WriteEntity(self.target)
				net.SendToServer()
			end

			if topicID == "GOODBYE" then
				self:exit()
			end

			self:prepareOptions(topic.options)
		end

		return
	end

	--unused, as its just for making the text appear slower
	i = 1
	messageTable = string.ToTable(parseMessage)
	concatMessage = ""
	timer.Create("typewriter", 0.05, string.len(parseMessage), function()
		concatMessage = concatMessage..messageTable[i]
		i = i + 1

		self.message:SetText(concatMessage)

		--End of message
		if i == (table.Count(messageTable) + 1) then
			scrollToBottom()

			if topicID then
				topic = self.tree[topicID]
				--Run post-callback, if there is one
				if isfunction(topic.postCallback) then
					topic.postCallback(topic, LocalPlayer(), self.target)
					net.Start("ixPostCallback")
					net.WriteString(self.treeID)
					net.WriteString(topicID)
					net.WriteEntity(self.target)
					net.SendToServer()
				end

				if topicID == "GOODBYE" then
					self:exit()
				end

				self:prepareOptions(topic.options)
			end

			timer.Destroy("typewriter")
		end
	end)
end

function PANEL:prepareOptions(options)
	self.buttonList = {}
	for k, topicID in ipairs(options) do
		topic = self.tree[topicID]
		self.buttonList[k] = self.options:Add("DLabel")
		self.buttonList[k]:Dock(TOP)
		self.buttonList[k]:DockMargin(4, 0, 4, 4)
		self.buttonList[k]:SetText(topic.statement)
		self.buttonList[k]:SetTextColor(Color(20, 20, 20, 255))
		self.buttonList[k]:SetFont("ixSmallFont")
		self.buttonList[k]:SetMouseInputEnabled(true)
		self.buttonList[k].Think = function()
			if self.buttonList[k]:IsHovered() then
				self.buttonList[k]:SetTextColor(Color(255, 255, 255))
			else
				self.buttonList[k]:SetTextColor(Color(220, 220, 220))
			end
		end
		self.buttonList[k].DoClick = function()
			self:startTopic(topicID)
		end
	end
end

function PANEL:exit()
	if timer.Exists("typewriter") then
		timer.Remove("typewriter")
	end

	self:AlphaTo(0, self.ANIM_SPEED, 1, function()
		gui.EnableScreenClicker(false)
		self:Remove()

		net.Start("ixDialogueFreeze")
		net.WriteBool(false)
		net.SendToServer()
	end)
end

function PANEL:Paint(w, h)
--	surface.SetDrawColor(0, 0, 0, 250)
--	surface.DrawRect(0, 0, w, h)

	surface.SetMaterial( Material("cotz/panels/dialogue.png") )
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(0, 0, w, h)

--	surface.SetDrawColor(0, 0, 0, 255)
--	surface.SetMaterial(gradient)
--	surface.DrawTexturedRect(0, 0, w, h)
end

vgui.Register("ixDialogue", PANEL, "EditablePanel")

net.Receive("ixDialogue", function()
	local target = net.ReadEntity()
	local treeID = net.ReadString()

	local panel = vgui.Create("ixDialogue")
	panel.target = target
	panel.treeID = treeID
end)
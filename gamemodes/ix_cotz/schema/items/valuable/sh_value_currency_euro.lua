ITEM.name = "Euro Notes"
ITEM.description = "A bundle of European currency."
ITEM.longdesc = "While this currency is not the primary way of trading in the zone, it does still retain value to people residing in european countries, and other financially interested people. Aside from a trading perspective, foreign currency is practically useless in an alienated environment such as the zone."
ITEM.model = "models/kek1ch/money_euro.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 52 -- lower than real conversion rate, intended

ITEM.quantity = 5000000

ITEM.flatweight = 0
ITEM.weight = 0.010

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 0),
	fov = 2.5,
}

function ITEM:GetPrice()
	return self.price * self:GetData("quantity", self.quantity)
end

ITEM.functions.combine = {
	OnCanRun = function(item, data)
		if !data then
			return false
		end
		local targetItem = ix.item.instances[data[1]]

		if targetItem.uniqueID == item.uniqueID then
			return true
		else
			return false
		end
	end,
	OnRun = function(item, data)
		local targetItem = ix.item.instances[data[1]]
		local targetQuantDiff = targetItem.quantity - targetItem:GetData("quantity", targetItem.quantity)
		local localQuant = item:GetData("quantity", item.quantity)
		local targetQuant = targetItem:GetData("quantity", targetItem.quantity)
		item.player:EmitSound("stalkersound/inv_properties.mp3", 110)
		if targetQuantDiff >= localQuant then
			targetItem:SetData("quantity", targetQuant + localQuant)
			return true
		else
			item:SetData("quantity", localQuant - targetQuantDiff)
			targetItem:SetData("quantity", targetItem.quantity)
			return false
		end
	end,
}

function ITEM:OnInstanced()
	if (!self:GetData("quantity")) then
		self:SetData("quantity", 1)
	end
end
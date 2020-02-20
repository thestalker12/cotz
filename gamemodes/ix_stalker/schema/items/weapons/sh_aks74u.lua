ITEM.name = "AKs-74u"
ITEM.description= "A short folding-stock assault rifle chambered for 5.45x39mm."
ITEM.longdesc = "The AKS-74U bridges the gap between a submachine gun and an assault rifle.\nIt was intended for use mainly with special forces, airborne infantry, rear-echelon support units and armored vehicle crews.\nIt is still used in these roles, but has been augmented by various submachine guns, and the AK-105.\nIt is a popular rifle with stalkers due to its reduced weight and slim profile allowing you to carry it with ease.\n\nAmmo: 5.45x39mm\nMagazine Capacity: 30"
ITEM.model = "models/weapons/w_smg_aks.mdl"
ITEM.class = "cw_aks74u"
ITEM.weaponCategory = "primary"
ITEM.width = 3
ITEM.price = 12750
ITEM.height = 2
ITEM.busflag = {"guns4"}
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_kobra", "md_pso1", "md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_reflex","md_pbs1","md_foregrip"}

ITEM.iconCam = {
	pos = Vector(3, 25, -2),
	ang = Angle(0, 270, 0),
	fov = 70
}
ITEM.pacData = {
[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Angles"] = Angle(74.21875, -177.46875, -96.1875),
						["Position"] = Vector(-11.734, -4.97998046875, 0.350830078125),
						["Model"] = "models/weapons/w_smg_aks.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "3543445691",
						["Bone"] = "chest",
						["Name"] = "aks74u",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1059632402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_aks74u@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1513482183",
		["EditorExpand"] = true,
	},
},
}
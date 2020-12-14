AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Colt Anaconda"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.SelectIcon = surface.GetTextureID("weaponicons/mr96")
	killicon.Add("cw_mr96", "weaponicons/mr96", Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = false
	SWEP.NoShells = true
		
	SWEP.IronsightPos = Vector(4.24, 6, 2.65)
	SWEP.IronsightAng = Vector(0.8, -0.12, 0)

	SWEP.SprintPos = Vector(0.256, 0.01, 1.2)
	SWEP.SprintAng = Vector(-17.778, 0, 0)
	
	SWEP.AlternativePos = Vector(-0.281, 1.325, -0.52)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.ViewModelMovementScale = 0.8
	SWEP.FullAimViewmodelRecoil = false
	SWEP.HUD_MagText = "CYLINDER: "

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1.5, roll = 3, forward = 1, pitch = 4}
	SWEP.CustomizationMenuScale = 0.01
	SWEP.DisableSprintViewSimulation = true

	SWEP.UseHands = true
end

SWEP.LuaViewmodelRecoil = false
SWEP.CanRestOnObjects = false

SWEP.Attachments = {["+reload"] = {header = "Ammo", offset = {500, -75}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = "anaconda_shoot1",
	reload = "anaconda_reload",
	idle = "anaconda_idle1",
	draw = "anaconda_draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}},

	reload = {[1] = {time = 0.7, sound = "CW_MR96_CYLINDEROPEN"},
	[2] = {time = 1.2, sound = "CW_MR96_ROUNDSOUT"},
	[3] = {time = 2.4, sound = "CW_MR96_ROUNDSIN"},
	[4] = {time = 2.6, sound = "CW_MR96_CYLINDERCLOSE"}}}

SWEP.SpeedDec = 10

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.HoldType = "revolver"
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "revolver"
SWEP.FireModes = {"double"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 90
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/c_anaconda.mdl"
SWEP.WorldModel		= "models/weapons/w_anaconda.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".44 Magnum"

SWEP.FireDelay = 0.08
SWEP.FireSound = "CW_MR96_FIRE_LONG"
SWEP.Recoil = 3.6

SWEP.WearDamage = 0.125
SWEP.WearEffect = 0.001

SWEP.HipSpread = 0.125
SWEP.AimSpread = 0.025
SWEP.VelocitySensitivity = 7
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 110
SWEP.DeployTime = 0.7
SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.6
SWEP.ReloadHalt = 2.7

SWEP.ReloadTime_Empty = 1.6
SWEP.ReloadHalt_Empty = 2.7


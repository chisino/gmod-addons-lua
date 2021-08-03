ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Cooker"
ENT.Spawnable = true
ENT.Category = "Lord's Cooking Addon"


function ENT:SetupDataTables()

    self:NetworkVar("Int", 1, "DoughAmount")
    self:NetworkVar("Int", 2, "SauceAmount")
    self:NetworkVar("Int", 3, "MilkAmount")
    self:NetworkVar("Int", 4, "ChocAmount")

end
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()

	self:SetModel("models/props_junk/garbage_coffeemug001a.mdl")
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self.isRunning = false
		local phys = self:GetPhysicsObject()

	if (phys:IsValid()) then

		phys:Wake()

	end
end
	
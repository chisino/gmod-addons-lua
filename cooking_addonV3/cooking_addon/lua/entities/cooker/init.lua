AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("imgui.lua")

include("shared.lua")

util.AddNetworkString("cookerButton")

function ENT:Initialize()

	self:SetModel("models/props_c17/furnitureStove001a.mdl")
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self.isRunning = false
		local phys = self:GetPhysicsObject()

	if (phys:IsValid()) then
		phys:Wake()
	end

	phys:SetMass(phys:GetMass() - 1250) -- making cooker lighter so that it can be picked up with hands/gravgun
	
	self.isBaking = false
end


function ENT:StartTouch(ent) -- keeping track of counts and stopping when both are at 3

	if (self:GetDoughAmount() == 3 and self:GetSauceAmount() == 3) or (self:GetMilkAmount() == 3 and self:GetChocAmount() == 3)  then
		self.isBaking = true
	end

	if ent:GetClass() == "dough" and self.isBaking == false and self:GetDoughAmount() ~= 3  then
		ent:Remove()
		self:SetDoughAmount(self:GetDoughAmount() + 1)
	elseif ent:GetClass() == "sauce" and self.isBaking == false and self:GetSauceAmount() ~= 3 then
		ent:Remove()
		self:SetSauceAmount(self:GetSauceAmount() + 1)

	elseif (self:GetMilkAmount() == 3 and self:GetChocAmount() == 3) then
		self.isBaking = true

	elseif ent:GetClass() == "milk" and self.isBaking == false and self:GetMilkAmount() ~= 3  then
		ent:Remove()
		self:SetMilkAmount(self:GetMilkAmount() + 1)
	elseif ent:GetClass() == "chocolate" and self.isBaking == false and self:GetChocAmount() ~= 3 then
		ent:Remove()
		self:SetChocAmount(self:GetChocAmount() + 1)
	end
	
end


function ENT:Use()
	if self.isBaking == true then
		self.isBaking = false

		self:EmitSound("ambient/gas/steam2.wav", 50)

		if (self:GetDoughAmount() == 3 and self:GetSauceAmount() == 3) then

			local bread = ents.Create("bread")
			bread:SetPos(self:GetPos() + Vector(0,0,25))

			timer.Create( "cookingTime", 2, 1, function() 
				bread:Spawn()
				self:SetDoughAmount(0)
				self:SetSauceAmount(0)
				self:StopSound("ambient/gas/steam2.wav")
			end )

		elseif (self:GetMilkAmount() == 3 and self:GetChocAmount() == 3) then

			local hotcocoa = ents.Create("hotcocoa")
			hotcocoa:SetPos(self:GetPos() + Vector(0,0,25))

			timer.Create( "cookingTime2", 2, 1, function() 
				hotcocoa:Spawn()
				self:SetMilkAmount(0)
				self:SetChocAmount(0)
				self:StopSound("ambient/gas/steam2.wav")
			end )

		end

	end
end

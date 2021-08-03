include("shared.lua")

surface.CreateFont( "TheDefaultSettings", {
	font = "Oswald", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 80,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )


function ENT:Draw()
	self:DrawModel()

	local Ang = self:GetAngles() -- rotating angles for SimpleText
	local Pos = self:GetPos()
	Ang:RotateAroundAxis(self:GetAngles():Forward(), 90)
	Ang:RotateAroundAxis(self:GetAngles():Up(), 90)

	-- Right    --> +Forward
	-- Left     --> -Forward
	-- Up       --> +Right
	-- Down     --> -Right
	-- Forward  --> +Up
	-- Backward --> -Up

	local BoxAng = self:GetAngles() -- rotating angles for RoundedBox
	BoxAng:RotateAroundAxis(self:GetAngles():Forward(), 0)
	BoxAng:RotateAroundAxis(self:GetAngles():Up(), 180)
	BoxAng:RotateAroundAxis(self:GetAngles():Right(), 90)

	local amountTable = {432, 288, 144, 0} -- start at max width and go down (index 1)

	cam.Start3D2D(Pos + Ang:Up()*15 - Ang:Right()*12.2 - Ang:Forward()*23, BoxAng, 0.1) -- Drawing Dough Box *BAR*
		draw.RoundedBox(0, 10, 10, 70, amountTable[self:GetDoughAmount() + 1], Color(255,0,0))
		if (self:GetDoughAmount() == 3) then
			draw.RoundedBox(0, 10, 10, 70, 432, Color(0,255,0))
		end
	cam.End3D2D()

	cam.Start3D2D(Pos + Ang:Up()*15 - Ang:Right()*58 - Ang:Forward()*50, Ang, 0.1) -- Drawing Dough Counter *TEXT*
		draw.SimpleText("Dough: "..self:GetDoughAmount().." / 3", "TheDefaultSettings", 500, 500, Color(0,0,0), 1, 1)
	cam.End3D2D()

	cam.Start3D2D(Pos + Ang:Up()*15 - Ang:Right()*2.5 - Ang:Forward()*23, BoxAng, 0.1) -- Drawing Sauce Box *BAR*
		draw.RoundedBox(0, 10, 10, 70, amountTable[self:GetSauceAmount() + 1], Color(255,0,0))
		if (self:GetSauceAmount() == 3) then
			draw.RoundedBox(0, 10, 10, 70, 432, Color(0,255,0))
		end
	cam.End3D2D()

	cam.Start3D2D(Pos + Ang:Up()*15 - Ang:Right()*48 - Ang:Forward()*50, Ang, 0.1) -- Drawing Sauce Counter *TEXT*
		draw.SimpleText("Sauce: "..self:GetSauceAmount().." / 3", "TheDefaultSettings", 500, 500, Color(0,0,0), 1, 1)
	cam.End3D2D()

end

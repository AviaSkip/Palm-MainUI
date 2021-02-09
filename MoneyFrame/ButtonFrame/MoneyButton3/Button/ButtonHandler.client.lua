--[[
	RippleButton
	Handles a ripple button
]]

-- [[ VARIALBES ]]
local Mouse = game.Players.LocalPlayer:GetMouse()
local Button  = script.Parent
local RippleImg = script:WaitForChild('RippleImg')
local UmbraShadow = script.Parent.Parent:FindFirstChild("shadowHolder"):FindFirstChild("umbraShadow")
local Image = script.Parent:FindFirstChild("Image")
local ImageColour = Image.ImageColor3
local TweenService = game:GetService("TweenService")
local TweenDown = TweenService:Create(UmbraShadow, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {ImageTransparency = 0.06})
local TweenUp = TweenService:Create(UmbraShadow, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {ImageTransparency = 0.86})
local TweenColourDown = TweenService:Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(44, 44, 44)})
local TweenColourUp = TweenService:Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(57, 57, 57)})
local TweenImageDown = TweenService:Create(Image, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(223, 223, 223)})
local TweenImageUp = TweenService:Create(Image, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = ImageColour})

local function ripple(t)
	if t == "W.I.P" then
		warn("W.I.P cannot be used")
	elseif t == "Click" then
		local ripple = RippleImg:Clone()
		ripple.Parent = Button
		local x, y = (Mouse.X - ripple.AbsolutePosition.X), (Mouse.Y - ripple.AbsolutePosition.Y)
		ripple.Position = UDim2.new(0, x, 0, y)
		local len, size = 0.45, nil -- 0.35
		local downlen = 0.2
		if Button.AbsoluteSize.X >= Button.AbsoluteSize.Y then
			size = (Button.AbsoluteSize.X * 1.5)
		else
			size = (Button.AbsoluteSize.Y * 1.5)
		end
		ripple:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
		for i = 1, 10 do
			ripple.ImageTransparency = ripple.ImageTransparency + 0.05
			wait(len / 12)
		end
		ripple:Destroy()
	else
		warn("RippleButton: Button '" .. script.Parent.Parent.Name .. "': '" .. t .. "' is not a valid type")
	end
end

Button.MouseButton1Click:Connect(function()
	ripple("Click")
end)

Button.MouseButton1Down:Connect(function()
	TweenDown:Play()
	TweenColourDown:Play()
end)

Button.MouseButton1Up:Connect(function()
	TweenUp:Play()
	TweenColourUp:Play()
end)

Button.MouseLeave:Connect(function()
	TweenUp:Play()
	TweenColourUp:Play()
end)
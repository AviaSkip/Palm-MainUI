--[[
	UIHandler
	Handles all the UI descendants of MainUI
]]

-- [[ Services ]]
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ContentProvider = game:GetService("ContentProvider")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

-- [[ Frames ]]
local BottomFrame = script.Parent:WaitForChild("BottomFrame")
local TeamFrame = script.Parent:WaitForChild("TeamFrame")
local SettingsFrame = script.Parent:WaitForChild("SettingsFrame")
local MoneyFrame = script.Parent:WaitForChild("MoneyFrame")
local MapFrame = script.Parent:WaitForChild("MapFrame")

-- [[ Buttons ]]
local TeamButton = BottomFrame:WaitForChild("TeamButton")
local SettingsButton = BottomFrame:WaitForChild("SettingsButton")
local MoneyButton = BottomFrame:WaitForChild("MoneyButton")
local MapButton = BottomFrame:WaitForChild("MapButton")

-- [[ Misc ]]
local LocalPlayer = Players.LocalPlayer
local UserId = LocalPlayer.UserId
local TeamEnabled = false
local SettingEnabled = false
local MoneyEnabled = false
local MapEnabled = false
local AssetsLoaded = false

local tweenInfo = TweenInfo.new(0.53, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- [[ Marketplace Handler ]]
local AssetIds = {
	["Cash1"] = 1149142135,
	["Cash2"] = 1149142165,
	["Cash3"] = 1149142230
}
local BuyButton1 = MoneyFrame.ButtonFrame:WaitForChild("MoneyButton1")
local BuyButton2 = MoneyFrame.ButtonFrame:WaitForChild("MoneyButton2")
local BuyButton3 = MoneyFrame.ButtonFrame:WaitForChild("MoneyButton3")

BuyButton1.Button.MouseButton1Click:Connect(function()
	MarketplaceService:PromptProductPurchase(LocalPlayer, AssetIds.Cash1)
	
	MarketplaceService.PromptProductPurchaseFinished:Connect(function(UserId, assetid, isFinished)
		if isFinished then
			-- TODO: ADD CASH TO ACCOUNT
			game.Players.AviaSkip.leaderstats.Money.Value += 1000
		end
	end)
end)

BuyButton2.Button.MouseButton1Click:Connect(function()
	MarketplaceService:PromptProductPurchase(LocalPlayer, AssetIds.Cash2)

	MarketplaceService.PromptProductPurchaseFinished:Connect(function(UserId, assetid, isFinished)
		if isFinished then
			-- TODO: ADD CASH TO ACCOUNT
			game.Players.AviaSkip.leaderstats.Money.Value += 5000
		end
	end)
end)

BuyButton3.Button.MouseButton1Click:Connect(function()
	MarketplaceService:PromptProductPurchase(LocalPlayer, AssetIds.Cash3)

	MarketplaceService.PromptProductPurchaseFinished:Connect(function(UserId, assetid, isFinished)
		if isFinished then
			-- TODO: ADD CASH TO ACCOUNT
			game.Players.AviaSkip.leaderstats.Money.Value += 10000
		end
	end)
end)

-- [[ Asset Pre-Loader ]]
local Assets = { "rbxassetid://6356403497", "rbxassetid://6356416122", "rbxassetid://6351938199", "rbxassetid://6347534921"}
ContentProvider:PreloadAsync(Assets, function()
	AssetsLoaded = true
end)

-- [[ Tween Animations ]]
local function TweenIn(menu)
	if menu == MapFrame then
		local TweenIn = TweenService:Create(menu, tweenInfo, {Position = UDim2.new(0.008, 0, 0.683, 0)})
		TweenIn:Play()
	else
		local TweenIn = TweenService:Create(menu, tweenInfo, {Position = UDim2.new(0.008, 0, 0.745, 0)})
		TweenIn:Play()
	end
end

local function TweenOut(menu)
	if menu == MapFrame then
		local TweenOut = TweenService:Create(menu, tweenInfo, {Position = UDim2.new(-0.18, 0, 0.683, 0)})
		TweenOut:Play()
	else
		local TweenOut = TweenService:Create(menu, tweenInfo, {Position = UDim2.new(-0.18, 0, 0.745, 0)})
		TweenOut:Play()
	end
end

local function OpenMenu(menu)
	if menu == "Settings" then
		if TeamEnabled and MoneyEnabled and MapEnabled == false then
			TweenIn(SettingsFrame)
			SettingEnabled = true
		elseif SettingEnabled == true then
			TweenOut(SettingsFrame)
			SettingEnabled = false
		else
			TeamEnabled = false
			MoneyEnabled = false
			MapEnabled = false
			TweenOut(TeamFrame)
			TweenOut(MoneyFrame)
			TweenOut(MapFrame)
			wait(tweenInfo.Time)
			TweenIn(SettingsFrame)
			SettingEnabled = true
		end
	elseif menu == "Map" then
		if TeamEnabled and MoneyEnabled and SettingEnabled == false then
			TweenIn(MapFrame)
			MapEnabled = true
		elseif MapEnabled == true then
			TweenOut(MapFrame)
			MapEnabled = false
		else
			TeamEnabled = false
			MoneyEnabled = false
			SettingEnabled = false
			TweenOut(TeamFrame)
			TweenOut(MoneyFrame)
			TweenOut(SettingsFrame)
			wait(tweenInfo.Time)
			TweenIn(MapFrame)
			MapEnabled = true
		end
	elseif menu == "Money" then
		if TeamEnabled and MapEnabled and SettingEnabled == false then
			TweenIn(MoneyFrame)
			MoneyEnabled = true
		elseif MoneyEnabled == true then
			TweenOut(MoneyFrame)
			MoneyEnabled = false
		else
			TeamEnabled = false
			MapEnabled = false
			SettingEnabled = false
			TweenOut(TeamFrame)
			TweenOut(MapFrame)
			TweenOut(SettingsFrame)
			wait(tweenInfo.Time)
			TweenIn(MoneyFrame)
			MoneyEnabled = true
		end
	elseif menu == "Team" then
		if MoneyEnabled and MapEnabled and SettingEnabled == false then
			TweenIn(TeamFrame)
			TeamEnabled = true
		elseif TeamEnabled == true then
			TweenOut(TeamFrame)
			TeamEnabled = false
		else
			MoneyEnabled = false
			MapEnabled = false
			SettingEnabled = false
			TweenOut(MoneyFrame)
			TweenOut(MapFrame)
			TweenOut(SettingsFrame)
			wait(tweenInfo.Time)
			TweenIn(TeamFrame)
			TeamEnabled = true
		end
	end
end

local TweenBottomFrameOut = TweenService:Create(BottomFrame, tweenInfo, {Position = UDim2.new(-0.1, 0, 0.874, 0)})
local TweenBottomFrameIn = TweenService:Create(BottomFrame, tweenInfo, {Position = UDim2.new(0.007, 0, 0.874, 0)})

local function HideUI()
	TweenOut(MapFrame)
	TweenOut(MoneyFrame)
	TweenOut(SettingsFrame)
	TweenOut(TeamFrame)
	TweenBottomFrameOut:Play()
	MapEnabled = false
	MoneyEnabled = false
	SettingEnabled = false
	TeamEnabled = false
end

local function ShowUI()
	TweenBottomFrameIn:Play()
end

MapButton.Button.MouseButton1Click:Connect(function()
	OpenMenu("Map")
end)

MoneyButton.Button.MouseButton1Click:Connect(function()
	OpenMenu("Money")
end)

SettingsButton.Button.MouseButton1Click:Connect(function()
	OpenMenu("Settings")
end)

TeamButton.Button.MouseButton1Click:Connect(function()
	OpenMenu("Team")
end)

-- [[ Map Handler ]]

local ScreenGui = MapFrame
local MinimapFrame = ScreenGui:WaitForChild("Minimap")
local DirectionArrow = MinimapFrame:WaitForChild("DirectionArrow")
local Char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Char:WaitForChild("HumanoidRootPart")
local Humanoid = Char:WaitForChild("Humanoid")
local CurrentCamera = Instance.new("Camera")

CurrentCamera.FieldOfView = 1
CurrentCamera.CameraType = Enum.CameraType.Scriptable
CurrentCamera.Parent = workspace
MinimapFrame.CurrentCamera = CurrentCamera

for i, minimapObject in pairs(workspace.MinimapObjects:GetChildren()) do
	minimapObject:Clone().Parent = MinimapFrame
end

game:GetService("RunService").RenderStepped:Connect(function()
	local camCFrame = CFrame.new(HRP.Position + Vector3.new(0, 5000, 0), HRP.Position)
	CurrentCamera.CFrame = camCFrame

	DirectionArrow.Rotation = -HRP.Orientation.Y - 90
end)
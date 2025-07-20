-- Slap Tower Script by TNTG (Delta X dùng)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")

-- GUI Menu
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Enabled = true
local Frame = Instance.new("Frame", ScreenGui)
Frame.Position = UDim2.new(0.3, 0, 0.3, 0)
Frame.Size = UDim2.new(0, 200, 0, 220)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderSizePixel = 0

local UIListLayout = Instance.new("UIListLayout", Frame)
UIListLayout.Padding = UDim.new(0, 8)

function createButton(name, callback)
	local btn = Instance.new("TextButton", Frame)
	btn.Size = UDim2.new(1, 0, 0, 30)
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.MouseButton1Click:Connect(callback)
	return btn
end

-- Fly
local flying = false
createButton("🕊️ Fly", function()
	local char = LocalPlayer.Character
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	if not flying then
		hum.PlatformStand = true
		local bv = Instance.new("BodyVelocity", char.HumanoidRootPart)
		bv.Name = "FlyForce"
		bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
		bv.Velocity = Vector3.new(0, 50, 0)
	else
		local fly = char.HumanoidRootPart:FindFirstChild("FlyForce")
		if fly then fly:Destroy() end
		hum.PlatformStand = false
	end
	flying = not flying
end)

-- Slap mạnh
createButton("💥 Slap mạnh", function()
	local char = LocalPlayer.Character
	local HRP = char and char:FindFirstChild("HumanoidRootPart")
	if HRP then
		HRP.Velocity = HRP.CFrame.lookVector * 300
	end
end)

-- Out (đẩy người)
createButton("🌪️ Out người khác", function()
	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			plr.Character.HumanoidRootPart.Velocity = Vector3.new(999, 999, 999)
		end
	end
end)

-- Anti Ban đơn giản
createButton("🛡️ Anti Ban", function()
	local mt = getrawmetatable(game)
	setreadonly(mt, false)
	local old = mt.__namecall
	mt.__namecall = newcclosure(function(self, ...)
		local args = {...}
		local method = getnamecallmethod()
		if method == "Kick" then
			return warn("Chặn Kick rồi!")
		end
		return old(self, unpack(args))
	end)
end)

-- Ẩn/Hiện GUI bằng phím M
UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.M then
		ScreenGui.Enabled = not ScreenGui.Enabled
	end
end)

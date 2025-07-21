local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Open = Instance.new("TextButton", ScreenGui)
local Main = Instance.new("Frame", ScreenGui)
local TabButtons = {}
local Tabs = {}

Open.Size = UDim2.new(0, 100, 0, 30)
Open.Position = UDim2.new(0, 0, 0.5, -15)
Open.Text = "Menu"
Open.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Open.TextColor3 = Color3.fromRGB(255, 255, 255)

Main.Size = UDim2.new(0, 350, 0, 400)
Main.Position = UDim2.new(0, 110, 0.5, -200)
Main.Visible = false
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

Open.MouseButton1Click:Connect(function()
	Main.Visible = not Main.Visible
end)

function CreateTab(name)
	local tab = Instance.new("ScrollingFrame", Main)
	tab.Name = name
	tab.Size = UDim2.new(1, 0, 1, -30)
	tab.Position = UDim2.new(0, 0, 0, 30)
	tab.Visible = false
	tab.CanvasSize = UDim2.new(0, 0, 5, 0)
	tab.ScrollBarThickness = 4

	local button = Instance.new("TextButton", Main)
	button.Size = UDim2.new(0, 80, 0, 30)
	button.Position = UDim2.new(#TabButtons * 0.24, 0, 0, 0)
	button.Text = name
	button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	button.TextColor3 = Color3.fromRGB(255, 255, 255)

	button.MouseButton1Click:Connect(function()
		for i, t in pairs(Tabs) do
			t.Visible = false
		end
		tab.Visible = true
	end)

	table.insert(TabButtons, button)
	Tabs[name] = tab
	return tab
end

function CreateToggle(parent, text, callback)
	local toggle = Instance.new("TextButton", parent)
	toggle.Size = UDim2.new(0, 300, 0, 40)
	toggle.Text = "OFF - " .. text
	toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
	toggle.MouseButton1Click:Connect(function()
		if toggle.Text:sub(1, 3) == "OFF" then
			toggle.Text = "ON - " .. text
			callback(true)
		else
			toggle.Text = "OFF - " .. text
			callback(false)
		end
	end)
end

local FarmTab = CreateTab("Farm")
local PvPTab = CreateTab("PvP")
local ESPTab = CreateTab("ESP")
local SkillTab = CreateTab("Skill")
local BossTab = CreateTab("Boss")

CreateToggle(FarmTab, "Auto Farm", function(v) _G.AutoFarm = v end)
CreateToggle(FarmTab, "Nhận Nhiệm Vụ", function(v) _G.GetQuest = v end)
CreateToggle(FarmTab, "Hút Quái", function(v) _G.BringMob = v end)
CreateToggle(FarmTab, "Bay Trên Đầu", function(v) _G.FlyAbove = v end)

CreateToggle(PvPTab, "Auto PvP", function(v) _G.AutoPvP = v end)
local PvPName = Instance.new("TextBox", PvPTab)
PvPName.Size = UDim2.new(0, 300, 0, 40)
PvPName.PlaceholderText = "Tên người chơi cần đánh"

CreateToggle(ESPTab, "ESP Người", function(v) _G.ESPPlayer = v end)
CreateToggle(ESPTab, "ESP Rương", function(v) _G.ESPChest = v end)
CreateToggle(ESPTab, "ESP Boss", function(v) _G.ESPBoss = v end)

CreateToggle(SkillTab, "Auto Skill Z", function(v) _G.SkillZ = v end)
CreateToggle(SkillTab, "Auto Skill X", function(v) _G.SkillX = v end)
CreateToggle(SkillTab, "Auto Skill C", function(v) _G.SkillC = v end)

CreateToggle(BossTab, "Server Hop Boss", function(v) _G.HopBoss = v end)
CreateToggle(BossTab, "Tìm Rip_Indra", function(v) _G.FindIndra = v end)
CreateToggle(BossTab, "Tìm Long Nha", function(v) _G.FindLeopard = v end)

spawn(function()
	while task.wait() do
		if _G.AutoFarm then
			-- logic farm theo cấp
		end
		if _G.AutoPvP and PvPName.Text ~= "" then
			-- logic tấn công người theo tên
		end
		if _G.SkillZ then
			game.VirtualInputManager:SendKeyEvent(true, "Z", false, game)
		end
		if _G.SkillX then
			game.VirtualInputManager:SendKeyEvent(true, "X", false, game)
		end
		if _G.SkillC then
			game.VirtualInputManager:SendKeyEvent(true, "C", false, game)
		end
	end
end)

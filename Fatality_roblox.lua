local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Colors = {
    Red = Color3.fromRGB(200, 50, 50),
    White = Color3.fromRGB(255, 255, 255),
    Dark = Color3.fromRGB(30, 30, 30),
    DarkPink = Color3.fromRGB(150, 50, 80)
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FatalityMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = CoreGui

local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 20, 0, 20)
ToggleButton.BackgroundColor3 = Colors.DarkPink
ToggleButton.BorderSizePixel = 0
ToggleButton.Text = "F"
ToggleButton.TextColor3 = Colors.White
ToggleButton.TextScaled = true
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleButton

local ToggleShadow = Instance.new("ImageLabel")
ToggleShadow.Name = "Shadow"
ToggleShadow.Size = UDim2.new(1, 10, 1, 10)
ToggleShadow.Position = UDim2.new(0, -5, 0, -5)
ToggleShadow.BackgroundTransparency = 1
ToggleShadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
ToggleShadow.ImageColor3 = Colors.Dark
ToggleShadow.ImageTransparency = 0.6
ToggleShadow.ScaleType = Enum.ScaleType.Slice
ToggleShadow.SliceCenter = Rect.new(10, 10, 118, 118)
ToggleShadow.Parent = ToggleButton

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.BackgroundColor3 = Colors.Red
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

local MainShadow = Instance.new("ImageLabel")
MainShadow.Name = "Shadow"
MainShadow.Size = UDim2.new(1, 20, 1, 20)
MainShadow.Position = UDim2.new(0, -10, 0, -10)
MainShadow.BackgroundTransparency = 1
MainShadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
MainShadow.ImageColor3 = Colors.Dark
MainShadow.ImageTransparency = 0.6
MainShadow.ScaleType = Enum.ScaleType.Slice
MainShadow.SliceCenter = Rect.new(10, 10, 118, 118)
MainShadow.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Colors.Dark
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 8)
TopCorner.Parent = TopBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "Title"
TitleLabel.Size = UDim2.new(1, -50, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Fatality"
TitleLabel.TextColor3 = Colors.DarkPink
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Parent = TopBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -40, 0, 5)
CloseButton.BackgroundColor3 = Colors.Red
CloseButton.BorderSizePixel = 0
CloseButton.Text = "×"
CloseButton.TextColor3 = Colors.White
CloseButton.TextScaled = true
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 4)
CloseCorner.Parent = CloseButton

local TabsFrame = Instance.new("Frame")
TabsFrame.Name = "TabsFrame"
TabsFrame.Size = UDim2.new(0, 120, 1, -40)
TabsFrame.Position = UDim2.new(0, 0, 0, 40)
TabsFrame.BackgroundColor3 = Colors.White
TabsFrame.BorderSizePixel = 0
TabsFrame.Parent = MainFrame

local TabsCorner = Instance.new("UICorner")
TabsCorner.CornerRadius = UDim.new(0, 8)
TabsCorner.Parent = TabsFrame

local TabButtons = {
    {Name = "Combat", Text = "Combat"},
    {Name = "Visuals", Text = "Visuals"},
    {Name = "Misc", Text = "Misc"},
    {Name = "Players", Text = "Players"},
    {Name = "Settings", Text = "Settings"}
}

local CurrentTab = nil

for i, tabData in ipairs(TabButtons) do
    local TabButton = Instance.new("TextButton")
    TabButton.Name = tabData.Name .. "Tab"
    TabButton.Size = UDim2.new(1, -10, 0, 35)
    TabButton.Position = UDim2.new(0, 5, 0, (i-1)*40 + 5)
    TabButton.BackgroundColor3 = Colors.Dark
    TabButton.BorderSizePixel = 0
    TabButton.Text = tabData.Text
    TabButton.TextColor3 = Colors.Red
    TabButton.TextScaled = true
    TabButton.Font = Enum.Font.Gotham
    TabButton.Parent = TabsFrame

    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 4)
    TabCorner.Parent = TabButton

    TabButton.MouseButton1Click:Connect(function()
        if CurrentTab then
            local oldTabContent = MainFrame:FindFirstChild(CurrentTab.Name .. "Content")
            if oldTabContent then
                oldTabContent.Visible = false
            end
            local oldTabButton = TabsFrame:FindFirstChild(CurrentTab.Name .. "Tab")
            if oldTabButton then
                oldTabButton.BackgroundColor3 = Colors.Dark
                oldTabButton.TextColor3 = Colors.Red
            end
        end

        local newTabContent = MainFrame:FindFirstChild(tabData.Name .. "Content")
        if newTabContent then
            newTabContent.Visible = true
        end

        TabButton.BackgroundColor3 = Colors.DarkPink
        TabButton.TextColor3 = Colors.White
        CurrentTab = tabData
    end)
end

local function createTabContent(tabName)
    local Content = Instance.new("ScrollingFrame")
    Content.Name = tabName .. "Content"
    Content.Size = UDim2.new(1, -130, 1, -45)
    Content.Position = UDim2.new(0, 120, 0, 40)
    Content.BackgroundTransparency = 1
    Content.BorderSizePixel = 0
    Content.ScrollBarThickness = 8
    Content.CanvasSize = UDim2.new(0, 0, 0, 600)
    Content.Visible = tabName == "Combat"
    Content.Parent = MainFrame

    local Layout = Instance.new("UIListLayout")
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 5)
    Layout.Parent = Content

    return Content
end

local CombatContent = createTabContent("Combat")
local VisualsContent = createTabContent("Visuals")
createTabContent("Misc")
createTabContent("Players")
createTabContent("Settings")

local CombatFeatures = {
    {Name = "Silent Aim", Settings = {
        {Type = "Checkbox", Name = "Raycast Head", Checked = false},
        {Type = "Checkbox", Name = "Raycast Torso", Checked = false},
        {Type = "Checkbox", Name = "Raycast Random", Checked = true},
        {Type = "Slider", Name = "FOV: 90", Value = 90},
        {Type = "Slider", Name = "Smoothness: 0.1", Value = 0.1},
        {Type = "Slider", Name = "Hit Chance: 100%", Value = 100},
        {Type = "Checkbox", Name = "Prediction", Checked = true},
        {Type = "Checkbox", Name = "Visibility Check", Checked = false},
        {Type = "Slider", Name = "Distance Limit: 1000", Value = 1000},
        {Type = "Checkbox", Name = "Team Check", Checked = true}
    }},
    {Name = "Auto Pick", Settings = {
        {Type = "Checkbox", Name = "Auto Pickup Weapons", Checked = true},
        {Type = "Checkbox", Name = "Prioritize Rare", Checked = false},
        {Type = "Slider", Name = "Pickup Range: 50", Value = 50},
        {Type = "Checkbox", Name = "Auto Equip", Checked = true}
    }},
    {Name = "Fake Lag", Settings = {
        {Type = "Slider", Name = "Lag Intensity: 0.5", Value = 0.5},
        {Type = "Checkbox", Name = "Packet Loss Mode", Checked = false},
        {Type = "Slider", Name = "Delay: 100ms", Value = 100},
        {Type = "Checkbox", Name = "Jitter", Checked = true}
    }}
}

local VisualsFeatures = {
    {Name = "ESP Hitbox", Settings = {
        {Type = "Checkbox", Name = "Highlight Local Hitbox", Checked = true},
        {Type = "Checkbox", Name = "Highlight Enemy Hitboxes", Checked = false},
        {Type = "Slider", Name = "Highlight Color R: 255", Value = 255},
        {Type = "Slider", Name = "Highlight Color G: 0", Value = 0},
        {Type = "Slider", Name = "Highlight Color B: 0", Value = 0}
    }}
}

local function createFeature(feature, parent)
    local FeatureToggle = Instance.new("TextButton")
    FeatureToggle.Name = feature.Name .. "Toggle"
    FeatureToggle.Size = UDim2.new(1, 0, 0, 30)
    FeatureToggle.BackgroundColor3 = Colors.Dark
    FeatureToggle.BorderSizePixel = 0
    FeatureToggle.Text = feature.Name .. ": OFF"
    FeatureToggle.TextColor3 = Colors.White
    FeatureToggle.TextScaled = true
    FeatureToggle.Font = Enum.Font.Gotham
    FeatureToggle.Parent = parent

    local FeatureToggleCorner = Instance.new("UICorner")
    FeatureToggleCorner.CornerRadius = UDim.new(0, 4)
    FeatureToggleCorner.Parent = FeatureToggle

    local isEnabled = false
    FeatureToggle.MouseButton1Click:Connect(function()
        isEnabled = not isEnabled
        FeatureToggle.Text = feature.Name .. ": " .. (isEnabled and "ON" or "OFF")
        FeatureToggle.BackgroundColor3 = isEnabled and Colors.DarkPink or Colors.Dark
        getgenv()["Fatality_" .. feature.Name:gsub(" ", "_") .. "_Enabled"] = isEnabled
    end)

    local holdStart = nil
    FeatureToggle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            holdStart = tick()
        end
    end)

    FeatureToggle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and holdStart and tick() - holdStart >= 0.5 then
            local QuickToggle = Instance.new("TextButton")
            QuickToggle.Name = feature.Name .. "QuickToggle"
            QuickToggle.Size = UDim2.new(0, 30, 0, 30)
            QuickToggle.Position = UDim2.new(0, 80, 0, 20)
            QuickToggle.BackgroundColor3 = isEnabled and Colors.DarkPink or Colors.Dark
            QuickToggle.BorderSizePixel = 0
            QuickToggle.Text = feature.Name:sub(1, 1)
            QuickToggle.TextColor3 = Colors.White
            QuickToggle.TextScaled = true
            QuickToggle.Font = Enum.Font.Gotham
            QuickToggle.Parent = ScreenGui

            local QuickCorner = Instance.new("UICorner")
            QuickCorner.CornerRadius = UDim.new(1, 0)
            QuickCorner.Parent = QuickToggle

            local QuickShadow = Instance.new("ImageLabel")
            QuickShadow.Size = UDim2.new(1, 6, 1, 6)
            QuickShadow.Position = UDim2.new(0, -3, 0, -3)
            QuickShadow.BackgroundTransparency = 1
            QuickShadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
            QuickShadow.ImageColor3 = Colors.Dark
            QuickShadow.ImageTransparency = 0.6
            QuickShadow.ScaleType = Enum.ScaleType.Slice
            QuickShadow.SliceCenter = Rect.new(10, 10, 118, 118)
            QuickShadow.Parent = QuickToggle

            local quickDragging, quickDragStart, quickStartPos = false, nil, nil
            QuickToggle.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    quickDragging = true
                    quickDragStart = input.Position
                    quickStartPos = QuickToggle.Position
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if quickDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local delta = input.Position - quickDragStart
                    QuickToggle.Position = UDim2.new(quickStartPos.X.Scale, quickStartPos.X.Offset + delta.X, quickStartPos.Y.Scale, quickStartPos.Y.Offset + delta.Y)
                end
            end)

            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    quickDragging = false
                end
            end)

            QuickToggle.MouseButton1Click:Connect(function()
                isEnabled = not isEnabled
                FeatureToggle.Text = feature.Name .. ": " .. (isEnabled and "ON" or "OFF")
                FeatureToggle.BackgroundColor3 = isEnabled and Colors.DarkPink or Colors.Dark
                QuickToggle.BackgroundColor3 = isEnabled and Colors.DarkPink or Colors.Dark
                getgenv()["Fatality_" .. feature.Name:gsub(" ", "_") .. "_Enabled"] = isEnabled
            end)
        end
        holdStart = nil
    end)

    local SettingsFrame = Instance.new("Frame")
    SettingsFrame.Name = feature.Name .. "Settings"
    SettingsFrame.Size = UDim2.new(1, 0, 0, #feature.Settings * 22)
    SettingsFrame.BackgroundColor3 = Colors.White
    SettingsFrame.BorderSizePixel = 0
    SettingsFrame.LayoutOrder = 1
    SettingsFrame.Parent = parent

    local SettingsCorner = Instance.new("UICorner")
    SettingsCorner.CornerRadius = UDim.new(0, 4)
    SettingsCorner.Parent = SettingsFrame

    local SettingsLayout = Instance.new("UIListLayout")
    SettingsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SettingsLayout.Padding = UDim.new(0, 2)
    SettingsLayout.Parent = SettingsFrame

    for _, setting in ipairs(feature.Settings) do
        local SettingButton = Instance.new("TextButton")
        SettingButton.Name = setting.Name
        SettingButton.Size = UDim2.new(1, -10, 0, 20)
        SettingButton.Position = UDim2.new(0, 5, 0, 0)
        SettingButton.BackgroundColor3 = Colors.Dark
        SettingButton.BorderSizePixel = 0
        SettingButton.Text = setting.Name .. (setting.Type == "Checkbox" and (setting.Checked and " [ON]" or " [OFF]") or "")
        SettingButton.TextColor3 = Colors.Red
        SettingButton.TextScaled = true
        SettingButton.Font = Enum.Font.Gotham
        SettingButton.Parent = SettingsFrame

        local SettingCorner = Instance.new("UICorner")
        SettingCorner.CornerRadius = UDim.new(0, 2)
        SettingCorner.Parent = SettingButton

        if setting.Type == "Checkbox" then
            local checked = setting.Checked
            SettingButton.MouseButton1Click:Connect(function()
                checked = not checked
                SettingButton.Text = setting.Name .. (checked and " [ON]" or " [OFF]")
                getgenv()["Fatality_" .. feature.Name:gsub(" ", "_") .. "_" .. setting.Name:gsub(" ", "_"):gsub(":", "")] = checked
            end)
        else
            local ValueBox = Instance.new("TextBox")
            ValueBox.Size = UDim2.new(0, 60, 1, 0)
            ValueBox.Position = UDim2.new(1, -70, 0, 0)
            ValueBox.BackgroundColor3 = Colors.DarkPink
            ValueBox.BorderSizePixel = 0
            ValueBox.Text = tostring(setting.Value)
            ValueBox.TextColor3 = Colors.White
            ValueBox.TextScaled = true
            ValueBox.Font = Enum.Font.Gotham
            ValueBox.Parent = SettingButton

            local ValueCorner = Instance.new("UICorner")
            ValueCorner.CornerRadius = UDim.new(0, 2)
            ValueCorner.Parent = ValueBox

            ValueBox.FocusLost:Connect(function()
                local val = tonumber(ValueBox.Text) or setting.Value
                ValueBox.Text = tostring(val)
                getgenv()["Fatality_" .. feature.Name:gsub(" ", "_") .. "_" .. setting.Name:gsub(" ", "_"):gsub(":", "")] = val
            end)
        end
    end
end

for _, feature in ipairs(CombatFeatures) do
    createFeature(feature, CombatContent)
end
for _, feature in ipairs(VisualsFeatures) do
    createFeature(feature, VisualsContent)
end

CombatContent.CanvasSize = UDim2.new(0, 0, 0, #CombatFeatures * 150)
VisualsContent.CanvasSize = UDim2.new(0, 0, 0, #VisualsFeatures * 100)

local firstTab = TabButtons[1]
local firstTabButton = TabsFrame:FindFirstChild(firstTab.Name .. "Tab")
if firstTabButton then
    firstTabButton.BackgroundColor3 = Colors.DarkPink
    firstTabButton.TextColor3 = Colors.White
    CurrentTab = firstTab
end

local openTween = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local closeTween = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In)

local function openMenu()
    MainFrame.Visible = true
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    TweenService:Create(MainFrame, openTween, {
        Size = UDim2.new(0, 400, 0, 300),
        Position = UDim2.new(0.5, -200, 0.5, -150)
    }):Play()
end

local function closeMenu()
    TweenService:Create(MainFrame, closeTween, {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    wait(0.3)
    MainFrame.Visible = false
end

ToggleButton.MouseButton1Click:Connect(function()
    if MainFrame.Visible then
        closeMenu()
    else
        openMenu()
    end
end)

CloseButton.MouseButton1Click:Connect(closeMenu)

local toggleDragging, dragging = false, false
local toggleDragStart, dragStart = nil, nil
local toggleStartPos, startPos = nil, nil

ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        toggleDragging = true
        toggleDragStart = input.Position
        toggleStartPos = ToggleButton.Position
    end
end)

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        if toggleDragging then
            local delta = input.Position - toggleDragStart
            ToggleButton.Position = UDim2.new(toggleStartPos.X.Scale, toggleStartPos.X.Offset + delta.X, toggleStartPos.Y.Scale, toggleStartPos.Y.Offset + delta.Y)
        end
        if dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        toggleDragging = false
        dragging = false
    end
end)
local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

getgenv().Fatality_Silent_Aim_Enabled = false
getgenv().Fatality_Silent_Aim_Raycast_Head = false
getgenv().Fatality_Silent_Aim_Raycast_Torso = false
getgenv().Fatality_Silent_Aim_Raycast_Random = true
getgenv().Fatality_Silent_Aim_FOV = 90
getgenv().Fatality_Silent_Aim_Smoothness = 0.1
getgenv().Fatality_Silent_Aim_Hit_Chance = 100
getgenv().Fatality_Silent_Aim_Prediction = true
getgenv().Fatality_Silent_Aim_Visibility_Check = false
getgenv().Fatality_Silent_Aim_Distance_Limit = 1000
getgenv().Fatality_Silent_Aim_Team_Check = true

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = getgenv().Fatality_Silent_Aim_FOV

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if getgenv().Fatality_Silent_Aim_Team_Check and player.Team == LocalPlayer.Team then continue end
            local distance = (Camera.CFrame.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if distance > getgenv().Fatality_Silent_Aim_Distance_Limit then continue end

            local screenPoint, onScreen = Camera:WorldToScreenPoint(player.Character.HumanoidRootPart.Position)
            if not onScreen then continue end

            local fovDistance = (Vector2.new(screenPoint.X, screenPoint.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
            if fovDistance < shortestDistance then
                if getgenv().Fatality_Silent_Aim_Visibility_Check then
                    local ray = Camera:ScreenPointToRay(Mouse.X, Mouse.Y)
                    local raycastParams = RaycastParams.new()
                    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
                    local result = Workspace:Raycast(ray.Origin, ray.Direction * distance, raycastParams)
                    if result and result.Instance:IsDescendantOf(player.Character) then
                        closestPlayer = player
                        shortestDistance = fovDistance
                    end
                else
                    closestPlayer = player
                    shortestDistance = fovDistance
                end
            end
        end
    end

    return closestPlayer
end

local function getTargetPart(player)
    local char = player.Character
    if not char then return nil end

    local parts = {"Head"}
    if getgenv().Fatality_Silent_Aim_Raycast_Torso then table.insert(parts, "Torso") end
    if getgenv().Fatality_Silent_Aim_Raycast_Random then parts = {"Head", "Torso", "HumanoidRootPart"} end

    local part = parts[math.random(1, #parts)]
    return char:FindFirstChild(part)
end

mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    local method = getnamecallmethod()

    if getgenv().Fatality_Silent_Aim_Enabled and method == "FireServer" and (self.Name:find("Aim") or self.Name:find("Shoot")) then
        local hitChance = getgenv().Fatality_Silent_Aim_Hit_Chance / 100
        if math.random() > hitChance then return oldNamecall(self, ...) end

        local closest = getClosestPlayer()
        if closest and getTargetPart(closest) then
            local targetPart = getTargetPart(closest)
            if getgenv().Fatality_Silent_Aim_Prediction then
                local velocity = closest.Character.HumanoidRootPart.Velocity
                targetPart.CFrame = targetPart.CFrame + (velocity * getgenv().Fatality_Silent_Aim_Smoothness)
            end
            args[2] = targetPart
        end
    end

    return oldNamecall(self, ...)
end)

setreadonly(mt, true)

getgenv().Fatality_Auto_Pick_Enabled = false
getgenv().Fatality_Auto_Pick_Auto_Pickup_Weapons = true
getgenv().Fatality_Auto_Pick_Prioritize_Rare = false
getgenv().Fatality_Auto_Pick_Pickup_Range = 50
getgenv().Fatality_Auto_Pick_Auto_Equip = true

RunService.Heartbeat:Connect(function()
    if not getgenv().Fatality_Auto_Pick_Enabled then return end
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    for _, obj in ipairs(Workspace:GetChildren()) do
        if obj:IsA("Tool") or obj.Name:find("Weapon") then
            local dist = (char.HumanoidRootPart.Position - obj.Handle.Position).Magnitude
            if dist < getgenv().Fatality_Auto_Pick_Pickup_Range then
                if getgenv().Fatality_Auto_Pick_Prioritize_Rare and obj.Rarity.Value ~= "Rare" then continue end
                obj.Handle.CFrame = char.HumanoidRootPart.CFrame
                firetouchinterest(char.HumanoidRootPart, obj.Handle, 0)
                wait(0.1)
                firetouchinterest(char.HumanoidRootPart, obj.Handle, 1)
                if getgenv().Fatality_Auto_Pick_Auto_Equip then
                    obj.Parent = LocalPlayer.Backpack
                end
            end
        end
    end
end)

getgenv().Fatality_Fake_Lag_Enabled = false
getgenv().Fatality_Fake_Lag_Lag_Intensity = 0.5
getgenv().Fatality_Fake_Lag_Packet_Loss_Mode = false
getgenv().Fatality_Fake_Lag_Delay = 100
getgenv().Fatality_Fake_Lag_Jitter = true

local lagConnection
local lastUpdate = tick()

if lagConnection then lagConnection:Disconnect() end

lagConnection = RunService.Heartbeat:Connect(function()
    if not getgenv().Fatality_Fake_Lag_Enabled then return end
    local currentTime = tick()
    local delay = getgenv().Fatality_Fake_Lag_Delay / 1000
    if currentTime - lastUpdate < delay * getgenv().Fatality_Fake_Lag_Lag_Intensity then return end

    if getgenv().Fatality_Fake_Lag_Packet_Loss_Mode and math.random() < 0.3 then return end

    if getgenv().Fatality_Fake_Lag_Jitter then
        LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(math.random(-1,1), 0, math.random(-1,1)) * 0.1
    end

    lastUpdate = currentTime
end)

getgenv().Fatality_ESP_Hitbox_Enabled = false
getgenv().Fatality_ESP_Hitbox_Highlight_Local_Hitbox = true
getgenv().Fatality_ESP_Hitbox_Highlight_Enemy_Hitboxes = false
getgenv().Fatality_ESP_Hitbox_Highlight_Color_R = 255
getgenv().Fatality_ESP_Hitbox_Highlight_Color_G = 0
getgenv().Fatality_ESP_Hitbox_Highlight_Color_B = 0

local highlightConnections = {}

local function createHighlight(part)
    local highlight = Instance.new("Highlight")
    highlight.Adornee = part
    highlight.FillColor = Color3.fromRGB(
        getgenv().Fatality_ESP_Hitbox_Highlight_Color_R,
        getgenv().Fatality_ESP_Hitbox_Highlight_Color_G,
        getgenv().Fatality_ESP_Hitbox_Highlight_Color_B
    )
    highlight.OutlineColor = Colors.White
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = part
    return highlight
end

RunService.Heartbeat:Connect(function()
    if not getgenv().Fatality_ESP_Hitbox_Enabled then
        for _, conn in pairs(highlightConnections) do
            conn:Disconnect()
        end
        highlightConnections = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character then
                for _, part in ipairs(player.Character:GetChildren()) do
                    if part:IsA("BasePart") and part:FindFirstChildOfClass("Highlight") then
                        part:FindFirstChildOfClass("Highlight"):Destroy()
                    end
                end
            end
        end
        return
    end

    if getgenv().Fatality_ESP_Hitbox_Highlight_Local_Hitbox and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetChildren()) do
            if part:IsA("BasePart") and not part:FindFirstChildOfClass("Highlight") then
                createHighlight(part)
            end
        end
    end

    if getgenv().Fatality_ESP_Hitbox_Highlight_Enemy_Hitboxes then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                for _, part in ipairs(player.Character:GetChildren()) do
                    if part:IsA("BasePart") and not part:FindFirstChildOfClass("Highlight") then
                        createHighlight(part)
                    end
                end
            end
        end
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            local conn = player.Character.ChildAdded:Connect(function(child)
                if getgenv().Fatality_ESP_Hitbox_Enabled and child:IsA("BasePart") then
                    if (player == LocalPlayer and getgenv().Fatality_ESP_Hitbox_Highlight_Local_Hitbox) or
                       (player ~= LocalPlayer and getgenv().Fatality_ESP_Hitbox_Highlight_Enemy_Hitboxes) then
                        createHighlight(child)
                    end
                end
            end)
            table.insert(highlightConnections, conn)
        end
    end
end)

spawn(function()
    while wait(0.1) do
    end
end)

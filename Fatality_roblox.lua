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
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundColor3 = Colors.Dark
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 8)
TopCorner.Parent = TopBar

local LogoLabel = Instance.new("TextLabel")
LogoLabel.Name = "Logo"
LogoLabel.Size = UDim2.new(0, 40, 0, 40)
LogoLabel.Position = UDim2.new(0, 10, 0, 5)
LogoLabel.BackgroundTransparency = 1
LogoLabel.Text = "F"
LogoLabel.TextColor3 = Colors.DarkPink
LogoLabel.TextScaled = true
LogoLabel.Font = Enum.Font.GothamBlack
LogoLabel.Parent = TopBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -40, 0, 10)
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
TabsFrame.Size = UDim2.new(0, 120, 1, -50)
TabsFrame.Position = UDim2.new(0, 0, 0, 50)
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
    Content.Size = UDim2.new(1, -130, 1, -55)
    Content.Position = UDim2.new(0, 120, 0, 50)
    Content.BackgroundTransparency = 1
    Content.BorderSizePixel = 0
    Content.ScrollBarThickness = 6
    Content.ScrollingDirection = Enum.ScrollingDirection.Y
    Content.CanvasSize = UDim2.new(0, 0, 0, 0)
    Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Content.Visible = tabName == "Combat"
    Content.Parent = MainFrame

    local Layout = Instance.new("UIListLayout")
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 8)
    Layout.Parent = Content

    local Padding = Instance.new("UIPadding")
    Padding.PaddingLeft = UDim.new(0, 5)
    Padding.PaddingRight = UDim.new(0, 5)
    Padding.PaddingTop = UDim.new(0, 5)
    Padding.Parent = Content

    return Content
end

local CombatContent = createTabContent("Combat")
local VisualsContent = createTabContent("Visuals")
createTabContent("Misc")
createTabContent("Players")
createTabContent("Settings")

local CombatFeatures = {
    {Name = "Silent Aim", Settings = {
        {Type = "Mode", Name = "Aim Mode", Options = {"Closest", "FOV", "Crosshair", "Headshot Only", "Smooth", "Legit"}, Selected = "Closest"},
        {Type = "Checkbox", Name = "Raycast Head", Checked = true},
        {Type = "Checkbox", Name = "Raycast Torso", Checked = false},
        {Type = "Checkbox", Name = "Raycast Random", Checked = false},
        {Type = "TextBox", Name = "FOV", Value = "90"},
        {Type = "TextBox", Name = "Smoothness", Value = "0.1"},
        {Type = "TextBox", Name = "Hit Chance", Value = "100"},
        {Type = "Checkbox", Name = "Prediction", Checked = true},
        {Type = "Checkbox", Name = "Visibility Check", Checked = false},
        {Type = "TextBox", Name = "Distance Limit", Value = "1000"},
        {Type = "Checkbox", Name = "Team Check", Checked = true}
    }},
    {Name = "Auto Pick", Settings = {
        {Type = "Mode", Name = "Pickup Mode", Options = {"All", "Weapons Only", "Rare Only", "Ammo Only", "Proximity", "Smart"}, Selected = "All"},
        {Type = "Checkbox", Name = "Auto Pickup", Checked = true},
        {Type = "Checkbox", Name = "Prioritize Rare", Checked = false},
        {Type = "TextBox", Name = "Pickup Range", Value = "50"},
        {Type = "Checkbox", Name = "Auto Equip", Checked = true},
        {Type = "TextBox", Name = "Wall Peek Sensitivity", Value = "5"}
    }},
    {Name = "Fake Lag", Settings = {
        {Type = "Mode", Name = "Lag Mode", Options = {"Constant", "Random", "Blink", "Adaptive", "Pulse", "Jitter Only"}, Selected = "Constant"},
        {Type = "TextBox", Name = "Lag Intensity", Value = "0.5"},
        {Type = "Checkbox", Name = "Packet Loss Mode", Checked = false},
        {Type = "TextBox", Name = "Delay", Value = "100"},
        {Type = "TextBox", Name = "Blink Interval", Value = "1.5"},
        {Type = "Checkbox", Name = "Jitter", Checked = true}
    }},
    {Name = "Anti Aim", Settings = {
        {Type = "Mode", Name = "Anti Mode", Options = {"Static", "Jitter", "Spin", "Blink", "Desync Offset", "Random Mix"}, Selected = "Static"},
        {Type = "TextBox", Name = "Yaw Offset", Value = "180"},
        {Type = "Checkbox", Name = "Pitch Flip", Checked = true},
        {Type = "TextBox", Name = "Jitter Speed", Value = "10"},
        {Type = "TextBox", Name = "Blink Interval", Value = "0.2"},
        {Type = "TextBox", Name = "Desync Offset", Value = "2"}
    }},
    {Name = "Speed", Settings = {
        {Type = "Mode", Name = "Speed Mode", Options = {"Normal", "Adaptive", "Burst", "Strafe", "Bunny Hop", "Teleport"}, Selected = "Normal"},
        {Type = "TextBox", Name = "Speed Multiplier", Value = "2"},
        {Type = "TextBox", Name = "Burst Duration", Value = "0.5"},
        {Type = "Checkbox", Name = "Sync with Blink", Checked = true}
    }}
}

local VisualsFeatures = {
    {Name = "ESP Hitbox", Settings = {
        {Type = "Mode", Name = "Highlight Style", Options = {"Wireframe", "Glow", "Outline", "Box Only", "Health Only", "Full"}, Selected = "Wireframe"},
        {Type = "Checkbox", Name = "Highlight Local Hitbox", Checked = true},
        {Type = "Checkbox", Name = "Highlight Enemy Hitboxes", Checked = false},
        {Type = "TextBox", Name = "Box Thickness", Value = "1"},
        {Type = "TextBox", Name = "Health Bar Color R", Value = "0"},
        {Type = "TextBox", Name = "Health Bar Color G", Value = "255"},
        {Type = "TextBox", Name = "Health Bar Color B", Value = "0"},
        {Type = "TextBox", Name = "Distance Limit", Value = "1000"},
        {Type = "TextBox", Name = "Glow Intensity", Value = "0.3"}
    }},
    {Name = "Bullet Tracers", Settings = {
        {Type = "Mode", Name = "Tracer Style", Options = {"Solid", "Glow", "Dashed", "Gradient", "Pulse", "Rainbow"}, Selected = "Glow"},
        {Type = "TextBox", Name = "Line Width", Value = "2"},
        {Type = "TextBox", Name = "Color R", Value = "255"},
        {Type = "TextBox", Name = "Color G", Value = "0"},
        {Type = "TextBox", Name = "Color B", Value = "0"},
        {Type = "TextBox", Name = "Duration", Value = "1"},
        {Type = "TextBox", Name = "Glow Intensity", Value = "0.5"},
        {Type = "TextBox", Name = "Notification Size", Value = "16"}
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
        local quickToggle = ScreenGui:FindFirstChild(feature.Name .. "QuickToggle")
        if quickToggle then
            quickToggle.BackgroundColor3 = isEnabled and Colors.DarkPink or Colors.Dark
        end
    end)

    local holdStart = nil
    FeatureToggle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            holdStart = tick()
        end
    end)

    FeatureToggle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and holdStart and tick() - holdStart >= 0.5 then
            if not ScreenGui:FindFirstChild(feature.Name .. "QuickToggle") then
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
        end
        holdStart = nil
    end)

    local SettingsFrame = Instance.new("Frame")
    SettingsFrame.Name = feature.Name .. "Settings"
    SettingsFrame.Size = UDim2.new(1, 0, 0, #feature.Settings * 25)
    SettingsFrame.BackgroundColor3 = Colors.White
    SettingsFrame.BorderSizePixel = 0
    SettingsFrame.LayoutOrder = 1
    SettingsFrame.Parent = parent

    local SettingsCorner = Instance.new("UICorner")
    SettingsCorner.CornerRadius = UDim.new(0, 4)
    SettingsCorner.Parent = SettingsFrame

    local SettingsLayout = Instance.new("UIListLayout")
    SettingsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SettingsLayout.Padding = UDim.new(0, 5)
    SettingsLayout.Parent = SettingsFrame

    local SettingsPadding = Instance.new("UIPadding")
    SettingsPadding.PaddingLeft = UDim.new(0, 5)
    SettingsPadding.PaddingTop = UDim.new(0, 5)
    SettingsPadding.Parent = SettingsFrame

    for _, setting in ipairs(feature.Settings) do
        if setting.Type == "Checkbox" then
            local SettingButton = Instance.new("TextButton")
            SettingButton.Name = setting.Name
            SettingButton.Size = UDim2.new(1, -10, 0, 20)
            SettingButton.BackgroundColor3 = Colors.Dark
            SettingButton.BorderSizePixel = 0
            SettingButton.Text = setting.Name .. (setting.Checked and " [ON]" or " [OFF]")
            SettingButton.TextColor3 = Colors.Red
            SettingButton.TextScaled = true
            SettingButton.Font = Enum.Font.Gotham
            SettingButton.Parent = SettingsFrame

            local SettingCorner = Instance.new("UICorner")
            SettingCorner.CornerRadius = UDim.new(0, 2)
            SettingCorner.Parent = SettingButton

            local checked = setting.Checked
            SettingButton.MouseButton1Click:Connect(function()
                checked = not checked
                SettingButton.Text = setting.Name .. (checked and " [ON]" or " [OFF]")
                getgenv()["Fatality_" .. feature.Name:gsub(" ", "_") .. "_" .. setting.Name:gsub(" ", "_"):gsub(":", "")] = checked
            end)
        elseif setting.Type == "TextBox" then
            local SettingButton = Instance.new("TextButton")
            SettingButton.Name = setting.Name
            SettingButton.Size = UDim2.new(1, -10, 0, 20)
            SettingButton.BackgroundColor3 = Colors.Dark
            SettingButton.BorderSizePixel = 0
            SettingButton.Text = setting.Name
            SettingButton.TextColor3 = Colors.Red
            SettingButton.TextScaled = true
            SettingButton.Font = Enum.Font.Gotham
            SettingButton.Parent = SettingsFrame

            local SettingCorner = Instance.new("UICorner")
            SettingCorner.CornerRadius = UDim.new(0, 2)
            SettingCorner.Parent = SettingButton

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
        elseif setting.Type == "Mode" then
            local ModeFrame = Instance.new("Frame")
            ModeFrame.Name = setting.Name
            ModeFrame.Size = UDim2.new(1, -10, 0, 20)
            ModeFrame.BackgroundColor3 = Colors.Dark
            ModeFrame.BorderSizePixel = 0
            ModeFrame.Parent = SettingsFrame

            local ModeCorner = Instance.new("UICorner")
            ModeCorner.CornerRadius = UDim.new(0, 2)
            ModeCorner.Parent = ModeFrame

            local ModeLabel = Instance.new("TextLabel")
            ModeLabel.Size = UDim2.new(0.5, 0, 1, 0)
            ModeLabel.BackgroundTransparency = 1
            ModeLabel.Text = setting.Name .. ": " .. setting.Selected
            ModeLabel.TextColor3 = Colors.Red
            ModeLabel.TextScaled = true
            ModeLabel.Font = Enum.Font.Gotham
            ModeLabel.Parent = ModeFrame

            local ModeButton = Instance.new("TextButton")
            ModeButton.Size = UDim2.new(0.5, -10, 1, 0)
            ModeButton.Position = UDim2.new(0.5, 5, 0, 0)
            ModeButton.BackgroundColor3 = Colors.DarkPink
            ModeButton.BorderSizePixel = 0
            ModeButton.Text = "Next"
            ModeButton.TextColor3 = Colors.White
            ModeButton.TextScaled = true
            ModeButton.Font = Enum.Font.Gotham
            ModeButton.Parent = ModeFrame

            local ModeButtonCorner = Instance.new("UICorner")
            ModeButtonCorner.CornerRadius = UDim.new(0, 2)
            ModeButtonCorner.Parent = ModeButton

            local currentIndex = table.find(setting.Options, setting.Selected) or 1
            ModeButton.MouseButton1Click:Connect(function()
                currentIndex = currentIndex % #setting.Options + 1
                local newMode = setting.Options[currentIndex]
                ModeLabel.Text = setting.Name .. ": " .. newMode
                getgenv()["Fatality_" .. feature.Name:gsub(" ", "_") .. "_" .. setting.Name:gsub(" ", "_"):gsub(":", "")] = newMode
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
getgenv().Fatality_Silent_Aim_Aim_Mode = "Closest"
getgenv().Fatality_Silent_Aim_Raycast_Head = true
getgenv().Fatality_Silent_Aim_Raycast_Torso = false
getgenv().Fatality_Silent_Aim_Raycast_Random = false
getgenv().Fatality_Silent_Aim_FOV = 90
getgenv().Fatality_Silent_Aim_Smoothness = 0.1
getgenv().Fatality_Silent_Aim_Hit_Chance = 100
getgenv().Fatality_Silent_Aim_Prediction = true
getgenv().Fatality_Silent_Aim_Visibility_Check = false
getgenv().Fatality_Silent_Aim_Distance_Limit = 1000
getgenv().Fatality_Silent_Aim_Team_Check = true

getgenv().Fatality_Auto_Pick_Enabled = false
getgenv().Fatality_Auto_Pick_Pickup_Mode = "All"
getgenv().Fatality_Auto_Pick_Auto_Pickup = true
getgenv().Fatality_Auto_Pick_Prioritize_Rare = false
getgenv().Fatality_Auto_Pick_Pickup_Range = 50
getgenv().Fatality_Auto_Pick_Auto_Equip = true
getgenv().Fatality_Auto_Pick_Wall_Peek_Sensitivity = 5

getgenv().Fatality_Fake_Lag_Enabled = false
getgenv().Fatality_Fake_Lag_Lag_Mode = "Constant"
getgenv().Fatality_Fake_Lag_Lag_Intensity = 0.5
getgenv().Fatality_Fake_Lag_Packet_Loss_Mode = false
getgenv().Fatality_Fake_Lag_Delay = 100
getgenv().Fatality_Fake_Lag_Blink_Interval = 1.5
getgenv().Fatality_Fake_Lag_Jitter = true

getgenv().Fatality_Anti_Aim_Enabled = false
getgenv().Fatality_Anti_Aim_Anti_Mode = "Static"
getgenv().Fatality_Anti_Aim_Yaw_Offset = 180
getgenv().Fatality_Anti_Aim_Pitch_Flip = true
getgenv().Fatality_Anti_Aim_Jitter_Speed = 10
getgenv().Fatality_Anti_Aim_Blink_Interval = 0.2
getgenv().Fatality_Anti_Aim_Desync_Offset = 2

getgenv().Fatality_Speed_Enabled = false
getgenv().Fatality_Speed_Speed_Mode = "Normal"
getgenv().Fatality_Speed_Speed_Multiplier = 2
getgenv().Fatality_Speed_Burst_Duration = 0.5
getgenv().Fatality_Speed_Sync_with_Blink = true

getgenv().Fatality_ESP_Hitbox_Enabled = false
getgenv().Fatality_ESP_Hitbox_Highlight_Style = "Wireframe"
getgenv().Fatality_ESP_Hitbox_Highlight_Local_Hitbox = true
getgenv().Fatality_ESP_Hitbox_Highlight_Enemy_Hitboxes = false
getgenv().Fatality_ESP_Hitbox_Box_Thickness = 1
getgenv().Fatality_ESP_Hitbox_Health_Bar_Color_R = 0
getgenv().Fatality_ESP_Hitbox_Health_Bar_Color_G = 255
getgenv().Fatality_ESP_Hitbox_Health_Bar_Color_B = 0
getgenv().Fatality_ESP_Hitbox_Distance_Limit = 1000
getgenv().Fatality_ESP_Hitbox_Glow_Intensity = 0.3

getgenv().Fatality_Bullet_Tracers_Enabled = false
getgenv().Fatality_Bullet_Tracers_Tracer_Style = "Glow"
getgenv().Fatality_Bullet_Tracers_Line_Width = 2
getgenv().Fatality_Bullet_Tracers_Color_R = 255
getgenv().Fatality_Bullet_Tracers_Color_G = 0
getgenv().Fatality_Bullet_Tracers_Color_B = 0
getgenv().Fatality_Bullet_Tracers_Duration = 1
getgenv().Fatality_Bullet_Tracers_Glow_Intensity = 0.5
getgenv().Fatality_Bullet_Tracers_Notification_Size = 16

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    local fovDistance = getgenv().Fatality_Silent_Aim_FOV

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if getgenv().Fatality_Silent_Aim_Team_Check and player.Team == LocalPlayer.Team then continue end
            local distance = (Camera.CFrame.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if distance > getgenv().Fatality_Silent_Aim_Distance_Limit then continue end

            local screenPoint, onScreen = Camera:WorldToScreenPoint(player.Character.HumanoidRootPart.Position)
            if not onScreen then continue end

            local mode = getgenv().Fatality_Silent_Aim_Aim_Mode
            local currentDistance = mode == "FOV" and (Vector2.new(screenPoint.X, screenPoint.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude or distance
            if mode == "Crosshair" then
                currentDistance = (Vector2.new(screenPoint.X, screenPoint.Y) - Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)).Magnitude
            end

            if currentDistance < (mode == "FOV" and fovDistance or shortestDistance) then
                if getgenv().Fatality_Silent_Aim_Visibility_Check then
                    local ray = Camera:ScreenPointToRay(screenPoint.X, screenPoint.Y)
                    local raycastParams = RaycastParams.new()
                    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
                    local result = Workspace:Raycast(ray.Origin, (player.Character.HumanoidRootPart.Position - ray.Origin).Unit * distance, raycastParams)
                    if result and result.Instance:IsDescendantOf(player.Character) then
                        closestPlayer = player
                        shortestDistance = currentDistance
                        if mode == "FOV" then fovDistance = currentDistance end
                    end
                else
                    closestPlayer = player
                    shortestDistance = currentDistance
                    if mode == "FOV" then fovDistance = currentDistance end
                end
            end
        end
    end

    return closestPlayer
end

local function getTargetPart(player)
    local char = player.Character
    if not char then return nil end
    if getgenv().Fatality_Silent_Aim_Aim_Mode == "Headshot Only" then
        return char:FindFirstChild("Head")
    end

    local parts = {}
    if getgenv().Fatality_Silent_Aim_Raycast_Head then table.insert(parts, "Head") end
    if getgenv().Fatality_Silent_Aim_Raycast_Torso then table.insert(parts, "Torso") end
    if getgenv().Fatality_Silent_Aim_Raycast_Random then parts = {"Head", "Torso", "HumanoidRootPart"} end

    local part = parts[math.random(1, #parts)] or "Head"
    return char:FindFirstChild(part)
end

mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    local method = getnamecallmethod()

    if getgenv().Fatality_Silent_Aim_Enabled and method == "FireServer" and (self.Name:find("Fire") or self.Name:find("Shoot")) then
        local hitChance = getgenv().Fatality_Silent_Aim_Hit_Chance / 100
        if getgenv().Fatality_Silent_Aim_Aim_Mode == "Legit" and math.random() > hitChance then
            return oldNamecall(self, ...)
        end

        local closest = getClosestPlayer()
        if closest and getTargetPart(closest) then
            local targetPart = getTargetPart(closest)
            local targetPos = targetPart.Position
            if getgenv().Fatality_Silent_Aim_Prediction then
                local velocity = closest.Character.HumanoidRootPart.Velocity
                targetPos = targetPos + (velocity * getgenv().Fatality_Silent_Aim_Smoothness)
            end
            if getgenv().Fatality_Silent_Aim_Aim_Mode == "Smooth" then
                local currentPos = args[1] or Camera.CFrame.Position
                targetPos = currentPos + (targetPos - currentPos) * getgenv().Fatality_Silent_Aim_Smoothness
            end
            args[1] = targetPos
        end
        return oldNamecall(self, unpack(args))
    end

    return oldNamecall(self, ...)
end)

setreadonly(mt, true)
RunService.Heartbeat:Connect(function()
    if not getgenv().Fatality_Auto_Pick_Enabled then return end
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    local closestEnemy = nil
    local minDist = math.huge
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (char.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if dist < minDist then
                minDist = dist
                closestEnemy = player
            end
        end
    end

    if closestEnemy and getgenv().Fatality_Auto_Pick_Wall_Peek_Sensitivity > 0 then
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
        raycastParams.FilterDescendantsInstances = {char}
        local ray = Workspace:Raycast(char.HumanoidRootPart.Position, (closestEnemy.Character.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Unit * minDist, raycastParams)
        local isBehindWall = ray and not ray.Instance:IsDescendantOf(closestEnemy.Character)
        if not isBehindWall then
            local offset = (closestEnemy.Character.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Unit * getgenv().Fatality_Auto_Pick_Wall_Peek_Sensitivity
            char.HumanoidRootPart.CFrame = CFrame.new(char.HumanoidRootPart.Position + offset)
        end
    end

    for _, obj in ipairs(Workspace:GetChildren()) do
        if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
            local mode = getgenv().Fatality_Auto_Pick_Pickup_Mode
            if mode == "Weapons Only" and not obj.Name:find("Weapon") then continue end
            if mode == "Rare Only" and (not obj:FindFirstChild("Rarity") or obj.Rarity.Value ~= "Rare") then continue end
            if mode == "Ammo Only" and not obj.Name:find("Ammo") then continue end
            local dist = (char.HumanoidRootPart.Position - obj.Handle.Position).Magnitude
            if mode == "Proximity" and dist > getgenv().Fatality_Auto_Pick_Pickup_Range then continue end
            if mode == "Smart" then
                local value = (obj:FindFirstChild("Rarity") and obj.Rarity.Value == "Rare" and 2 or 1) / dist
                if value < 0.1 then continue end
            end
            if dist < getgenv().Fatality_Auto_Pick_Pickup_Range then
                if getgenv().Fatality_Auto_Pick_Prioritize_Rare and obj.Rarity and obj.Rarity.Value ~= "Rare" then continue end
                if getgenv().Fatality_Auto_Pick_Auto_Pickup then
                    local remote = obj:FindFirstChildOfClass("RemoteEvent")
                    if remote then
                        remote:FireServer("Pickup")
                    else
                        obj.Handle.CFrame = char.HumanoidRootPart.CFrame
                        firetouchinterest(char.HumanoidRootPart, obj.Handle, 0)
                        wait(0.05)
                        firetouchinterest(char.HumanoidRootPart, obj.Handle, 1)
                    end
                    if getgenv().Fatality_Auto_Pick_Auto_Equip then
                        if obj.Parent ~= LocalPlayer.Backpack then
                            obj.Parent = LocalPlayer.Backpack
                            LocalPlayer.Character.Humanoid:EquipTool(obj)
                        end
                    end
                end
            end
        end
    end
end)

local lagConnection
local lastUpdate = tick()
local storedPosition = nil
local isBlinking = false

if lagConnection then lagConnection:Disconnect() end

lagConnection = RunService.Heartbeat:Connect(function()
    if not getgenv().Fatality_Fake_Lag_Enabled then
        storedPosition = nil
        isBlinking = false
        return
    end
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    local currentTime = tick()
    local delay = getgenv().Fatality_Fake_Lag_Delay / 1000
    local mode = getgenv().Fatality_Fake_Lag_Lag_Mode

    if mode == "Random" then
        delay = delay * math.random(0.5, 1.5)
    elseif mode == "Blink" then
        if currentTime - lastUpdate >= getgenv().Fatality_Fake_Lag_Blink_Interval then
            isBlinking = not isBlinking
            lastUpdate = currentTime
            if not isBlinking then
                storedPosition = char.HumanoidRootPart.CFrame
            end
        end
        if isBlinking and storedPosition then
            char.HumanoidRootPart.CFrame = storedPosition
            if getgenv().Fatality_Fake_Lag_Packet_Loss_Mode and math.random() < 0.2 then
                return
            end
            return
        end
    elseif mode == "Constant" then
        if currentTime - lastUpdate < delay * getgenv().Fatality_Fake_Lag_Lag_Intensity then
            if storedPosition then
                char.HumanoidRootPart.CFrame = storedPosition
            end
            if getgenv().Fatality_Fake_Lag_Packet_Loss_Mode and math.random() < 0.2 then
                return
            end
            return
        end
    elseif mode == "Adaptive" then
        local moveDir = char.Humanoid.MoveDirection.Magnitude
        if moveDir > 0 then
            delay = delay * 0.5
        end
        if currentTime - lastUpdate < delay then
            if storedPosition then
                char.HumanoidRootPart.CFrame = storedPosition
            end
            return
        end
    elseif mode == "Pulse" then
        if math.sin(currentTime * 5) > 0 then
            if storedPosition then
                char.HumanoidRootPart.CFrame = storedPosition
            end
            return
        end
    elseif mode == "Jitter Only" then
        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(math.random(-0.5, 0.5), 0, math.random(-0.5, 0.5)) * 0.1
        return
    end

    storedPosition = char.HumanoidRootPart.CFrame
    if getgenv().Fatality_Fake_Lag_Jitter then
        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(math.random(-0.5, 0.5), 0, math.random(-0.5, 0.5)) * 0.1
    end
    lastUpdate = currentTime
end)

local antiAimConnection
local antiLastUpdate = tick()
local antiStoredPosition = nil

if antiAimConnection then antiAimConnection:Disconnect() end

antiAimConnection = RunService.Heartbeat:Connect(function()
    if not getgenv().Fatality_Anti_Aim_Enabled then
        antiStoredPosition = nil
        return
    end
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    local currentTime = tick()
    local mode = getgenv().Fatality_Anti_Aim_Anti_Mode
    antiStoredPosition = char.HumanoidRootPart.CFrame

    if mode == "Static" then
        local yaw = math.rad(getgenv().Fatality_Anti_Aim_Yaw_Offset)
        local pitch = getgenv().Fatality_Anti_Aim_Pitch_Flip and -math.pi/2 or math.pi/2
        char.HumanoidRootPart.CFrame = CFrame.new(char.HumanoidRootPart.Position) * CFrame.Angles(pitch, yaw, 0)
    elseif mode == "Jitter" then
        local offset = math.sin(currentTime * getgenv().Fatality_Anti_Aim_Jitter_Speed) * math.rad(30)
        char.HumanoidRootPart.CFrame = CFrame.new(char.HumanoidRootPart.Position) * CFrame.Angles(0, offset, 0)
    elseif mode == "Spin" then
        local yaw = (currentTime * getgenv().Fatality_Anti_Aim_Jitter_Speed) % (2 * math.pi)
        char.HumanoidRootPart.CFrame = CFrame.new(char.HumanoidRootPart.Position) * CFrame.Angles(0, yaw, 0)
    elseif mode == "Blink" then
        if currentTime - antiLastUpdate >= getgenv().Fatality_Anti_Aim_Blink_Interval then
            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(math.random(-1, 1), math.random(-0.5, 0.5), math.random(-1, 1))
            antiLastUpdate = currentTime
        end
    elseif mode == "Desync Offset" then
        local offset = Vector3.new(getgenv().Fatality_Anti_Aim_Desync_Offset * (math.random(0, 1) == 0 and 1 or -1), 0, 0)
        char.HumanoidRootPart.CFrame = CFrame.new(char.HumanoidRootPart.Position + offset)
    elseif mode == "Random Mix" then
        local modes = {"Static", "Jitter", "Spin", "Blink", "Desync Offset"}
        local randomMode = modes[math.random(1, #modes)]
        if randomMode == "Static" then
            local yaw = math.rad(getgenv().Fatality_Anti_Aim_Yaw_Offset)
            local pitch = getgenv().Fatality_Anti_Aim_Pitch_Flip and -math.pi/2 or math.pi/2
            char.HumanoidRootPart.CFrame = CFrame.new(char.HumanoidRootPart.Position) * CFrame.Angles(pitch, yaw, 0)
        elseif randomMode == "Jitter" then
            local offset = math.sin(currentTime * getgenv().Fatality_Anti_Aim_Jitter_Speed) * math.rad(30)
            char.HumanoidRootPart.CFrame = CFrame.new(char.HumanoidRootPart.Position) * CFrame.Angles(0, offset, 0)
        elseif randomMode == "Spin" then
            local yaw = (currentTime * getgenv().Fatality_Anti_Aim_Jitter_Speed) % (2 * math.pi)
            char.HumanoidRootPart.CFrame = CFrame.new(char.HumanoidRootPart.Position) * CFrame.Angles(0, yaw, 0)
        elseif randomMode == "Blink" then
            if currentTime - antiLastUpdate >= getgenv().Fatality_Anti_Aim_Blink_Interval then
                char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(math.random(-1, 1), math.random(-0.5, 0.5), math.random(-1, 1))
                antiLastUpdate = currentTime
            end
        elseif randomMode == "Desync Offset" then
            local offset = Vector3.new(getgenv().Fatality_Anti_Aim_Desync_Offset * (math.random(0, 1) == 0 and 1 or -1), 0, 0)
            char.HumanoidRootPart.CFrame = CFrame.new(char.HumanoidRootPart.Position + offset)
        end
    end
end)

local speedConnection
local speedLastUpdate = tick()
local baseWalkSpeed = 16

if speedConnection then speedConnection:Disconnect() end

speedConnection = RunService.Heartbeat:Connect(function()
    if not getgenv().Fatality_Speed_Enabled then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = baseWalkSpeed
        end
        return
    end
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") then return end

    local currentTime = tick()
    local mode = getgenv().Fatality_Speed_Speed_Mode
    local multiplier = getgenv().Fatality_Speed_Speed_Multiplier
    local humanoid = char.Humanoid

    if mode == "Normal" then
        humanoid.WalkSpeed = baseWalkSpeed * multiplier
    elseif mode == "Adaptive" then
        local moveDir = humanoid.MoveDirection.Magnitude
        humanoid.WalkSpeed = baseWalkSpeed * (1 + (moveDir > 0 and multiplier or 0))
    elseif mode == "Burst" then
        if getgenv().Fatality_Speed_Sync_with_Blink and getgenv().Fatality_Fake_Lag_Enabled and getgenv().Fatality_Fake_Lag_Lag_Mode == "Blink" then
            if isBlinking then
                humanoid.WalkSpeed = baseWalkSpeed
            else
                humanoid.WalkSpeed = baseWalkSpeed * multiplier
            end
        else
            if currentTime - speedLastUpdate >= getgenv().Fatality_Speed_Burst_Duration then
                humanoid.WalkSpeed = baseWalkSpeed * multiplier
                speedLastUpdate = currentTime
            else
                humanoid.WalkSpeed = baseWalkSpeed
            end
        end
    elseif mode == "Strafe" then
        humanoid.WalkSpeed = baseWalkSpeed * multiplier
        local moveDir = humanoid.MoveDirection
        if moveDir.Magnitude > 0 then
            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(moveDir.X, 0, moveDir.Z) * 0.1
        end
    elseif mode == "Bunny Hop" then
        humanoid.WalkSpeed = baseWalkSpeed * multiplier
        if humanoid.Jump then
            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(0, multiplier * 0.5, 0)
        end
    elseif mode == "Teleport" then
        if currentTime - speedLastUpdate >= getgenv().Fatality_Speed_Burst_Duration then
            local moveDir = humanoid.MoveDirection
            if moveDir.Magnitude > 0 then
                char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + moveDir * multiplier
            end
            speedLastUpdate = currentTime
        end
    end

    if multiplier > 1 then
        local moveDir = humanoid.MoveDirection * multiplier
        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + moveDir * 0.1
    end
end)
local highlightConnections = {}

local function createHighlight(part)
    if part:FindFirstChildOfClass("Highlight") then return end
    local highlight = Instance.new("Highlight")
    highlight.Adornee = part
    highlight.FillColor = Color3.fromRGB(
        getgenv().Fatality_ESP_Hitbox_Health_Bar_Color_R,
        getgenv().Fatality_ESP_Hitbox_Health_Bar_Color_G,
        getgenv().Fatality_ESP_Hitbox_Health_Bar_Color_B
    )
    highlight.OutlineColor = Colors.White
    local style = getgenv().Fatality_ESP_Hitbox_Highlight_Style
    highlight.FillTransparency = style == "Wireframe" or style == "Box Only" and 1 or (style == "Glow" or style == "Full" and getgenv().Fatality_ESP_Hitbox_Glow_Intensity or 0.5)
    highlight.OutlineTransparency = style == "Wireframe" or style == "Outline" or style == "Full" and 0 or 1
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = part

    if style == "Health Only" or style == "Full" then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESPBillboard"
        billboard.Size = UDim2.new(0, 50, 0, 20)
        billboard.Adornee = part
        billboard.AlwaysOnTop = true
        billboard.StudsOffset = Vector3.new(0, 2, 0)
        billboard.Parent = part

        local healthBar = Instance.new("Frame")
        healthBar.Size = UDim2.new(1, 0, 0, 5)
        healthBar.Position = UDim2.new(0, 0, 0, 0)
        healthBar.BackgroundColor3 = Color3.fromRGB(
            getgenv().Fatality_ESP_Hitbox_Health_Bar_Color_R,
            getgenv().Fatality_ESP_Hitbox_Health_Bar_Color_G,
            getgenv().Fatality_ESP_Hitbox_Health_Bar_Color_B
        )
        healthBar.BorderSizePixel = 0
        healthBar.Parent = billboard

        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 0, 10)
        nameLabel.Position = UDim2.new(0, 0, 0, 5)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = part.Parent.Name
        nameLabel.TextColor3 = Colors.White
        nameLabel.TextScaled = true
        nameLabel.Font = Enum.Font.Gotham
        nameLabel.Parent = billboard

        local distanceLabel = Instance.new("TextLabel")
        distanceLabel.Size = UDim2.new(1, 0, 0, 10)
        distanceLabel.Position = UDim2.new(0, 0, 0, 15)
        distanceLabel.BackgroundTransparency = 1
        distanceLabel.Text = "0 studs"
        distanceLabel.TextColor3 = Colors.White
        distanceLabel.TextScaled = true
        distanceLabel.Font = Enum.Font.Gotham
        distanceLabel.Parent = billboard

        RunService.RenderStepped:Connect(function()
            if part.Parent and part.Parent:FindFirstChild("Humanoid") then
                local health = part.Parent.Humanoid.Health / part.Parent.Humanoid.MaxHealth
                healthBar.Size = UDim2.new(health, 0, 0, 5)
                local dist = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (LocalPlayer.Character.HumanoidRootPart.Position - part.Position).Magnitude) or 0
                distanceLabel.Text = math.floor(dist) .. " studs"
            else
                billboard:Destroy()
            end
        end)
    end
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
                    if part:IsA("BasePart") then
                        if part:FindFirstChildOfClass("Highlight") then
                            part:FindFirstChildOfClass("Highlight"):Destroy()
                        end
                        if part:FindFirstChild("ESPBillboard") then
                            part:FindFirstChild("ESPBillboard"):Destroy()
                        end
                    end
                end
            end
        end
        return
    end

    if getgenv().Fatality_ESP_Hitbox_Highlight_Local_Hitbox and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetChildren()) do
            if part:IsA("BasePart") then
                createHighlight(part)
            end
        end
    end

    if getgenv().Fatality_ESP_Hitbox_Highlight_Enemy_Hitboxes then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                for _, part in ipairs(player.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        createHighlight(part)
                    end
                end
            end
        end
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and not highlightConnections[player] then
            local conn = player.Character.ChildAdded:Connect(function(child)
                if getgenv().Fatality_ESP_Hitbox_Enabled and child:IsA("BasePart") then
                    if (player == LocalPlayer and getgenv().Fatality_ESP_Hitbox_Highlight_Local_Hitbox) or
                       (player ~= LocalPlayer and getgenv().Fatality_ESP_Hitbox_Highlight_Enemy_Hitboxes) then
                        createHighlight(child)
                    end
                end
            end)
            highlightConnections[player] = conn
        end
    end
end)

local function createTracer(startPos, endPos, damage)
    if not getgenv().Fatality_Bullet_Tracers_Enabled then return end

    local tracer = Instance.new("Part")
    tracer.Anchored = true
    tracer.CanCollide = false
    tracer.Size = Vector3.new(getgenv().Fatality_Bullet_Tracers_Line_Width / 10, getgenv().Fatality_Bullet_Tracers_Line_Width / 10, (startPos - endPos).Magnitude)
    tracer.CFrame = CFrame.new(startPos, endPos) * CFrame.new(0, 0, -(startPos - endPos).Magnitude / 2)
    tracer.BrickColor = BrickColor.new(Color3.fromRGB(
        getgenv().Fatality_Bullet_Tracers_Color_R,
        getgenv().Fatality_Bullet_Tracers_Color_G,
        getgenv().Fatality_Bullet_Tracers_Color_B
    ))
    tracer.Material = Enum.Material.Neon
    tracer.Parent = Workspace

    local style = getgenv().Fatality_Bullet_Tracers_Tracer_Style
    if style == "Dashed" then
        tracer.Size = Vector3.new(getgenv().Fatality_Bullet_Tracers_Line_Width / 10, getgenv().Fatality_Bullet_Tracers_Line_Width / 10, (startPos - endPos).Magnitude / 2)
        local secondTracer = Instance.new("Part")
        secondTracer.Anchored = true
        secondTracer.CanCollide = false
        secondTracer.Size = Vector3.new(getgenv().Fatality_Bullet_Tracers_Line_Width / 10, getgenv().Fatality_Bullet_Tracers_Line_Width / 10, (startPos - endPos).Magnitude / 2)
        secondTracer.CFrame = CFrame.new(startPos, endPos) * CFrame.new(0, 0, -(startPos - endPos).Magnitude / 4)
        secondTracer.BrickColor = tracer.BrickColor
        secondTracer.Material = Enum.Material.Neon
        secondTracer.Parent = Workspace
        spawn(function()
            wait(getgenv().Fatality_Bullet_Tracers_Duration)
            secondTracer:Destroy()
        end)
    elseif style == "Gradient" then
        local gradient = Instance.new("Gradient")
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, tracer.BrickColor.Color),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
        })
        gradient.Parent = tracer
    elseif style == "Pulse" then
        spawn(function()
            local tween = game:GetService("TweenService"):Create(tracer, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Transparency = 0.5})
            tween:Play()
        end)
    elseif style == "Rainbow" then
        spawn(function()
            while tracer.Parent do
                tracer.BrickColor = BrickColor.new(Color3.fromHSV(tick() % 5 / 5, 1, 1))
                wait(0.1)
            end
        end)
    end

    if style == "Glow" or style == "Full" then
        local highlight = Instance.new("Highlight")
        highlight.Adornee = tracer
        highlight.FillTransparency = getgenv().Fatality_Bullet_Tracers_Glow_Intensity
        highlight.OutlineTransparency = 0
        highlight.FillColor = tracer.BrickColor.Color
        highlight.Parent = tracer
    end

    local notification = Instance.new("TextLabel")
    notification.Size = UDim2.new(0, 200, 0, 30)
    notification.Position = UDim2.new(0.5, -100, 0.6, 0)
    notification.BackgroundTransparency = 1
    notification.Text = damage > 0 and ("Hit: " .. math.floor(damage) .. " dmg") or "Miss"
    notification.TextColor3 = damage > 0 and Colors.Red or Colors.White
    notification.TextSize = getgenv().Fatality_Bullet_Tracers_Notification_Size
    notification.Font = Enum.Font.GothamBold
    notification.Parent = ScreenGui

    spawn(function()
        wait(getgenv().Fatality_Bullet_Tracers_Duration)
        tracer:Destroy()
        notification:Destroy()
    end)
end

local tracerConnection
if tracerConnection then tracerConnection:Disconnect() end

tracerConnection = mt.__namecall:Connect(function(self, ...)
    local args = {...}
    local method = getnamecallmethod()

    if getgenv().Fatality_Bullet_Tracers_Enabled and method == "FireServer" and (self.Name:find("Fire") or self.Name:find("Shoot")) then
        local startPos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.Position or Camera.CFrame.Position
        local endPos = args[1] or Camera.CFrame.Position
        local damage = 0

        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
        raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
        local ray = Workspace:Raycast(startPos, (endPos - startPos).Unit * 1000, raycastParams)
        if ray and ray.Instance:IsDescendantOf(Workspace) then
            endPos = ray.Position
            local hitPlayer = Players:GetPlayerFromCharacter(ray.Instance.Parent)
            if hitPlayer and hitPlayer.Character and hitPlayer.Character:FindFirstChild("Humanoid") then
                damage = math.random(10, 50) -- Замените на реальный расчёт урона, если доступен
            end
        end
        createTracer(startPos, endPos, damage)
    end
end)

spawn(function()
    while wait(0.1) do
    end
end)

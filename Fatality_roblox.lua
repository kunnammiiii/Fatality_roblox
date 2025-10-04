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
ToggleButton.Position = UDim2.new(1, -70, 1, -70)
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
MainFrame.Size = UDim2.new(0, 350, 0, 250)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
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
LogoLabel.Size = UDim2.new(0, 50, 0, 50)
LogoLabel.Position = UDim2.new(0, 10, 0, 0)
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
local MiscContent = createTabContent("Misc")
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
    }},
    {Name = "Hit Particles", Settings = {
        {Type = "Checkbox", Name = "Enable Particles", Checked = true},
        {Type = "TextBox", Name = "Particle Size", Value = "1"},
        {Type = "TextBox", Name = "Particle Color R", Value = "255"},
        {Type = "TextBox", Name = "Particle Color G", Value = "0"},
        {Type = "TextBox", Name = "Particle Color B", Value = "0"}
    }},
    {Name = "Kill Effect", Settings = {
        {Type = "Checkbox", Name = "Enable Kill Effect", Checked = true},
        {Type = "TextBox", Name = "Effect Intensity", Value = "1"}
    }},
    {Name = "Custom Crosshair", Settings = {
        {Type = "Checkbox", Name = "Enable Crosshair", Checked = true},
        {Type = "TextBox", Name = "Crosshair Size", Value = "10"},
        {Type = "TextBox", Name = "Crosshair Color R", Value = "255"},
        {Type = "TextBox", Name = "Crosshair Color G", Value = "255"},
        {Type = "TextBox", Name = "Crosshair Color B", Value = "255"}
    }},
    {Name = "Hitmarker", Settings = {
        {Type = "Checkbox", Name = "Enable Hitmarker", Checked = true},
        {Type = "TextBox", Name = "Hitmarker Size", Value = "20"}
    }},
    {Name = "Damage Indicator", Settings = {
        {Type = "Checkbox", Name = "Enable Indicator", Checked = true},
        {Type = "TextBox", Name = "Text Size", Value = "14"}
    }},
    {Name = "Model Swap", Settings = {
        {Type = "Mode", Name = "Model Style", Options = {"CJ Ballas", "Neon Cyberpunk", "Retro Gangster", "Anime Thug", "Street Punk"}, Selected = "CJ Ballas"},
        {Type = "Checkbox", Name = "Enable Model Swap", Checked = true}
    }}
}

local MiscFeatures = {
    {Name = "Shift Lock", Settings = {
        {Type = "Checkbox", Name = "Enable Shift Lock", Checked = true},
        {Type = "TextBox", Name = "Shift Speed", Value = "5"}
    }}
}

local function createFeature(feature, parent)
    local FeatureToggle = Instance.new("TextButton")
    FeatureToggle.Name = feature.Name .. "Toggle"
    FeatureToggle.Size = UDim2.new(1, 0, 0, 30)
    FeatureToggle.BackgroundColor3 = Colors.Dark
    FeatureToggle.BorderSizePixel = 0
    FeatureToggle.Text = feature.Name .. ": " .. (feature.Settings[1].Checked and "ON" or "OFF")
    FeatureToggle.TextColor3 = Colors.White
    FeatureToggle.TextScaled = true
    FeatureToggle.Font = Enum.Font.Gotham
    FeatureToggle.Parent = parent

    local FeatureToggleCorner = Instance.new("UICorner")
    FeatureToggleCorner.CornerRadius = UDim.new(0, 4)
    FeatureToggleCorner.Parent = FeatureToggle

    local isEnabled = feature.Settings[1].Checked
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

                local quickDragging = false
                local quickDragStart = nil
                local quickStartPos = nil
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
for _, feature in ipairs(MiscFeatures) do
    createFeature(feature, MiscContent)
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
        Size = UDim2.new(0, 350, 0, 250),
        Position = UDim2.new(0.5, -175, 0.5, -125)
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
    if getgenv().Fatality_Silent_Aim_Raycast_Random then
        parts = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"}
    end
    return char:FindFirstChild(parts[math.random(1, #parts)] or "Head")
end

local function applyPrediction(targetPos, target)
    if getgenv().Fatality_Silent_Aim_Prediction and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local velocity = target.Character.HumanoidRootPart.Velocity
        local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue() / 1000
        targetPos = targetPos + velocity * ping
    end
    return targetPos
end

mt.__namecall = function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    if getgenv().Fatality_Silent_Aim_Enabled and method == "FindPartOnRayWithIgnoreList" then
        local closestPlayer = getClosestPlayer()
        if closestPlayer and closestPlayer.Character and math.random(1, 100) <= getgenv().Fatality_Silent_Aim_Hit_Chance then
            local targetPart = getTargetPart(closestPlayer)
            if targetPart then
                local targetPos = applyPrediction(targetPart.Position, closestPlayer)
                local ray = args[1]
                local origin = ray.Origin
                local direction = (targetPos - origin).Unit * 1000
                args[1] = Ray.new(origin, direction)
            end
        end
    end
    return oldNamecall(self, unpack(args))
end

RunService.RenderStepped:Connect(function()
    if getgenv().Fatality_Auto_Pick_Enabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj:FindFirstChild("TouchTransmitter") then
                local distance = (obj.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if distance <= getgenv().Fatality_Auto_Pick_Pickup_Range then
                    local mode = getgenv().Fatality_Auto_Pick_Pickup_Mode
                    local isValid = mode == "All" or
                        (mode == "Weapons Only" and obj.Name:lower():match("gun") or obj.Name:lower():match("weapon")) or
                        (mode == "Rare Only" and getgenv().Fatality_Auto_Pick_Prioritize_Rare and obj.Name:lower():match("rare")) or
                        (mode == "Ammo Only" and obj.Name:lower():match("ammo")) or
                        (mode == "Proximity" and distance <= 10) or
                        (mode == "Smart" and (obj.Name:lower():match("gun") or obj.Name:lower():match("ammo") or obj.Name:lower():match("rare")))
                    if isValid then
                        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, obj, 0)
                        wait()
                        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, obj, 1)
                        if getgenv().Fatality_Auto_Pick_Auto_Equip then
                            game:GetService("ReplicatedStorage").Remotes.EquipTool:FireServer(obj.Name)
                        end
                    end
                end
            end
        end
    end
end)
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

local NetworkClient = game:GetService("NetworkClient")
local RunService = game:GetService("RunService")

RunService.Heartbeat:Connect(function()
    if getgenv().Fatality_Fake_Lag_Enabled then
        local mode = getgenv().Fatality_Fake_Lag_Lag_Mode
        local intensity = getgenv().Fatality_Fake_Lag_Lag_Intensity
        local delay = getgenv().Fatality_Fake_Lag_Delay / 1000
        local blinkInterval = getgenv().Fatality_Fake_Lag_Blink_Interval

        if mode == "Constant" then
            NetworkClient:SetOutgoingKBPSLimit(intensity * 1000)
        elseif mode == "Random" then
            NetworkClient:SetOutgoingKBPSLimit(math.random(100, 1000) * intensity)
        elseif mode == "Blink" then
            if math.floor(tick() % blinkInterval) == 0 then
                NetworkClient:SetOutgoingKBPSLimit(0)
            else
                NetworkClient:SetOutgoingKBPSLimit(1000)
            end
        elseif mode == "Adaptive" then
            local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
            NetworkClient:SetOutgoingKBPSLimit(math.clamp(1000 - ping * intensity, 100, 1000))
        elseif mode == "Pulse" then
            NetworkClient:SetOutgoingKBPSLimit(math.sin(tick()) * 500 * intensity + 500)
        elseif mode == "Jitter Only" and getgenv().Fatality_Fake_Lag_Jitter then
            NetworkClient:SetOutgoingKBPSLimit(math.random(200, 800))
        end

        if getgenv().Fatality_Fake_Lag_Packet_Loss_Mode then
            wait(delay)
        end
    else
        NetworkClient:SetOutgoingKBPSLimit(0)
    end
end)

RunService.Stepped:Connect(function()
    if getgenv().Fatality_Anti_Aim_Enabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local mode = getgenv().Fatality_Anti_Aim_Anti_Mode
        local root = LocalPlayer.Character.HumanoidRootPart
        local yaw = getgenv().Fatality_Anti_Aim_Yaw_Offset
        local pitch = getgenv().Fatality_Anti_Aim_Pitch_Flip and -1 or 1
        local jitter = getgenv().Fatality_Anti_Aim_Jitter_Speed
        local blink = getgenv().Fatality_Anti_Aim_Blink_Interval
        local desync = getgenv().Fatality_Anti_Aim_Desync_Offset

        if mode == "Static" then
            root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(yaw), 0) * CFrame.Angles(math.rad(90 * pitch), 0, 0)
        elseif mode == "Jitter" then
            root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(yaw + math.sin(tick() * jitter) * 30), 0)
        elseif mode == "Spin" then
            root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(tick() * 360), 0)
        elseif mode == "Blink" then
            if math.floor(tick() % blink) == 0 then
                root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(yaw), 0)
            end
        elseif mode == "Desync Offset" then
            root.CFrame = root.CFrame * CFrame.new(Vector3.new(desync, 0, desync)) * CFrame.Angles(0, math.rad(yaw), 0)
        elseif mode == "Random Mix" then
            root.CFrame = root.CFrame * CFrame.Angles(math.random(-1, 1) * math.rad(90), math.rad(yaw + math.random(-30, 30)), 0)
        end
    end
end)
getgenv().Fatality_Speed_Enabled = false
getgenv().Fatality_Speed_Speed_Mode = "Normal"
getgenv().Fatality_Speed_Speed_Multiplier = 2
getgenv().Fatality_Speed_Burst_Duration = 0.5
getgenv().Fatality_Speed_Sync_with_Blink = true

getgenv().Fatality_Shift_Lock_Enabled = true
getgenv().Fatality_Shift_Lock_Shift_Speed = 5

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ShiftButton = Instance.new("TextButton")
ShiftButton.Name = "ShiftButton"
ShiftButton.Size = UDim2.new(0, 50, 0, 50)
ShiftButton.Position = UDim2.new(0, 10, 1, -60)
ShiftButton.BackgroundColor3 = Colors.Dark
ShiftButton.BorderSizePixel = 0
ShiftButton.Text = "Shift"
ShiftButton.TextColor3 = Colors.White
ShiftButton.TextScaled = true
ShiftButton.Font = Enum.Font.Gotham
ShiftButton.Parent = ScreenGui

local ShiftCorner = Instance.new("UICorner")
ShiftCorner.CornerRadius = UDim.new(0, 8)
ShiftCorner.Parent = ShiftButton

local shiftDragging = false
local shiftDragStart = nil
local shiftStartPos = nil

ShiftButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        shiftDragging = true
        shiftDragStart = input.Position
        shiftStartPos = ShiftButton.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if shiftDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - shiftDragStart
        ShiftButton.Position = UDim2.new(shiftStartPos.X.Scale, shiftStartPos.X.Offset + delta.X, shiftStartPos.Y.Scale, shiftStartPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        shiftDragging = false
    end
end)

local isShifting = false
ShiftButton.MouseButton1Click:Connect(function()
    if getgenv().Fatality_Shift_Lock_Enabled then
        isShifting = not isShifting
        ShiftButton.BackgroundColor3 = isShifting and Colors.DarkPink or Colors.Dark
    end
end)

RunService.Heartbeat:Connect(function()
    if getgenv().Fatality_Speed_Enabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local humanoid = LocalPlayer.Character.Humanoid
        local mode = getgenv().Fatality_Speed_Speed_Mode
        local multiplier = getgenv().Fatality_Speed_Speed_Multiplier
        local burstDuration = getgenv().Fatality_Speed_Burst_Duration

        local baseSpeed = isShifting and getgenv().Fatality_Shift_Lock_Shift_Speed or 16 * multiplier

        if mode == "Normal" then
            humanoid.WalkSpeed = baseSpeed
        elseif mode == "Adaptive" then
            humanoid.WalkSpeed = baseSpeed + math.sin(tick()) * 5
        elseif mode == "Burst" then
            if math.floor(tick() % burstDuration) == 0 then
                humanoid.WalkSpeed = baseSpeed * 2
            else
                humanoid.WalkSpeed = baseSpeed
            end
        elseif mode == "Strafe" then
            humanoid.WalkSpeed = baseSpeed + (UserInputService:IsKeyDown(Enum.KeyCode.A) or UserInputService:IsKeyDown(Enum.KeyCode.D)) and 5 or 0
        elseif mode == "Bunny Hop" then
            if humanoid.Jump then
                humanoid.WalkSpeed = baseSpeed * 1.5
            else
                humanoid.WalkSpeed = baseSpeed
            end
        elseif mode == "Teleport" and getgenv().Fatality_Speed_Sync_with_Blink then
            if math.floor(tick() % 1) == 0 then
                LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + LocalPlayer.Character.Humanoid.MoveDirection * baseSpeed
            end
        end
    elseif LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local humanoid = LocalPlayer.Character.Humanoid
        humanoid.WalkSpeed = isShifting and getgenv().Fatality_Shift_Lock_Shift_Speed or 16
    end
end)
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

getgenv().Fatality_Bullet_Tracers_Enabled = true
getgenv().Fatality_Bullet_Tracers_Tracer_Style = "Glow"
getgenv().Fatality_Bullet_Tracers_Line_Width = 2
getgenv().Fatality_Bullet_Tracers_Color_R = 255
getgenv().Fatality_Bullet_Tracers_Color_G = 0
getgenv().Fatality_Bullet_Tracers_Color_B = 0
getgenv().Fatality_Bullet_Tracers_Duration = 1
getgenv().Fatality_Bullet_Tracers_Glow_Intensity = 0.5
getgenv().Fatality_Bullet_Tracers_Notification_Size = 16

getgenv().Fatality_Hit_Particles_Enabled = true
getgenv().Fatality_Hit_Particles_Particle_Size = 1
getgenv().Fatality_Hit_Particles_Particle_Color_R = 255
getgenv().Fatality_Hit_Particles_Particle_Color_G = 0
getgenv().Fatality_Hit_Particles_Particle_Color_B = 0

getgenv().Fatality_Kill_Effect_Enabled = true
getgenv().Fatality_Kill_Effect_Effect_Intensity = 1

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local function createBox(player)
    local box = Instance.new("BoxHandleAdornment")
    box.Size = Vector3.new(4, 6, 4)
    box.Color3 = Color3.fromRGB(getgenv().Fatality_ESP_Hitbox_Health_Bar_Color_R, getgenv().Fatality_ESP_Hitbox_Health_Bar_Color_G, getgenv().Fatality_ESP_Hitbox_Health_Bar_Color_B)
    box.Transparency = getgenv().Fatality_ESP_Hitbox_Highlight_Style == "Glow" and 0.5 or 0.7
    box.ZIndex = 10
    box.AlwaysOnTop = getgenv().Fatality_ESP_Hitbox_Highlight_Style == "Wireframe" or getgenv().Fatality_ESP_Hitbox_Highlight_Style == "Outline"
    box.Adornee = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    box.Parent = game.CoreGui
    return box
end

local function createHealthBar(player)
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 50, 0, 5)
    billboard.AlwaysOnTop = true
    billboard.Adornee = player.Character and player.Character:FindFirstChild("Head")
    billboard.Parent = game.CoreGui

    local healthFrame = Instance.new("Frame")
    healthFrame.Size = UDim2.new(1, 0, 1, 0)
    healthFrame.BackgroundColor3 = Color3.fromRGB(getgenv().Fatality_ESP_Hitbox_Health_Bar_Color_R, getgenv().Fatality_ESP_Hitbox_Health_Bar_Color_G, getgenv().Fatality_ESP_Hitbox_Health_Bar_Color_B)
    healthFrame.Parent = billboard

    return billboard
end

RunService.RenderStepped:Connect(function()
    if getgenv().Fatality_ESP_Hitbox_Enabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                if not getgenv().Fatality_ESP_Hitbox_Highlight_Enemy_Hitboxes then continue end
                local distance = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                if distance > getgenv().Fatality_ESP_Hitbox_Distance_Limit then continue end

                local box = game.CoreGui:FindFirstChild(player.Name .. "_Box")
                if not box then
                    box = createBox(player)
                    box.Name = player.Name .. "_Box"
                end
                box.Adornee = player.Character.HumanoidRootPart

                if getgenv().Fatality_ESP_Hitbox_Highlight_Style == "Health Only" or getgenv().Fatality_ESP_Hitbox_Highlight_Style == "Full" then
                    local healthBar = game.CoreGui:FindFirstChild(player.Name .. "_HealthBar")
                    if not healthBar then
                        healthBar = createHealthBar(player)
                        healthBar.Name = player.Name .. "_HealthBar"
                    end
                    healthBar.Adornee = player.Character.Head
                    local health = player.Character.Humanoid.Health / player.Character.Humanoid.MaxHealth
                    healthBar.Frame.Size = UDim2.new(health, 0, 1, 0)
                end
            end
        end
    end
end)

local function createTracer(startPos, endPos)
    local tracer = Instance.new("Frame")
    tracer.Size = UDim2.new(0, getgenv().Fatality_Bullet_Tracers_Line_Width, 0, (startPos - endPos).Magnitude)
    tracer.Position = UDim2.new(0, (startPos.X + endPos.X) / 2, 0, (startPos.Y + endPos.Y) / 2)
    tracer.Rotation = math.deg(math.atan2(endPos.Y - startPos.Y, endPos.X - startPos.X))
    tracer.BackgroundColor3 = Color3.fromRGB(getgenv().Fatality_Bullet_Tracers_Color_R, getgenv().Fatality_Bullet_Tracers_Color_G, getgenv().Fatality_Bullet_Tracers_Color_B)
    tracer.BorderSizePixel = 0
    tracer.Parent = game.CoreGui
    Debris:AddItem(tracer, getgenv().Fatality_Bullet_Tracers_Duration)

    if getgenv().Fatality_Bullet_Tracers_Tracer_Style == "Glow" then
        local glow = Instance.new("ImageLabel")
        glow.Size = UDim2.new(1, 10, 1, 10)
        glow.Position = UDim2.new(0, -5, 0, -5)
        glow.BackgroundTransparency = 1
        glow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
        glow.ImageColor3 = Color3.fromRGB(getgenv().Fatality_Bullet_Tracers_Color_R, getgenv().Fatality_Bullet_Tracers_Color_G, getgenv().Fatality_Bullet_Tracers_Color_B)
        glow.ImageTransparency = 1 - getgenv().Fatality_Bullet_Tracers_Glow_Intensity
        glow.Parent = tracer
    end
end

local function createParticle(position)
    if not getgenv().Fatality_Hit_Particles_Enabled then return end
    local particle = Instance.new("Part")
    particle.Size = Vector3.new(getgenv().Fatality_Hit_Particles_Particle_Size, getgenv().Fatality_Hit_Particles_Particle_Size, getgenv().Fatality_Hit_Particles_Particle_Size)
    particle.Position = position
    particle.Color = Color3.fromRGB(getgenv().Fatality_Hit_Particles_Particle_Color_R, getgenv().Fatality_Hit_Particles_Particle_Color_G, getgenv().Fatality_Hit_Particles_Particle_Color_B)
    particle.Anchored = true
    particle.CanCollide = false
    particle.Parent = Workspace
    Debris:AddItem(particle, 0.5)

    local emitter = Instance.new("ParticleEmitter")
    emitter.Size = NumberSequence.new(getgenv().Fatality_Hit_Particles_Particle_Size)
    emitter.Rate = 50
    emitter.Lifetime = NumberRange.new(0.3, 0.5)
    emitter.Speed = NumberRange.new(5, 10)
    emitter.Color = ColorSequence.new(Color3.fromRGB(getgenv().Fatality_Hit_Particles_Particle_Color_R, getgenv().Fatality_Hit_Particles_Particle_Color_G, getgenv().Fatality_Hit_Particles_Particle_Color_B))
    emitter.Parent = particle
end

local function createKillEffect(player)
    if not getgenv().Fatality_Kill_Effect_Enabled then return end
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local effect = Instance.new("PointLight")
        effect.Brightness = getgenv().Fatality_Kill_Effect_Effect_Intensity
        effect.Range = 10
        effect.Color = Color3.fromRGB(255, 0, 0)
        effect.Parent = player.Character.HumanoidRootPart
        Debris:AddItem(effect, 0.5)
    end
end

Players.PlayerRemoving:Connect(function(player)
    local box = game.CoreGui:FindFirstChild(player.Name .. "_Box")
    if box then box:Destroy() end
    local healthBar = game.CoreGui:FindFirstChild(player.Name .. "_HealthBar")
    if healthBar then healthBar:Destroy() end
end)

RunService.RenderStepped:Connect(function()
    if getgenv().Fatality_Bullet_Tracers_Enabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local gun = LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
        if gun then
            local fireEvent = gun:FindFirstChild("Fire") or gun:FindFirstChild("Shoot")
            if fireEvent then
                fireEvent:Connect(function(targetPos)
                    local startPos = Camera:WorldToScreenPoint(LocalPlayer.Character.HumanoidRootPart.Position)
                    local endPos = Camera:WorldToScreenPoint(targetPos)
                    createTracer(Vector2.new(startPos.X, startPos.Y), Vector2.new(endPos.X, endPos.Y))
                end)
            end
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function(character)
    character.Humanoid.HealthChanged:Connect(function(health)
        if health < character.Humanoid.MaxHealth then
            createParticle(character.HumanoidRootPart.Position)
        end
    end)
    character.Humanoid.Died:Connect(function()
        createKillEffect(LocalPlayer)
    end)
end)
getgenv().Fatality_Custom_Crosshair_Enabled = true
getgenv().Fatality_Custom_Crosshair_Crosshair_Size = 10
getgenv().Fatality_Custom_Crosshair_Crosshair_Color_R = 255
getgenv().Fatality_Custom_Crosshair_Crosshair_Color_G = 255
getgenv().Fatality_Custom_Crosshair_Crosshair_Color_B = 255

getgenv().Fatality_Hitmarker_Enabled = true
getgenv().Fatality_Hitmarker_Hitmarker_Size = 20

getgenv().Fatality_Damage_Indicator_Enabled = true
getgenv().Fatality_Damage_Indicator_Text_Size = 14

getgenv().Fatality_Model_Swap_Enabled = true
getgenv().Fatality_Model_Swap_Model_Style = "CJ Ballas"

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local function createCrosshair()
    local crosshair = Instance.new("Frame")
    crosshair.Size = UDim2.new(0, getgenv().Fatality_Custom_Crosshair_Crosshair_Size, 0, getgenv().Fatality_Custom_Crosshair_Crosshair_Size)
    crosshair.Position = UDim2.new(0.5, -getgenv().Fatality_Custom_Crosshair_Crosshair_Size / 2, 0.5, -getgenv().Fatality_Custom_Crosshair_Crosshair_Size / 2)
    crosshair.BackgroundColor3 = Color3.fromRGB(getgenv().Fatality_Custom_Crosshair_Crosshair_Color_R, getgenv().Fatality_Custom_Crosshair_Crosshair_Color_G, getgenv().Fatality_Custom_Crosshair_Crosshair_Color_B)
    crosshair.BorderSizePixel = 0
    crosshair.Parent = game.CoreGui
    return crosshair
end

local function createHitmarker()
    if not getgenv().Fatality_Hitmarker_Enabled then return end
    local hitmarker = Instance.new("Frame")
    hitmarker.Size = UDim2.new(0, getgenv().Fatality_Hitmarker_Hitmarker_Size, 0, getgenv().Fatality_Hitmarker_Hitmarker_Size)
    hitmarker.Position = UDim2.new(0.5, -getgenv().Fatality_Hitmarker_Hitmarker_Size / 2, 0.5, -getgenv().Fatality_Hitmarker_Hitmarker_Size / 2)
    hitmarker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    hitmarker.BorderSizePixel = 0
    hitmarker.Parent = game.CoreGui
    Debris:AddItem(hitmarker, 0.2)
end

local function createDamageIndicator(position, damage)
    if not getgenv().Fatality_Damage_Indicator_Enabled then return end
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 100, 0, 30)
    billboard.AlwaysOnTop = true
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.Adornee = Workspace:FindPartOnRay(Ray.new(position, Vector3.new(0, -10, 0)))
    billboard.Parent = game.CoreGui

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = tostring(damage)
    text.TextColor3 = Color3.fromRGB(255, 0, 0)
    text.TextSize = getgenv().Fatality_Damage_Indicator_Text_Size
    text.Font = Enum.Font.Gotham
    text.Parent = billboard

    local tween = TweenService:Create(billboard, TweenInfo.new(1, Enum.EasingStyle.Linear), {StudsOffset = Vector3.new(0, 4, 0)})
    tween:Play()
    Debris:AddItem(billboard, 1)
end

local function applyModelSwap(player)
    if not player.Character then return end
    local style = getgenv().Fatality_Model_Swap_Model_Style
    local textures = {
        ["CJ Ballas"] = {Shirt = "rbxassetid://1489665925", Pants = "rbxassetid://1489666023", Face = "rbxassetid://144075659", Color = Color3.fromRGB(128, 0, 128)},
        ["Neon Cyberpunk"] = {Shirt = "rbxassetid://6067428139", Pants = "rbxassetid://6067428140", Face = "rbxassetid://144075659", Color = Color3.fromRGB(0, 255, 255)},
        ["Retro Gangster"] = {Shirt = "rbxassetid://6067428139", Pants = "rbxassetid://6067428140", Face = "rbxassetid://144075659", Color = Color3.fromRGB(50, 50, 50)},
        ["Anime Thug"] = {Shirt = "rbxassetid://6067428139", Pants = "rbxassetid://6067428140", Face = "rbxassetid://144075659", Color = Color3.fromRGB(255, 0, 255)},
        ["Street Punk"] = {Shirt = "rbxassetid://6067428139", Pants = "rbxassetid://6067428140", Face = "rbxassetid://144075659", Color = Color3.fromRGB(255, 165, 0)}
    }

    local data = textures[style]
    if player.Character:FindFirstChild("Shirt") then
        player.Character.Shirt.ShirtTemplate = data.Shirt
    else
        local shirt = Instance.new("Shirt")
        shirt.ShirtTemplate = data.Shirt
        shirt.Parent = player.Character
    end

    if player.Character:FindFirstChild("Pants") then
        player.Character.Pants.PantsTemplate = data.Pants
    else
        local pants = Instance.new("Pants")
        pants.PantsTemplate = data.Pants
        pants.Parent = player.Character
    end

    if player.Character:FindFirstChild("Head") and player.Character.Head:FindFirstChild("face") then
        player.Character.Head.face.Texture = data.Face
    end

    for _, part in ipairs(player.Character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.BrickColor = BrickColor.new(data.Color)
        end
    end
end

RunService.RenderStepped:Connect(function()
    if getgenv().Fatality_Custom_Crosshair_Enabled then
        local crosshair = game.CoreGui:FindFirstChild("Crosshair")
        if not crosshair then
            crosshair = createCrosshair()
            crosshair.Name = "Crosshair"
        end
    else
        local crosshair = game.CoreGui:FindFirstChild("Crosshair")
        if crosshair then crosshair:Destroy() end
    end

    if getgenv().Fatality_Model_Swap_Enabled and LocalPlayer.Character then
        applyModelSwap(LocalPlayer)
    end
end)

LocalPlayer.CharacterAdded:Connect(function(character)
    if getgenv().Fatality_Model_Swap_Enabled then
        applyModelSwap(LocalPlayer)
    end
    character.Humanoid.HealthChanged:Connect(function(health)
        if health < character.Humanoid.MaxHealth then
            createHitmarker()
            createDamageIndicator(character.HumanoidRootPart.Position, character.Humanoid.MaxHealth - health)
        end
    end)
end)

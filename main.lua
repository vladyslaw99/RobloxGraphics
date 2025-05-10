local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "GM_Mod"
gui.ResetOnSpawn = false

-- Loading Screen
local loadingFrame = Instance.new("Frame", gui)
loadingFrame.Size = UDim2.new(1, 0, 1, 0)
loadingFrame.BackgroundColor3 = Color3.new(0, 0, 0)
loadingFrame.ZIndex = 10

local loadingLabel = Instance.new("TextLabel", loadingFrame)
loadingLabel.Size = UDim2.new(0, 200, 0, 50)
loadingLabel.Position = UDim2.new(0.5, -100, 0.5, -25)
loadingLabel.Text = "Loading..."
loadingLabel.TextColor3 = Color3.new(1, 1, 1)

-- Main Menu
local menuFrame = Instance.new("Frame", gui)
menuFrame.Size = UDim2.new(0.4, 0, 0.7, 0)
menuFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
menuFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
menuFrame.ClipsDescendants = true

local uiCorner = Instance.new("UICorner", menuFrame)
uiCorner.CornerRadius = UDim.new(0.05, 0)

local uiStroke = Instance.new("UIStroke", menuFrame)
uiStroke.Color = Color3.fromRGB(75, 0, 130)
uiStroke.Thickness = 3

-- Glowing effect
local glow = Instance.new("UIGradient", uiStroke)
glow.Rotation = 45
glow.Transparency = NumberSequence.new(0.5)

RunService.Heartbeat:Connect(function(t)
    glow.Offset = Vector2.new(math.sin(t * 5) * 0.5, math.cos(t * 5) * 0.5)
end)

-- Header
local header = Instance.new("Frame", menuFrame)
header.Size = UDim2.new(1, 0, 0.15, 0)
header.BackgroundTransparency = 1

local avatar = Instance.new("ImageLabel", header)
avatar.Size = UDim2.new(0.15, 0, 0.8, 0)
avatar.Position = UDim2.new(0.05, 0, 0.1, 0)
avatar.Image = "https://via.placeholder.com/150"

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(0.6, 0, 0.5, 0)
title.Position = UDim2.new(0.25, 0, 0.1, 0)
title.Text = "GM Mod"
title.TextColor3 = Color3.new(1, 1, 1)

local developer = Instance.new("TextLabel", header)
developer.Size = UDim2.new(0.6, 0, 0.3, 0)
developer.Position = UDim2.new(0.25, 0, 0.6, 0)
developer.Text = "Developer: foitye"
developer.TextColor3 = Color3.new(0.7, 0.7, 0.7)

-- Tabs
local tabs = {"💾 Main", "🔫 Game", "🧑 Players", "🌍 Language", "⚙ Config"}
local tabButtons = {}
local contentFrames = {}

-- Tab buttons container
local tabContainer = Instance.new("Frame", menuFrame)
tabContainer.Size = UDim2.new(1, 0, 0.1, 0)
tabContainer.Position = UDim2.new(0, 0, 0.15, 0)
tabContainer.BackgroundTransparency = 1

-- Content container
local contentContainer = Instance.new("Frame", menuFrame)
contentContainer.Size = UDim2.new(1, 0, 0.75, 0)
contentContainer.Position = UDim2.new(0, 0, 0.25, 0)
contentContainer.BackgroundTransparency = 1

-- Create tabs
for i, tabName in ipairs(tabs) do
    -- Tab button
    local tabButton = Instance.new("TextButton", tabContainer)
    tabButton.Size = UDim2.new(1/#tabs, 0, 1, 0)
    tabButton.Position = UDim2.new((i-1)/#tabs, 0, 0, 0)
    tabButton.Text = tabName
    tabButton.TextColor3 = Color3.new(1, 1, 1)
    tabButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    
    -- Content frame
    local contentFrame = Instance.new("Frame", contentContainer)
    contentFrame.Size = UDim2.new(1, 0, 1, 0)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Visible = i == 1
    
    table.insert(tabButtons, tabButton)
    table.insert(contentFrames, contentFrame)
    
    tabButton.MouseButton1Click:Connect(function()
        for _, frame in ipairs(contentFrames) do
            frame.Visible = false
        end
        contentFrame.Visible = true
    end)
end

-- Players List
local playersScroll = Instance.new("ScrollingFrame", contentFrames[3])
playersScroll.Size = UDim2.new(1, 0, 1, 0)
playersScroll.CanvasSize = UDim2.new(0, 0, 2, 0)

local function updatePlayers()
    playersScroll:ClearAllChildren()
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player then
            local playerFrame = Instance.new("Frame", playersScroll)
            playerFrame.Size = UDim2.new(1, -20, 0, 100)
            playerFrame.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
            
            -- Add player info and buttons here
        end
    end
end

-- Update players every 3 seconds
while true do
    updatePlayers()
    wait(3)
end

-- Toggle button
local toggleButton = Instance.new("TextButton", gui)
toggleButton.Size = UDim2.new(0.2, 0, 0.05, 0)
toggleButton.Position = UDim2.new(0.4, 0, -0.05, 0)
toggleButton.Text = "Hide GM Mod"
toggleButton.BackgroundTransparency = 0.7
toggleButton.BackgroundColor3 = Color3.new(0, 0, 0)

local function toggleMenu()
    if menuFrame.Visible then
        -- Hide animation
        TweenService:Create(menuFrame, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -200, -0.7, -175)}):Play()
        TweenService:Create(menuFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        toggleButton.Text = "Show GM Mod"
    else
        -- Show animation
        menuFrame.Visible = true
        TweenService:Create(menuFrame, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -200, 0.5, -175)}):Play()
        TweenService:Create(menuFrame, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
        toggleButton.Text = "Hide GM Mod"
    end
end

toggleButton.MouseButton1Click:Connect(toggleMenu)
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.O then
        toggleMenu()
    end
end)

-- Hide loading screen after 3 seconds
wait(3)
loadingFrame:TweenPosition(UDim2.new(0.5, 0, 1, 0), "Out", "Quad", 1)
wait(1)
loadingFrame:Destroy()

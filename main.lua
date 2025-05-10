local loadGraphicPreset = loadstring(game:HttpGet("https://raw.githubusercontent.com/vladyslaw99/RobloxGraphics/main/graphics.lua"))()

-- UI Library
local UI = {
    Screens = {},
    Tweens = {},
    CurrentScreen = nil
}

-- Services
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Create main GUI
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local MainGUI = Instance.new("ScreenGui")
MainGUI.Name = "GenGraphicsUI"
MainGUI.ResetOnSpawn = false
MainGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
MainGUI.Parent = PlayerGui

-- Loading screen
function UI:CreateLoadingScreen()
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BackgroundTransparency = 0.3
    frame.Name = "LoadingScreen"
    
    local spinner = Instance.new("Frame")
    spinner.Size = UDim2.new(0, 80, 0, 80)
    spinner.Position = UDim2.new(0.5, -40, 0.4, -40)
    spinner.BackgroundTransparency = 1
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.new(1, 0.5, 0)),
        ColorSequenceKeypoint.new(1, Color3.new(1, 0.9, 0))
    })
    gradient.Rotation = 90
    gradient.Parent = spinner
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 4
    stroke.Color = Color3.new(1, 1, 1)
    stroke.Transparency = 0.2
    stroke.Parent = spinner
    
    for i = 1, 12 do
        local part = Instance.new("Frame")
        part.Size = UDim2.new(0.08, 0, 0.3, 0)
        part.Position = UDim2.new(0.46, 0, 0.1, 0)
        part.BackgroundColor3 = Color3.new(1, 1, 1)
        part.Rotation = (i-1) * 30
        part.Parent = spinner
    end
    
    local rotateAnim = TweenService:Create(
        spinner,
        TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1),
        {Rotation = 360}
    )
    rotateAnim:Play()
    
    local title = Instance.new("TextLabel")
    title.Text = "GenGraphics"
    title.Font = Enum.Font.GothamBlack
    title.TextSize = 28
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0.5, 20)
    title.BackgroundTransparency = 1
    title.TextStrokeTransparency = 0.5
    title.TextStrokeColor3 = Color3.new(0, 0, 0)
    
    spinner.Parent = frame
    title.Parent = frame
    frame.Parent = MainGUI
    
    self.Tweens[spinner] = rotateAnim
    self.Screens.Loading = frame
    
    return frame
end

-- Main menu
function UI:CreateMainMenu()
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.45, 0, 0.55, 0)
    frame.Position = UDim2.new(0.275, 0, 0.225, 0)
    frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    frame.BackgroundTransparency = 0.4
    frame.Visible = false
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.04, 0)
    corner.Parent = frame
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Color = Color3.new(1, 1, 1)
    stroke.Transparency = 0.7
    stroke.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Text = "GRAPHICS PRESETS"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Size = UDim2.new(1, 0, 0.15, 0)
    title.Position = UDim2.new(0, 0, 0.05, 0)
    title.BackgroundTransparency = 1
    title.TextStrokeTransparency = 0.7
    
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Size = UDim2.new(0.8, 0, 0.7, 0)
    buttonContainer.Position = UDim2.new(0.1, 0, 0.2, 0)
    buttonContainer.BackgroundTransparency = 1
    
    local buttons = {
        {
            name = "ULTRA QUALITY",
            desc = "Maximum visual fidelity\nHigh system requirements",
            color = Color3.fromRGB(0, 180, 255),
            preset = "Ultra Quality"
        },
        {
            name = "BALANCED",
            desc = "Good visuals and performance\nRecommended for most systems",
            color = Color3.fromRGB(120, 220, 0),
            preset = "Balanced"
        },
        {
            name = "PERFORMANCE",
            desc = "Optimized for performance\nLower visual quality",
            color = Color3.fromRGB(255, 100, 0),
            preset = "Performance"
        }
    }
    
    for i, btn in ipairs(buttons) do
        local buttonFrame = Instance.new("Frame")
        buttonFrame.Size = UDim2.new(1, 0, 0.3, -10)
        buttonFrame.Position = UDim2.new(0, 0, 0.33 * (i-1), 0)
        buttonFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        buttonFrame.BackgroundTransparency = 0.5
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0.08, 0)
        btnCorner.Parent = buttonFrame
        
        local btnStroke = Instance.new("UIStroke")
        btnStroke.Thickness = 1.5
        btnStroke.Color = btn.color
        btnStroke.Transparency = 0.5
        btnStroke.Parent = buttonFrame
        
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, 0, 1, 0)
        button.BackgroundTransparency = 1
        button.Text = ""
        button.ZIndex = 2
        
        local btnTitle = Instance.new("TextLabel")
        btnTitle.Text = btn.name
        btnTitle.Font = Enum.Font.GothamBlack
        btnTitle.TextSize = 18
        btnTitle.TextColor3 = btn.color
        btnTitle.Size = UDim2.new(1, -20, 0.4, 0)
        btnTitle.Position = UDim2.new(0, 10, 0.1, 0)
        btnTitle.BackgroundTransparency = 1
        btnTitle.TextXAlignment = Enum.TextXAlignment.Left
        
        local btnDesc = Instance.new("TextLabel")
        btnDesc.Text = btn.desc
        btnDesc.Font = Enum.Font.Gotham
        btnDesc.TextSize = 14
        btnDesc.TextColor3 = Color3.new(0.9, 0.9, 0.9)
        btnDesc.Size = UDim2.new(1, -20, 0.6, 0)
        btnDesc.Position = UDim2.new(0, 10, 0.4, 0)
        btnDesc.BackgroundTransparency = 1
        btnDesc.TextXAlignment = Enum.TextXAlignment.Left
        btnDesc.TextYAlignment = Enum.TextYAlignment.Top
        
        button.MouseEnter:Connect(function()
            TweenService:Create(buttonFrame, TweenInfo.new(0.3), {
                BackgroundTransparency = 0.3,
                BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)
            }):Play()
            TweenService:Create(btnStroke, TweenInfo.new(0.3), {
                Transparency = 0.2
            }):Play()
        end)
        
        button.MouseLeave:Connect(function()
            TweenService:Create(buttonFrame, TweenInfo.new(0.3), {
                BackgroundTransparency = 0.5,
                BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
            }):Play()
            TweenService:Create(btnStroke, TweenInfo.new(0.3), {
                Transparency = 0.5
            }):Play()
        end)
        
        button.MouseButton1Click:Connect(function()
            self:ApplyPreset(btn.preset)
        end)
        
        btnTitle.Parent = buttonFrame
        btnDesc.Parent = buttonFrame
        button.Parent = buttonFrame
        buttonFrame.Parent = buttonContainer
    end
    
    title.Parent = frame
    buttonContainer.Parent = frame
    frame.Parent = MainGUI
    
    self.Screens.MainMenu = frame
    return frame
end

-- Preset loading screen
function UI:CreatePresetScreen(presetName)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BackgroundTransparency = 0.5
    
    local container = Instance.new("Frame")
    container.Size = UDim2.new(0.5, 0, 0.25, 0)
    container.Position = UDim2.new(0.25, 0, 0.375, 0)
    container.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
    container.BackgroundTransparency = 0.3
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.05, 0)
    corner.Parent = container
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Color = Color3.new(1, 1, 1)
    stroke.Transparency = 0.5
    stroke.Parent = container
    
    local title = Instance.new("TextLabel")
    title.Text = "APPLYING "..presetName:upper()
    title.Font = Enum.Font.GothamBlack
    title.TextSize = 24
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Size = UDim2.new(1, -40, 0.4, 0)
    title.Position = UDim2.new(0, 20, 0.1, 0)
    title.BackgroundTransparency = 1
    title.TextXAlignment = Enum.TextXAlignment.Left
    
    local progressBar = Instance.new("Frame")
    progressBar.Size = UDim2.new(0.9, 0, 0.1, 0)
    progressBar.Position = UDim2.new(0.05, 0, 0.7, 0)
    progressBar.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    progressBar.BorderSizePixel = 0
    
    local progressFill = Instance.new("Frame")
    progressFill.Size = UDim2.new(0, 0, 1, 0)
    progressFill.BackgroundColor3 = Color3.fromHSV(0.55, 0.8, 1)
    progressFill.BorderSizePixel = 0
    
    local glow = Instance.new("ImageLabel")
    glow.Size = UDim2.new(1, 0, 1, 0)
    glow.Image = "rbxassetid://5028857084"
    glow.ImageColor3 = Color3.fromHSV(0.55, 0.3, 1)
    glow.ScaleType = Enum.ScaleType.Slice
    glow.SliceCenter = Rect.new(20, 20, 280, 280)
    glow.BackgroundTransparency = 1
    glow.Parent = progressFill
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.5, 0)
    corner.Parent = progressBar
    
    progressFill.Parent = progressBar
    title.Parent = container
    progressBar.Parent = container
    container.Parent = frame
    frame.Parent = MainGUI
    
    return {
        Frame = frame,
        Progress = progressFill
    }
end

-- Apply preset function
function UI:ApplyPreset(presetName)
    -- Close current screen
    if self.CurrentScreen then
        self.CurrentScreen:Destroy()
    end
    
    -- Create loading screen
    local presetScreen = self:CreatePresetScreen(presetName)
    self.CurrentScreen = presetScreen.Frame
    
    -- Animate progress
    for i = 1, 100 do
        presetScreen.Progress.Size = UDim2.new(i/100, 0, 1, 0)
        RunService.Heartbeat:Wait()
    end
    
    -- Apply graphics
    loadGraphicPreset(presetName)
    
    -- Fade out
    TweenService:Create(presetScreen.Frame, TweenInfo.new(0.7), {
        BackgroundTransparency = 1
    }):Play()
    
    wait(0.7)
    presetScreen.Frame:Destroy()
end

-- Initialize UI
function UI:Init()
    -- Create loading screen
    local loadingScreen = self:CreateLoadingScreen()
    
    -- Wait 2 seconds with loading animation
    wait(2)
    
    -- Fade out loading screen
    TweenService:Create(loadingScreen, TweenInfo.new(0.8), {
        BackgroundTransparency = 1
    }):Play()
    
    -- Create main menu
    local mainMenu = self:CreateMainMenu()
    mainMenu.Visible = true
    
    -- Fade in main menu
    TweenService:Create(mainMenu, TweenInfo.new(0.8), {
        BackgroundTransparency = 0.4
    }):Play()
    
    -- Cleanup loading screen
    wait(0.8)
    loadingScreen:Destroy()
end

-- Start the UI
UI:Init()

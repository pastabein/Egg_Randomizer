-- Roblox Egg Refresher Script with Start Button and Minimize/Full Mode

-- [Previous Code...]

-- === Refresh Button ===
local refreshButton = Instance.new("TextButton", mainSquare)
refreshButton.Size = UDim2.new(0.8, 0, 0.15, 0)
refreshButton.Position = UDim2.new(0.1, 0, 0.25, 0)
refreshButton.Text = "Refresh"
refreshButton.Font = Enum.Font.SourceSans
refreshButton.TextSize = 18
refreshButton.TextColor3 = Color3.new(1, 1, 1)
refreshButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Instance.new("UICorner", refreshButton)

local refreshTimer
refreshButton.MouseButton1Click:Connect(function()
    if refreshTimer then return end
    refreshTimer = true
    refreshButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

    local timeRemaining = 180
    task.spawn(function()
        while timeRemaining > 0 do
            task.wait(1)
            timeRemaining -= 1
            local minutes = math.floor(timeRemaining / 60)
            local seconds = timeRemaining % 60
            refreshButton.Text = string.format("Refresh (%d:%02d)", minutes, seconds)
        end
        refreshButton.Text = "Refresh"
        refreshButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        refreshTimer = nil
    end)
end)

-- === Detect Egg Button ===
local detectButton = Instance.new("TextButton", mainSquare)
detectButton.Size = UDim2.new(0.8, 0, 0.15, 0)
detectButton.Position = UDim2.new(0.1, 0, 0.45, 0)
detectButton.Text = "Detect Egg"
detectButton.Font = Enum.Font.SourceSans
detectButton.TextSize = 18
detectButton.TextColor3 = Color3.new(1, 1, 1)
detectButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
Instance.new("UICorner", detectButton)

local detectTimer
local TweenService = game:GetService("TweenService")
detectButton.MouseButton1Click:Connect(function()
    if detectTimer then return end
    detectTimer = true

    local timeRemaining = 600
    local glowTween = TweenService:Create(detectButton, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    })

    detectButton.Text = string.format("Detecting... (%d:%02d)", math.floor(timeRemaining / 60), timeRemaining % 60)
    glowTween:Play()

    task.spawn(function()
        while timeRemaining > 0 do
            task.wait(1)
            timeRemaining -= 1
            local minutes = math.floor(timeRemaining / 60)
            local seconds = timeRemaining % 60
            detectButton.Text = string.format("Detecting... (%d:%02d)", minutes, seconds)
        end

        glowTween:Cancel()
        detectButton.Text = "Detect Egg"
        detectButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        detectTimer = nil
    end)
end)

-- === Title ===
local titleLabel = Instance.new("TextLabel", mainSquare)
titleLabel.Size = UDim2.new(1, 0, 0.15, 0)
titleLabel.Position = UDim2.new(0, 0, 0.65, 0)
titleLabel.Text = "Egg Refresher - Modified by No-Lag Script"
titleLabel.Font = Enum.Font.SourceSansSemibold
titleLabel.TextSize = 14
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.BackgroundTransparency = 1

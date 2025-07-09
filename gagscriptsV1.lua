local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- === ScreenGui ===
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.ResetOnSpawn = false

-- === Universal Draggable Function ===
local function makeDraggable(frame)
    local UIS = game:GetService("UserInputService")
    local dragging, dragInput, dragStart, startPos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
        end
    end)
end

-- === Start Frame ===
local startFrame = Instance.new("Frame", screenGui)
startFrame.Size = UDim2.new(0, 250, 0, 120)
startFrame.Position = UDim2.new(0.4, 0, 0.4, 0)
startFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
startFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
startFrame.BorderSizePixel = 2
Instance.new("UICorner", startFrame)
makeDraggable(startFrame)

local startButton = Instance.new("TextButton", startFrame)
startButton.Size = UDim2.new(0.7, 0, 0.5, 0)
startButton.Position = UDim2.new(0.15, 0, 0.25, 0)
startButton.Text = "Start"
startButton.Font = Enum.Font.SourceSans
startButton.TextSize = 22
startButton.TextColor3 = Color3.new(1, 1, 1)
startButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Instance.new("UICorner", startButton)

local startTextStroke = Instance.new("UIStroke", startButton)
startTextStroke.Color = Color3.fromRGB(255, 255, 255)
startTextStroke.Thickness = 0.8

-- === Main Square ===
local mainSquare = Instance.new("Frame", screenGui)
mainSquare.Size = UDim2.new(0, 280, 0, 180)
mainSquare.Position = UDim2.new(0.4, 0, 0.35, 0)
mainSquare.BorderSizePixel = 0
mainSquare.Visible = false
Instance.new("UICorner", mainSquare)
makeDraggable(mainSquare)

-- Gradient black-to-gray
local gradient = Instance.new("UIGradient", mainSquare)
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 80, 80))
}

-- === Egg Button ===
local eggButton = Instance.new("TextButton", mainSquare)
eggButton.Size = UDim2.new(0.8, 0, 0.25, 0)
eggButton.Position = UDim2.new(0.1, 0, 0.1, 0)
eggButton.Text = "Choose Egg"
eggButton.Font = Enum.Font.SourceSans
eggButton.TextSize = 18
eggButton.TextColor3 = Color3.new(1, 1, 1)
eggButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Instance.new("UICorner", eggButton)
local eggStroke = Instance.new("UIStroke", eggButton)
eggStroke.Color = Color3.fromRGB(255, 255, 255)

-- === Refresh Button ===
local refreshButton = Instance.new("TextButton", mainSquare)
refreshButton.Size = UDim2.new(0.8, 0, 0.25, 0)
refreshButton.Position = UDim2.new(0.1, 0, 0.4, 0)
refreshButton.Text = "Refresh"
refreshButton.Font = Enum.Font.SourceSans
refreshButton.TextSize = 18
refreshButton.TextColor3 = Color3.new(1, 1, 1)
refreshButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Instance.new("UICorner", refreshButton)
local refreshStroke = Instance.new("UIStroke", refreshButton)
refreshStroke.Color = Color3.fromRGB(255, 255, 255)

local refreshTimer = nil

-- === Egg List Frame ===
local eggListFrame = Instance.new("Frame", mainSquare)
eggListFrame.Size = UDim2.new(0.6, 0, 0.7, 0)
eggListFrame.Position = UDim2.new(1.05, 0, 0.1, 0)
eggListFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
eggListFrame.Visible = false
Instance.new("UICorner", eggListFrame)

-- === Egg Options ===
local eggs = {"Bug Egg", "Night Egg", "Anti-Bee Egg", "Oasis Egg"}
local eggColors = {
    ["Bug Egg"]     = Color3.fromRGB(102, 204, 0),    -- green
    ["Night Egg"]   = Color3.fromRGB(51, 51, 102),    -- dark blue/purple
    ["Anti-Bee Egg"]= Color3.fromRGB(204, 51, 0),     -- red
    ["Oasis Egg"]   = Color3.fromRGB(51, 153, 204),   -- blue
}

for i, eggName in ipairs(eggs) do
    local eggOption = Instance.new("TextButton", eggListFrame)
    eggOption.Size = UDim2.new(1, 0, 0.2, 0)
    eggOption.Position = UDim2.new(0, 0, (i - 1) * 0.22, 0)
    eggOption.Text = eggName
    eggOption.Font = Enum.Font.SourceSans
    eggOption.TextSize = 16
    eggOption.TextColor3 = Color3.new(1, 1, 1)
    eggOption.BackgroundColor3 = eggColors[eggName] or Color3.fromRGB(60, 60, 60)
    Instance.new("UICorner", eggOption)
    local eggOptionStroke = Instance.new("UIStroke", eggOption)
    eggOptionStroke.Color = Color3.fromRGB(255, 255, 255)

    eggOption.MouseButton1Click:Connect(function()
        eggButton.Text = eggName
        eggButton.BackgroundColor3 = eggColors[eggName] or Color3.fromRGB(70, 70, 70)
        eggListFrame.Visible = false
    end)
end

-- === Button Functionality ===
startButton.MouseButton1Click:Connect(function()
    startFrame.Visible = false
    mainSquare.Visible = true
end)

eggButton.MouseButton1Click:Connect(function()
    eggListFrame.Visible = not eggListFrame.Visible
end)

refreshButton.MouseButton1Click:Connect(function()
    if refreshTimer then return end
    refreshButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

    local timeRemaining = 180
    refreshButton.Text = "Refresh (" .. timeRemaining .. "s)"
    refreshTimer = true

    task.spawn(function()
        while timeRemaining > 0 do
            task.wait(1)
            timeRemaining -= 1
            refreshButton.Text = "Refresh (" .. timeRemaining .. "s)"
        end
        refreshButton.Text = "Refresh"
        refreshButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        refreshTimer = nil
    end)
end)

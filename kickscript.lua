loadstring([[
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local PlayerList = Instance.new("ScrollingFrame")
local KickButton = Instance.new("TextButton")
local Title = Instance.new("TextLabel")
local UIListLayout = Instance.new("UIListLayout")

local selectedPlayer = nil

-- إعدادات الواجهة (اللون الأسود)
ScreenGui.Parent = game:GetService("CoreGui")

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -150)
MainFrame.Size = UDim2.new(0, 250, 0, 350)
MainFrame.BorderSizePixel = 2

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Text = "Admin Panel"
Title.TextSize = 20

PlayerList.Parent = MainFrame
PlayerList.Position = UDim2.new(0, 10, 0, 50)
PlayerList.Size = UDim2.new(0, 230, 0, 240)
PlayerList.BackgroundTransparency = 1
PlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)

UIListLayout.Parent = PlayerList
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

KickButton.Parent = MainFrame
KickButton.Position = UDim2.new(0, 10, 0, 300)
KickButton.Size = UDim2.new(0, 230, 0, 40)
KickButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
KickButton.TextColor3 = Color3.fromRGB(255, 255, 255)
KickButton.Text = "Kick"
KickButton.TextSize = 18

local function updateList()
    for _, child in pairs(PlayerList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        local pBtn = Instance.new("TextButton")
        pBtn.Parent = PlayerList
        pBtn.Size = UDim2.new(1, -10, 0, 30)
        pBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        pBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        pBtn.Text = player.Name
        
        pBtn.MouseButton1Click:Connect(function()
            for _, btn in pairs(PlayerList:GetChildren()) do
                if btn:IsA("TextButton") then btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45) end
            end
            pBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            selectedPlayer = player
        end)
    end
end

KickButton.MouseButton1Click:Connect(function()
    if selectedPlayer then
        selectedPlayer:Kick("You have been kicked from the server.")
        selectedPlayer = nil
        updateList()
    end
end)

updateList()
game:GetService("Players").PlayerAdded:Connect(updateList)
game:GetService("Players").PlayerRemoving:Connect(updateList)
]])()


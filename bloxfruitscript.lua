-- KT Farm - Auto Level Farm with Simple UI
local lp = game.Players.LocalPlayer
local chr = lp.Character or lp.CharacterAdded:Wait()
local hum = chr:WaitForChild("HumanoidRootPart")

-- Function to get current level
local function getLevel()
    return lp.Data.Level.Value
end

-- Simple level-based quest system (you can expand it)
local quests = {
    {level = 10, questName = "Bandit", questNPC = "Bandit Quest Giver", enemyName = "Bandit"},
    {level = 30, questName = "Gorilla", questNPC = "Jungle Quest Giver", enemyName = "Gorilla"},
    {level = 60, questName = "Pirate", questNPC = "Pirate Quest Giver", enemyName = "Pirate"},
    -- Add more quests here...
}

-- Function to find current quest info
local function getQuest()
    local lvl = getLevel()
    for i = #quests, 1, -1 do
        if lvl >= quests[i].level then
            return quests[i]
        end
    end
end

-- UI setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Position = UDim2.new(0, 20, 0.5, -50)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0

local Toggle = Instance.new("TextButton", Frame)
Toggle.Size = UDim2.new(1, 0, 1, 0)
Toggle.Text = "KT Farm OFF"
Toggle.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
Toggle.TextColor3 = Color3.new(1, 1, 1)
Toggle.Font = Enum.Font.SourceSansBold
Toggle.TextSize = 20

local farming = false

Toggle.MouseButton1Click:Connect(function()
    farming = not farming
    Toggle.Text = farming and "KT Farm ON" or "KT Farm OFF"
    Toggle.BackgroundColor3 = farming and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(255, 50, 50)
end)

-- Farm loop
task.spawn(function()
    while true do
        if farming then
            local q = getQuest()
            if q then
                -- Auto navigate to quest NPC
                for _, npc in pairs(workspace.NPCs:GetChildren()) do
                    if npc.Name == q.questNPC then
                        hum.CFrame = npc.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                        wait(1)
                        fireclickdetector(npc.ClickDetector)
                        wait(1)
                        game:GetService("ReplicatedStorage").Remotes.Comm:InvokeServer("StartQuest", q.questName, 1)
                        break
                    end
                end

                -- Find and attack enemies
                for _, mob in pairs(workspace.Enemies:GetChildren()) do
                    if mob.Name == q.enemyName and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                        repeat
                            hum.CFrame = mob.HumanoidRootPart.CFrame + Vector3.new(0, 2, 0)
                            wait(0.2)
                        until not mob or mob.Humanoid.Health <= 0 or not farming
                    end
                end
            end
        end
        wait(1)
    end
end)

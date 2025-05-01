-- KT Farm by KT Hub

-- Load UI Library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- Window setup
local Window = OrionLib:MakeWindow({
    Name = "KT Farm | Blox Fruits",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "KTFarmHub"
})

-- Variables
getgenv().autoFarm = false
getgenv().autoSkillZ = false
getgenv().autoSkillX = false
getgenv().autoSkillC = false

-- Anti-AFK
pcall(function()
    local vu = game:service("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end)

-- Auto Haki
function enableHaki()
    local plr = game.Players.LocalPlayer
    if not plr.Character:FindFirstChild("HasBuso") then
        game:GetService("VirtualInputManager"):SendKeyEvent(true, "J", false, game)
        wait(0.2)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, "J", false, game)
    end
end

-- Get enemy
function getEnemy()
    local enemies = workspace.Enemies:GetChildren()
    for i, v in pairs(enemies) do
        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            return v
        end
    end
    return nil
end

-- Farm loop
spawn(function()
    while wait(0.1) do
        if autoFarm then
            pcall(function()
                enableHaki()
                local mob = getEnemy()
                if mob then
                    repeat wait(0.2)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,5,3)
                        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,0,0,true,game,0)
                        wait(0.05)
                        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,0,0,false,game,0)
                    until mob.Humanoid.Health <= 0 or not autoFarm
                end
            end)
        end
    end
end)

-- Skill spam
spawn(function()
    while wait(1) do
        if autoSkillZ then
            keypress(0x5A) wait(0.1) keyrelease(0x5A)
        end
        if autoSkillX then
            keypress(0x58) wait(0.1) keyrelease(0x58)
        end
        if autoSkillC then
            keypress(0x43) wait(0.1) keyrelease(0x43)
        end
    end
end)

-- Tabs and toggles
local MainTab = Window:MakeTab({
    Name = "Auto Farm",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

MainTab:AddToggle({
    Name = "Bật Auto Farm",
    Default = false,
    Callback = function(v)
        autoFarm = v
    end
})

MainTab:AddToggle({
    Name = "Tự bật skill Z",
    Default = false,
    Callback = function(v)
        autoSkillZ = v
    end
})

MainTab:AddToggle({
    Name = "Tự bật skill X",
    Default = false,
    Callback = function(v)
        autoSkillX = v
    end
})

MainTab:AddToggle({
    Name = "Tự bật skill C",
    Default = false,
    Callback = function(v)
        autoSkillC = v
    end
})

OrionLib:Init()

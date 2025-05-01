-- Cài đặt điều kiện level
local player = game.Players.LocalPlayer
local level = player.Data.Level.Value

-- Hàm Auto Farm
function autoFarm()
    while true do
        wait(1)
        -- Điều kiện level để farm
        if level >= 100 then
            -- Tìm tất cả kẻ thù trong vùng farm
            for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                if enemy:FindFirstChild("HumanoidRootPart") then
                    -- Di chuyển đến kẻ thù và tấn công
                    player.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, "Z", false, game)
                end
            end
        end
    end
end

-- Hàm Auto Start Quest
function autoStartQuest()
    -- Nếu level phù hợp với quest
    if level >= 100 then
        -- Tìm NPC Quest và bắt đầu quest
        local questNpc = game:GetService("Workspace"):FindFirstChild("QuestNPC")
        if questNpc then
            questNpc.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "BanditQuest1", 1)
        end
    end
end

-- Hàm Teleport đến vị trí (Không di chuyển)
function teleportTo(position)
    player.Character.HumanoidRootPart.CFrame = CFrame.new(position)
end

-- Hàm Lấy CDK
function getCDK()
    if level >= 200 then
        -- Teleport đến vị trí CDK
        teleportTo(Vector3.new(-2000, 10, 3000)) -- Sử dụng vị trí CDK của bạn
        -- Lấy CDK
        local cdk = game:GetService("Workspace"):FindFirstChild("CDK")
        if cdk then
            -- Lấy CDK
            cdk:Click()
        end
    end
end

-- Hàm Lấy Kiếm Tushita
function getTushita()
    if level >= 1000 then
        -- Teleport đến vị trí Tushita
        teleportTo(Vector3.new(1500, 10, 1500)) -- Vị trí của Tushita
        -- Lấy Kiếm Tushita
        local tushita = game:GetService("Workspace"):FindFirstChild("TushitaSword")
        if tushita then
            tushita:Click()
        end
    end
end

-- Hàm Lấy Kiếm Yama
function getYama()
    if level >= 1200 then
        -- Teleport đến vị trí Yama
        teleportTo(Vector3.new(2000, 10, 2000)) -- Vị trí của Yama
        -- Lấy Kiếm Yama
        local yama = game:GetService("Workspace"):FindFirstChild("YamaSword")
        if yama then
            yama:Click()
        end
    end
end

-- Hàm Teleport đến vị trí có Cup Rip Indra
function teleportToRipIndra()
    teleportTo(Vector3.new(3000, 10, 4000)) -- Vị trí cup Rip Indra
end

-- Gọi các hàm theo điều kiện level và script yêu cầu
if level >= 100 then
    autoFarm()
end

if level >= 100 then
    autoStartQuest()
end

if level >= 200 then
    getCDK()
end

if level >= 1000 then
    getTushita()
end

if level >= 1200 then
    getYama()
end

-- Teleport đến cup Rip Indra
teleportToRipIndra()
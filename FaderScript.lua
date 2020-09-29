local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local DetectionFolder = workspace.TPs
local func = game.ReplicatedStorage.HitS
local groupId
local hit = false
local spot = game.Workspace.TPs.Teleport1.TP

local function fadeGui(gui, timeInput, value)
	local tween = TweenService:Create(gui, TweenInfo.new(
			timeInput, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0
		), {BackgroundTransparency = value}
	)
	
	tween:Play()
	tween.Completed:Wait()
end

local function fadeText(gui, timeInput, value)
	local tween = TweenService:Create(gui, TweenInfo.new(
			timeInput, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0
		), {TextTransparency = value}
	)
	
	tween:Play()
	tween.Completed:Wait()
end
local function fadeImage(gui, timeInput, value)
	local tween = TweenService:Create(gui, TweenInfo.new(
			timeInput, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0
		), {ImageTransparency = value}
	)
	
	tween:Play()
	tween.Completed:Wait()
end

local function onInitFading(player)
    player.Character.Humanoid.WalkSpeed = 0
    local PlayerGui = player.PlayerGui
    local Fader = PlayerGui:FindFirstChild("Fader")
    
    func:FireClient(player, false)
    fadeGui(Fader.F, 0.75, -0.2)
    fadeImage(Fader.F.A, 0.75, -0.2)
    fadeText(Fader.F.B, 0.75, -0.2)
    fadeText(Fader.F.C, 0.75, -0.2)
    Fader.F.Exit.Visible = true
    player.Character.Torso.CFrame = spot.CFrame + Vector3.new(0, 3, 0) 
    
    game.ReplicatedStorage.ExitAFK:FireClient(player)
    game.ReplicatedStorage.ExitAFK.OnServerEvent:Wait()
    
    -- exit afk bit
    Fader.F.Exit.Visible = false
    fadeText(Fader.F.C, 0.75, 1)
    fadeText(Fader.F.B, 0.75, 1)
    fadeImage(Fader.F.A, 0.75, 1)
    fadeGui(Fader.F, 0.75, 1)
    hit = false
    func:FireClient(player, true)
    player:LoadCharacter()
end

local function onTouched(part, destination)
	if part.Parent:FindFirstChild("Humanoid") ~= nil then
		local player = game.Players:GetPlayerFromCharacter(part.Parent)
		if hit == false then
			hit = true
            onInitFading(player)
		end
	end
end

-- Player is added. Player chats AFK or BRB, they will be teleported and stay AFK.
Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(msg)
        if msg:lower() == "afk" or msg:lower() == "brb" then
            onInitFading(player)
        end
    end)
end)

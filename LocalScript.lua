local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService('StarterGui')
local UserInputService = game:GetService("UserInputService")

local IsFading = false

local connection
local currentTween
local function ran(state)
	StarterGui:SetCore("TopbarEnabled", state)
	UserInputService.ModalEnabled = state
end

game.ReplicatedStorage.ExitAFK.OnClientEvent:Connect(function(ran)
	connection = UserInputService.InputBegan:Connect(function()
        game.ReplicatedStorage.ExitAFK:FireServer()
        connection:Disconnect()
	end)
end)

game.ReplicatedStorage.HitS.OnClientEvent:Connect(ran)

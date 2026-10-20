-- CameraModule.client.lua

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local function switchCameraMode()
    if humanoid.CameraMode == Enum.HumanoidCameraMode.FirstPerson then
        humanoid.CameraMode = Enum.HumanoidCameraMode.ThirdPerson
    else
        humanoid.CameraMode = Enum.HumanoidCameraMode.FirstPerson
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.F then
        switchCameraMode()
    end
end)
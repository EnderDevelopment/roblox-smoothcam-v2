-- CameraController.server.lua

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local CameraSettings = require(ReplicatedStorage:WaitForChild("CameraSettings"))

local function setupCamera(player)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local camera = workspace.CurrentCamera

    local function updateCamera()
        if humanoid.CameraMode == Enum.HumanoidCameraMode.FirstPerson then
            camera.CameraType = Enum.CameraType.Scriptable
            camera.CFrame = character.Head.CFrame * CFrame.new(0, 0, -1)
        else
            camera.CameraType = Enum.CameraType.Custom
            camera.CFrame = CFrame.new(character.Head.Position, character.Head.Position + character.Head.CFrame.LookVector)
        end
    end

    humanoid.CameraOffset = CameraSettings.cameraOffset
    humanoid.CameraMode = CameraSettings.defaultCameraMode

    updateCamera()
    humanoid:GetPropertyChangedSignal("CameraMode"):Connect(updateCamera)
end

Players.PlayerAdded:Connect(setupCamera)

for _, player in ipairs(Players:GetPlayers()) do
    setupCamera(player)
end
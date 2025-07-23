
-- KTC HUB - REACTS MODULE + INFINITE DRIBBLE GUI
-- Autor: Tps Abz

-- 🦊 FOX REACT
_G.Vector = Vector3.new(math.huge, math.huge, math.huge)
local original
original = hookmetamethod(game, "__namecall", function(self, ...)
    local args = { ... }
    local method = getnamecallmethod()
    if not checkcaller() and method == "FireServer" and self.Name == "Kick" then
        args[6] = _G.Vector
        return original(self, unpack(args))
    end
    return original(self, ...)
end)

-- 🧬 VECTOZ REACT
_G.Vector = Vector3.new(math.huge, math.huge, math.huge)
local originalVectoz
originalVectoz = hookmetamethod(game, "__namecall", function(self, ...)
    local args = { ... }
    local method = getnamecallmethod()
    if not checkcaller() and method == "FireServer" and self.Name == "Kick" then
        args[6] = _G.Vector
        return originalVectoz(self, unpack(args))
    end
    return originalVectoz(self, ...)
end)

-- 🧤 KEEPZ REACT
local player = game.Players.LocalPlayer
local originalKeepz
originalKeepz = hookmetamethod(game, "__namecall", function(self, ...)
    local args = { ... }
    local method = getnamecallmethod()
    if not checkcaller() and method == "FireServer" and tostring(self) == "Dribble" then
        args[2] = player.Character.Humanoid:FindFirstChild("LLCL")
        return originalKeepz(self, unpack(args))
    end
    return originalKeepz(self, ...)
end)

-- 🦵 TUNAZ REACT (manual con K)
local mouse = player:GetMouse()
mouse.KeyDown:Connect(function(key)
    if key:lower() == "k" then
        for _, d in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
            if d:IsA("RemoteEvent") and d.Name:find("React") then
                d:FireServer(nil, Vector3.new(math.huge, math.huge, math.huge), CFrame.new())
            end
        end
    end
end)

-- 💣 ALZ REACT (Pastebin externo)
loadstring(game:HttpGet("https://pastebin.com/raw/GrePU9TQ"))()

-- 🔁 INFINITE DRIBBLE HELPER GUI
local character = player.Character or player.CharacterAdded:Wait()
local ball = workspace.TPSSystem.TPS
local runService = game:GetService("RunService")
local userInput = game:GetService("UserInputService")
local followBall = false
local isMovingManually = false

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
local toggleButton = Instance.new("TextButton", gui)
toggleButton.Size = UDim2.new(0, 180, 0, 40)
toggleButton.Position = UDim2.new(0, 20, 0, 300)
toggleButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
toggleButton.Text = "Toggle Infinite Dribble [C]"
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 18
toggleButton.Draggable = true

toggleButton.MouseButton1Click:Connect(function()
    followBall = not followBall
    print("[KTC DRIBBLE] GUI Toggle:", followBall and "ON" or "OFF")
end)

local function follow()
	if followBall and not isMovingManually then
		character:WaitForChild("Humanoid"):MoveTo(ball.Position)
	end
end

userInput.InputBegan:Connect(function(input, gameProcessed)
	if input.UserInputType == Enum.UserInputType.Keyboard or input.UserInputType == Enum.UserInputType.MouseMovement then
		isMovingManually = true
	end
end)

userInput.InputEnded:Connect(function(input, gameProcessed)
	if input.UserInputType == Enum.UserInputType.Keyboard or input.UserInputType == Enum.UserInputType.MouseMovement then
		isMovingManually = false
	end
end)

userInput.InputBegan:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode.C and not gameProcessed then
		followBall = not followBall
		print("[KTC DRIBBLE] Hotkey C Toggle:", followBall and "ON" or "OFF")
	end
end)

runService.RenderStepped:Connect(function()
	if followBall then follow() end
end)

player.CharacterAdded:Connect(function(char)
	character = char
end)

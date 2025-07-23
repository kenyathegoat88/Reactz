local player = game.Players.LocalPlayer local mouse = player:GetMouse() local runService = game:GetService("RunService") local userInput = game:GetService("UserInputService") local character = player.Character or player.CharacterAdded:Wait() local ball = workspace:WaitForChild("TPSSystem"):WaitForChild("TPS") local followBall = false local isMovingManually = false

local gui = Instance.new("ScreenGui", game.CoreGui) local frame = Instance.new("Frame", gui) frame.Size = UDim2.new(0, 250, 0, 300) frame.Position = UDim2.new(0, 50, 0, 100) frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) frame.Active = true frame.Draggable = true frame.Name = "KTC_REACTS"

local function createButton(text, posY, callback) local button = Instance.new("TextButton", frame) button.Size = UDim2.new(1, -20, 0, 30) button.Position = UDim2.new(0, 10, 0, posY) button.BackgroundColor3 = Color3.fromRGB(60, 60, 60) button.TextColor3 = Color3.new(1, 1, 1) button.Text = text button.Font = Enum.Font.SourceSansBold button.TextSize = 16 button.MouseButton1Click:Connect(callback) end

createButton("Kenya React", 10, function() _G.Vector = Vector3.new(math.huge, math.huge, math.huge) local original original = hookmetamethod(game, "__namecall", function(self, ...) local args = { ... } local method = getnamecallmethod() if not checkcaller() and method == "FireServer" and self.Name == "Kick" then args[6] = _G.Vector return original(self, unpack(args)) end return original(self, ...) end) end)

createButton("Nanito React", 50, function() _G.Vector = Vector3.new(math.huge, math.huge, math.huge) local originalVectoz originalVectoz = hookmetamethod(game, "__namecall", function(self, ...) local args = { ... } local method = getnamecallmethod() if not checkcaller() and method == "FireServer" and self.Name == "Kick" then args[6] = _G.Vector return originalVectoz(self, unpack(args)) end return originalVectoz(self, ...) end) end)

createButton("Cholo React", 90, function() local originalKeepz originalKeepz = hookmetamethod(game, "__namecall", function(self, ...) local args = { ... } local method = getnamecallmethod() if not checkcaller() and method == "FireServer" and tostring(self) == "Dribble" then args[2] = player.Character.Humanoid:FindFirstChild("LLCL") return originalKeepz(self, unpack(args)) end return originalKeepz(self, ...) end) end)

createButton("chris React (K)", 130, function() mouse.KeyDown:Connect(function(key) if key:lower() == "k" then for _, d in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do if d:IsA("RemoteEvent") and d.Name:find("React") then d:FireServer(nil, Vector3.new(math.huge, math.huge, math.huge), CFrame.new()) end end end end) end)

createButton("Auto Dribble (C)", 170, function() followBall = not followBall end)

userInput.InputBegan:Connect(function(input, gameProcessed) if input.KeyCode == Enum.KeyCode.C and not gameProcessed then followBall = not followBall end end)

userInput.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.Keyboard or input.UserInputType == Enum.UserInputType.MouseMovement then isMovingManually = true end end)

userInput.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.Keyboard or input.UserInputType == Enum.UserInputType.MouseMovement then isMovingManually = false end end)

runService.RenderStepped:Connect(function() if followBall and not isMovingManually and character and character:FindFirstChild("Humanoid") then character.Humanoid:MoveTo(ball.Position) end end)

player.CharacterAdded:Connect(function(char) character = char end)

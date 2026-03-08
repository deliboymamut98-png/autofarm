-- MNK's Autofarm İnstagram = mn.k006 discord = findhost
local lp = game:GetService("Players").LocalPlayer
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")


_G.MenuKey = "Insert"
_G.TpDelay = 1
_G.BlurEnabled = false
_G.HudEnabled = true
_G.AntiAFK = false
local autoTeleportEnabled = false
local currentTargetPos = nil
local CurrentThemeIndex = 4 
local Keybinds = {}

local Themes = {
    {Name = "DARK", Bg = Color3.fromRGB(15, 15, 15), Accent = Color3.fromRGB(0, 255, 150)},
    {Name = "OCEAN", Bg = Color3.fromRGB(10, 25, 45), Accent = Color3.fromRGB(0, 190, 255)},
    {Name = "SAKURA", Bg = Color3.fromRGB(35, 15, 25), Accent = Color3.fromRGB(255, 160, 210)},
    {Name = "EMBER", Bg = Color3.fromRGB(25, 10, 5), Accent = Color3.fromRGB(255, 100, 0)},
    {Name = "MIDNIGHT", Bg = Color3.fromRGB(5, 5, 20), Accent = Color3.fromRGB(140, 0, 255)},
    {Name = "CYBERPUNK", Bg = Color3.fromRGB(5, 5, 5), Accent = Color3.fromRGB(255, 255, 0)},
    {Name = "LIGHT", Bg = Color3.fromRGB(240, 240, 240), Accent = Color3.fromRGB(40, 40, 40)},
    {Name = "NEON", Bg = Color3.fromRGB(10, 0, 25), Accent = Color3.fromRGB(0, 255, 255)},

    -- Yeni Temalar
    {Name = "FOREST", Bg = Color3.fromRGB(10, 30, 10), Accent = Color3.fromRGB(0, 200, 100)},
    {Name = "BLOOD", Bg = Color3.fromRGB(30, 0, 0), Accent = Color3.fromRGB(255, 0, 0)},
    {Name = "ICE", Bg = Color3.fromRGB(200, 230, 255), Accent = Color3.fromRGB(0, 170, 255)},
    {Name = "GOLD", Bg = Color3.fromRGB(30, 25, 10), Accent = Color3.fromRGB(255, 200, 0)},
    {Name = "GRAPE", Bg = Color3.fromRGB(20, 0, 30), Accent = Color3.fromRGB(200, 0, 255)},
    {Name = "MINT", Bg = Color3.fromRGB(10, 30, 25), Accent = Color3.fromRGB(0, 255, 170)},
    {Name = "SUNSET", Bg = Color3.fromRGB(40, 15, 5), Accent = Color3.fromRGB(255, 120, 60)},
    {Name = "SKY", Bg = Color3.fromRGB(20, 40, 70), Accent = Color3.fromRGB(120, 200, 255)},

    -- Chroma (Rainbow)
    {Name = "CHROMA", Bg = Color3.fromRGB(10, 10, 10), Accent = Color3.fromRGB(255, 0, 0)}
}

if CoreGui:FindFirstChild("SpeedFarm_Fixed") then CoreGui.SpeedFarm_Fixed:Destroy() end
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "SpeedFarm_Fixed"

local function Notify(title, text)
    local NotifFrame = Instance.new("Frame", ScreenGui)
    NotifFrame.Size = UDim2.new(0, 250, 0, 60)
    NotifFrame.Position = UDim2.new(1, 20, 1, -80)
    NotifFrame.BackgroundColor3 = Themes[CurrentThemeIndex].Bg
    NotifFrame.BorderSizePixel = 0
    Instance.new("UICorner", NotifFrame)
    
    local Line = Instance.new("Frame", NotifFrame)
    Line.Size = UDim2.new(0, 4, 1, 0)
    Line.BackgroundColor3 = Themes[CurrentThemeIndex].Accent
    Instance.new("UICorner", Line)

    local Tl = Instance.new("TextLabel", NotifFrame)
    Tl.Text = title:upper()
    Tl.Size = UDim2.new(1, -20, 0, 25)
    Tl.Position = UDim2.new(0, 15, 0, 5)
    Tl.TextColor3 = Themes[CurrentThemeIndex].Accent
    Tl.Font = Enum.Font.GothamBold
    Tl.TextSize = 14
    Tl.BackgroundTransparency = 1
    Tl.TextXAlignment = Enum.TextXAlignment.Left

    local Tx = Instance.new("TextLabel", NotifFrame)
    Tx.Text = text
    Tx.Size = UDim2.new(1, -20, 0, 20)
    Tx.Position = UDim2.new(0, 15, 0, 30)
    Tx.TextColor3 = Color3.new(1,1,1)
    Tx.Font = Enum.Font.Gotham
    Tx.TextSize = 12
    Tx.BackgroundTransparency = 1
    Tx.TextXAlignment = Enum.TextXAlignment.Left

    NotifFrame:TweenPosition(UDim2.new(1, -270, 1, -80), "Out", "Back", 0.5)
    task.delay(3, function()
        NotifFrame:TweenPosition(UDim2.new(1, 20, 1, -80), "In", "Back", 0.5)
        task.wait(0.5)
        NotifFrame:Destroy()
    end)
end

local BlurEffect = Instance.new("BlurEffect", Lighting)
BlurEffect.Size = 0

local IntroLabel = Instance.new("TextLabel", ScreenGui)
IntroLabel.Text = "MNK'S AUTOFARM"
IntroLabel.Font = Enum.Font.GothamBlack
IntroLabel.TextSize = 100 
IntroLabel.TextColor3 = Color3.new(1,1,1)
IntroLabel.BackgroundTransparency = 1
IntroLabel.Position = UDim2.new(0.5, 0, 1.5, 0)
IntroLabel.AnchorPoint = Vector2.new(0.5, 0.5)
IntroLabel.Size = UDim2.new(1, 0, 0.2, 0)


local HudFrame = Instance.new("Frame", ScreenGui)
HudFrame.Size = UDim2.new(0, 180, 0, 35)
HudFrame.Position = UDim2.new(1, -190, 0, 10)
HudFrame.BackgroundTransparency = 0.8
HudFrame.BackgroundColor3 = Color3.new(0,0,0)
HudFrame.Active = true
HudFrame.Draggable = true
Instance.new("UICorner", HudFrame).CornerRadius = UDim.new(0, 8)

local HudLabel = Instance.new("TextLabel", HudFrame)
HudLabel.Size = UDim2.new(1, 0, 1, 0)
HudLabel.BackgroundTransparency = 1
HudLabel.Font = Enum.Font.GothamBold
HudLabel.TextSize = 16
HudLabel.TextXAlignment = Enum.TextXAlignment.Center


local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Themes[CurrentThemeIndex].Bg
MainFrame.Size = UDim2.new(0, 380, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.ClipsDescendants = true
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundTransparency = 0.95

local Title = Instance.new("TextLabel", TopBar)
Title.Text = "MNK's AutoFarm [BASIC]"
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.TextColor3 = Themes[CurrentThemeIndex].Accent
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left


local TabFrame = Instance.new("Frame", MainFrame)
TabFrame.Size = UDim2.new(1, 0, 0, 35)
TabFrame.Position = UDim2.new(0, 0, 0, 50)
TabFrame.BackgroundTransparency = 1

local PointsBtn = Instance.new("TextButton", TabFrame)
PointsBtn.Size = UDim2.new(0.33, 0, 1, 0)
PointsBtn.Text = "POINTS"
PointsBtn.Font = Enum.Font.GothamMedium
PointsBtn.TextSize = 12
PointsBtn.TextColor3 = Color3.new(1,1,1)
PointsBtn.BackgroundTransparency = 1

local PlayersBtn = Instance.new("TextButton", TabFrame)
PlayersBtn.Size = UDim2.new(0.33, 0, 1, 0)
PlayersBtn.Position = UDim2.new(0.33, 0, 0, 0)
PlayersBtn.Text = "PLAYERS"
PlayersBtn.Font = Enum.Font.GothamMedium
PlayersBtn.TextSize = 12
PlayersBtn.TextColor3 = Color3.fromRGB(140, 140, 140)
PlayersBtn.BackgroundTransparency = 1

local SettingsBtn = Instance.new("TextButton", TabFrame)
SettingsBtn.Size = UDim2.new(0.33, 0, 1, 0)
SettingsBtn.Position = UDim2.new(0.66, 0, 0, 0)
SettingsBtn.Text = "SETTINGS"
SettingsBtn.Font = Enum.Font.GothamMedium
SettingsBtn.TextSize = 12
SettingsBtn.TextColor3 = Color3.fromRGB(140, 140, 140)
SettingsBtn.BackgroundTransparency = 1


local PointsPage = Instance.new("Frame", MainFrame)
PointsPage.Size = UDim2.new(1, -20, 1, -100)
PointsPage.Position = UDim2.new(0, 10, 0, 95)
PointsPage.BackgroundTransparency = 1

local PlayersPage = Instance.new("ScrollingFrame", MainFrame)
PlayersPage.Size = UDim2.new(1, -20, 1, -100)
PlayersPage.Position = UDim2.new(0, 10, 0, 95)
PlayersPage.BackgroundTransparency = 1
PlayersPage.Visible = false
PlayersPage.ScrollBarThickness = 3
PlayersPage.ScrollBarImageColor3 = Themes[CurrentThemeIndex].Accent
Instance.new("UIListLayout", PlayersPage).Padding = UDim.new(0, 5)

local SettingsPage = Instance.new("ScrollingFrame", MainFrame)
SettingsPage.Size = UDim2.new(1, -20, 1, -100)
SettingsPage.Position = UDim2.new(0, 10, 0, 95)
SettingsPage.BackgroundTransparency = 1
SettingsPage.Visible = false
SettingsPage.ScrollBarThickness = 4 
SettingsPage.ScrollBarImageColor3 = Themes[CurrentThemeIndex].Accent
Instance.new("UIListLayout", SettingsPage).Padding = UDim.new(0, 10)


local function CreateSwitch(parent, text, default, callback)
    local Container = Instance.new("Frame", parent)
    Container.Size = UDim2.new(1, 0, 0, 40)
    Container.BackgroundTransparency = 1

    local Lbl = Instance.new("TextLabel", Container)
    Lbl.Text = text
    Lbl.Size = UDim2.new(0.7, 0, 1, 0)
    Lbl.TextColor3 = Color3.new(1,1,1)
    Lbl.Font = Enum.Font.GothamMedium
    Lbl.TextSize = 14
    Lbl.BackgroundTransparency = 1
    Lbl.TextXAlignment = Enum.TextXAlignment.Left

    local Bg = Instance.new("TextButton", Container)
    Bg.Size = UDim2.new(0, 46, 0, 22)
    Bg.Position = UDim2.new(1, -50, 0.5, -11)
    Bg.Text = ""
    Bg.BackgroundColor3 = default and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(220, 50, 50)
    Instance.new("UICorner", Bg).CornerRadius = UDim.new(1, 0)

    local Circle = Instance.new("Frame", Bg)
    Circle.Size = UDim2.new(0, 18, 0, 18)
    Circle.Position = default and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
    Circle.BackgroundColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

    local state = default
    Bg.MouseButton1Click:Connect(function()
        state = not state
        callback(state)
        TweenService:Create(Bg, TweenInfo.new(0.3), {BackgroundColor3 = state and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(220, 50, 50)}):Play()
        TweenService:Create(Circle, TweenInfo.new(0.2), {Position = state and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)}):Play()
    end)
end


local P_Input = Instance.new("TextBox", PointsPage)
P_Input.Size = UDim2.new(0.75, 0, 0, 35)
P_Input.PlaceholderText = "Location Name..."
P_Input.Text = ""
P_Input.BackgroundColor3 = Color3.fromRGB(30,30,30)
P_Input.TextColor3 = Color3.new(1,1,1)
P_Input.Font = Enum.Font.GothamMedium
P_Input.TextSize = 14
Instance.new("UICorner", P_Input)

local P_Add = Instance.new("TextButton", PointsPage)
P_Add.Size = UDim2.new(0.22, 0, 0, 35)
P_Add.Position = UDim2.new(0.78, 0, 0, 0)
P_Add.Text = "ADD"
P_Add.BackgroundColor3 = Themes[CurrentThemeIndex].Accent
P_Add.TextColor3 = Color3.new(1,1,1)
P_Add.Font = Enum.Font.GothamBold
P_Add.TextSize = 14
Instance.new("UICorner", P_Add)

local P_Scroll = Instance.new("ScrollingFrame", PointsPage)
P_Scroll.Size = UDim2.new(1, 0, 1, -45)
P_Scroll.Position = UDim2.new(0, 0, 0, 45)
P_Scroll.BackgroundTransparency = 1
P_Scroll.ScrollBarThickness = 3
P_Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UIListLayout", P_Scroll).Padding = UDim.new(0, 6)

local function AddPointRow(name, cf)
    local Row = Instance.new("Frame", P_Scroll)
    Row.Size = UDim2.new(1, -5, 0, 45)
    Row.BackgroundColor3 = Color3.fromRGB(28,28,28)
    Instance.new("UICorner", Row)

    local Lbl = Instance.new("TextLabel", Row)
    Lbl.Text = name
    Lbl.Size = UDim2.new(0.4, 0, 0.6, 0)
    Lbl.Position = UDim2.new(0, 10, 0, 5)
    Lbl.TextColor3 = Color3.new(1,1,1)
    Lbl.Font = Enum.Font.GothamMedium
    Lbl.TextSize = 13
    Lbl.BackgroundTransparency = 1
    Lbl.TextXAlignment = Enum.TextXAlignment.Left

    local Kb = Instance.new("TextButton", Row)
    Kb.Text = "Key: None"
    Kb.Size = UDim2.new(0.4, 0, 0.4, 0)
    Kb.Position = UDim2.new(0, 10, 0.6, -2)
    Kb.BackgroundTransparency = 1
    Kb.TextColor3 = Themes[CurrentThemeIndex].Accent
    Kb.Font = Enum.Font.GothamMedium
    Kb.TextSize = 10
    Kb.TextXAlignment = Enum.TextXAlignment.Left

    local currentKey = nil
    Kb.MouseButton1Click:Connect(function()
        Kb.Text = "Press any key..."
        local connection
        connection = UserInputService.InputBegan:Connect(function(i, g)
            if not g and i.UserInputType == Enum.UserInputType.Keyboard then
                currentKey = i.KeyCode.Name
                Kb.Text = "Key: " .. currentKey
                Keybinds[currentKey] = cf
                Notify("Keybind", name .. " bound to " .. currentKey)
                connection:Disconnect()
            end
        end)
    end)

    local Go = Instance.new("TextButton", Row)
    Go.Text = "TP"
    Go.Size = UDim2.new(0, 35, 0, 25)
    Go.Position = UDim2.new(1, -135, 0.5, -12.5)
    Go.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    Go.TextColor3 = Color3.new(1,1,1)
    Go.Font = Enum.Font.GothamBold
    Instance.new("UICorner", Go)

    local Auto = Instance.new("TextButton", Row)
    Auto.Text = "AUTO"
    Auto.Size = UDim2.new(0, 45, 0, 25)
    Auto.Position = UDim2.new(1, -95, 0.5, -12.5)
    Auto.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Auto.TextColor3 = Color3.new(1,1,1)
    Auto.Font = Enum.Font.GothamBold
    Instance.new("UICorner", Auto)

    local Del = Instance.new("TextButton", Row)
    Del.Text = "X"
    Del.Size = UDim2.new(0, 35, 0, 25)
    Del.Position = UDim2.new(1, -45, 0.5, -12.5)
    Del.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    Del.TextColor3 = Color3.new(1,1,1)
    Del.Font = Enum.Font.GothamBold
    Instance.new("UICorner", Del)

    Go.MouseButton1Click:Connect(function() 
        lp.Character.HumanoidRootPart.CFrame = cf 
    end)
    
    Auto.MouseButton1Click:Connect(function()
        if currentTargetPos == cf and autoTeleportEnabled then
            autoTeleportEnabled = false
            Auto.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            Notify("Auto-Farm", "Stopped")
        else
            autoTeleportEnabled = true
            currentTargetPos = cf
            Auto.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            Notify("Auto-Farm", "Traveling to " .. name)
        end
    end)
    
    Del.MouseButton1Click:Connect(function() 
        if currentKey then Keybinds[currentKey] = nil end
        Row:Destroy() 
    end)
end

P_Add.MouseButton1Click:Connect(function()
    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        local pointName = (P_Input.Text ~= "" and P_Input.Text or "Point " .. math.random(100, 999))
        AddPointRow(pointName, lp.Character.HumanoidRootPart.CFrame)
        P_Input.Text = ""
        Notify("MNK's", "Location Saved!")
    end
end)


local function UpdatePlayerList()
    PlayersPage:ClearAllChildren()
    Instance.new("UIListLayout", PlayersPage).Padding = UDim.new(0, 5)
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player ~= lp then
            local pRow = Instance.new("Frame", PlayersPage)
            pRow.Size = UDim2.new(1, 0, 0, 40)
            pRow.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Instance.new("UICorner", pRow)
            
            local pName = Instance.new("TextLabel", pRow)
            pName.Text = player.DisplayName .. " (@" .. player.Name .. ")"
            pName.Size = UDim2.new(0.6, 0, 0.6, 0)
            pName.Position = UDim2.new(0, 10, 0, 2)
            pName.TextColor3 = Color3.new(1,1,1)
            pName.Font = Enum.Font.GothamMedium
            pName.TextSize = 12
            pName.BackgroundTransparency = 1
            pName.TextXAlignment = Enum.TextXAlignment.Left

            local pStats = Instance.new("TextLabel", pRow)
            pStats.Size = UDim2.new(0.6, 0, 0.4, 0)
            pStats.Position = UDim2.new(0, 10, 0.6, -2)
            pStats.TextColor3 = Themes[CurrentThemeIndex].Accent
            pStats.Font = Enum.Font.Gotham
            pStats.TextSize = 10
            pStats.BackgroundTransparency = 1
            pStats.TextXAlignment = Enum.TextXAlignment.Left

            local pGo = Instance.new("TextButton", pRow)
            pGo.Text = "TP"
            pGo.Size = UDim2.new(0, 40, 0, 25)
            pGo.Position = UDim2.new(1, -50, 0.5, -12.5)
            pGo.BackgroundColor3 = Themes[CurrentThemeIndex].Accent
            pGo.TextColor3 = Color3.new(0,0,0)
            pGo.Font = Enum.Font.GothamBold
            Instance.new("UICorner", pGo)

            pGo.MouseButton1Click:Connect(function()
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    lp.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                    Notify("MNK's", "Jumped to " .. player.DisplayName)
                end
            end)

            task.spawn(function()
                while pRow.Parent do
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = math.floor((lp.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude)
                        local health = player.Character:FindFirstChild("Humanoid") and math.floor(player.Character.Humanoid.Health) or 0
                        pStats.Text = "Dist: " .. dist .. "m | HP: " .. health
                    end
                    task.wait(1)
                end
            end)
        end
    end
end


local function LowGraphics()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("MeshPart") then
            v.Material = Enum.Material.Plastic
            v.Reflectance = 0
        elseif v:IsA("Decal") then v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end
    end
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    settings().Rendering.QualityLevel = 1
    Notify("Graphics", "Potato Mode Activated!")
end

local function ServerHop()
    Notify("Server", "Finding new lobby...")
    local x = {}
    local res = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
    for _, v in ipairs(HttpService:JSONDecode(res).data) do
        if v.playing < v.maxPlayers and v.id ~= game.JobId then table.insert(x, v.id) end
    end
    if #x > 0 then TeleportService:TeleportToPlaceInstance(game.PlaceId, x[math.random(1, #x)])
    else Notify("Error", "No other servers found!") end
end


CreateSwitch(SettingsPage, "Anti-AFK", false, function(v) _G.AntiAFK = v end)


CreateSwitch(SettingsPage, "Background Blur", false, function(v) 
    _G.BlurEnabled = v 
    if MainFrame.Visible then
        BlurEffect.Size = v and 18 or 0
    end
end)


CreateSwitch(SettingsPage, "Show FPS & Ping HUD", true, function(v) 
    _G.HudEnabled = v 
    HudFrame.Visible = v
end)


local DelayContainer = Instance.new("Frame", SettingsPage)
DelayContainer.Size = UDim2.new(1, 0, 0, 45)
DelayContainer.BackgroundTransparency = 1

local DelayLabel = Instance.new("TextLabel", DelayContainer)
DelayLabel.Text = "Auto-TP Delay (sec):"
DelayLabel.Size = UDim2.new(0.6, 0, 1, 0)
DelayLabel.TextColor3 = Color3.new(1,1,1)
DelayLabel.Font = Enum.Font.GothamMedium
DelayLabel.TextSize = 14
DelayLabel.BackgroundTransparency = 1
DelayLabel.TextXAlignment = Enum.TextXAlignment.Left

local DelayInput = Instance.new("TextBox", DelayContainer)
DelayInput.Size = UDim2.new(0, 60, 0, 30)
DelayInput.Position = UDim2.new(1, -65, 0.5, -15)
DelayInput.Text = tostring(_G.TpDelay)
DelayInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
DelayInput.TextColor3 = Color3.new(1,1,1)
DelayInput.Font = Enum.Font.GothamBold
Instance.new("UICorner", DelayInput)

DelayInput.FocusLost:Connect(function()
    local val = tonumber(DelayInput.Text)
    if val then
        _G.TpDelay = math.clamp(val, 0.1, 60)
        DelayInput.Text = tostring(_G.TpDelay)
        Notify("Settings", "TP Delay set to: " .. _G.TpDelay .. "s")
    else
        DelayInput.Text = tostring(_G.TpDelay)
    end
end)


local HopBtn = Instance.new("TextButton", SettingsPage)
HopBtn.Size = UDim2.new(1, 0, 0, 40)
HopBtn.Text = "SERVER HOP"
HopBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
HopBtn.TextColor3 = Color3.new(1,1,1)
HopBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", HopBtn)
HopBtn.MouseButton1Click:Connect(ServerHop)

local PotatoBtn = Instance.new("TextButton", SettingsPage)
PotatoBtn.Size = UDim2.new(1, 0, 0, 40)
PotatoBtn.Text = "FPS BOOST"
PotatoBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
PotatoBtn.TextColor3 = Color3.new(1,1,1)
PotatoBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", PotatoBtn)
PotatoBtn.MouseButton1Click:Connect(LowGraphics)


local DropdownContainer = Instance.new("Frame", SettingsPage)
DropdownContainer.Size = UDim2.new(1, 0, 0, 45)
DropdownContainer.BackgroundTransparency = 1

local ThemeMainBtn = Instance.new("TextButton", DropdownContainer)
ThemeMainBtn.Size = UDim2.new(1, 0, 0, 45)
ThemeMainBtn.Text = "SELECT THEME: " .. Themes[CurrentThemeIndex].Name
ThemeMainBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
ThemeMainBtn.TextColor3 = Color3.new(1,1,1)
ThemeMainBtn.Font = Enum.Font.GothamMedium
Instance.new("UICorner", ThemeMainBtn)

local ThemeList = Instance.new("Frame", ThemeMainBtn)
ThemeList.Size = UDim2.new(1, 0, 0, 0)
ThemeList.Position = UDim2.new(0, 0, 1, 5)
ThemeList.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ThemeList.Visible = false
ThemeList.ZIndex = 10
Instance.new("UICorner", ThemeList)
Instance.new("UIListLayout", ThemeList)

ThemeMainBtn.MouseButton1Click:Connect(function()
    ThemeList.Visible = not ThemeList.Visible
    ThemeList.Size = ThemeList.Visible and UDim2.new(1, 0, 0, #Themes * 35) or UDim2.new(1, 0, 0, 0)
end)

for i, t in ipairs(Themes) do
    local T_Btn = Instance.new("TextButton", ThemeList)
    T_Btn.Size = UDim2.new(1, 0, 0, 35)
    T_Btn.BackgroundTransparency = 1
    T_Btn.Text = "   " .. t.Name
    T_Btn.TextColor3 = Color3.new(1,1,1)
    T_Btn.TextXAlignment = Enum.TextXAlignment.Left
    T_Btn.ZIndex = 11

    local ColorPreview = Instance.new("Frame", T_Btn)
    ColorPreview.Size = UDim2.new(0, 15, 0, 15)
    ColorPreview.Position = UDim2.new(1, -25, 0.5, -7.5)
    ColorPreview.BackgroundColor3 = t.Accent
    ColorPreview.ZIndex = 12
    Instance.new("UICorner", ColorPreview)

    T_Btn.MouseButton1Click:Connect(function()
        CurrentThemeIndex = i
        MainFrame.BackgroundColor3 = t.Bg
        Title.TextColor3 = t.Accent
        ThemeMainBtn.Text = "SELECT THEME: " .. t.Name
        ThemeList.Visible = false
    end)
end

local CreatedBy = Instance.new("TextLabel", SettingsPage)
CreatedBy.Size = UDim2.new(1, 0, 0, 30)
CreatedBy.BackgroundTransparency = 1
CreatedBy.Text = "Created By MNK's"
CreatedBy.Font = Enum.Font.GothamBold
CreatedBy.TextSize = 14


RunService.RenderStepped:Connect(function()
    local c = Color3.fromHSV(tick() % 5 / 5, 0.7, 1)
    if _G.HudEnabled then
        HudFrame.Visible = true
        local fps = math.floor(1 / RunService.RenderStepped:Wait())
        local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        HudLabel.Text = string.format("FPS: %d | MS: %d", fps, ping)
        HudLabel.TextColor3 = c
    else
        HudFrame.Visible = false
    end
    IntroLabel.TextColor3 = c
    CreatedBy.TextColor3 = c
end)


UserInputService.InputBegan:Connect(function(i, g)
    if not g and i.UserInputType == Enum.UserInputType.Keyboard then
        if Keybinds[i.KeyCode.Name] then
            lp.Character.HumanoidRootPart.CFrame = Keybinds[i.KeyCode.Name]
            Notify("MNK's", "Teleported!")
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(_G.TpDelay)
        if autoTeleportEnabled and currentTargetPos then
            pcall(function() lp.Character.HumanoidRootPart.CFrame = currentTargetPos end)
        end
    end
end)

lp.Idled:Connect(function()
    if _G.AntiAFK then
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new())
    end
end)


PointsBtn.MouseButton1Click:Connect(function()
    PointsPage.Visible = true PlayersPage.Visible = false SettingsPage.Visible = false
    PointsBtn.TextColor3 = Color3.new(1,1,1) 
    PlayersBtn.TextColor3 = Color3.fromRGB(140,140,140) SettingsBtn.TextColor3 = Color3.fromRGB(140,140,140)
end)
PlayersBtn.MouseButton1Click:Connect(function()
    PointsPage.Visible = false PlayersPage.Visible = true SettingsPage.Visible = false
    UpdatePlayerList()
    PlayersBtn.TextColor3 = Color3.new(1,1,1) 
    PointsBtn.TextColor3 = Color3.fromRGB(140,140,140) SettingsBtn.TextColor3 = Color3.fromRGB(140,140,140)
end)
SettingsBtn.MouseButton1Click:Connect(function()
    PointsPage.Visible = false PlayersPage.Visible = false SettingsPage.Visible = true
    SettingsBtn.TextColor3 = Color3.new(1,1,1) 
    PointsBtn.TextColor3 = Color3.fromRGB(140,140,140) PlayersBtn.TextColor3 = Color3.fromRGB(140,140,140)
end)


task.spawn(function()
    BlurEffect.Size = 0
    TweenService:Create(BlurEffect, TweenInfo.new(1), {Size = 24}):Play()
    local t1 = TweenService:Create(IntroLabel, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 0.5, 0)})
    t1:Play() t1.Completed:Wait()
    local s = tick() while tick()-s < 1.5 do
        IntroLabel.Position = UDim2.new(0.5, math.random(-8,8), 0.5, math.random(-8,8))
        task.wait(0.04)
    end
    IntroLabel.Position = UDim2.new(0.5,0,0.5,0) task.wait(0.3)
    local tOut = TweenService:Create(IntroLabel, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(0.5, 0, -0.5, 0)})
    tOut:Play() tOut.Completed:Wait()
    MainFrame.Visible = true
    TweenService:Create(MainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Back), {Size = UDim2.new(0, 380, 0, 500)}):Play()
    if not _G.BlurEnabled then TweenService:Create(BlurEffect, TweenInfo.new(0.5), {Size = 0}):Play() end
    Notify("Welcome", "Mnk's AutoFarm Loaded!")
end)


UserInputService.InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode[_G.MenuKey] then
        local opening = MainFrame.Size.Y.Offset == 0
        TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = opening and UDim2.new(0, 380, 0, 500) or UDim2.new(0, 380, 0, 0)}):Play()
        TweenService:Create(BlurEffect, TweenInfo.new(0.4), {Size = (opening and _G.BlurEnabled) and 18 or 0}):Play()
    end

end)



-- ========================================================
--   ✨ DEVY QUALITY PANEL v4 ✨ | Efeitos Visuais + Glossy
--   Luz realista (SunRays) batendo no cenário + Glossy s/ luz
-- ========================================================

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- ================= SALVAR ORIGINAIS =================
local originalFogColor = Lighting.FogColor
local originalFogStart = Lighting.FogStart
local originalFogEnd = Lighting.FogEnd
local originalAmbient = Lighting.Ambient
local originalOutdoor = Lighting.OutdoorAmbient
local originalClockTime = Lighting.ClockTime
local originalBrightness = Lighting.Brightness
local originalEnvDiffuse = Lighting.EnvironmentDiffuseScale
local originalEnvSpecular = Lighting.EnvironmentSpecularScale

local glossyActive = false
local glossConn = nil

-- ================= UI DESIGN =================
local gui = Instance.new("ScreenGui")
gui.Name = "DevyEffects"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 45, 0, 45)
toggleBtn.Position = UDim2.new(0, 20, 0.5, -22)
toggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
toggleBtn.Text = "✨"
toggleBtn.TextSize = 20
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.AutoButtonColor = false
toggleBtn.Active = true
toggleBtn.Draggable = true
toggleBtn.Parent = gui
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)
local btnStroke = Instance.new("UIStroke", toggleBtn)
btnStroke.Color = Color3.fromRGB(180, 100, 255)
btnStroke.Thickness = 2

local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 260, 0, 320)
panel.Position = UDim2.new(0.5, -130, 0.5, -160)
panel.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
panel.BackgroundTransparency = 0.1
panel.Visible = false
panel.Active = true
panel.Parent = gui
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 12)
local pStroke = Instance.new("UIStroke", panel)
pStroke.Color = Color3.fromRGB(80, 80, 100)
pStroke.Thickness = 1.5

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 35)
header.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
header.Parent = panel
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "Devy Effects V4"
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(200, 150, 255)
title.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0.5, -12)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 12
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Parent = header
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

local dragging, dragInput, dragStart, startPos
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = panel.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        panel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -10, 1, -45)
scroll.Position = UDim2.new(0, 5, 0, 40)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 3
scroll.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 120)
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.Parent = panel

local listLayout = Instance.new("UIListLayout", scroll)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 6)
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scroll.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
end)

local function createBtn(text, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    btn.AutoButtonColor = false
    btn.Parent = scroll
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    local s = Instance.new("UIStroke", btn)
    s.Color = Color3.fromRGB(60, 60, 75); s.Thickness = 1
    btn.MouseEnter:Connect(function() TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 55)}):Play() end)
    btn.MouseLeave:Connect(function() TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 38)}):Play() end)
    return btn
end

local sunsetBtn = createBtn("Sunset / Sunrise ☀️", Color3.fromRGB(255, 180, 100))
local purpleBtn = createBtn("Vibe Roxa 🌌", Color3.fromRGB(180, 120, 255))
local glossyBtn = createBtn("Glossy Light ✨", Color3.fromRGB(255, 255, 200))
local fog1Btn  = createBtn("Neblina Escura 🌫️", Color3.fromRGB(180, 180, 180))
local fog2Btn  = createBtn("Neblina Clara ☁️", Color3.fromRGB(220, 220, 220))
local resetBtn = createBtn("Resetar Tudo ❌", Color3.fromRGB(255, 100, 100))

toggleBtn.MouseButton1Click:Connect(function() panel.Visible = not panel.Visible end)
closeBtn.MouseButton1Click:Connect(function() panel.Visible = false end)

-- ================= FUNÇÕES =================

local function clearEnvironment()
    Lighting.FogColor = originalFogColor
    Lighting.FogStart = originalFogStart
    Lighting.FogEnd = originalFogEnd
    Lighting.Ambient = originalAmbient
    Lighting.OutdoorAmbient = originalOutdoor
    Lighting.ClockTime = originalClockTime
    Lighting.Brightness = originalBrightness
    Lighting.EnvironmentDiffuseScale = originalEnvDiffuse
    Lighting.EnvironmentSpecularScale = originalEnvSpecular
    
    for _, v in ipairs(Lighting:GetChildren()) do
        if v:IsA("Atmosphere") and v.Name == "DevyAtm" then v:Destroy() end
        if v:IsA("ColorCorrectionEffect") and v.Name == "DevyCC" then v:Destroy() end
        if v:IsA("SunRaysEffect") and v.Name == "DevyRays" then v:Destroy() end
    end
end

local function clearGlossy()
    glossyActive = false
    if glossConn then glossConn:Disconnect() end
    if player.Character then
        for _, v in ipairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.Material = Enum.Material.Plastic; v.Reflectance = 0 end
            if v:IsA("PointLight") and v.Name == "GlossyLight" then v:Destroy() end
        end
    end
    glossyBtn.Text = "Glossy Light ✨"
    glossyBtn.TextColor3 = Color3.fromRGB(255, 255, 200)
end

local function applyGlossy()
    clearGlossy()
    glossyActive = true
    local function addGloss(character)
        for _, v in ipairs(character:GetDescendants()) do
            if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                v.Material = Enum.Material.Glass
                v.Reflectance = 0.8
            end
        end
    end
    if player.Character then addGloss(player.Character) end
    glossConn = player.CharacterAdded:Connect(addGloss)
    glossyBtn.Text = "Glossy ON ✨"
    glossyBtn.TextColor3 = Color3.fromRGB(100, 255, 100)
end

-- ================= BOTÕES =================

-- 1. Sunset (Luz forte batendo + Raios de Sol)
sunsetBtn.MouseButton1Click:Connect(function()
    clearEnvironment()
    -- Faz a luz bater no ambiente
    Lighting.ClockTime = 17.5 -- Pôr do sol
    Lighting.Brightness = 3
    Lighting.EnvironmentDiffuseScale = 1 -- Reflexo da luz no ambiente
    Lighting.EnvironmentSpecularScale = 1
    
    Lighting.FogColor = Color3.fromRGB(255, 140, 100)
    Lighting.FogStart = 0
    Lighting.FogEnd = 400
    Lighting.Ambient = Color3.fromRGB(255, 180, 150)
    Lighting.OutdoorAmbient = Color3.fromRGB(255, 180, 150)
    
    -- Efeito de Raios de Sol (God Rays)
    local rays = Instance.new("SunRaysEffect")
    rays.Name = "DevyRays"
    rays.Intensity = 0.15
    rays.Spread = 0.5
    rays.Parent = Lighting

    local atm = Instance.new("Atmosphere")
    atm.Name = "DevyAtm"
    atm.Color = Color3.fromRGB(255, 150, 100)
    atm.Decay = Color3.fromRGB(100, 150, 255)
    atm.Density = 0.4
    atm.Glare = 1 -- Brilho no horizonte
    atm.Haze = 2
    atm.Parent = Lighting
end)

-- 2. Vibe Roxa (Luz noturna + raios)
purpleBtn.MouseButton1Click:Connect(function()
    clearEnvironment()
    Lighting.ClockTime = 0 -- Noite
    Lighting.Brightness = 2
    Lighting.EnvironmentDiffuseScale = 1
    Lighting.EnvironmentSpecularScale = 1
    
    Lighting.FogColor = Color3.fromRGB(80, 60, 120)
    Lighting.FogStart = 0
    Lighting.FogEnd = 200
    Lighting.Ambient = Color3.fromRGB(60, 50, 100)
    Lighting.OutdoorAmbient = Color3.fromRGB(60, 50, 100)
    
    local atm = Instance.new("Atmosphere")
    atm.Name = "DevyAtm"
    atm.Color = Color3.fromRGB(100, 60, 150)
    atm.Density = 0.4
    atm.Glare = 0.5
    atm.Parent = Lighting
    
    local cc = Instance.new("ColorCorrectionEffect")
    cc.Name = "DevyCC"
    cc.TintColor = Color3.fromRGB(200, 150, 255)
    cc.Contrast = 0.2
    cc.Saturation = 0.5
    cc.Parent = Lighting
end)

-- 3. Glossy
glossyBtn.MouseButton1Click:Connect(function()
    if glossyActive then clearGlossy() else applyGlossy() end
end)

-- 4. Neblina 1 (Escura)
fog1Btn.MouseButton1Click:Connect(function()
    clearEnvironment()
    Lighting.FogColor = Color3.fromRGB(100, 100, 100)
    Lighting.FogStart = 0
    Lighting.FogEnd = 120
    Lighting.Ambient = Color3.fromRGB(100, 100, 100)
    Lighting.OutdoorAmbient = Color3.fromRGB(100, 100, 100)
end)

-- 5. Neblina 2 (Clara)
fog2Btn.MouseButton1Click:Connect(function()
    clearEnvironment()
    Lighting.FogColor = Color3.fromRGB(210, 210, 210)
    Lighting.FogStart = 0
    Lighting.FogEnd = 150
    Lighting.Ambient = Color3.fromRGB(210, 210, 210)
    Lighting.OutdoorAmbient = Color3.fromRGB(210, 210, 210)
end)

-- 6. Resetar TUDO
resetBtn.MouseButton1Click:Connect(function()
    clearEnvironment()
    clearGlossy()
end)

print("✨ Devy Effects V4 (Luz Realista + Glossy) carregado! ✨")

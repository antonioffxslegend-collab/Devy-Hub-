-- ========================================================
--   👑 DEVY HUB (Launcher) 👑
--   Abas: Quality, Cursors, Skies
-- ========================================================

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- ================= DADOS PARA OS PAINÉIS =================
-- 1. Cursors
local cursorSize = 32
local currentCursorId = "rbxassetid://131843855435385"
local DefaultImages = {"rbxasset://textures/MouseLockedCursor.png","rbxasset://textures/MouseLockedCursor@2x.png"}
local ShiftlockObjects = {}

local allCursors = {
    {Name="White", Id="rbxassetid://131843855435385"}, {Name="Purple", Id="rbxassetid://105227484929270"},
    {Name="Dark Red", Id="rbxassetid://70807381747714"}, {Name="Black", Id="rbxassetid://134411152875782"},
    {Name="Pink", Id="rbxassetid://101446374921049"}, {Name="Blue", Id="rbxassetid://94640444703376"},
    {Name="Green", Id="rbxassetid://112063814299010"}, {Name="Teal", Id="rbxassetid://105472303240225"},
    {Name="Hot Pink", Id="rbxassetid://120423063723029"}, {Name="Red", Id="rbxassetid://93953005352303"},
    {Name="Mocha", Id="rbxassetid://123066282804999"}, {Name="Cinnamoroll", Id="rbxassetid://130820173728340"},
    {Name="Blue Diamond", Id="rbxassetid://86867462006638"}, {Name="Red Diamond", Id="rbxassetid://92104309771570"},
    {Name="Red Star", Id="rbxassetid://93839976680281"}, {Name="Orange", Id="rbxassetid://132782590439670"},
    {Name="Kuromi", Id="rbxassetid://94422136876896"}, {Name="Hello Kitty", Id="rbxassetid://124324922920553"},
    {Name="Hello Kitty Bow", Id="rbxassetid://120839586609926"}, {Name="Apple Jack", Id="rbxassetid://105737560480211"},
    {Name="Chococat", Id="rbxthumb://type=Asset&id=118126832694865&w=150&h=150"},
    {Name="Star Perplexo", Id="rbxthumb://type=Asset&id=130225909042821&w=150&h=150"},
    {Name="White Star", Id="rbxthumb://type=Asset&id=91945747069689&w=150&h=150"},
    {Name="Teal Star", Id="rbxthumb://type=Asset&id=92452799913309&w=150&h=150"},
    {Name="Purple Bow", Id="rbxthumb://type=Asset&id=88548312898815&w=150&h=150"},
    {Name="Pompompurin", Id="rbxassetid://74655745935138"},
    {Name="Elii Blue Bow", Id="rbxassetid://111473814494633"}
}

-- 2. Skies
local availableSkies = {
    {name="Pompompurin", preview="rbxassetid://75714771802586", t={Ft = "rbxassetid://75714771802586", Bk = "rbxassetid://101135179311032", Lf = "rbxassetid://91074229280193", Rt = "rbxassetid://104253825473230", Up = "rbxassetid://123932407033264", Dn = "rbxassetid://104726275265089"}},
    {name="Kuromi", preview="rbxassetid://88489220146042", t={Bk="rbxassetid://70452413404770",Dn="rbxassetid://123427371005731",Ft="rbxassetid://88489220146042",Lf="rbxassetid://122589234533772",Rt="rbxassetid://116202549075645",Up="rbxassetid://83605197436509"}},
    {name="Cinnamoroll", preview="rbxassetid://120341099215321", t={Bk="rbxassetid://89366633020960",Dn="rbxassetid://116309195857720",Ft="rbxassetid://120341099215321",Lf="rbxassetid://91812928190255",Rt="rbxassetid://94423580805320",Up="rbxassetid://110878880655531"}},
    {name="Apple Jack", preview="rbxassetid://112101406433040", t={Bk="rbxassetid://82808455277415",Dn="rbxassetid://95291741443754",Ft="rbxassetid://112101406433040",Lf="rbxassetid://114535847152295",Rt="rbxassetid://70437680826929",Up="rbxassetid://123557920456536"}},
    {name="HK Christmas", preview="rbxassetid://133452089641107", t={Bk="rbxassetid://135297280579161",Dn="rbxassetid://76872220095611",Ft="rbxassetid://133452089641107",Lf="rbxassetid://104464782805839",Rt="rbxassetid://88627908709078",Up="rbxassetid://82728976669867"}},
    {name="Billie Eilish", preview="rbxassetid://90547004293864", t={Bk="rbxassetid://96872763324980",Dn="rbxassetid://136699999413389",Ft="rbxassetid://90547004293864",Lf="rbxassetid://93704506246640",Rt="rbxassetid://86195794785935",Up="rbxassetid://71481407456803"}},
    {name="Spooky", preview="rbxassetid://131333613950625", t={Bk="rbxassetid://87967125504678",Dn="rbxassetid://99948314010718",Ft="rbxassetid://131333613950625",Lf="rbxassetid://86435422447872",Rt="rbxassetid://110806247796360",Up="rbxassetid://94221824992515"}},
    {name="Melody", preview="rbxassetid://126411388718422", t={Bk="rbxassetid://139844427143659",Dn="rbxassetid://123648101830800",Ft="rbxassetid://126411388718422",Lf="rbxassetid://86046415976082",Rt="rbxassetid://110938737354251",Up="rbxassetid://135279992658427"}},
    {name="Chococat", preview="rbxassetid://127432502457919", t={Bk="rbxassetid://122934223825685",Dn="rbxassetid://123427371005731",Ft="rbxassetid://127432502457919",Lf="rbxassetid://118552411654693",Rt="rbxassetid://79507204666851",Up="rbxassetid://90208876152081"}},
    {name="Goodnight", kind="single", id=9848172808}, {name="Space Blue", kind="single", id=110721469926251},
    {name="Emo", kind="single", id=106377173007538}, {name="Red Cloud", kind="single", id=136055162054954},
    {name="Aurora", kind="single", id=86047318924047}, {name="Pink Sunrise", kind="single", id=102712197652880},
    {name="Hades", kind="single", id=11730863818}
}

-- 3. Quality (Originais)
local originalFogColor = Lighting.FogColor; local originalFogStart = Lighting.FogStart; local originalFogEnd = Lighting.FogEnd
local originalAmbient = Lighting.Ambient; local originalOutdoor = Lighting.OutdoorAmbient; local originalClockTime = Lighting.ClockTime
local originalBrightness = Lighting.Brightness; local originalEnvDiffuse = Lighting.EnvironmentDiffuseScale; local originalEnvSpecular = Lighting.EnvironmentSpecularScale
local glossyActive = false; local glossConn = nil

-- ================= LÓGICA DE CURSOR =================
local function ScanShiftLock()
    ShiftlockObjects = {}
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("ImageLabel") or v:IsA("ImageButton") then
            if table.find(DefaultImages, v.Image) or string.find(string.lower(v.Name), "shift") or string.find(string.lower(v.Name), "lock") then
                table.insert(ShiftlockObjects, v)
            end
        end
    end
end
local function ApplyCursor()
    for _, v in pairs(ShiftlockObjects) do
        if v and v.Parent then
            v.Image = currentCursorId; v.Size = UDim2.new(0, cursorSize, 0, cursorSize)
            v.ImageTransparency = (cursorSize == 0) and 1 or 0; v.BackgroundTransparency = 1; v.ScaleType = Enum.ScaleType.Fit
        end
    end
end
game.DescendantAdded:Connect(function(v)
    task.wait(1)
    if v:IsA("ImageLabel") or v:IsA("ImageButton") then
        if table.find(DefaultImages, v.Image) or string.find(string.lower(v.Name), "shift") or string.find(string.lower(v.Name), "lock") then
            table.insert(ShiftlockObjects, v); ApplyCursor()
        end
    end
end)
ScanShiftLock()

-- ================= UI DO HUB =================
local hub = Instance.new("ScreenGui")
hub.Name = "DevyHub"
hub.ResetOnSpawn = false
hub.IgnoreGuiInset = true
hub.Parent = player:WaitForChild("PlayerGui")

-- Botão do Hub (👑)
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0, 20, 0.5, -25)
toggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
toggleBtn.Text = "👑"
toggleBtn.TextSize = 26
toggleBtn.AutoButtonColor = false
toggleBtn.Parent = hub
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)
local tStroke = Instance.new("UIStroke", toggleBtn)
tStroke.Color = Color3.fromRGB(255, 215, 0); tStroke.Thickness = 2

-- Painel do Hub
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 320, 0, 240)
main.Position = UDim2.new(0.5, -160, 0.5, -120)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
main.Visible = false
main.Parent = hub
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)
local mStroke = Instance.new("UIStroke", main)
mStroke.Color = Color3.fromRGB(80, 80, 100); mStroke.Thickness = 2

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 35)
header.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
header.Parent = main
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 1, 0); title.BackgroundTransparency = 1
title.Text = "Devy Hub"; title.Font = Enum.Font.GothamBold; title.TextSize = 14
title.TextColor3 = Color3.fromRGB(255, 215, 0); title.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 0, 25); closeBtn.Position = UDim2.new(1, -30, 0.5, -12)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80); closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold; closeBtn.TextSize = 12; closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Parent = header
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

-- Arrastar Hub
local dragging, dragInput, dragStart, startPos
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = main.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
header.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

toggleBtn.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)
closeBtn.MouseButton1Click:Connect(function() main.Visible = false end)

-- ================= SISTEMA DE ABAS DO HUB =================
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(0, 90, 1, -45); tabBar.Position = UDim2.new(0, 10, 0, 45)
tabBar.BackgroundTransparency = 1; tabBar.Parent = main
local tLayout = Instance.new("UIListLayout", tabBar)
tLayout.Padding = UDim.new(0, 8); tLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -110, 1, -55); content.Position = UDim2.new(0, 100, 0, 45)
content.BackgroundColor3 = Color3.fromRGB(20, 20, 25); content.Parent = main
Instance.new("UICorner", content).CornerRadius = UDim.new(0, 8)

local pages = {}
local function createTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 32); btn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    btn.Text = name; btn.Font = Enum.Font.GothamBold; btn.TextSize = 11; btn.TextColor3 = Color3.fromRGB(150, 150, 170)
    btn.AutoButtonColor = false; btn.Parent = tabBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local page = Instance.new("Frame")
    page.Size = UDim2.new(1, -10, 1, -10); page.Position = UDim2.new(0, 5, 0, 5)
    page.BackgroundTransparency = 1; page.Visible = false; page.Parent = content
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        for _, b in pairs(tabBar:GetChildren()) do if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(30, 30, 38); b.TextColor3 = Color3.fromRGB(150, 150, 170) end end
        page.Visible = true; btn.BackgroundColor3 = Color3.fromRGB(45, 130, 220); btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    pages[page] = page; return page, btn
end

local qPage, qBtn = createTab("Quality ✨")
local cPage, cBtn = createTab("Cursors 🖱️")
local sPage, sBtn = createTab("Skies ☁️")
qPage.Visible = true; qBtn.BackgroundColor3 = Color3.fromRGB(45, 130, 220); qBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- ================= GERADOR DE BOTÕES PARA OS PAINÉIS =================
local function createEquipBtn(parent, panelName, guiRef)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Position = UDim2.new(0, 5, 0, 20)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    btn.Text = "Abrir " .. panelName
    btn.Font = Enum.Font.GothamBold; btn.TextSize = 12; btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.AutoButtonColor = false; btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
    local isOpen = false
    btn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        guiRef.Enabled = isOpen
        if isOpen then
            btn.Text = "Fechar " .. panelName
            btn.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
        else
            btn.Text = "Abrir " .. panelName
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
        end
    end)
end

-- ================= 1. CRIANDO PAINEL DE QUALITY =================
local qGui = Instance.new("ScreenGui")
qGui.Name = "DevyEffects"
qGui.ResetOnSpawn = false; qGui.IgnoreGuiInset = true; qGui.Enabled = false
qGui.Parent = player:WaitForChild("PlayerGui")

local qPanel = Instance.new("Frame")
qPanel.Size = UDim2.new(0, 250, 0, 300); qPanel.Position = UDim2.new(0.5, -125, 0.5, -150)
qPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 20); qPanel.Active = true; qPanel.Parent = qGui
Instance.new("UICorner", qPanel).CornerRadius = UDim.new(0, 12)

local qHeader = Instance.new("Frame")
qHeader.Size = UDim2.new(1, 0, 0, 35); qHeader.BackgroundColor3 = Color3.fromRGB(25, 25, 30); qHeader.Parent = qPanel
Instance.new("UICorner", qHeader).CornerRadius = UDim.new(0, 12)
local qTitle = Instance.new("TextLabel")
qTitle.Size = UDim2.new(1, 0, 1, 0); qTitle.BackgroundTransparency = 1; qTitle.Text = "Quality Effects"
qTitle.Font = Enum.Font.GothamBold; qTitle.TextSize = 14; qTitle.TextColor3 = Color3.fromRGB(200, 150, 255); qTitle.Parent = qHeader

local qClose = Instance.new("TextButton")
qClose.Size = UDim2.new(0, 25, 0, 25); qClose.Position = UDim2.new(1, -30, 0.5, -12)
qClose.BackgroundColor3 = Color3.fromRGB(255, 80, 80); qClose.Text = "X"; qClose.Font = Enum.Font.GothamBold; qClose.TextSize = 12; qClose.Parent = qHeader
Instance.new("UICorner", qClose).CornerRadius = UDim.new(1, 0)
qClose.MouseButton1Click:Connect(function() qGui.Enabled = false; qPage:FindFirstChildOfClass("TextButton").Text = "Abrir Quality ✨"; qPage:FindFirstChildOfClass("TextButton").BackgroundColor3 = Color3.fromRGB(30, 30, 38) end)

local qScroll = Instance.new("ScrollingFrame")
qScroll.Size = UDim2.new(1, -10, 1, -45); qScroll.Position = UDim2.new(0, 5, 0, 40)
qScroll.BackgroundTransparency = 1; qScroll.ScrollBarThickness = 3; qScroll.CanvasSize = UDim2.new(0, 0, 0, 0); qScroll.Parent = qPanel
local qLayout = Instance.new("UIListLayout", qScroll)
qLayout.SortOrder = Enum.SortOrder.LayoutOrder; qLayout.Padding = UDim.new(0, 6); qLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
qLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() qScroll.CanvasSize = UDim2.new(0, 0, 0, qLayout.AbsoluteContentSize.Y + 10) end)

local function qBtn(text, color)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -10, 0, 35); b.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    b.Text = text; b.Font = Enum.Font.GothamBold; b.TextSize = 12; b.TextColor3 = color; b.AutoButtonColor = false; b.Parent = qScroll
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8); return b
end

-- Lógica do Quality
local function clearEnv()
    Lighting.FogColor = originalFogColor; Lighting.FogStart = originalFogStart; Lighting.FogEnd = originalFogEnd
    Lighting.Ambient = originalAmbient; Lighting.OutdoorAmbient = originalOutdoor; Lighting.ClockTime = originalClockTime
    Lighting.Brightness = originalBrightness; Lighting.EnvironmentDiffuseScale = originalEnvDiffuse; Lighting.EnvironmentSpecularScale = originalEnvSpecular
    for _, v in ipairs(Lighting:GetChildren()) do
        if v:IsA("Atmosphere") and v.Name == "DevyAtm" then v:Destroy() end
        if v:IsA("ColorCorrectionEffect") and v.Name == "DevyCC" then v:Destroy() end
        if v:IsA("SunRaysEffect") and v.Name == "DevyRays" then v:Destroy() end
    end
end
local function clearGloss()
    glossyActive = false; if glossConn then glossConn:Disconnect() end
    if player.Character then
        for _, v in ipairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.Material = Enum.Material.Plastic; v.Reflectance = 0 end
            if v:IsA("PointLight") and v.Name == "GlossyLight" then v:Destroy() end
        end
    end
end

local sBtn2 = qBtn("Sunset / Sunrise ☀️", Color3.fromRGB(255, 180, 100))
sBtn2.MouseButton1Click:Connect(function()
    clearEnv(); Lighting.ClockTime = 17.5; Lighting.Brightness = 3; Lighting.EnvironmentDiffuseScale = 1; Lighting.EnvironmentSpecularScale = 1
    Lighting.FogColor = Color3.fromRGB(255, 140, 100); Lighting.FogStart = 0; Lighting.FogEnd = 400
    Lighting.Ambient = Color3.fromRGB(255, 180, 150); Lighting.OutdoorAmbient = Color3.fromRGB(255, 180, 150)
    local rays = Instance.new("SunRaysEffect"); rays.Name = "DevyRays"; rays.Intensity = 0.15; rays.Spread = 0.5; rays.Parent = Lighting
    local atm = Instance.new("Atmosphere"); atm.Name = "DevyAtm"; atm.Color = Color3.fromRGB(255, 150, 100); atm.Decay = Color3.fromRGB(100, 150, 255); atm.Density = 0.4; atm.Parent = Lighting
end)

local pBtn2 = qBtn("Vibe Roxa 🌌", Color3.fromRGB(180, 120, 255))
pBtn2.MouseButton1Click:Connect(function()
    clearEnv(); Lighting.ClockTime = 0; Lighting.Brightness = 2; Lighting.EnvironmentDiffuseScale = 1; Lighting.EnvironmentSpecularScale = 1
    Lighting.FogColor = Color3.fromRGB(80, 60, 120); Lighting.FogStart = 0; Lighting.FogEnd = 200
    Lighting.Ambient = Color3.fromRGB(60, 50, 100); Lighting.OutdoorAmbient = Color3.fromRGB(60, 50, 100)
    local atm = Instance.new("Atmosphere"); atm.Name = "DevyAtm"; atm.Color = Color3.fromRGB(100, 60, 150); atm.Density = 0.4; atm.Parent = Lighting
    local cc = Instance.new("ColorCorrectionEffect"); cc.Name = "DevyCC"; cc.TintColor = Color3.fromRGB(200, 150, 255); cc.Contrast = 0.2; cc.Parent = Lighting
end)

local gBtn2 = qBtn("Glossy Light ✨", Color3.fromRGB(255, 255, 200))
gBtn2.MouseButton1Click:Connect(function()
    if glossyActive then clearGloss(); gBtn2.Text = "Glossy Light ✨"
    else
        clearGloss(); glossyActive = true
        local function addG(c) for _, v in ipairs(c:GetDescendants()) do if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then v.Material = Enum.Material.Glass; v.Reflectance = 0.8 end end end
        if player.Character then addG(player.Character) end
        glossConn = player.CharacterAdded:Connect(addG); gBtn2.Text = "Glossy ON ✨"
    end
end)

local rBtn2 = qBtn("Resetar ❌", Color3.fromRGB(255, 100, 100))
rBtn2.MouseButton1Click:Connect(function() clearEnv(); clearGloss(); gBtn2.Text = "Glossy Light ✨" end)
createEquipBtn(qPage, "Quality ✨", qGui)

-- ================= 2. CRIANDO PAINEL DE CURSORS =================
local cGui = Instance.new("ScreenGui")
cGui.Name = "DevyCursorPanel"
cGui.ResetOnSpawn = false; cGui.IgnoreGuiInset = true; cGui.Enabled = false
cGui.Parent = player:WaitForChild("PlayerGui")

local cPanel = Instance.new("Frame")
cPanel.Size = UDim2.new(0, 250, 0, 300); cPanel.Position = UDim2.new(0.5, -125, 0.5, -150)
cPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 20); cPanel.Active = true; cPanel.Parent = cGui
Instance.new("UICorner", cPanel).CornerRadius = UDim.new(0, 12)

local cHeader = Instance.new("Frame")
cHeader.Size = UDim2.new(1, 0, 0, 35); cHeader.BackgroundColor3 = Color3.fromRGB(25, 25, 30); cHeader.Parent = cPanel
Instance.new("UICorner", cHeader).CornerRadius = UDim.new(0, 12)
local cTitle = Instance.new("TextLabel")
cTitle.Size = UDim2.new(1, 0, 1, 0); cTitle.BackgroundTransparency = 1; cTitle.Text = "Cursors"
cTitle.Font = Enum.Font.GothamBold; cTitle.TextSize = 14; cTitle.TextColor3 = Color3.fromRGB(255, 255, 255); cTitle.Parent = cHeader

local cClose = Instance.new("TextButton")
cClose.Size = UDim2.new(0, 25, 0, 25); cClose.Position = UDim2.new(1, -30, 0.5, -12)
cClose.BackgroundColor3 = Color3.fromRGB(255, 80, 80); cClose.Text = "X"; cClose.Font = Enum.Font.GothamBold; cClose.TextSize = 12; cClose.Parent = cHeader
Instance.new("UICorner", cClose).CornerRadius = UDim.new(1, 0)
cClose.MouseButton1Click:Connect(function() cGui.Enabled = false; cPage:FindFirstChildOfClass("TextButton").Text = "Abrir Cursors 🖱️"; cPage:FindFirstChildOfClass("TextButton").BackgroundColor3 = Color3.fromRGB(30, 30, 38) end)

local cScroll = Instance.new("ScrollingFrame")
cScroll.Size = UDim2.new(1, -10, 1, -45); cScroll.Position = UDim2.new(0, 5, 0, 40)
cScroll.BackgroundTransparency = 1; cScroll.ScrollBarThickness = 3; cScroll.CanvasSize = UDim2.new(0, 0, 0, 0); cScroll.Parent = cPanel

local cGrid = Instance.new("UIGridLayout", cScroll)
cGrid.CellSize = UDim2.new(0, 45, 0, 45); cGrid.CellPadding = UDim2.new(0, 6, 0, 6); cGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center
cGrid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() cScroll.CanvasSize = UDim2.new(0, 0, 0, cGrid.AbsoluteContentSize.Y + 10) end)

for _, data in ipairs(allCursors) do
    local ib = Instance.new("ImageButton")
    ib.BackgroundColor3 = Color3.fromRGB(30, 30, 38); ib.ScaleType = Enum.ScaleType.Fit; ib.Image = data.Id; ib.Parent = cScroll
    Instance.new("UICorner", ib).CornerRadius = UDim.new(0, 8)
    ib.MouseButton1Click:Connect(function() currentCursorId = data.Id; ApplyCursor() end)
end
createEquipBtn(cPage, "Cursors 🖱️", cGui)

-- ================= 3. CRIANDO PAINEL DE SKIES =================
local sGui = Instance.new("ScreenGui")
sGui.Name = "DevySkiesPanel"
sGui.ResetOnSpawn = false; sGui.IgnoreGuiInset = true; sGui.Enabled = false
sGui.Parent = player:WaitForChild("PlayerGui")

local sPanel = Instance.new("Frame")
sPanel.Size = UDim2.new(0, 320, 0, 300); sPanel.Position = UDim2.new(0.5, -160, 0.5, -150)
sPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 20); sPanel.Active = true; sPanel.Parent = sGui
Instance.new("UICorner", sPanel).CornerRadius = UDim.new(0, 12)

local sHeader = Instance.new("Frame")
sHeader.Size = UDim2.new(1, 0, 0, 35); sHeader.BackgroundColor3 = Color3.fromRGB(25, 25, 30); sHeader.Parent = sPanel
Instance.new("UICorner", sHeader).CornerRadius = UDim.new(0, 12)
local sTitle = Instance.new("TextLabel")
sTitle.Size = UDim2.new(1, 0, 1, 0); sTitle.BackgroundTransparency = 1; sTitle.Text = "Skies"
sTitle.Font = Enum.Font.GothamBold; sTitle.TextSize = 14; sTitle.TextColor3 = Color3.fromRGB(255, 255, 255); sTitle.Parent = sHeader

local sClose = Instance.new("TextButton")
sClose.Size = UDim2.new(0, 25, 0, 25); sClose.Position = UDim2.new(1, -30, 0.5, -12)
sClose.BackgroundColor3 = Color3.fromRGB(255, 80, 80); sClose.Text = "X"; sClose.Font = Enum.Font.GothamBold; sClose.TextSize = 12; sClose.Parent = sHeader
Instance.new("UICorner", sClose).CornerRadius = UDim.new(1, 0)
sClose.MouseButton1Click:Connect(function() sGui.Enabled = false; sPage:FindFirstChildOfClass("TextButton").Text = "Abrir Skies ☁️"; sPage:FindFirstChildOfClass("TextButton").BackgroundColor3 = Color3.fromRGB(30, 30, 38) end)

local sScroll = Instance.new("ScrollingFrame")
sScroll.Size = UDim2.new(1, -10, 1, -45); sScroll.Position = UDim2.new(0, 5, 0, 40)
sScroll.BackgroundTransparency = 1; sScroll.ScrollBarThickness = 3; sScroll.CanvasSize = UDim2.new(0, 0, 0, 0); sScroll.Parent = sPanel

local sGrid = Instance.new("UIGridLayout", sScroll)
sGrid.CellSize = UDim2.new(0, 140, 0, 80); sGrid.CellPadding = UDim2.new(0, 6, 0, 6); sGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center
sGrid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() sScroll.CanvasSize = UDim2.new(0, 0, 0, sGrid.AbsoluteContentSize.Y + 15) end)

local function clearSkies()
    for _, v in ipairs(Lighting:GetChildren()) do
        if v:IsA("Sky") or v:IsA("Atmosphere") or (v:IsA("ColorCorrectionEffect") and v.Name == "DevyCC") then v:Destroy() end
    end
end

for _, data in ipairs(availableSkies) do
    local btn = Instance.new("ImageButton")
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 38); btn.Image = data.preview or "rbxassetid://0"; btn.ScaleType = Enum.ScaleType.Crop; btn.AutoButtonColor = false; btn.Parent = sScroll
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(function()
        clearSkies()
        if data.kind == "single" then
            local ok, obj = pcall(function() return game:GetObjects("rbxassetid://" .. tostring(data.id))[1] end)
            if ok and obj and obj:IsA("Sky") then obj.Parent = Lighting end
        else
            local sky = Instance.new("Sky"); sky.Name = "CustomSky"
            sky.SkyboxBk = data.t.Bk; sky.SkyboxDn = data.t.Dn; sky.SkyboxFt = data.t.Ft
            sky.SkyboxLf = data.t.Lf; sky.SkyboxRt = data.t.Rt; sky.SkyboxUp = data.t.Up
            sky.Parent = Lighting
        end
        for _, v in ipairs(sScroll:GetChildren()) do if v:IsA("ImageButton") then v.BorderSizePixel = 0 end end
        btn.BorderSizePixel = 2; btn.BorderColor3 = Color3.fromRGB(255, 255, 0)
    end)
end
createEquipBtn(sPage, "Skies ☁️", sGui)

print("👑 Devy Hub carregado! Use o botão do trono para abrir.")

-- ==========================================
--  JoseAngel_Blox Run for Brainrot Script v1.1
--  Diseño 100% Nativo (Sin Librerías)
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

-- Evitar que se duplique el menú si lo ejecutas varias veces
local guiName = "JoseAngel_RunForBrainrot"
if CoreGui:FindFirstChild(guiName) then
    CoreGui[guiName]:Destroy()
end

-- ====================
-- CREACIÓN DE LA UI
-- ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = guiName
ScreenGui.Parent = CoreGui

-- Marco Principal (Fondo Rojo Bonito)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 550, 0, 350)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(160, 20, 20) -- Rojo elegante
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Permite mover la ventana
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Título con Brillo (Letras Rojas)
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 35)
TitleLabel.Position = UDim2.new(0, 0, 0, 5)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "JoseAngel_Blox Run for Brainrot"
TitleLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
TitleLabel.TextSize = 22
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Parent = MainFrame

-- Borde negro para que resalte la letra roja sobre el fondo rojo
local TitleStroke = Instance.new("UIStroke")
TitleStroke.Color = Color3.fromRGB(15, 0, 0)
TitleStroke.Thickness = 2
TitleStroke.Parent = TitleLabel

-- Efecto de Brillo Movible en el Título
local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 50, 50)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 200, 200)), -- Zona de brillo
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 50, 50))
})
TitleGradient.Rotation = 45
TitleGradient.Parent = TitleLabel

-- Animación del brillo
spawn(function()
    while task.wait() do
        for i = -1, 1, 0.02 do
            TitleGradient.Offset = Vector2.new(i, 0)
            task.wait(0.02)
        end
    end
end)

-- Subtítulo Transparente
local SubTitleLabel = Instance.new("TextLabel")
SubTitleLabel.Size = UDim2.new(1, 0, 0, 20)
SubTitleLabel.Position = UDim2.new(0, 0, 0, 35)
SubTitleLabel.BackgroundTransparency = 1
SubTitleLabel.Text = "Creado por JoseAngel_Blox"
SubTitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SubTitleLabel.TextTransparency = 0.6 -- Letras transparentes
SubTitleLabel.TextSize = 14
SubTitleLabel.Font = Enum.Font.Gotham
SubTitleLabel.Parent = MainFrame

-- Contenedor Izquierdo (Pestañas y Perfil)
local LeftPanel = Instance.new("Frame")
LeftPanel.Size = UDim2.new(0.3, -10, 1, -65)
LeftPanel.Position = UDim2.new(0, 10, 0, 60)
LeftPanel.BackgroundColor3 = Color3.fromRGB(130, 15, 15)
LeftPanel.Parent = MainFrame

local LeftCorner = Instance.new("UICorner")
LeftCorner.CornerRadius = UDim.new(0, 8)
LeftCorner.Parent = LeftPanel

-- Contenedor Derecho (Funciones)
local RightPanel = Instance.new("Frame")
RightPanel.Size = UDim2.new(0.7, -20, 1, -65)
RightPanel.Position = UDim2.new(0.3, 10, 0, 60)
RightPanel.BackgroundColor3 = Color3.fromRGB(110, 10, 10)
RightPanel.Parent = MainFrame

local RightCorner = Instance.new("UICorner")
RightCorner.CornerRadius = UDim.new(0, 8)
RightCorner.Parent = RightPanel

-- ====================
-- SISTEMA DE PESTAÑAS (TABS)
-- ====================
local TabContainer = Instance.new("ScrollingFrame")
TabContainer.Size = UDim2.new(1, 0, 1, -70) -- Deja espacio abajo para el perfil
TabContainer.BackgroundTransparency = 1
TabContainer.ScrollBarThickness = 0
TabContainer.Parent = LeftPanel

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Padding = UDim.new(0, 5)
TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabListLayout.Parent = TabContainer

local Pages = {}

local function CreateTab(name, isFirst)
    -- Botón de la pestaña
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(0.9, 0, 0, 35)
    TabButton.BackgroundColor3 = Color3.fromRGB(90, 5, 5)
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.Text = name
    TabButton.Font = Enum.Font.GothamBold
    TabButton.TextSize = 14
    TabButton.Parent = TabContainer

    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 6)
    TabCorner.Parent = TabButton

    -- Página correspondiente
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.ScrollBarThickness = 4
    Page.Visible = isFirst
    Page.Parent = RightPanel

    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Padding = UDim.new(0, 8)
    PageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    PageLayout.Parent = Page
    
    local PagePadding = Instance.new("UIPadding")
    PagePadding.PaddingTop = UDim.new(0, 10)
    PagePadding.Parent = Page

    Pages[name] = Page

    TabButton.MouseButton1Click:Connect(function()
        for pageName, pageFrame in pairs(Pages) do
            pageFrame.Visible = (pageName == name)
        end
    end)

    return Page
end

-- ====================
-- SECCIÓN DE PERFIL (Abajo a la Izquierda)
-- ====================
local ProfileFrame = Instance.new("Frame")
ProfileFrame.Size = UDim2.new(1, 0, 0, 60)
ProfileFrame.Position = UDim2.new(0, 0, 1, -60)
ProfileFrame.BackgroundColor3 = Color3.fromRGB(90, 5, 5)
ProfileFrame.Parent = LeftPanel

local ProfileCorner = Instance.new("UICorner")
ProfileCorner.CornerRadius = UDim.new(0, 8)
ProfileCorner.Parent = ProfileFrame

-- Avatar del Jugador
local AvatarImage = Instance.new("ImageLabel")
AvatarImage.Size = UDim2.new(0, 45, 0, 45)
AvatarImage.Position = UDim2.new(0, 5, 0, 7)
AvatarImage.BackgroundColor3 = Color3.fromRGB(60, 5, 5)
AvatarImage.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
AvatarImage.Parent = ProfileFrame

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0)
AvatarCorner.Parent = AvatarImage

-- Nombre de Usuario
local UsernameLabel = Instance.new("TextLabel")
UsernameLabel.Size = UDim2.new(1, -60, 0, 20)
UsernameLabel.Position = UDim2.new(0, 55, 0, 10)
UsernameLabel.BackgroundTransparency = 1
UsernameLabel.Text = LocalPlayer.Name
UsernameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
UsernameLabel.Font = Enum.Font.GothamBold
UsernameLabel.TextSize = 12
UsernameLabel.TextScaled = true
UsernameLabel.Parent = ProfileFrame

-- Logo de Roblox Premium (Si lo tiene)
if LocalPlayer.MembershipType == Enum.MembershipType.Premium then
    local PremiumIcon = Instance.new("ImageLabel")
    PremiumIcon.Size = UDim2.new(0, 20, 0, 20)
    PremiumIcon.Position = UDim2.new(0, 55, 0, 30)
    PremiumIcon.BackgroundTransparency = 1
    PremiumIcon.Image = "rbxassetid://6207172044" -- Logo oficial de Premium
    PremiumIcon.Parent = ProfileFrame
else
    local NoPremium = Instance.new("TextLabel")
    NoPremium.Size = UDim2.new(1, -60, 0, 15)
    NoPremium.Position = UDim2.new(0, 55, 0, 30)
    NoPremium.BackgroundTransparency = 1
    NoPremium.Text = "Standard"
    NoPremium.TextColor3 = Color3.fromRGB(200, 200, 200)
    NoPremium.TextXAlignment = Enum.TextXAlignment.Left
    NoPremium.Font = Enum.Font.Gotham
    NoPremium.TextSize = 10
    NoPremium.Parent = ProfileFrame
end


-- ====================
-- FUNCIONES DE LA UI (Helpers)
-- ====================
local function CreateButton(page, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.9, 0, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Text = text
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 14
    Btn.Parent = page

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Btn

    Btn.MouseButton1Click:Connect(callback)
    return Btn
end

local function CreateLabel(page, text)
    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(0.9, 0, 0, 25)
    Lbl.BackgroundTransparency = 1
    Lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    Lbl.Text = text
    Lbl.Font = Enum.Font.Gotham
    Lbl.TextSize = 13
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.Parent = page
end

-- Teleport Seguro
local function TeleportTo(partName)
    local target = Workspace:FindFirstChild(partName, true) -- Busca en todo el mapa
    if target and target:IsA("BasePart") then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = target.CFrame + Vector3.new(0, 3, 0)
        end
    end
end

-- ====================
-- CREACIÓN DE CONTENIDO
-- ====================

-- Pestaña 1: INFO
local InfoPage = CreateTab("Info", true)
CreateLabel(InfoPage, "Nombre del creador: JoseAngel_Bloxx")
CreateLabel(InfoPage, "Fecha de lanzamiento: 16/09/2026")
CreateLabel(InfoPage, "Versión: 1.1")
CreateLabel(InfoPage, "Update: Nuevo Script para Run")
CreateLabel(InfoPage, "for brainrot, este es un script completo.")

-- Pestaña 2: MAIN
local MainPage = CreateTab("Main", false)

local AutoFarmToggled = false
CreateButton(MainPage, "Toggle Auto Farm (CollectionZone)", function()
    AutoFarmToggled = not AutoFarmToggled
    while AutoFarmToggled do
        TeleportTo("CollectionZone")
        task.wait(1) -- Pausa para no colapsar el juego
    end
end)

CreateButton(MainPage, "Auto End (Ethereal)", function()
    TeleportTo("Ethereal")
end)

CreateButton(MainPage, "Auto Buy (Speed)", function()
    TeleportTo("Speed")
end)

CreateButton(MainPage, "Auto Sell (Sell)", function()
    TeleportTo("Sell")
end)

CreateButton(MainPage, "Auto Collect (Ir a tu Base)", function()
    -- Busca un modelo/carpeta en Workspace que se llame igual que tu usuario
    local myBase = Workspace:FindFirstChild(LocalPlayer.Name, true) 
    if myBase then
        local targetPart = myBase:FindFirstChildWhichIsA("BasePart") or myBase.PrimaryPart
        if targetPart and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = targetPart.CFrame + Vector3.new(0, 5, 0)
        end
    end
end)

-- Pestaña 3: PLAYER
local PlayerPage = CreateTab("Player", false)

-- Sistema de Velocidad
local currentSpeed = 16

local SpeedDisplay = Instance.new("TextLabel")
SpeedDisplay.Size = UDim2.new(0.9, 0, 0, 25)
SpeedDisplay.BackgroundTransparency = 1
SpeedDisplay.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedDisplay.Text = "Walkspeed Actual: " .. currentSpeed
SpeedDisplay.Font = Enum.Font.GothamBold
SpeedDisplay.TextSize = 14
SpeedDisplay.Parent = PlayerPage

local SpeedControlFrame = Instance.new("Frame")
SpeedControlFrame.Size = UDim2.new(0.9, 0, 0, 35)
SpeedControlFrame.BackgroundTransparency = 1
SpeedControlFrame.Parent = PlayerPage

local BtnMinus = Instance.new("TextButton")
BtnMinus.Size = UDim2.new(0.45, 0, 1, 0)
BtnMinus.Position = UDim2.new(0, 0, 0, 0)
BtnMinus.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
BtnMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnMinus.Text = "- Velocidad"
BtnMinus.Font = Enum.Font.GothamBold
BtnMinus.TextSize = 14
BtnMinus.Parent = SpeedControlFrame
Instance.new("UICorner", BtnMinus).CornerRadius = UDim.new(0, 6)

local BtnPlus = Instance.new("TextButton")
BtnPlus.Size = UDim2.new(0.45, 0, 1, 0)
BtnPlus.Position = UDim2.new(0.55, 0, 0, 0)
BtnPlus.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
BtnPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnPlus.Text = "+ Velocidad"
BtnPlus.Font = Enum.Font.GothamBold
BtnPlus.TextSize = 14
BtnPlus.Parent = SpeedControlFrame
Instance.new("UICorner", BtnPlus).CornerRadius = UDim.new(0, 6)

local function UpdateSpeed()
    SpeedDisplay.Text = "Walkspeed Actual: " .. currentSpeed
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = currentSpeed
    end
end

BtnPlus.MouseButton1Click:Connect(function()
    currentSpeed = currentSpeed + 10
    UpdateSpeed()
end)

BtnMinus.MouseButton1Click:Connect(function()
    currentSpeed = math.max(16, currentSpeed - 10)
    UpdateSpeed()
end)

-- Bucle para mantener la velocidad infinita activa (si el juego intenta resetearla)
RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum.WalkSpeed ~= currentSpeed and currentSpeed > 16 then
            hum.WalkSpeed = currentSpeed
        end
    end
end)

-- Sistema de Infinite Jump
local InfJumpActivo = false
CreateButton(PlayerPage, "Toggle Infinite Jump", function()
    InfJumpActivo = not InfJumpActivo
end)

UserInputService.JumpRequest:Connect(function()
    if InfJumpActivo then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

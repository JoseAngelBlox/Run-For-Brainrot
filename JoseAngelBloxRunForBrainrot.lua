-- ==========================================
--  JoseAngel_Blox Run for brainrot
--  Diseño Compacto + Velocidad Ajustable
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

-- Eliminar ejecuciones previas para evitar duplicados en la pantalla
if CoreGui:FindFirstChild("JoseAngel_RunBrainrot") then
    CoreGui.JoseAngel_RunBrainrot:Destroy()
end

-- ==========================================
-- INTERFAZ GRÁFICA (GUI)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_RunBrainrot"
ScreenGui.Parent = CoreGui

-- Marco principal (Cuadrado y pequeño)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 220)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

-- Título RGB
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "JoseAngel_Blox\nRun for brainrot"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextWrapped = true
Title.Parent = MainFrame

-- Botón Walkspeed (Toggle)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0.8, 0, 0, 35)
ToggleBtn.Position = UDim2.new(0.1, 0, 0, 55)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
ToggleBtn.Text = "Walkspeed: OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 14
ToggleBtn.Parent = MainFrame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleBtn

-- Indicador de Velocidad
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, 0, 0, 30)
SpeedLabel.Position = UDim2.new(0, 0, 0, 100)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Velocidad: 100"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextSize = 16
SpeedLabel.Parent = MainFrame

-- Botón Menos (-)
local MinusBtn = Instance.new("TextButton")
MinusBtn.Size = UDim2.new(0, 50, 0, 40)
MinusBtn.Position = UDim2.new(0, 30, 0, 140)
MinusBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MinusBtn.Text = "-"
MinusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinusBtn.Font = Enum.Font.GothamBold
MinusBtn.TextSize = 24
MinusBtn.Parent = MainFrame

local MinusCorner = Instance.new("UICorner")
MinusCorner.CornerRadius = UDim.new(0, 8)
MinusCorner.Parent = MinusBtn

-- Botón Más (+)
local PlusBtn = Instance.new("TextButton")
PlusBtn.Size = UDim2.new(0, 50, 0, 40)
PlusBtn.Position = UDim2.new(1, -80, 0, 140)
PlusBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
PlusBtn.Text = "+"
PlusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PlusBtn.Font = Enum.Font.GothamBold
PlusBtn.TextSize = 24
PlusBtn.Parent = MainFrame

local PlusCorner = Instance.new("UICorner")
PlusCorner.CornerRadius = UDim.new(0, 8)
PlusCorner.Parent = PlusBtn

-- ==========================================
-- LÓGICA DEL SCRIPT
-- ==========================================

-- Arrastrar la interfaz (Draggable)
local dragging, dragInput, dragStart, startPos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Efecto RGB para el título
task.spawn(function()
    while task.wait() do
        -- Cambia el color basándose en el tiempo (tick)
        Title.TextColor3 = Color3.fromHSV(tick() % 4 / 4, 1, 1)
    end
end)

-- Lógica de Velocidad
local isRunning = false
local currentSpeed = 100

-- Actualizar texto de velocidad
local function UpdateSpeedText()
    SpeedLabel.Text = "Velocidad: " .. currentSpeed
end

-- Activar/Desactivar Walkspeed
ToggleBtn.MouseButton1Click:Connect(function()
    isRunning = not isRunning
    if isRunning then
        ToggleBtn.Text = "Walkspeed: ON"
        ToggleBtn.TextColor3 = Color3.fromRGB(100, 255, 100) -- Verde
    else
        ToggleBtn.Text = "Walkspeed: OFF"
        ToggleBtn.TextColor3 = Color3.fromRGB(255, 100, 100) -- Rojo
        -- Restaurar velocidad normal
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
end)

-- Disminuir Velocidad
MinusBtn.MouseButton1Click:Connect(function()
    currentSpeed = math.max(16, currentSpeed - 10) -- No bajar de 16 (velocidad normal)
    UpdateSpeedText()
end)

-- Aumentar Velocidad
PlusBtn.MouseButton1Click:Connect(function()
    currentSpeed = currentSpeed + 10
    UpdateSpeedText()
end)

-- Bucle constante para forzar la velocidad (evita que el juego la reinicie)
RunService.Stepped:Connect(function()
    if isRunning and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = currentSpeed
    end
end)


--[[
    DIAMOND UNIVERSAL HUB v1.0
    Universal Roblox utility hub
]]

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local old = game.CoreGui:FindFirstChild("DiamondUniversal")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "DiamondUniversal"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(530, 350)
main.Position = UDim2.new(.5, -265, .5, -175)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 23)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(150, 65, 255)

local top = Instance.new("Frame", main)
top.Size = UDim2.new(1, 0, 0, 45)
top.BackgroundColor3 = Color3.fromRGB(25, 20, 38)
top.BorderSizePixel = 0
Instance.new("UICorner", top).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", top)
title.Size = UDim2.new(1, -100, 1, 0)
title.Position = UDim2.fromOffset(15, 0)
title.BackgroundTransparency = 1
title.Text = "◆ DIAMOND UNIVERSAL"
title.TextColor3 = Color3.fromRGB(190, 125, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 17
title.TextXAlignment = Enum.TextXAlignment.Left

local close = Instance.new("TextButton", top)
close.Size = UDim2.fromOffset(35, 30)
close.Position = UDim2.new(1, -42, 0, 7)
close.Text = "×"
close.TextSize = 23
close.TextColor3 = Color3.new(1,1,1)
close.BackgroundColor3 = Color3.fromRGB(180, 45, 65)
Instance.new("UICorner", close)

local open = Instance.new("TextButton", gui)
open.Size = UDim2.fromOffset(52, 52)
open.Position = UDim2.new(0, 20, .5, 0)
open.Text = "◆"
open.TextSize = 25
open.TextColor3 = Color3.fromRGB(210, 160, 255)
open.BackgroundColor3 = Color3.fromRGB(20, 15, 35)
open.Visible = false
Instance.new("UICorner", open).CornerRadius = UDim.new(1, 0)

close.MouseButton1Click:Connect(function()
    main.Visible = false
    open.Visible = true
end)

open.MouseButton1Click:Connect(function()
    main.Visible = true
    open.Visible = false
end)

-- DRAG
local dragging, dragStart, startPos

top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

local sidebar = Instance.new("Frame", main)
sidebar.Position = UDim2.fromOffset(10, 55)
sidebar.Size = UDim2.fromOffset(125, 285)
sidebar.BackgroundTransparency = 1

local sideLayout = Instance.new("UIListLayout", sidebar)
sideLayout.Padding = UDim.new(0, 7)

local content = Instance.new("Frame", main)
content.Position = UDim2.fromOffset(145, 55)
content.Size = UDim2.new(1, -155, 1, -65)
content.BackgroundTransparency = 1

local function label(text, y)
    local l = Instance.new("TextLabel", content)
    l.Size = UDim2.new(1, -10, 0, 35)
    l.Position = UDim2.fromOffset(5, y)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = Color3.new(1,1,1)
    l.Font = Enum.Font.Gotham
    l.TextSize = 14
    l.TextXAlignment = Enum.TextXAlignment.Left
    return l
end

local function button(text, callback)
    local b = Instance.new("TextButton", content)
    b.Size = UDim2.new(1, -10, 0, 35)
    b.BackgroundColor3 = Color3.fromRGB(35, 27, 50)
    b.Text = text
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamSemibold
    b.TextSize = 13
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(callback)
    return b
end

local pages = {}

local function newPage(name)
    local page = Instance.new("Frame", content)
    page.Size = UDim2.fromScale(1,1)
    page.BackgroundTransparency = 1
    page.Visible = false
    pages[name] = page
    return page
end

local function tab(name)
    local b = Instance.new("TextButton", sidebar)
    b.Size = UDim2.new(1,0,0,35)
    b.BackgroundColor3 = Color3.fromRGB(35,25,50)
    b.Text = name
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamSemibold
    b.TextSize = 13
    Instance.new("UICorner",b)
    b.MouseButton1Click:Connect(function()
        for _,p in pairs(pages) do p.Visible = false end
        pages[name].Visible = true
    end)
end

local home = newPage("Home")
local playerPage = newPage("Player")
local visuals = newPage("Visuals")
local utility = newPage("Utility")

tab("Home")
tab("Player")
tab("Visuals")
tab("Utility")

home.Visible = true

local function makeButton(page, text, y, callback)
    local b = Instance.new("TextButton", page)
    b.Position = UDim2.fromOffset(5,y)
    b.Size = UDim2.new(1,-10,0,35)
    b.BackgroundColor3 = Color3.fromRGB(38,28,55)
    b.TextColor3 = Color3.new(1,1,1)
    b.Text = text
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    Instance.new("UICorner",b)
    b.MouseButton1Click:Connect(callback)
    return b
end

local function getHumanoid()
    local char = Player.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end

local function getRoot()
    local char = Player.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function makeLabel(page,text,y)
    local l = Instance.new("TextLabel",page)
    l.Position = UDim2.fromOffset(5,y)
    l.Size = UDim2.new(1,-10,0,35)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = Color3.fromRGB(200,170,255)
    l.Font = Enum.Font.GothamBold
    l.TextSize = 15
    l.TextXAlignment = Enum.TextXAlignment.Left
    return l
end

makeLabel(home,"Welcome to DIAMOND UNIVERSAL!",5)
makeLabel(home,"Player: "..Player.Name,45)
makeLabel(home,"Game: "..game.Name,85)
makeLabel(home,"Universal utility hub",125)

makeLabel(playerPage,"PLAYER SETTINGS",5)

local speed = 16
makeButton(playerPage,"WalkSpeed +10",45,function()
    speed = math.min(speed + 10, 200)
    local h = getHumanoid()
    if h then h.WalkSpeed = speed end
end)

makeButton(playerPage,"WalkSpeed RESET",85,function()
    speed = 16
    local h = getHumanoid()
    if h then h.WalkSpeed = 16 end
end)

makeButton(playerPage,"JumpPower +20",125,function()
    local h = getHumanoid()
    if h then
        h.UseJumpPower = true
        h.JumpPower = h.JumpPower + 20
    end
end)

makeButton(playerPage,"Reset Character",165,function()
    local h = getHumanoid()
    if h then h.Health = 0 end
end)

makeLabel(visuals,"VISUAL SETTINGS",5)

local espEnabled = false
local highlights = {}

makeButton(visuals,"Toggle Player ESP",45,function()
    espEnabled = not espEnabled

    if not espEnabled then
        for _,v in pairs(highlights) do
            v:Destroy()
        end
        table.clear(highlights)
        return
    end

    for _,p in ipairs(Players:GetPlayers()) do
        if p ~= Player and p.Character then
            local h = Instance.new("Highlight")
            h.FillColor = Color3.fromRGB(160,70,255)
            h.OutlineColor = Color3.new(1,1,1)
            h.Adornee = p.Character
            h.Parent = gui
            highlights[p] = h
        end
    end
end)

makeLabel(utility,"UTILITY",5)

makeButton(utility,"Full Bright",45,function()
    Lighting.Brightness = 3
    Lighting.ClockTime = 14
    Lighting.GlobalShadows = false
end)

makeButton(utility,"Normal Lighting",85,function()
    Lighting.Brightness = 1
    Lighting.ClockTime = 14
    Lighting.GlobalShadows = true
end)

makeButton(utility,"Refresh Character",125,function()
    Player:LoadCharacter()
end)

-- FPS / PING
local stats = makeLabel(home,"FPS: -- | Ping: --",175)
local frames, elapsed = 0, 0

RunService.RenderStepped:Connect(function(dt)
    frames += 1
    elapsed += dt
    if elapsed >= 1 then
        local ping = "--"
        pcall(function()
            ping = tostring(math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())).." ms"
        end)
        stats.Text = "FPS: "..frames.." | Ping: "..ping
        frames = 0
        elapsed = 0
    end
end)

Players.PlayerAdded:Connect(function(p)
    if espEnabled then
        p.CharacterAdded:Connect(function(char)
            task.wait(1)
            if espEnabled then
                local h = Instance.new("Highlight")
                h.Adornee = char
                h.FillColor = Color3.fromRGB(160,70,255)
                h.Parent = gui
                highlights[p] = h
            end
        end)
    end
end)

print("[DIAMOND UNIVERSAL] Loaded!")

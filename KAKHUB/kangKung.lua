setfflag("HumanoidParallelRemoveNoPhysics", "False")
setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
setfflag("CrashPadUploadToBacktraceToBacktraceBaseUrl", "")
setfflag("CrashUploadToBacktracePercentage", "0")
setfflag("CrashUploadToBacktraceBlackholeToken", "")
setfflag("CrashUploadToBacktraceWindowsPlayerToken", "")

local Global_V = {} 
-- pcall(function()
--     local req = (syn and syn.request) or (http and http.request) or request;
--     local GetDataFormServer = req({
--         Url = 'http://kangisloser.xyz/GetData',
--         Method = 'POST',
--         Headers = {
--             ["Content-Type"] = "application/json"
--         };
--         Body = game:GetService('HttpService'):JSONEncode({
--             GameId = tostring(game.PlaceId)
--         }),
--     })
--     local Body = game:GetService("HttpService"):JSONDecode(GetDataFormServer.Body)
--     Global_V = {
--         Version_script = Body.Version,
--         Script_enabled = Body.ScriptEnabled
--     }
-- end)

-- if getgenv().IsKangDev == "Haachamaissocute!" then
    Global_V = {
        Version_script = "0.0.0 [In Development]";
        Script_enabled = true;
    }
-- end
if not Global_V.Script_enabled then
    return game.Players.LocalPlayer:Kick("Script was disabled.")
end
local Ui_Tab = {};
local Cache = {
    GlobalValue = {
        ListAllDevilFurits = loadstring(game:HttpGet("https://raw.githubusercontent.com/KangKung01/KangWinnerB/main/OPL/DevilFurit_Name.lua"))(),
        ListAllBox = {"Common Box", "Uncommon Box", "Rare Box", "Ultra Rare Box"},
        ListMods = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://raw.githubusercontent.com/KangKung01/KangWinnerB/main/OPL/ModsList.json"))
    },
    AutoDie = {},
    Hunter = {},
    Player = {},
    BringMonter = {},
    Teleport = {},
    FakeStats = {},
    Boolean = {}
}

local ToFullName = function(name)
    for i, v in pairs(game.Players:GetChildren()) do
        if tostring(name) == "@all" and v.Name ~= game.Players.LocalPlayer.Name then
            return v
        end
        if string.match(string.lower(v.Name), string.lower(tostring(name))) and v.Name ~= game.Players.LocalPlayer.Character then
            return v
        end
    end
    return
end

local KangFindNearest = function()
    local ObjectNearest;
    local NearestList = {};
    for i,v in pairs(game.Players:GetChildren()) do
        if v.Name ~= game.Players.LocalPlayer.Name and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 then
            table.insert(NearestList, v)
        end
    end
    if NearestList[1] ~= nil then
        ObjectNearest = NearestList[1]
    end
    if ObjectNearest ~= nil then
        for i,v in pairs(NearestList) do
            if (game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - v.Character:FindFirstChild("HumanoidRootPart").Position).magnitude <= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - ObjectNearest.Character:FindFirstChild("HumanoidRootPart").Position).magnitude then
                ObjectNearest = v
            end
        end
    end
    return ObjectNearest
end

local CreateESP = function(p, c)
    local Main = Instance.new("BillboardGui")
    local Title = Instance.new("TextLabel")
    
    Main.Name = "ESP"
    Main.Parent = p
    Main.AlwaysOnTop = true
    Main.LightInfluence = 1
    Main.MaxDistance = Cache.EspDistance
    Main.Size = UDim2.new(0, 25, 0, 25) 
    Main.StudsOffset = Vector3.new(0, 2, 0) 
    
    Title.Name = "Title"
    Title.Parent = Main  
    Title.BackgroundColor3 = Color3.new(1, 1, 1)
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, 0, 1, 0)
    Title.Text = tostring(c)
    Title.TextColor3 = Cache.Hunter.Espcolor or Color3.fromRGB(255, 255, 255)
    Title.TextSize = 11
    return Main
end



local Flux = loadstring(game:HttpGet"https://raw.githubusercontent.com/KangKung02/H2O/main/Flux_Ui.lua")();
local win = Flux:Window("Krypton Premium", "                  version : "..Global_V.Version_script, Color3.fromRGB(33, 30, 207), Enum.KeyCode.RightControl)
Ui_Tab["Farming beri"] = win:Tab("Farming beri", "http://www.roblox.com/asset/?id=6756586445")

Ui_Tab["Farming beri"]:Label("⭐ Player 1 gives life for Player 2 ⭐")

Ui_Tab["Farming beri"]:Line()

Ui_Tab["Farming beri"]:Label("⭐ Player 1⭐")
Ui_Tab["Farming beri"]:Button("Set Position", "set current position to confix.", function()
    local Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    Cache.AutoDie.Position = {
        x = Position.X,
        y = Position.Y,
        z = Position.Z;
    }
end)
Cache.AutoDie.SpawnPoint = {}
Ui_Tab["Farming beri"]:Button("Set Spawn Point", "set spawn point to position.", function()
    if Cache.AutoDie.Switched then
        for i, v in pairs(game.Workspace.Spawns:GetChildren()) do
            v.CFrame = Cache.AutoDie.SpawnPoint[i]
        end
        Cache.AutoDie.Switched = false
    else
        for _, v in pairs(game.Workspace.Spawns:GetChildren()) do
            local Position = Cache.AutoDie.Position
            if #Cache.AutoDie.SpawnPoint ~= 10 then
                table.insert(Cache.AutoDie.SpawnPoint, v.CFrame)
            end
            v.CFrame = CFrame.new(Vector3.new(Position.x, Position.y, Position.z))
        end
        Cache.AutoDie.Switched = true
    end
end)

Ui_Tab["Farming beri"]:Toggle("Start Sacrifice", "automatically spawn, die", false, function(Boolean)
    Cache.Boolean.StartSacrifice = Boolean
end)

Ui_Tab["Farming beri"]:Toggle("Start Sacrifice [Beta]", "automatically spawn, die", false, function(Boolean)
    Cache.Boolean.StartSacrificeBeta = Boolean
end)




Cache.AutoDie.Debug = 0
spawn(function()
    while wait(1) do
        if Cache.Boolean.StartSacrifice and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character.Humanoid ~= 0 and game.Players.LocalPlayer.Character:FindFirstChild("Drown") and game.Players.LocalPlayer.PlayerGui:FindFirstChild("Blindness") then
            pcall(function()
                repeat
                    wait()
                until game.Players.LocalPlayer.PlayerGui:FindFirstChild("Blindness")
                if game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y >= 20000 then
                    game.Players.LocalPlayer.Character.CamScript.ClientServerClient:FireServer()
                    game.Players.LocalPlayer.Character.Weapons:FireServer()
                    game.Players.LocalPlayer.Character.CharacterTrait.ClothingTrigger:FireServer()
                    Cache.AutoDie.Debug = 0
                    wait(3)
                else
                    wait(1)
                    for i = 1, 12 do
                        game.Players.LocalPlayer.Character.Drown:FireServer("NOPLS")
                        wait(0.01)
                    end
                    Cache.AutoDie.Debug += 1
                    if Cache.AutoDie.Debug >= 6 then
                        game.Players.LocalPlayer.Character.Humanoid:Destroy()
                        Cache.AutoDie.Debug = 0
                    end
                end
            end)
        end
    end
end)

spawn(function()
    while wait(3) do
        pcall(function()
            if Cache.Boolean.StartSacrificeBeta then
                if game.Players.LocalPlayer.PlayerGui.Load.Frame.Visible then
                    wait(3)
                    firesignal(game.Players.LocalPlayer.PlayerGui.Load.Frame.Load.MouseButton1Click)
                    wait(3)
                    repeat
                        game.Players.LocalPlayer.Character.Drown:FireServer("NOPLS")
                        wait(0.1)
                    until game.Players.LocalPlayer.PlayerGui.Load.Frame.Visible
                end
            end
        end)
    end
end)

Ui_Tab["Farming beri"]:Line()

Ui_Tab["Farming beri"]:Label("⭐ Player 2⭐")

Ui_Tab["Farming beri"]:Textbox("Player 1 Name", "in put player 1 name in here.", false, function(Value)
    Cache.AutoDie.Inputname = string.lower(tostring(Value))
end)

Ui_Tab["Farming beri"]:Button("Teleport To Player 1", "", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(ToFullName(Cache.AutoDie.Inputname).Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0))
end)

Ui_Tab["Farming beri"]:Button("Safe Zone", "", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(100000, 3500, 80000))
    local Base = Instance.new("Part", game.Workspace)
    Base.Size = Vector3.new(50, 1, 50)
    Base.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, -3, 0)
    Base.Anchored = true
end)



Ui_Tab["Hunter"] = win:Tab("Hunter", "http://www.roblox.com/asset/?id=6756586445")

Ui_Tab["Hunter"]:Label("⭐ Kill Someone And Steal Some Fruit! ⭐")

Ui_Tab["Hunter"]:Line()

Ui_Tab["Hunter"]:Label("⭐ Settings ⭐")

Ui_Tab["Hunter"]:Textbox("Taget's Name", "in put taget anem here (No need to type in full)", false, function(Value)
    Cache.Hunter.Inputname = string.lower(tostring(Value))
end)
if not Cache.Hunter.Inputdistance then
    Cache.Hunter.Inputdistance = 6
end
Ui_Tab["Hunter"]:Textbox("Distance", "", false, function(Value)
    Cache.Hunter.Inputdistance = tonumber(Value)
end)

--Ui_Tab["Hunter"]:Slider("Distance", "distance with taget.", -16, 16, 6,function(Value)
--    Cache.Hunter.Inputdistance = tonumber(Value)
--end)

Ui_Tab["Hunter"]:Textbox("Hit Box", "", false, function(Value)
    xpcall(function()
        Cache.Hunter.HitBoxSize = tonumber(Value) + 0
    end, function()
        Cache.Hunter.HitBoxSize = 20
    end)
end)


game:GetService("RunService").RenderStepped:Connect(function()
    pcall(function()
        if Cache.Hunter.HitBoxSize then
            for i, v in pairs(game.Players:GetChildren()) do
                if v.Character:FindFirstChild("HumanoidRootPart") and v.Name ~= game.Players.LocalPlayer.Name then
                    v.Character.HumanoidRootPart.Size = Vector3.new(Cache.Hunter.HitBoxSize, Cache.Hunter.HitBoxSize, Cache.Hunter.HitBoxSize)
                    v.Character.HumanoidRootPart.Transparency = 0.9
                    v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue")
                    v.Character.HumanoidRootPart.Material = "Neon"
                    v.Character.HumanoidRootPart.CanCollide = false
                end
            end
        end
    end)
end)

if not Cache.Hunter.Espmaximumdistance then
    Cache.Hunter.Espmaximumdistance = 6.02e23
end
Ui_Tab["Hunter"]:Textbox("Esp Maximum Distance", "", false, function(Value)
    Cache.Hunter.Espmaximumdistance = tonumber(Value)
end)

if not Cache.Hunter.Espcolor then
    Cache.Hunter.Espcolor = Color3.fromRGB(255, 255, 255)
end
Ui_Tab["Hunter"]:Colorpicker("Esp Color", Color3.fromRGB(255, 255, 255), function(Value)
    Cache.Hunter.Espcolor = Value
end)

if not Cache.Hunter.EspmaximumAimbot then
    Cache.Hunter.Aimbotmaximumdistance = 6.02e23
end

Ui_Tab["Hunter"]:Textbox("Aimbot Maximum Distance", "", false, function(Value)
    Cache.Hunter.Aimbotmaximumdistance = tonumber(Value)
end)

Ui_Tab["Hunter"]:Line()
Ui_Tab["Hunter"]:Label("⭐ About Taget ⭐")

Ui_Tab["Hunter"]:Toggle("Bring Taget", "", false, function(Boolean)
    Cache.Boolean.BringTaget = Boolean
end)

Ui_Tab["Hunter"]:Toggle("Teleport Taget", "", false, function(Boolean)
    Cache.Boolean.TeleportTaget = Boolean
end)

spawn(function()
    while wait() do
        pcall(function()
            local Ply = ToFullName(Cache.Hunter.Inputname)
            if Cache.Boolean.BringTaget then
                Ply.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2) + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * Cache.Hunter.Inputdistance
            end
            if Cache.Boolean.TeleportTaget then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =  Ply.Character.HumanoidRootPart.CFrame * CFrame.new(2, 0, 0) + Ply.Character.HumanoidRootPart.CFrame.lookVector * Cache.Hunter.Inputdistance
            end
        end)
    end
end)

Ui_Tab["Hunter"]:Toggle("View Player", "", false, function(Boolean)
    if Boolean then
        game.Workspace.CurrentCamera.CameraSubject = ToFullName(Cache.Hunter.Inputname).Character.Humanoid
    else
        game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
    end
end)

Ui_Tab["Hunter"]:Toggle("Aim Bot Taget", "", false, function(Boolean)
    Cache.Boolean.AimbotTaget = Boolean
end)

Ui_Tab["Hunter"]:Toggle("Esp Taget", "", false, function(Boolean)
    Cache.Boolean.EspTaget = Boolean
    if not Boolean then
        local Ply = ToFullName(Cache.Hunter.Inputname)
        if Ply and Ply.Character.HumanoidRootPart:FindFirstChild("ESP") then
            Ply.Character.HumanoidRootPart.ESP:Destroy()
        end
    end
end)

game:GetService("RunService").Stepped:Connect(function()
    pcall(function()
        if Cache.Boolean.AimbotTaget and ToFullName(Cache.Hunter.Inputname) and Cache.Hunter.Aimbotmaximumdistance >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - ToFullName(Cache.Hunter.Inputname).Character.HumanoidRootPart.Position).Magnitude then
            game.Workspace.CurrentCamera.CoordinateFrame = CFrame.new(game.Workspace.CurrentCamera.CoordinateFrame.Position, ToFullName(Cache.Hunter.Inputname).Character.HumanoidRootPart.CFrame.Position)
        end
        if Cache.Boolean.EspTaget then
            local Ply = ToFullName(Cache.Hunter.Inputname)
            if Ply and Cache.Hunter.Espmaximumdistance >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Ply.Character.HumanoidRootPart.Position).Magnitude then
                if Ply.Character.HumanoidRootPart:FindFirstChild("ESP") then
                    Ply.Character.HumanoidRootPart.ESP:Destroy()
                end
                CreateESP(Ply.Character.HumanoidRootPart, string.format("Name : %s\nDistance : %s", Ply.Name, math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Ply.Character.HumanoidRootPart.Position).Magnitude)))
            end
        end
    end)
end)

Ui_Tab["Hunter"]:Line()
Ui_Tab["Hunter"]:Label("⭐ Other ⭐")

Ui_Tab["Hunter"]:Button("View Evenyone", "", function()
    for _, v in pairs(game.Players:GetChildren()) do
        if v.Name ~= game.Players.LocalPlayer.Name and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") then
            local ESP = CreateESP(v.Character.HumanoidRootPart, string.format("Name : %s\nDistance : %s", v.Name, math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude)))
            game.Workspace.CurrentCamera.CameraSubject = v.Character.Humanoid
            wait(0.7)
            ESP:Destroy()
        end
    end
    wait(0.7)
    game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
end)

Ui_Tab["Hunter"]:Toggle("Esp Evenyone", "", false, function(Boolean)
    Cache.Boolean.EspEveryone = Boolean
    if not Boolean then
        for i, v in pairs(game.Players:GetChildren()) do
            if v.Name ~= game.Players.LocalPlayer.Name then
                local Ply = v
                if Ply and Ply.Character.HumanoidRootPart:FindFirstChild("ESP") then
                    Ply.Character.HumanoidRootPart.ESP:Destroy()
                end
            end
        end
    end
end)

Ui_Tab["Hunter"]:Toggle("Aim Bot nearest", "", false, function(Boolean)
    Cache.Boolean.Aimbotnearest = Boolean
end)

game:GetService("RunService").Stepped:Connect(function()
    pcall(function()
        if Cache.Boolean.Aimbotnearest and KangFindNearest() and Cache.Hunter.Aimbotmaximumdistance >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - KangFindNearest().Character.HumanoidRootPart.Position).Magnitude then
            game.Workspace.CurrentCamera.CoordinateFrame = CFrame.new(game.Workspace.CurrentCamera.CoordinateFrame.Position, KangFindNearest().Character.HumanoidRootPart.CFrame.Position)
        end
        if Cache.Boolean.EspEveryone then
            local Ply = ToFullName(Cache.Hunter.Inputname)
            for i, v in pairs(game.Players:GetChildren()) do
                if v.Name ~= game.Players.LocalPlayer.Name then
                    local Ply = v
                    if Ply and Cache.Hunter.Espmaximumdistance >= (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Ply.Character.HumanoidRootPart.Position).Magnitude then
                        if Ply.Character.HumanoidRootPart:FindFirstChild("ESP") then
                            Ply.Character.HumanoidRootPart.ESP:Destroy()
                        end
                        CreateESP(Ply.Character.HumanoidRootPart, string.format("Name : %s\nDistance : %s", Ply.Name, math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Ply.Character.HumanoidRootPart.Position).Magnitude)))
                    end    
                end
            end
        end
    end)
end)

Ui_Tab["Hunter"]:Button("Check inventory", "", function()
    print("------------------------------------")
    print("↓↓↓ In inventory ↓↓↓")
    for _,v in pairs(game.Players:GetChildren()) do
        if v.Name ~= game.Players.LocalPlayer.Name then
            for _,x in pairs(v.Backpack:GetChildren()) do
                if x.ClassName == "Tool" then
                    if table.find(Cache.GlobalValue.ListAllDevilFurits,x.Name) then
                        print(string.format("**Fruit Name : %s Owner : %s**", x.Name, v.Name))
                    elseif string.find(string.lower(x.Name), string.lower("Fruit")) then
                        print(string.format("Fruit Name : %s Owner : %s", x.Name, v.Name))
                    end
                end
            end
        end
    end
    print("↓↓↓ In Ground ↓↓↓")
    for i,v in pairs(game.Workspace.Trees.Tree.Model:GetChildren()) do
        if v.ClassName == "Tool" then
            if table.find(Cache.GlobalValue.ListAllDevilFurits,v.Name) then
                print(string.format("**Fruit Name : %s Owner : %s**", v.Name, "None"))
            elseif string.find(string.lower(v.Name), string.lower("Fruit")) then
                print(string.format("Fruit Name : %s Owner : %s", v.Name, "None"))
            end
        end
    end
    print("↓↓↓ In Hand ↓↓↓")
    for _,p in pairs(game.Players:GetChildren()) do
        if p.Name ~= game.Players.LocalPlayer.Name then
            for _,v in pairs(p.Character:GetChildren()) do
                if v.ClassName == "Tool" then
                    if table.find(Cache.GlobalValue.ListAllDevilFurits,v.Name) then
                        print(string.format("**Fruit Name : %s Owner : %s**", v.Name, p.Name))
                    elseif string.find(string.lower(v.Name), string.lower("Fruit")) then
                        print(string.format("Fruit Name : %s Owner : %s", v.Name, p.Name))
                    end        
                end
            end
        end
    end
    print("↓↓↓ In Pedestal ↓↓↓")
    for _,path in pairs (game:GetService("Workspace").Island14.PedestalSpots:GetChildren()) do
        for _,v in pairs (path:GetChildren()) do 
            if table.find(Cache.GlobalValue.ListAllDevilFurits,v.Name) then
                print(string.format("**Fruit Name : %s Owner : %s**", v.Name, "None"))
            elseif string.find(string.lower(v.Name), string.lower("Fruit")) then
                print(string.format("Fruit Name : %s Owner : %s", v.Name, "None"))
            end
        end
    end
    print("↓↓↓ In Rebirth Pedestal ↓↓↓")
    for _,v in pairs (game:GetService("Workspace").Altar.FruitReceptical:GetChildren()) do 
        if table.find(Cache.GlobalValue.ListAllDevilFurits,v.Name) then
            print(string.format("**Fruit Name : %s Owner : %s**", v.Name, "None"))
        elseif string.find(string.lower(v.Name), string.lower("Fruit")) then
            print(string.format("Fruit Name : %s Owner : %s", v.Name, "None"))
        end
    end
    print("------------------------------------")
end)

Ui_Tab["Hunter"]:Toggle("Loot Devil Fruit", "", false, function(Boolean)
    Cache.Boolean.LootDevilFurit = Boolean
end)

Ui_Tab["Hunter"]:Toggle("Loot Box", "", false, function(Boolean)
    Cache.Boolean.LootBox = Boolean
end)

Ui_Tab["Hunter"]:Toggle("Loot Compass", "", false, function(Boolean)
    Cache.Boolean.LootCompass = Boolean
end)

Ui_Tab["Hunter"]:Toggle("Loot Drink", "", false, function(Boolean)
    Cache.Boolean.LootDrink = Boolean
end)

spawn(function()
    while wait() do
        pcall(function()
            if Cache.Boolean.LootDevilFurit then
                for i, v in pairs(game.Workspace.Trees.Tree.Model:GetChildren()) do
                    if v.ClassName == "Tool" then
                        fireclickdetector(v.Main.ClickDetector)
                    end
                end
            end
            if Cache.Boolean.LootBox then
                for i, v in pairs(game.Workspace:GetChildren()) do
                    if string.match(v.Name, "Box") and v:FindFirstChild("Handle") then
                        v.Handle.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
                    end
                end
            end
            if Cache.Boolean.LootCompass then
                for i, v in pairs(game.Workspace:GetChildren()) do
                    if v.Name == "Compass" and v:FindFirstChild("Handle") then
                        v.Handle.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
                    end
                end
            end
        end)
        if Cache.Boolean.LootDrink then
            local Drinks = {"Cider+", "Lemonade+", "Juice+", "Smoothie+"}
            for i, v in pairs(game.Workspace:GetChildren()) do
                if table.find(Drinks, v.Name) and v:FindFirstChild("Handle") then
                    v.Handle.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
                end
            end
        end
    end
end)

Ui_Tab["Hunter"]:Line()
Ui_Tab["Hunter"]:Label("⭐ Server Hop ⭐")

Ui_Tab["Hunter"]:Button("Send JobId To Clipboard", "", function()
    setclipboard(game.JobId)
end)

Ui_Tab["Hunter"]:Textbox("Input JobId", "input you job id using for hop server.", true, function(Value)
    Cache.Hunter.Inputjobid = tostring(Value)
end)

Ui_Tab["Hunter"]:Button("Join Server", "", function()
    game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, Cache.Hunter.Inputjobid)
end)

Ui_Tab["Hunter"]:Button("Hop Server With Random", "", function()
    local NotSameServer
    xpcall(function()
        NotSameServer = game:GetService('HttpService'):JSONDecode(readfile('NotSameServer.json'))
        if #NotSameServer >= 5 then
            NotSameServer = {}
        end
        writefile('NotSameServer.json', game:GetService('HttpService'):JSONEncode(NotSameServer))
    end, function()
        NotSameServer = {}
        writefile('NotSameServer.json', game:GetService('HttpService'):JSONEncode(NotSameServer))
    end)

    local ServerList, Server = {}
    pcall(function()
        Server = game:GetService('HttpService'):JSONDecode(game:HttpGet(string.format('https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100', game.PlaceId)))
    end)
    
    
    pcall(function()
        for _, v in pairs(Server.data) do
            if not table.find(NotSameServer, v.id) and v.maxPlayers ~= v.playing then
                table.insert(ServerList, v.id)
            end
        end
    end)
    
    if #ServerList == 0 then
        game:GetService('TeleportService'):Teleport(game.PlaceId)
    end
    
    repeat
        game.StarterGui:SetCore('SendNotification', {
            Title = "README UWU",
            Text = "Rejoining!",
            Icon = "rbxassetid://6756586445",
            Duration = 5,
        })
        local ServerID = ServerList[math.random(1, #ServerList)]
        table.insert(NotSameServer, ServerID)
        writefile('NotSameServer.json', game:GetService('HttpService'):JSONEncode(NotSameServer))
        wait(3)
        game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, ServerID)
        wait(10)
    until not game.Players  
end)

Ui_Tab["Players"] = win:Tab("Players", "http://www.roblox.com/asset/?id=6756586445")
Ui_Tab["Players"]:Label("⭐ Enjoy! ⭐")
Ui_Tab["Players"]:Line()

Ui_Tab["Players"]:Label("⭐ Fishing ⭐")

Ui_Tab["Players"]:Dropdown("Select Rod", {"Wood Rod", "Sturdy Rod", "Super Rod"}, function(DropDown)
    Cache.Player.SelectRod  = tostring(DropDown)
end)

Ui_Tab["Players"]:Toggle("Auto Fishing", "", false, function(Boolean)
    Cache.Boolean.AutoFishing = Boolean
end)

spawn(function()
    while wait() do
        pcall(function()
            if Cache.Boolean.AutoFishing then
                if not game.Players.LocalPlayer.Character:FindFirstChild(Cache.Player.SelectRod) then
                    game.Players.LocalPlayer.Backpack:FindFirstChild(Cache.Player.SelectRod).Parent = game.Players.LocalPlayer.Character
                else
                    if game.Players.LocalPlayer.Character[Cache.Player.SelectRod].Cast:FindFirstChild("Bobber") then
                        if game.Players.LocalPlayer.Character[Cache.Player.SelectRod].Cast.Bobber.Effect.Enabled then
                            game:GetService("Players").LocalPlayer.Character[Cache.Player.SelectRod].Click:FireServer((game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5) + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 13).Position)
                        end
                    else
                        game:GetService("Players").LocalPlayer.Character[Cache.Player.SelectRod].Click:FireServer((game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5) + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 13).Position)
                    end
                end
            end
        end)
    end
end)

Ui_Tab["Players"]:Line()
Ui_Tab["Players"]:Label("⭐ Drinking ⭐")

Ui_Tab["Players"]:Dropdown("Select Drink", {"Cider+", "Lemonade+", "Juice+", "Smoothie+"}, function(DropDown)
    Cache.Player.SelectDrink  = tostring(DropDown)
end)

Ui_Tab["Players"]:Textbox("Amount Drink", "", false, function(Value)
    Cache.Player.DrinkAmount = tonumber(Value)
end)

Ui_Tab["Players"]:Button("Buy Drink", "", function()
    for i = 1, Cache.Player.DrinkAmount do
        game.Workspace.Merchants.BetterDrinkMerchant.Clickable.Retum:FireServer(Cache.Player.SelectDrink)
    end
end)

Ui_Tab["Players"]:Toggle("Auto Drink", "", false, function(Boolean)
    Cache.Boolean.AutoDrink = Boolean
end)

Ui_Tab["Players"]:Toggle("Auto Drop Drink", "", false, function(Boolean)
    Cache.Boolean.AutoDropDrink = Boolean
end)

spawn(function()
    while wait() do
        pcall(function()
            local Drinks = {"Cider+", "Lemonade+", "Juice+", "Smoothie+"}
            if Cache.Boolean.AutoDrink then
                for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if table.find(Drinks, v.Name) then
                        game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                        v.Parent = game.Players.LocalPlayer.Character
                        v:Activate()
                    end
                end
            end
            if Cache.Boolean.AutoDropDrink then
                for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if table.find(Drinks, v.Name) then
                        game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                        v.Parent = game.Players.LocalPlayer.Character
                        v.Parent = game.Workspace
                    end
                end
            end
        end)
    end
end)
Ui_Tab["Players"]:Line()
Ui_Tab["Players"]:Label("⭐ Auto Attack ⭐")

Ui_Tab["Players"]:Textbox("Tools Name", "", false, function(Value)
    for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v.ClassName == "Tool" and string.match(string.lower(v.Name), string.lower(tostring(Value))) then
            Cache.Player.Inputtoolname = v.Name
        end
    end
    for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v.ClassName == "Tool" and string.match(string.lower(v.Name), string.lower(tostring(Value))) then
            Cache.Player.Inputtoolname = v.Name
        end
    end
end)

Ui_Tab["Players"]:Toggle("Auto Equip Tool", "" , false, function(Value)
    Cache.Boolean.AutoEquipTool = Value
end)

Ui_Tab["Players"]:Toggle("Auto Activate Tool", "" , false, function(Value)
    Cache.Boolean.AutoActivateTool = Value
end)

spawn(function()
    while wait() do
        pcall(function()
            if Cache.Boolean.AutoEquipTool and not game.Players.LocalPlayer.Character:FindFirstChild(Cache.Player.Inputtoolname) then
                game.Players.LocalPlayer.Backpack:FindFirstChild(Cache.Player.Inputtoolname).Parent = game.Players.LocalPlayer.Character
            end
            if Cache.Boolean.AutoActivateTool and game.Players.LocalPlayer.Character:FindFirstChild(Cache.Player.Inputtoolname) then
                game.Players.LocalPlayer.Character:FindFirstChild(Cache.Player.Inputtoolname):Activate()
            end
        end)
    end
end)


Ui_Tab["Players"]:Line()
Ui_Tab["Players"]:Label("⭐ Auto Keyboard ⭐")

Cache.Player.DelayOfAutoKeyboard = 0
Ui_Tab["Players"]:Textbox("Delay", "", false, function(Value)
    xpcall(function()
        Cache.Player.DelayOfAutoKeyboard = tonumber(Value) + 0
    end, function()
        Cache.Player.DelayOfAutoKeyboard = 0
    end)
end)

Cache.Player.KeyboardKey = {}
for i = 1, 5 do
    Ui_Tab["Players"]:Textbox("Keyboard Keys :", "", false, function(Value)
        Cache.Player.KeyboardKey[i] = string.upper(tostring(Value))
    end)
end

Ui_Tab["Players"]:Toggle("Auto Keyboard", "input space for stop." , false, function(Value)
    Cache.Boolean.AutoKeyboardPress = Value
end)

spawn(function()
    while wait() do
        pcall(function()
            if Cache.Boolean.AutoKeyboardPress then
                wait(Cache.Player.DelayOfAutoKeyboard)
                for _, Value in pairs(Cache.Player.KeyboardKey) do
                    if Value ~= " " or Value ~= "" then
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, Value, false, game)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, Value, false, game)                  
                    end
                    wait(0.1)
                end
            end
        end)
    end
end)

Ui_Tab["Players"]:Line()
Ui_Tab["Players"]:Label("⭐ Auto Haki ⭐")

Cache.Player.HakiLimit_Min = 50
Cache.Player.HakiLimit_Max = 50

Ui_Tab["Players"]:Slider("Haki Limit Minimal", "Haki function will stop only when haki limit more then haki energy", 0, 99, 50,function(Value)
    Cache.Player.HakiLimit_Min = tonumber(Value)
end)
Ui_Tab["Players"]:Slider("Haki Limit Maximum", "Haki function will working only when haki limit more then haki energy", 0, 99, 50,function(Value)
    Cache.Player.HakiLimit_Max = tonumber(Value)
end)


Ui_Tab["Players"]:Toggle("Auto Use Buso Haki", "" , false, function(Value)
    Cache.Boolean.AutoUseBusoHaki = Value
end)

Ui_Tab["Players"]:Toggle("Auto Use Kenbunshoku Haki", "" , false, function(Value)
    Cache.Boolean.AutoUseKenbunshokuHaki = Value
end)
spawn(function()
    while wait() do
        pcall(function()
            if Cache.Boolean.AutoUseBusoHaki then
                if not game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].UsingHaki.Value and game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].HakiBar.Value >= game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].Data.HakiLevel.Value / 100 * Cache.Player.HakiLimit_Max then
                    game.Workspace.UserData["User_"..game.Players.LocalPlayer.UserId].UpdateHaki:FireServer()
                    wait(3)
                elseif game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].UsingHaki.Value and game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].HakiBar.Value <= game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].Data.HakiLevel.Value / 100 * Cache.Player.HakiLimit_Min then
                    game.Workspace.UserData["User_"..game.Players.LocalPlayer.UserId].UpdateHaki:FireServer()
                    wait(3)
                end
            end
        end)
    end
end)

spawn(function()
    while wait(0.1) do
        pcall(function()
            if Cache.Boolean.AutoUseKenbunshokuHaki then
                if game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].HakiBar.Value >= game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].Data.HakiLevel.Value / 100 * Cache.Player.HakiLimit_Max then
                    game.Workspace.UserData["User_"..game.Players.LocalPlayer.UserId].III:FireServer("On", game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].Data.HakiLevel.Value)
                elseif game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].HakiBar.Value <= game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].Data.HakiLevel.Value / 100 * Cache.Player.HakiLimit_Min then
                    game.Workspace.UserData["User_"..game.Players.LocalPlayer.UserId].III:FireServer("On", game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].Data.HakiLevel.Value)
                    game.Workspace.UserData["User_"..game.Players.LocalPlayer.UserId].III:FireServer("Off", game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].Data.HakiLevel.Value)
                end
            end
        end)
    end
end)

spawn(function()
    while wait(0.1) do
        pcall(function()
            if Cache.Boolean.AutoUseKenbunshokuHaki then
                local OldHaki = game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].HakiBar.Value
                if OldHaki == game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].Data.HakiLevel.Value then
                    return
                end
                wait(4.4)
                if OldHaki == game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].HakiBar.Value then
                    game.Workspace.UserData["User_"..game.Players.LocalPlayer.UserId].III:FireServer("On", game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].Data.HakiLevel.Value)
                    wait(2)
                    game.Workspace.UserData["User_"..game.Players.LocalPlayer.UserId].III:FireServer("Off", game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].Data.HakiLevel.Value)
                    wait(5)
                end
            end
        end)
    end
end)
Ui_Tab["Players"]:Line()
Ui_Tab["Players"]:Label("⭐ Basic ⭐")

Ui_Tab["Players"]:Toggle("Anti AFK", "" , true, function(Value)
    Cache.Boolean.AntiAFK = Value
end)

Ui_Tab["Players"]:Toggle("Anti Mods", "" , false, function(Value)
    Cache.Boolean.AntiMods = Value
end)

Ui_Tab["Players"]:Toggle("Infinite jump", "" , false, function(Value)
    Cache.Boolean.InfiniteJump = Value
end)

Ui_Tab["Players"]:Toggle("No Clip", "" , false, function(Boolen)
    Cache.Boolean.NoClip = Boolen
end)

Ui_Tab["Players"]:Bind("Keypress Teleport", Enum.KeyCode.P, function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position + Vector3.new(0, 3, 0))
end)

Ui_Tab["Players"]:Button("Safe Zone", "", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(50000, 3500, 80000))
    local Base = Instance.new("Part", game.Workspace)
    Base.Size = Vector3.new(50, 1, 50)
    Base.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, -3, 0)
    Base.Anchored = true
end)

game:GetService("RunService").Stepped:Connect(function()
    if Cache.Boolean.NoClip and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
    end
end)

game:GetService("Players").LocalPlayer.Idled:Connect(function()
    if Cache.Boolean.AntiAFK then
        game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait()
        game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)    
    end
end)

game:GetService("RunService").Stepped:Connect(function()
    if Cache.Boolean.AntiMods then
        for i, v in pairs(game.Players:GetChildren()) do
            if table.find(Cache.GlobalValue.ListMods, v.Name) then
                game.Players.LocalPlayer:Kick("Auto Mods :\n I Saw Some Mods Here!")
            end
        end
    end
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if Cache.Boolean.InfiniteJump then
        game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

Ui_Tab["Players"]:Line()
Ui_Tab["Players"]:Label("⭐ Farming ⭐")

Ui_Tab["Players"]:Toggle("Auto Collect Chest", "" , false, function(Value)
    Cache.Boolean.AutoCollectChest = Value
end)

Ui_Tab["Players"]:Toggle("Auto Get Mission", "" , false, function(Value)
    Cache.Boolean.AutoGetMission = Value
end)

Ui_Tab["Players"]:Toggle("Auto Fishing Quest", "" , false, function(Value)
    Cache.Boolean.AutoFishingQuest = Value
end)


Ui_Tab["Players"]:Toggle("Auto Sam Quest", "" , false, function(Value)
    Cache.Boolean.AutoSamQuest = Value
end)

Ui_Tab["Players"]:Toggle("Auto Compass Quest", "" , false, function(Value)
    Cache.Boolean.AutoCompassQuest = Value
end)

Ui_Tab["Players"]:Toggle("Auto Unbox Box", "" , false, function(Value)
    Cache.Boolean.AutoUnboxBox = Value
end)

Ui_Tab["Players"]:Toggle("Auto Claim Hourly Reward", "" , false, function(Value)
    Cache.Boolean.AutoClaimHourlyReward = Value
end)

Ui_Tab["Players"]:Toggle("Auto Claim Daily Reward", "" , false, function(Value)
    Cache.Boolean.AutoClaimDailyReward = Value
end)

Ui_Tab["Players"]:Toggle("Auto Farm Juice", "" , false, function(Value)
    Cache.Boolean.AutoFarmJuice = Value
end)

Ui_Tab["Players"]:Toggle("Auto Drink Everything", "" , false, function(Value)
    Cache.Boolean.AutoDrinkEverything = Value
end)

spawn(function()
    while wait() do
        pcall(function()
            if Cache.Boolean.AutoCollectChest then
                for _, v1 in pairs(game.Workspace:GetDescendants()) do
                    if v1.Name == "TouchInterest" and v1.Parent.Name == "TreasureChestPart" and v1.Parent.Parent.Name == "TreasureChest" then
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v1.Parent, 0)
                    end
                end
                wait(5)
            end
        end)
    end
end)

spawn(function()
    while wait(2) do
        pcall(function()
            if Cache.Boolean.AutoGetMission and game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].Data.MissionObjective.Value == "None" then
                game.Workspace.Merchants.ExpertiseMerchant.Clickable.Retum:FireServer()
            end
        end)
    end
end)

spawn(function()
    while wait() do
        pcall(function()
            if Cache.Boolean.AutoFishingQuest then
                if game:GetService("Workspace").Merchants.QuestFishMerchant.Clickable:FindFirstChild("BillboardGui").TextLabel.Text == "" then
                    game.Workspace.Merchants.QuestFishMerchant.Clickable.Retum:FireServer()
                end
                local Package = game.Players.LocalPlayer.Backpack:FindFirstChild("Package");
                if Package then
                    local OldPostiton = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                    Package.Parent = game.Players.LocalPlayer.Character
                    for _, v in pairs(game.Workspace.Merchants:GetChildren()) do
                        if v:FindFirstChild("HumanoidRootPart") then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.HumanoidRootPart.Position) * CFrame.new(0, 2, 0) + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 2
                            Package:Activate()
                            if not game.Players.LocalPlayer.Character:FindFirstChild("Package") then
                                break
                            end
                            wait(0.2)
                        end
                    end
                    game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                    wait(1)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(OldPostiton)

                end
            end
        end)
    end
end)

spawn(function()
    while wait(2) do
        pcall(function()
            if Cache.Boolean.AutoSamQuest then
                game.Workspace.Merchants.QuestMerchant.Clickable.Retum:FireServer("Claim1");
            end
        end)
    end
end)

spawn(function()
    while wait(0.1) do
        pcall(function()
            if Cache.Boolean.AutoCompassQuest then
                local Compass = game.Players.LocalPlayer.Backpack:FindFirstChild("Compass")
                local Compass2 = game.Players.LocalPlayer.Character:FindFirstChild("Compass")
                if Compass or Compass2 then
                    local OldPostiton = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                    Compass.Parent = game.Players.LocalPlayer.Character
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Compass.Poser.Value)
                    Compass:Activate()
                    wait(1)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(OldPostiton)
                end
            end
        end)
    end
end)

spawn(function()
    while wait(0.1) do
        pcall(function()
            if Cache.Boolean.AutoUnboxBox then
                for _, Value in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if table.find(Cache.GlobalValue.ListAllBox, Value.Name) then
                        game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                        Value.Parent = game.Players.LocalPlayer.Character
                        Value:Activate()
                    end
                end
            end
        end)
    end
end)

spawn(function()
    while wait(0.1) do
        pcall(function()
            if Cache.Boolean.AutoClaimHourlyReward then
                game.Workspace.UserData["User_"..game.Players.LocalPlayer.UserId].ClaimRewardHourly:FireServer("RewardMark")
            end
            if Cache.Boolean.AutoClaimDailyReward then
                game.Workspace.UserData["User_"..game.Players.LocalPlayer.UserId].ClaimRewardDaily:FireServer("RewardMark")
            end
        end)
    end
end)

spawn(function()
    while wait(0.1) do
        pcall(function()
            if Cache.Boolean.AutoFarmJuice then
                for _, v in pairs(game:GetService("Workspace").Barrels.Barrels:GetChildren()) do
                    if v:FindFirstChild("ClickDetector") then
                        fireclickdetector(v.ClickDetector)
                    end
                    wait(0.1)
                    for _, v in pairs(game:GetService("Workspace").Island8.Kitchen:GetChildren()) do
                        if v.Name == "Folder" and v:FindFirstChild("JuicingBowl") then
                            fireclickdetector(v.JuicingBowl.Bowl.ClickDetector)
                        end
                    end              
                end
            end
        end)
    end
end)

spawn(function()
    while wait(0.1) do
        pcall(function()
            if Cache.Boolean.AutoDrinkEverything then
                local Drinks = {"Cider", "Lemonade", "Juice", "Smoothie", "Milk", "Golden Apple"}
                for _, v1 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    for _, v2 in pairs(Drinks) do
                        if string.match(v1.Name, v2) then
                            game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                            v1.Parent = game.Players.LocalPlayer.Character
                            v1:Activate()
                        end
                    end
                end
            end
        end)
    end
end)

Ui_Tab["Players"]:Line()
Ui_Tab["Players"]:Label("⭐ Spam Skill ⭐")



local GetPowerFruitForKey = function(InputKey)
    local Export = {};
    local TableOfKey = {
        A = 1,
        B = 2,
        C = 3,
        D = 4,
        E = 5,
        F = 6
    }
    for _, v in pairs(game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].Data:GetChildren()) do
        if v.Name:find("Basic_DF") and v.Value == string.upper(InputKey) then
            Export[1] = TableOfKey[v.Name:split("")[10]]
            Export[2] = 1
            if v.Name:match("%d") == "2" then
                Export[1] += 6
                Export[2] = 2
            end
        end
    end
    return Export;
end
Ui_Tab["Players"]:Textbox("Skill Key", "", false, function(Value)
    Cache.Player.FruitKeyboard, Cache.Player.NumberFruit = unpack(GetPowerFruitForKey(Value))
    if Cache.Player.NumberFruit == 1 then
        Cache.Player.SpamSkillFruit = game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].Data.DevilFruit.Value
    elseif Cache.Player.NumberFruit == 2 then
        Cache.Player.SpamSkillFruit = game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].Data.DevilFruit2.Value
    end
end)

Cache.Player.DelaySkill = 0.0001
Ui_Tab["Players"]:Textbox("Delay", "", false, function(Value)
    xpcall(function()
        Cache.Player.DelaySkill  = tonumber(Value)
    end, function()
        Cache.Player.DelaySkill  = 0.000001
    end)
end)

Ui_Tab["Players"]:Textbox("Skill Charge", "", false, function(Value)
    Cache.Player.SelectCharge_SpamSkill  = tonumber(Value)
end)

Ui_Tab["Players"]:Toggle("Spam Skill", "", false, function(Value)
    Cache.Boolean.StartSpamSkill = Value
if Cache.Player.SpamSkillFruit == "Magma" then
    Cache.Player.FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[Cache.Player.SpamSkillFruit])["VTCmel"]
elseif Cache.Player.SpamSkillFruit == "Gas" then
    Cache.Player.FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[Cache.Player.SpamSkillFruit])["VTCtb"]
elseif Cache.Player.SpamSkillFruit == "Sand" then
    Cache.Player.FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[Cache.Player.SpamSkillFruit])["VTCaufn"]
elseif Cache.Player.SpamSkillFruit == "Dark" then
    Cache.Player.FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[Cache.Player.SpamSkillFruit])["VTCjebaj"]
elseif Cache.Player.SpamSkillFruit == "Chilly" then
    Cache.Player.FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[Cache.Player.SpamSkillFruit])["VTCewddsfe"]
elseif Cache.Player.SpamSkillFruit == "Rumble" then
    Cache.Player.FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[Cache.Player.SpamSkillFruit])["VTCzyhf"]    
elseif Cache.Player.SpamSkillFruit == "Snow" then
    Cache.Player.FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[Cache.Player.SpamSkillFruit])["VTCqkxtn"]
elseif Cache.Player.SpamSkillFruit == "Light" then
    Cache.Player.FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[Cache.Player.SpamSkillFruit])["VTCrv"]
elseif Cache.Player.SpamSkillFruit == "String" then
    Cache.Player.FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[Cache.Player.SpamSkillFruit])["VTCjwbvx"]
elseif Cache.Player.SpamSkillFruit == "Flare" then
    Cache.Player.FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[Cache.Player.SpamSkillFruit])["VTCmgwcm"]
elseif Cache.Player.SpamSkillFruit == "Love" then
    Cache.Player.FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[Cache.Player.SpamSkillFruit])["VTCwxt"]
elseif Cache.Player.SpamSkillFruit == "Phoenix" then
    Cache.Player.FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[Cache.Player.SpamSkillFruit])["VTCytb"]
elseif Cache.Player.SpamSkillFruit == "Quake" then
    Cache.Player.FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[Cache.Player.SpamSkillFruit])["VTCebvc"]
elseif Cache.Player.SpamSkillFruit == "Candy" then
    Cache.Player.FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[Cache.Player.SpamSkillFruit])["VTCdhabvd"]
elseif Cache.Player.SpamSkillFruit == "Bomb" then
    Cache.Player.FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[Cache.Player.SpamSkillFruit])["VTCcpkghc"]
elseif Cache.Player.SpamSkillFruit == "Venom" then
    Cache.Player.FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[Cache.Player.SpamSkillFruit])["VTCiuew"]
elseif Cache.Player.SpamSkillFruit == "Rumble1" then
    Cache.Player.FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[Cache.Player.SpamSkillFruit])["VTCwnuy"]
elseif Cache.Player.SpamSkillFruit == "Gravity" then
    Cache.Player.FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[Cache.Player.SpamSkillFruit])["VTCjh"]
elseif Cache.Player.SpamSkillFruit == "Plasma" then
    Cache.Player.FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[Cache.Player.SpamSkillFruit])["VTCpwd"]
end    
end)


local FindFruitArgumet = loadstring(game:HttpGet'https://pastebin.com/raw/zF1YYPRL')();


local GetingSkillArgumet = function(Arg1)
    if Arg1 == "M_H" then
        return game.Players.LocalPlayer:GetMouse().Hit;
    elseif Arg1 == "M_T" then
        return game.Players.LocalPlayer:GetMouse().Target;
    elseif Arg1 == "C" then
        return Cache.Player.SelectCharge_SpamSkill or 100;
    elseif Arg1 == "nil" then
        return false;
    elseif Arg1 == "CM" then
        return "Left";
    elseif Arg1 == "M_H_P" then
        return game.Players.LocalPlayer:GetMouse().Hit.Position;
    elseif Arg1 == "ARM_P" then
        return game.Players.LocalPlayer.Character["Right Arm"].Position;
    elseif Arg1 == "HRP_P" then
        return game.Players.LocalPlayer.Character.HumanoidRootPart.Position;
    elseif Arg1 == "DS_SL" then
        return game.Workspace.UserData["User_"..game.Players.LocalPlayer.UserId].Data.SniperLevel.Value;
    elseif Arg1 == "DS_DL" then
        return game.Workspace.UserData["User_"..game.Players.LocalPlayer.UserId].Data.DefenseLevel.Value;
    elseif Arg1 == "GT" then
        local AllPlayers = {};
        for i, v in pairs(game.Players:GetChildren()) do
            if v.Name ~= game.Players.LocalPlayer.Name and  (game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - v.Character:FindFirstChild("HumanoidRootPart").Position).magnitude < 1000 then
                table.insert(AllPlayers, v)
            end
        end
        return AllPlayers;
    elseif Arg1 == "C_GDP" then
        local function GetDotPoint()
            local v45 = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 1000, 0);
            local v46, v47, v48 = workspace:FindPartOnRay(Ray.new(v45, (game.Players.LocalPlayer:GetMouse().Hit.p - v45).unit * 5000), game.Players.LocalPlayer.Character);
            return v47;
        end;
        return CFrame.new(GetDotPoint());
    end
end

spawn(function()
    while wait(Cache.Player.DelaySkill) do
        pcall(function()
            if Cache.Boolean.StartSpamSkill and game.Players.LocalPlayer.Character:FindFirstChild("Powers") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                if Cache.Player.FruitKeyArgumet then
                    local FuritTypeArgument = FindFruitArgumet:Get(Cache.Player.SpamSkillFruit);
                    game:GetService("Players").LocalPlayer.Character.Powers[Cache.Player.SpamSkillFruit].RemoteEvent:FireServer(
                        Cache.Player.FruitKeyArgumet,
                        string.format("%sPower%s", Cache.Player.SpamSkillFruit, Cache.Player.FruitKeyboard),
                        "StartCharging",
                        CFrame.new(game.Players.LocalPlayer:GetMouse().Hit.Position)
                    )
                    local Args = {Cache.Player.FruitKeyArgumet, string.format("%sPower%s", Cache.Player.SpamSkillFruit, Cache.Player.FruitKeyboard), "StopCharging"};
                    for i, v in pairs(FuritTypeArgument[string.format("Power%s", (Cache.Player.NumberFruit == 1 and Cache.Player.FruitKeyboard) or Cache.Player.NumberFruit == 2 and Cache.Player.FruitKeyboard - 6)]) do
                        local Data = GetingSkillArgumet(v);
                        table.insert(Args, Data)
                    end
                    game:GetService("Players").LocalPlayer.Character.Powers[Cache.Player.SpamSkillFruit].RemoteEvent:FireServer(unpack(Args))
                end
                if game.Players.LocalPlayer.Character.Humanoid.Health <= 0 then
                    Cache.Boolean.StartSpamSkill = false
                end
            end
        end)
    end
end)

Ui_Tab["Players"]:Line()
Ui_Tab["Players"]:Label("⭐ Advance - <Can Make You lag> ⭐")


Ui_Tab["Players"]:Textbox("Set Move Speed", "", false, function(Value)
    xpcall(function()
        Cache.Player.InputMoveSpeed = tonumber(Value) + 0
    end, function()
        Cache.Player.InputMoveSpeed = 16
    end)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
end)

Ui_Tab["Players"]:Textbox("Set Jump Power", "", false, function(Value)
    xpcall(function()
        Cache.Player.InputJumpPower = tonumber(Value) + 0
    end, function()
        Cache.Player.InputJumpPower = 50
    end)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
end)

Ui_Tab["Players"]:Toggle("No Skill Cooldown", "", false, function(Value)
    Cache.Boolean.NoCooldownSkill = Value
end)

spawn(function()
    repeat wait() until Cache.Player.InputMoveSpeed or Cache.Player.InputJumpPower;
    local Old;
    Old = hookmetamethod(game.Players.LocalPlayer.Character, "__newindex", function(s, k, v)
        if s.Name == "Humanoid" then
            if Cache.Player.InputMoveSpeed and tostring(k) == "WalkSpeed" then
                return Old(s, k, Cache.Player.InputMoveSpeed)
            elseif Cache.Player.InputJumpPower and tostring(k) == "JumpPower" then
                return Old(s, k, Cache.Player.InputJumpPower)
            end
        end
        return Old(s, k, v)
    end)
end)

spawn(function()
    repeat wait() until Cache.Boolean.NoCooldownSkill
    local Old;
    Old = hookmetamethod(game.Players.LocalPlayer.Character.Powers, "__namecall", function(Self, ...)
        local Args = {...}
        if Cache.Boolean.NoCooldownSkill and getnamecallmethod() == "FireServer" then
            if table.find(Args, "StopCharging") then
                return spawn(Old(Self, ...))
            end
        end
        return Old(Self, ...)
    end)
end)

Ui_Tab["Players"]:Toggle("No Drowning Damage", "" , false, function(Value)
    Cache.Boolean.NoDrowningDamage = Value
end)

spawn(function()
    repeat wait() until Cache.Boolean.NoDrowningDamage
local Old;
Old = hookmetamethod(game, "__namecall", function(Self, Args1, ...)
        if Cache.Boolean.NoDrowningDamage and not checkcaller() and Self.Name == "Drown" and Args1 == "NOPLS" then
            return
        end
        return Old(Self, Args1, ...)
    end)
end)

Ui_Tab["Players"]:Line()
Ui_Tab["Players"]:Label("⭐ Instant Kill ⭐")

Cache.Player.InstantKillSpeed = 1
Ui_Tab["Players"]:Textbox("Instant Kill Speed", "", false, function(Value)
    xpcall(function()
        Cache.Player.InstantKillSpeed = tonumber(Value) + 0
    end, function()
        Cache.Player.InstantKillSpeed = 1
    end)
end)

Cache.Player.InstantKillData = {};
Ui_Tab["Players"]:Toggle("Instant Kill [Kogatana]", "" , false, function(Value)
    Cache.Boolean.StartInstantKill_Kogatana = Value
    if Value and game.Players.LocalPlayer.Character:FindFirstChild("Kogatana") and game.Players.LocalPlayer.Character.Kogatana:FindFirstChild("AnimationController") then
        Cache.Player.InstantKillData["Kogatana"] = getsenv(game.Players.LocalPlayer.Character.Kogatana:FindFirstChild("AnimationController"))["PlaceId"];
    end
end)

Ui_Tab["Players"]:Toggle("Instant Kill [Seastone Cestus]", "" , false, function(Value)
    Cache.Boolean.StartInstantKill_SeastoneCestus = Value
    if Value and game.Players.LocalPlayer.Character:FindFirstChild("Seastone Cestus") and game.Players.LocalPlayer.Character["Seastone Cestus"]:FindFirstChild("AnimationController") then
        Cache.Player.InstantKillData["Seastone Cestus"] = getsenv(game.Players.LocalPlayer.Character["Seastone Cestus"]:FindFirstChild("AnimationController"))["PlaceId"];
    end
end)

Ui_Tab["Players"]:Toggle("Instant Kill [Yoru]", "" , false, function(Value)
    Cache.Boolean.StartInstantKill_Yoru = Value
    if Value and game.Players.LocalPlayer.Character:FindFirstChild("Yoru") and game.Players.LocalPlayer.Character["Yoru"]:FindFirstChild("AnimationController") then
        Cache.Player.InstantKillData["Yoru"] = getsenv(game.Players.LocalPlayer.Character["Yoru"]:FindFirstChild("AnimationController"))["PlaceId"];
    end
end)

local FindToolInInventory = function(Tools)
    for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v.Name == Tools and v.ClassName == "Tool" and v:FindFirstChild("AnimationController") then
            return true
        end
    end
    return false
end
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    if not (Cache.Boolean.StartInstantKill_Kogatana or Cache.Boolean.StartInstantKill_SeastoneCestus or Cache.Boolean.StartInstantKill_Yoru) then
        return
    end
    repeat wait() until (Cache.Boolean.StartInstantKill_Kogatana and FindToolInInventory("Kogatana")) or (Cache.Boolean.StartInstantKill_SeastoneCestus and FindToolInInventory("Seastone Cestus")) or (Cache.Boolean.StartInstantKill_Yoru and FindToolInInventory("Yoru")) 
    local Weapon;
    if Cache.Boolean.StartInstantKill_Kogatana then
        Weapon = "Kogatana"
    elseif Cache.Boolean.StartInstantKill_SeastoneCestus then
        Weapon = "Seastone Cestus"
    elseif Cache.Boolean.StartInstantKill_Yoru then
        Weapon = "Yoru"
    end
    repeat
        Cache.Player.InstantKillData[Weapon] = "NaN";
        Cache.Player.InstantKillData[Weapon] = getsenv(game.Players.LocalPlayer.Character[Weapon]:FindFirstChild("AnimationController"))["PlaceId"];
        wait()
    until Cache.Player.InstantKillData[Weapon] ~= "NaN" and Cache.Player.InstantKillData[Weapon] ~= nil;
end)

game:GetService("RunService").Stepped:Connect(function()
    if Cache.Boolean.StartInstantKill_Kogatana and game.Players.LocalPlayer.Character:FindFirstChild("Kogatana") and game.Players.LocalPlayer.Character.Kogatana:FindFirstChild("AnimationController") then
        if Cache.Player.InstantKillData["Kogatana"] and Cache.Player.InstantKillData["Kogatana"] ~= "NaN" then
            for _ = 1, Cache.Player.InstantKillSpeed do
                game.Players.LocalPlayer.Character:FindFirstChild("Kogatana").RequestAnimation:FireServer(tonumber(Cache.Player.InstantKillData["Kogatana"]))
            end
        end
        if game.Players.LocalPlayer.Character.Humanoid.Health <= 0 then
            Cache.Player.InstantKillData["Kogatana"] = "NaN"
        end
    end
end)

game:GetService("RunService").Stepped:Connect(function()
    if Cache.Boolean.StartInstantKill_SeastoneCestus and game.Players.LocalPlayer.Character:FindFirstChild("Seastone Cestus") and game.Players.LocalPlayer.Character["Seastone Cestus"]:FindFirstChild("AnimationController") then
        if Cache.Player.InstantKillData["Seastone Cestus"] and Cache.Player.InstantKillData["Seastone Cestus"] ~= "NaN" then
            for _ = 1, Cache.Player.InstantKillSpeed do
                game.Players.LocalPlayer.Character:FindFirstChild("Seastone Cestus").RequestAnimation:FireServer(tonumber(Cache.Player.InstantKillData["Seastone Cestus"]))
            end
        end
        if game.Players.LocalPlayer.Character.Humanoid.Health <= 0 then
            Cache.Player.InstantKillData["Seastone Cestus"] = "NaN"
        end
    end
end)

game:GetService("RunService").Stepped:Connect(function()
    if Cache.Boolean.StartInstantKill_Yoru and game.Players.LocalPlayer.Character:FindFirstChild("Yoru") and game.Players.LocalPlayer.Character["Yoru"]:FindFirstChild("AnimationController") then
        if Cache.Player.InstantKillData["Yoru"] and Cache.Player.InstantKillData["Yoru"] ~= "NaN" then
            for _ = 1, Cache.Player.InstantKillSpeed do
                game.Players.LocalPlayer.Character:FindFirstChild("Yoru").RequestAnimation:FireServer(tonumber(Cache.Player.InstantKillData["Yoru"]))
            end
        end
        if game.Players.LocalPlayer.Character.Humanoid.Health <= 0 then
            Cache.Player.InstantKillData["Yoru"] = "NaN"
        end
    end
end)


Ui_Tab["Players"]:Line()
Ui_Tab["Players"]:Label("⭐ Fruit Storage ⭐")
Cache.Player.Inputfruitlist = {}

Ui_Tab["Players"]:Textbox("Devil Fruit Name", "", false, function(Value)
    Cache.Player.Inputfruitname = string.lower(tostring(Value))
end)

Ui_Tab["Players"]:Button("⭐ Add All Rare Devil Furit To List ⭐", "", function()
    for _, value in pairs(Cache.GlobalValue.ListAllDevilFurits) do
        table.insert(Cache.Player.Inputfruitlist, value)
    end
end)

Ui_Tab["Players"]:Button("Add Devil Furit To List", "", function()
    table.insert(Cache.Player.Inputfruitlist, Cache.Player.Inputfruitname)
end)

Ui_Tab["Players"]:Button("Delete Last Devil Furit Form List", "", function()
    table.remove(Cache.Player.Inputfruitlist, #Cache.Player.Inputfruitlist)
end)

Ui_Tab["Players"]:Button("Print Devil Furit List", "", function()
    local Content = "";
    for Index, Value in pairs(Cache.Player.Inputfruitlist) do
        Content = string.format("%s Index : %s : Value : %s\n", Content, Index, Value)
    end
    print(Content)
end)

Ui_Tab["Players"]:Toggle("Keep All Shiny", "", false, function(Value)
    Cache.Boolean.StorageKeepShiny = Value
end)

Cache.Boolean.StorageUsingGroup = {}
for Index = 1, 12 do
    Ui_Tab["Players"]:Toggle("Storage No."..Index, "", false, function(Value)
        Cache.Boolean.StorageUsingGroup[Index] = Value
    end)
end


spawn(function()
    local CheckStorage = function(Number)
        if game.Players.LocalPlayer.PlayerGui.Storage.Frame["StoredDF"..Number].Button.Text == "Store" and game.Players.LocalPlayer.PlayerGui.Storage.Frame["StoredDF"..Number].Visible == true then
            return true
        end
        return false
    end
    while wait() do
        pcall(function()
            for Index, Value in pairs(Cache.Boolean.StorageUsingGroup) do
                if Value and CheckStorage(Index) then
                    for _, Fruit in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        for _, FuritFormList in pairs(Cache.Player.Inputfruitlist) do
                            if Fruit.ClassName == "Tool" and (string.match(string.lower(Fruit.Name), string.lower(FuritFormList)) or (Cache.Boolean.StorageKeepShiny and Fruit:FindFirstChild("Main") and Fruit.Main:FindFirstChild("AuraAttachment"))) then
                                game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                                Fruit.Parent = game.Players.LocalPlayer.Character
                                game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].StoredDFRequest:FireServer("StoredDF"..Index)
                                break
                            end
                        end
                    end
                end
            end
        end)
    end
end)

Ui_Tab["Players"]:Line()
Ui_Tab["Players"]:Label("⭐ Fruit Stats ⭐")

Ui_Tab["Players"]:Button("Open Affinity Diviner", "", function()
    fireclickdetector(game:GetService("Workspace").Merchants.AffinityMerchant.Clickable.ClickDetector)
end)

Cache.Player.DevilFruitStats = {
    Melee = 1.1,
    Sword = 1.1,
    Sniper = 1.1,
    Defense = 1.1,
    PayWith = false,
}

Ui_Tab["Players"]:Dropdown("Pay With", {"Cash", "Gems"}, function(Value)
    Cache.Player.DevilFruitStats.PayWith = tostring(Value)
end)

Ui_Tab["Players"]:Slider("Melee Stats", "Set your minimal stats [set to 0 mean any].", 0, 10, 1,function(Value)
    Cache.Player.DevilFruitStats.Melee = 1 + (tonumber(Value) * 0.1)
end)
Ui_Tab["Players"]:Slider("Sword Stats", "Set your minimal stats [set to 0 mean any].", 0, 10, 1,function(Value)
    Cache.Player.DevilFruitStats.Sword = 1 + (tonumber(Value) * 0.1)
end)
Ui_Tab["Players"]:Slider("Sniper Stats", "Set your minimal stats [set to 0 mean any].", 0, 10, 1,function(Value)
    Cache.Player.DevilFruitStats.Sniper = 1 + (tonumber(Value) * 0.1)
end)
Ui_Tab["Players"]:Slider("Defense Stat.", "Set your minimal stats [set to 0 mean any].", 0, 10, 1,function(Value)
    Cache.Player.DevilFruitStats.Defense = 1 + (tonumber(Value) * 0.1)
end)

Cache.Player.LockStats = {}
Ui_Tab["Players"]:Toggle("Lock Melee", "", false, function(Value)
    Cache.Player.LockStats.Melee = Value
end)
Ui_Tab["Players"]:Toggle("Lock Sword", "", false, function(Value)
    Cache.Player.LockStats.Sword = Value
end)
Ui_Tab["Players"]:Toggle("Lock Sniper", "", false, function(Value)
    Cache.Player.LockStats.Sniper = Value
end)
Ui_Tab["Players"]:Toggle("Lock Defense", "", false, function(Value)
    Cache.Player.LockStats.Defense = Value
end)


Ui_Tab["Players"]:Toggle("Auto Random Stats Fruit 1", "", false, function(Value)
    Cache.Boolean.RandomStatsFurit_1 = Value
end)

Ui_Tab["Players"]:Toggle("Auto Random Stats Fruit 2", "", false, function(Value)
    Cache.Boolean.RandomStatsFurit_2 = Value
end)

spawn(function()
    while wait(0.1) do
        pcall(function()
            if Cache.Player.DevilFruitStats.PayWith and Cache.Boolean.RandomStatsFurit_1 and game.Players.LocalPlayer.PlayerGui:FindFirstChild("AffinityUI") then
                local Count = 0
                for _, Value in pairs({"Melee", "Sword", "Sniper", "Defense"}) do
                    if Cache.Player.DevilFruitStats[Value] == 1 or game.Workspace.UserData["User_" .. game.Players.LocalPlayer.UserId].Data["DFT1" .. Value].Value < Cache.Player.DevilFruitStats[Value] then
                        Count += 1
                    end
                end
                if Count == 4 then
                    game.Workspace.Merchants.AffinityMerchant.Clickable.Retum:FireServer("DFT1", Cache.Player.LockStats.Defense or false, Cache.Player.LockStats.Melee or false, Cache.Player.LockStats.Sniper or false, Cache.Player.LockStats.Sword or false, Cache.Player.DevilFruitStats.PayWith)
                    wait(10)
                end
            end
        end)
    end
end)

spawn(function()
    while wait(0.1) do
        pcall(function()
            if Cache.Player.DevilFruitStats.PayWith and Cache.Boolean.RandomStatsFurit_2 and  game.Workspace.UserData["User_" .. game.Players.LocalPlayer.UserId].Data.DevilFruit2.Value ~= "None" and game.Players.LocalPlayer.PlayerGui:FindFirstChild("AffinityUI") then
                local Count = 0
                for _, Value in pairs({"Melee", "Sword", "Sniper", "Defense"}) do
                    if Cache.Player.DevilFruitStats[Value] == 1 or game.Workspace.UserData["User_" .. game.Players.LocalPlayer.UserId].Data["DFT2" .. Value].Value < Cache.Player.DevilFruitStats[Value] then
                        Count += 1
                    end
                end
                if Count == 4 then
                    game.Workspace.Merchants.AffinityMerchant.Clickable.Retum:FireServer("DFT2", Cache.Player.LockStats.Defense or false, Cache.Player.LockStats.Melee or false, Cache.Player.LockStats.Sniper or false, Cache.Player.LockStats.Sword or false, Cache.Player.DevilFruitStats.PayWith)
                    wait(10)
                end
            end
        end)
    end
end)

Ui_Tab["Players"]:Line()
Ui_Tab["Players"]:Label("⭐ Miscellaneous ⭐")

Ui_Tab["Players"]:Toggle("Auto Spawn When Dead", "", false, function(Value)
    Cache.Boolean.AutoSpawnWhenDead = Value
end)

spawn(function()
    while wait() do
        pcall(function()
            if Cache.Boolean.AutoSpawnWhenDead then
                if game.Players.LocalPlayer.PlayerGui.Load.Frame.Visible then
                    wait(3)
                    firesignal(game.Players.LocalPlayer.PlayerGui.Load.Frame.Load.MouseButton1Click)
                end
            end
        end)
    end
end)

Ui_Tab["Players"]:Button("Get Seastone Cestus <Need Max Melee>", "", function()
    game.Workspace.UserData["User_"..game.Players.LocalPlayer.UserId].UpdateMelee:FireServer("Seastone Cestus")
end)


Ui_Tab["Bring Monter"] = win:Tab("Farming Monter", "http://www.roblox.com/asset/?id=6756586445")
Ui_Tab["Bring Monter"]:Line()
Ui_Tab["Bring Monter"]:Label("⭐ Farming Only With Gun(?) ⭐")

if not Cache.BringMonter.Inputdistance then
    Cache.BringMonter.Inputdistance = 8
end

Ui_Tab["Bring Monter"]:Textbox("Distance", "", false, function(Value)
    Cache.BringMonter.Inputdistance = tonumber(Value)
end)

--Ui_Tab["Bring Monter"]:Slider("Distance", "", -16, 16, 9,function(Value)
--    Cache.BringMonter.Inputdistance = tonumber(Value)
--end)

Cache.BringMonter.TypePosition = "X";
Ui_Tab["Bring Monter"]:Dropdown("Type Position", {"X", "Y"}, function(DropDown)
    Cache.BringMonter.TypePosition  = tostring(DropDown)
end)

Ui_Tab["Bring Monter"]:Toggle("One Hit", "", false, function(Value)
    Cache.Boolean.StartOneHit = Value
end)

Ui_Tab["Bring Monter"]:Textbox("Tools Name", "", false, function(Value)
    for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v.ClassName == "Tool" and string.match(string.lower(v.Name), string.lower(tostring(Value))) then
            Cache.BringMonter.Inputtoolname = v.Name
        end
    end
    for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v.ClassName == "Tool" and string.match(string.lower(v.Name), string.lower(tostring(Value))) then
            Cache.BringMonter.Inputtoolname = v.Name
        end
    end
end)

Ui_Tab["Bring Monter"]:Line()
Ui_Tab["Bring Monter"]:Label("⭐ Basic ⭐")

Cache.BringMonter.MonterList = {}
Cache.Boolean.BringMonterGroup = {}
local CreateBringMonter = function(name)
    Ui_Tab["Bring Monter"]:Toggle(tostring(name), "" , false, function(Value)
        Cache.Boolean.BringMonterGroup[name] = Value
    end)
end

CreateBringMonter("Lv1 Crab")
CreateBringMonter("Lv2 Angry Bob")
CreateBringMonter("Lv3 Crab")
CreateBringMonter("Lv4 Boar")
CreateBringMonter("Lv4 Crab")
CreateBringMonter("Lv4 Freddy")
CreateBringMonter("Lv5 Crab")
CreateBringMonter("Lv9 Bandit")
CreateBringMonter("Lv11 Boar")
CreateBringMonter("Lv12 Thug")
CreateBringMonter("Lv12 Boar")
CreateBringMonter("Lv14 Boar")
CreateBringMonter("Lv14 Bandit")
CreateBringMonter("Lv15 Thug")
CreateBringMonter("Lv15 Bandit")
CreateBringMonter("Lv15 Boar")
CreateBringMonter("Lv16 Boar")
CreateBringMonter("Lv17 Thug")
CreateBringMonter("Lv20 Thief")
CreateBringMonter("Lv20 Gunslinger")
CreateBringMonter("Lv22 Thug")
CreateBringMonter("Lv22 Angry Bobby")
CreateBringMonter("Lv23 Thug")
CreateBringMonter("Lv24 Fred")
CreateBringMonter("Lv24 Thug")
CreateBringMonter("Lv24 Angry Bobbi")
CreateBringMonter("Lv24 Gunslinger")
CreateBringMonter("Lv28 Freyd")
CreateBringMonter("Lv28 Fredde")
CreateBringMonter("Lv28 Friedrich")
CreateBringMonter("Lv29 Angry Bobber")
CreateBringMonter("Lv29 Frued")
CreateBringMonter("Lv30 Thug")
CreateBringMonter("Lv32 Fredric")
CreateBringMonter("Lv32 Thief")
CreateBringMonter("Lv34 Freddi")
CreateBringMonter("Lv35 Angry Bobb")
CreateBringMonter("Lv36 Gunslinger")
CreateBringMonter("Lv40 Cave Demon")
CreateBringMonter("Lv40 Thug")
CreateBringMonter("Lv42 Gunslinger")
CreateBringMonter("Lv50 Gunslinger")
CreateBringMonter("Lv186 Cave Demon")
CreateBringMonter("Lv188 Cave Demon")
CreateBringMonter("Lv198 Cave Demon")
CreateBringMonter("Lv200 Vokun")
CreateBringMonter("Lv219 Cave Demon")
CreateBringMonter("Lv360 Bruno")
CreateBringMonter("Lv440 Buster")
CreateBringMonter("Lv500 Bucky")
CreateBringMonter("Lv8000 Gunner Captain")

spawn(function()
    while wait() do
        pcall(function()
            for index, value in pairs(Cache.Boolean.BringMonterGroup) do
                if value then
                    for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v.Name == index and v:FindFirstChild("HumanoidRootPart") then
                            v.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3) + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * Cache.BringMonter.Inputdistance
                        end
                    end
                end
            end
        end)
    end
end)

Ui_Tab["Bring Monter"]:Line()
Ui_Tab["Bring Monter"]:Label("⭐ Advance ⭐")

Ui_Tab["Bring Monter"]:Textbox("Monter's Name", "", false, function(Value)
    Cache.BringMonter.Inputmontername = string.lower(tostring(Value))
end)

Ui_Tab["Bring Monter"]:Toggle("Bring Monter", "" , false, function(Value)
    Cache.Boolean.StartBringMonter = Value
end)

spawn(function()
    while wait() do
        pcall(function()
            if Cache.Boolean.StartBringMonter then
                for _, value in pairs(game.Workspace.Enemies:GetChildren()) do
                    if string.match(string.lower(value.Name), Cache.BringMonter.Inputmontername) and value:FindFirstChild("HumanoidRootPart") then
                        value.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3) + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * Cache.BringMonter.Inputdistance
                    end
                end
            end
        end)
    end
end)

Ui_Tab["Bring Monter"]:Line()
Ui_Tab["Bring Monter"]:Label("💀 Dangerous 💀")

Ui_Tab["Bring Monter"]:Line()
Ui_Tab["Bring Monter"]:Label("⭐ Basic ⭐")

Cache.Boolean.TeleportMonterGroup = {}
local CreateTeleportMonter = function(name)
    Ui_Tab["Bring Monter"]:Toggle(tostring(name), "" , false, function(Value)
        Cache.Boolean.TeleportMonterGroup[name] = Value
        Cache.Boolean.NoClip = Value
    end)
end

CreateTeleportMonter("Lv1 Crab")
CreateTeleportMonter("Lv2 Angry Bob")
CreateTeleportMonter("Lv3 Crab")
CreateTeleportMonter("Lv4 Boar")
CreateTeleportMonter("Lv4 Crab")
CreateTeleportMonter("Lv4 Freddy")
CreateTeleportMonter("Lv5 Crab")
CreateTeleportMonter("Lv9 Bandit")
CreateTeleportMonter("Lv11 Boar")
CreateTeleportMonter("Lv12 Thug")
CreateTeleportMonter("Lv12 Boar")
CreateTeleportMonter("Lv14 Boar")
CreateTeleportMonter("Lv14 Bandit")
CreateTeleportMonter("Lv15 Thug")
CreateTeleportMonter("Lv15 Bandit")
CreateTeleportMonter("Lv15 Boar")
CreateTeleportMonter("Lv16 Boar")
CreateTeleportMonter("Lv17 Thug")
CreateTeleportMonter("Lv20 Thief")
CreateTeleportMonter("Lv20 Gunslinger")
CreateTeleportMonter("Lv22 Thug")
CreateTeleportMonter("Lv22 Angry Bobby")
CreateTeleportMonter("Lv23 Thug")
CreateTeleportMonter("Lv24 Fred")
CreateTeleportMonter("Lv24 Thug")
CreateTeleportMonter("Lv24 Angry Bobbi")
CreateTeleportMonter("Lv24 Gunslinger")
CreateTeleportMonter("Lv28 Freyd")
CreateTeleportMonter("Lv28 Fredde")
CreateTeleportMonter("Lv28 Friedrich")
CreateTeleportMonter("Lv29 Angry Bobber")
CreateTeleportMonter("Lv29 Frued")
CreateTeleportMonter("Lv30 Thug")
CreateTeleportMonter("Lv32 Fredric")
CreateTeleportMonter("Lv32 Thief")
CreateTeleportMonter("Lv34 Freddi")
CreateTeleportMonter("Lv35 Angry Bobb")
CreateTeleportMonter("Lv36 Gunslinger")
CreateTeleportMonter("Lv40 Cave Demon")
CreateTeleportMonter("Lv40 Thug")
CreateTeleportMonter("Lv42 Gunslinger")
CreateTeleportMonter("Lv50 Gunslinger")
CreateTeleportMonter("Lv186 Cave Demon")
CreateTeleportMonter("Lv188 Cave Demon")
CreateTeleportMonter("Lv198 Cave Demon")
CreateTeleportMonter("Lv200 Vokun")
CreateTeleportMonter("Lv219 Cave Demon")
CreateTeleportMonter("Lv360 Bruno")
CreateTeleportMonter("Lv440 Buster")
CreateTeleportMonter("Lv500 Bucky")
CreateTeleportMonter("Lv8000 Gunner Captain")

---------------------

--spawn(function()
--    local function Attack(Obj)
--        if not Cache.BringMonter.Inputmontername or Cache.BringMonter.Inputmontername == "" then return end;
--        local ListTools = {"Slingshot", "Stars", "Crossbow", "Flintlock"};
--        local Tool;
--        repeat
--            game.Players.LocalPlayer.Character.Humanoid:UnequipTools();
--            for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
--                if not Tool and v.ClassName == "Tool" and string.match(string.lower(v.Name), string.lower(Cache.BringMonter.Inputmontername)) then
--                    v.Parent = game.Players.LocalPlayer.Character;
--                    Tool = v;
--                    break;
--               end
--            end
--            if not Cache.BringMonter.Inputmontername then return end;
--            wait();
--        until Tool;
--        local TimeOut = 0;
--        local OldKill = game:GetService("Workspace").UserData["User_" .. game.Players.LocalPlayer.UserId].Data.Kills.Value;
--        repeat
--            pcall(function()
--                if table.find(ListTools, Tool.Name) then
--                    Tool.RemoteEvent:FireServer(CFrame.new(Obj.HumanoidRootPart.Position), Obj.HumanoidRootPart);
--                else
--                   Tool:Activate();
--                end
--            end);
--            TimeOut += 1;
--            wait(0.1);
--        until OldKill < game:GetService("Workspace").UserData["User_" .. game.Players.LocalPlayer.UserId].Data.Kills.Value or not Cache.Boolean.TeleportMonterGroup or TimeOut > 10;
--    end
--    while wait() do
--        pcall(function()
--            if not Cache.Boolean.TeleportMonterGroup or not IsSpawned() then return end;
--            for _, Value in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
--                   if not Cache.Boolean.TeleportMonterGroup then return end;
--                if Cache.Boolean.TeleportMonterGroup[Value.Name] and Value:FindFirstChild("HumanoidRootPart") and Value:FindFirstChild("Humanoid") and Value.Humanoid.Health > 0 then
--                    if Cache.BringMonter.TypePosition == "X" then
--                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Value.HumanoidRootPart.Position + Vector3.new(0, 0, Cache.BringMonter.Inputdistance), Value.HumanoidRootPart.Position);
--                        if Cache.Boolean.StartOneHit then Value.Humanoid.Health = 0 end;
--                       Attack(Value);
--                    elseif Cache.BringMonter.TypePosition == "Y" then
--                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Value.HumanoidRootPart.Position + Vector3.new(0, Cache.BringMonter.Inputdistance, 0), Value.HumanoidRootPart.Position);
--                        if Cache.Boolean.StartOneHit then Value.Humanoid.Health = 0 end;
--                        Attack(Value);
--                    end
--                end
--            end
--        end)
--    end
--end);

---------------------


local LastAttackFunc = function(Obj)
    local ListTools = {"Slingshot", "Stars", "Crossbow", "Flintlock"};
    local Tool;
    local IsGun = table.find(ListTools, Cache.BringMonter.Inputtoolname);
    repeat
        game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
        for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v.Name == Cache.BringMonter.Inputtoolname and v.ClassName == "Tool" then
                v.Parent = game.Players.LocalPlayer.Character
                Tool = v
            end
        end
        wait()
    until Tool ~= nil
    local Timer = 0
    local OldKill = game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].Data.Kills.Value
    repeat
        if Cache.BringMonter.TypePosition == "X" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Obj.HumanoidRootPart.Position + Vector3.new(0, 0, Cache.BringMonter.Inputdistance), Obj.HumanoidRootPart.Position)
             print(Cache.BringMonter.Inputdistance)
            if Cache.Boolean.StartOneHit then Obj.Humanoid.Health = 0 end;                 
        elseif Cache.BringMonter.TypePosition == "Y" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Obj.HumanoidRootPart.Position + Vector3.new(0, Cache.BringMonter.Inputdistance, 0), Obj.HumanoidRootPart.Position)
            if Cache.Boolean.StartOneHit then Obj.Humanoid.Health = 0 end;  
        end
        wait(0.1)
        if isnetworkowner(Obj.HumanoidRootPart) then
            Obj.Humanoid.Health = 0
        end
        if IsGun then
            Tool.RemoteEvent:FireServer(CFrame.new(Obj.HumanoidRootPart.Position), Obj.HumanoidRootPart);
        else
            Tool:Activate()
        end
        Timer += 1
        wait(0.1)
    until OldKill < game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].Data.Kills.Value or Timer >= 10
end
    


spawn(function()
    while wait() do
        pcall(function()
            for index, value in pairs(Cache.Boolean.TeleportMonterGroup) do
                if value then
                    for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v.Name == index and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Head") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            if Cache.Boolean.StartOneHit then
                                LastAttackFunc(v)
                            else
                                if Cache.BringMonter.TypePosition == "X" then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.HumanoidRootPart.Position + Vector3.new(0, 0, Cache.BringMonter.Inputdistance), v.HumanoidRootPart.Position)
                                    if Cache.Boolean.StartOneHit then v.Humanoid.Health = 0 end;        
                                elseif Cache.BringMonter.TypePosition == "Y" then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.HumanoidRootPart.Position + Vector3.new(0, Cache.BringMonter.Inputdistance, 0), v.HumanoidRootPart.Position)
                                    if Cache.Boolean.StartOneHit then v.Humanoid.Health = 0 end;
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)


Ui_Tab["Bring Monter"]:Line()
Ui_Tab["Bring Monter"]:Label("⭐ Advance ⭐")

Ui_Tab["Bring Monter"]:Textbox("Monter's Name", "", false, function(Value)
    Cache.BringMonter.Inputmonterteleportname = string.lower(tostring(Value))
end)

Ui_Tab["Bring Monter"]:Toggle("Teleport Monter", "" , false, function(Value)
    Cache.Boolean.StartTeleportMonter = Value
    Cache.Boolean.NoClip = Value
end)

spawn(function()
    while wait() do
        pcall(function()
            if Cache.Boolean.StartTeleportMonter then
                for _, value in pairs(game.Workspace.Enemies:GetChildren()) do
                    if string.match(string.lower(value.Name), Cache.BringMonter.Inputmonterteleportname) and value:FindFirstChild("HumanoidRootPart") and value:FindFirstChild("Humanoid")  and value:FindFirstChild("Head") and value.Humanoid.Health > 0 then
                        if Cache.Boolean.StartOneHit then
                            LastAttackFunc(value)
                        else
                            if Cache.BringMonter.TypePosition == "X" then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(value.HumanoidRootPart.Position + Vector3.new(0, Cache.BringMonter.Inputdistance, 0), value.HumanoidRootPart.Position)
                            elseif Cache.BringMonter.TypePosition == "Y" then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(value.HumanoidRootPart.Position + Vector3.new(0, 0, Cache.BringMonter.Inputdistance), value.HumanoidRootPart.Position)               
                            end
                        end
                    end
                end
            end
        end)
    end
end)

Ui_Tab["Teleport"] = win:Tab("Teleport", "http://www.roblox.com/asset/?id=6756586445")
Ui_Tab["Teleport"]:Line()
Ui_Tab["Teleport"]:Label("⭐ Teleport? ⭐")

Ui_Tab["Teleport"]:Line()
Ui_Tab["Teleport"]:Label("⭐ Basic ⭐")

local CreateTeleportPostiton = function(a, b)
    Ui_Tab["Teleport"]:Button(tostring(a), "", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = b
    end)
end

CreateTeleportPostiton("House island", CFrame.new(882, 269, 1219))
CreateTeleportPostiton("Sand island", CFrame.new(-204, 221, -113))
CreateTeleportPostiton("Sam island", CFrame.new(-1282, 217, -1353))
CreateTeleportPostiton("Fountain island", CFrame.new(-238, 225, -1108))
CreateTeleportPostiton("Castle island", CFrame.new(-3137, 353, -4111))
CreateTeleportPostiton("Evil island", CFrame.new(-5275, 515, -7849))
CreateTeleportPostiton("Tree island", CFrame.new(-6035, 401, -2))
CreateTeleportPostiton("Racetrack island", CFrame.new(-6447, 275, 4612))
CreateTeleportPostiton("Small snow island", CFrame.new(-1897, 224, 3296))
CreateTeleportPostiton("Big snow island", CFrame.new(6672, 417, -1475))
CreateTeleportPostiton("Krizma island", CFrame.new(-1071, 360, 1671))
CreateTeleportPostiton("Bar island", CFrame.new(1505, 260, 2171))
CreateTeleportPostiton("Moon island", CFrame.new(3205, 356, 1658))
CreateTeleportPostiton("Vokun island", CFrame.new(4617, 216, 4951))
CreateTeleportPostiton("Pyramid island", CFrame.new(118, 215, 4774))
CreateTeleportPostiton("Aura island", CFrame.new(-1558, 215, 9935))
CreateTeleportPostiton("Stone island", CFrame.new(-2728, 252, 1071))
CreateTeleportPostiton("Fishing island", CFrame.new(-1692, 215, -326))
CreateTeleportPostiton("Old stone island", CFrame.new(2054, 487, -701))
CreateTeleportPostiton("Boss inland", CFrame.new(4853, 569, -7207))
CreateTeleportPostiton("Sand castle island", CFrame.new(1016, 223, -3282))
CreateTeleportPostiton("Mansion island", CFrame.new(1798, 217, 903))
CreateTeleportPostiton("Near voken island", CFrame.new(1063, 217, 3353))

Ui_Tab["Teleport"]:Line()
Ui_Tab["Teleport"]:Label("⭐ Advance ⭐")

xpcall(function()
    Cache.Teleport.Database = game:GetService("HttpService"):JSONDecode(readfile("H2O_Folder/TeleportPostiton.json"))
end, function()
    Cache.Teleport.Database = {}
    if not isfolder("H2O_Folder") then
        makefolder("H2O_Folder")
    end
end)

Ui_Tab["Teleport"]:Textbox("Title Name", "", false, function(Value)
    Cache.Teleport.InputTitlename = tostring(Value)
end)

Ui_Tab["Teleport"]:Button("Set Postiton To Setting", "", function()
    local Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    Cache.Teleport.Inputpostiton = string.format("return Vector3.new(%s, %s, %s)", math.floor(Position.X), math.floor(Position.Y), math.floor(Position.Z))
end)

Ui_Tab["Teleport"]:Button("Print All Table Teleport", "", function()
    local Content = ""
    for index, value in pairs(Cache.Teleport.Database) do
        Content = string.format("%s Index : %s Value : {%s, %s},\n", Content, index, value.Title, value.Position)
    end
    print(Content)
end)

Ui_Tab["Teleport"]:Button("Add Index Teleport", "", function()
    table.insert(Cache.Teleport.Database, {
        Title = Cache.Teleport.InputTitlename,
        Position = Cache.Teleport.Inputpostiton
    })
end)

Ui_Tab["Teleport"]:Button("Delete Last Index Teleport", "", function()
    table.remove(Cache.Teleport.Database, #Cache.Teleport.Database)
end)

Ui_Tab["Teleport"]:Button("Save To File", "", function()
    writefile("H2O_Folder/TeleportPostiton.json", game:GetService("HttpService"):JSONEncode(Cache.Teleport.Database))
end)

Ui_Tab["Teleport"]:Line()
Ui_Tab["Teleport"]:Label("⭐ Custom ⭐")

pcall(function()
    for index = 1, #Cache.Teleport.Database do
        local Value = Cache.Teleport.Database[index];
        local Position = loadstring(Value.Position)()
        if typeof(Position) ~= "Vector3" then
            return game.Players.LocalPlayer:Kick("Error : Teleport Error \n Pls Delete TeleportPostiton.json!")
        end
        Ui_Tab["Teleport"]:Button(tostring(Value.Title), "", function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Position)
        end)
    end
end)

Ui_Tab["Fake Stats"] = win:Tab("Fake Stats", "http://www.roblox.com/asset/?id=6756586445")
Ui_Tab["Fake Stats"]:Line()
Ui_Tab["Fake Stats"]:Label("⭐ Fake Not Real ⭐")

Ui_Tab["Fake Stats"]:Line()
Ui_Tab["Fake Stats"]:Label("⭐ Players Stats ⭐")

Ui_Tab["Fake Stats"]:Textbox("Player's Name", "", false, function(Text)
    game.Players.LocalPlayer.PlayerGui.Menu.Frame.C.Frame.Nametag.Text = tostring(Text)
end)
Ui_Tab["Fake Stats"]:Textbox("Melee Stats", "", false, function(Text)
    game.Players.LocalPlayer.PlayerGui.Menu.Frame.C.Frame.Melee.Text = tostring("Melee: "..Text)
end)
Ui_Tab["Fake Stats"]:Textbox("Sniper Stats", "", false, function(Text)
    game.Players.LocalPlayer.PlayerGui.Menu.Frame.C.Frame.Sniper.Text = tostring("Sniper: "..Text)
end)
Ui_Tab["Fake Stats"]:Textbox("Sword Stats", "", false, function(Text)
    game.Players.LocalPlayer.PlayerGui.Menu.Frame.C.Frame.Sword.Text = tostring("Sword: "..Text)
end)
Ui_Tab["Fake Stats"]:Textbox("Defense Stats", "", false, function(Text)
    game.Players.LocalPlayer.PlayerGui.Menu.Frame.C.Frame.Defense.Text = tostring("Defense: "..Text)
end)
Ui_Tab["Fake Stats"]:Textbox("Haki Stats", "", false, function(Text)
    game.Players.LocalPlayer.PlayerGui.Menu.Frame.C.Frame.Haki.Text = tostring("Haki: "..Text)
end)

Ui_Tab["Fake Stats"]:Textbox("Total Level", "", false, function(Text)
    game.Players.LocalPlayer.PlayerGui.Menu.Frame.C.Frame.TotalLevel.Text = tostring("Total Level: "..Text)
end)

Ui_Tab["Fake Stats"]:Textbox("Devil Fruit 1 Name", "", false, function(Text)
    game.Players.LocalPlayer.PlayerGui.Menu.Frame.D.Frame.E.Frame.DevilFruit["00"].Ability.Text = tostring(Text)
    game.Players.LocalPlayer.PlayerGui.Menu.Frame.C.Frame.A.DevilFruit.Text = tostring(Text)
end)

Ui_Tab["Fake Stats"]:Textbox("Devil Fruit 2 Name", "", false, function(Text)
    game.Players.LocalPlayer.PlayerGui.Menu.Frame.D.Frame.E.Frame.DevilFruit2["00"].Ability.Text = tostring(Text)
    game.Players.LocalPlayer.PlayerGui.Menu.Frame.C.Frame.A.DevilFruit2.Text = tostring(Text)
end)

Ui_Tab["Fake Stats"]:Line()
Ui_Tab["Fake Stats"]:Label("⭐ Fruits Stats ⭐")

Ui_Tab["Fake Stats"]:Textbox("Number Fruits", "", false, function(Text)
    Cache.FakeStats.Inputfruitnumber = tostring(Text)
end)

Ui_Tab["Fake Stats"]:Textbox("Name", "", false, function(Text)
    game.Players.LocalPlayer.PlayerGui.Storage.Frame["StoredDF"..Cache.FakeStats.Inputfruitnumber].DevilFruit.Text = tostring(Text)
end)

Ui_Tab["Fake Stats"]:Textbox("Defense", "", false, function(Text)
    game.Players.LocalPlayer.PlayerGui.Storage.Frame["StoredDF"..Cache.FakeStats.Inputfruitnumber].Affinities.DefenseAffinity.Value = tonumber(Text)
end)

Ui_Tab["Fake Stats"]:Textbox("Melee", "", false, function(Text)
    game.Players.LocalPlayer.PlayerGui.Storage.Frame["StoredDF"..Cache.FakeStats.Inputfruitnumber].Affinities.MeleeAffinity.Value = tonumber(Text)
end)

Ui_Tab["Fake Stats"]:Textbox("Sniper", "", false, function(Text)
    game.Players.LocalPlayer.PlayerGui.Storage.Frame["StoredDF"..Cache.FakeStats.Inputfruitnumber].Affinities.SniperAffinity.Value = tonumber(Text)
end)

Ui_Tab["Fake Stats"]:Textbox("Sword", "", false, function(Text)
    game.Players.LocalPlayer.PlayerGui.Storage.Frame["StoredDF"..Cache.FakeStats.Inputfruitnumber].Affinities.SwordAffinity.Value = tonumber(Text)
end)

Ui_Tab["Fake Stats"]:Colorpicker("Color 1 Aura", Color3.fromRGB(255,1,1), function(Value)
    game.Players.LocalPlayer.PlayerGui.Storage.Frame["StoredDF"..Cache.FakeStats.Inputfruitnumber].DFU1.ImageColor3 = Value
end)

Ui_Tab["Fake Stats"]:Colorpicker("Color 2 Aura", Color3.fromRGB(255,1,1), function(Value)
    game.Players.LocalPlayer.PlayerGui.Storage.Frame["StoredDF"..Cache.FakeStats.Inputfruitnumber].DFU2.ImageColor3 = Value
end)

Ui_Tab["Fake Stats"]:Toggle("Set Aura 1", "" , false, function(Value)
    game.Players.LocalPlayer.PlayerGui.Storage.Frame["StoredDF"..Cache.FakeStats.Inputfruitnumber].DFU1.Visible = Value
end)

Ui_Tab["Fake Stats"]:Toggle("Set Aura 2", "" , false, function(Value)
    game.Players.LocalPlayer.PlayerGui.Storage.Frame["StoredDF"..Cache.FakeStats.Inputfruitnumber].DFU2.Visible = Value
end)

Ui_Tab["Credit"] = win:Tab("Credit", "http://www.roblox.com/asset/?id=6756586445")
Ui_Tab["Credit"]:Line()
Ui_Tab["Credit"]:Label("⭐ Credit To Kang Yes Only Kang 😢 ⭐")
Ui_Tab["Credit"]:Label("Made By : Kang Kung#7271")
Ui_Tab["Credit"]:Label("Discord : https://discord.gg/B659FscCBz")
Ui_Tab["Credit"]:Button("Copy","Copy This Link.", function()
    setclipboard("https://discord.gg/B659FscCBz")
    local req = (syn and syn.request) or request
    req({
        Url = "http://127.0.0.1:6463/rpc?v=1",
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json",
            ["Origin"] = "https://discord.com"
        },
        Body = game:GetService("HttpService"):JSONEncode({
            cmd = "INVITE_BROWSER",
            args = {
                code = "B659FscCBz"
            },
            nonce = game:GetService("HttpService"):GenerateGUID(false)
        }),
    })
    Flux:Notification("Copy Done!", "Okay!")
end)


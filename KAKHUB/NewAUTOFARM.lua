local player = game.Players.LocalPlayer 
local allowedNames = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://raw.githubusercontent.com/KAKXHUB/ProjectOPL/refs/heads/main/KAKHUB/Myfriend"))

local isAllowed = false  

for _, name in pairs(allowedNames) do
    if player.Name == name then
        isAllowed = true  
        break  
    end
end

if not isAllowed then
    player:Kick("กากนอกคอก")
end



local Versionxx = "2.4.5"
print("Version: "..Versionxx)
---------------


local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "AUTOFARM " .. Versionxx,
    SubTitle = "by PeetJKA",
    TabWidth = 160,
    Size = UDim2.fromOffset(487.2, 404.8),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "gem" }),
    Quest = Window:AddTab({ Title = "Quest", Icon = "clipboard" }),
    Start = Window:AddTab({ Title = "Stats", Icon = "flame" }),
    Playerss = Window:AddTab({ Title = "Players", Icon = "users" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "database" }),
    Farming = Window:AddTab({ Title = "Farming", Icon = "skull" }),
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "house" }),
    Spam = Window:AddTab({ Title = "Spam", Icon = "locate" }),
    HunterX = Window:AddTab({ Title = "HunterX", Icon = "radio" }),
    Dupe = Window:AddTab({ Title = "Dupe", Icon = "copy" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })

}

local Cache = { DevConfig = {} };

Cache.DevConfig["ListOfBox"] = {"Common Box", "Uncommon Box", "Rare Box", "Ultra Rare Box"};
Cache.DevConfig["ListOfDrink"] = {"Cider+", "Lemonade+", "Juice+", "Smoothie+"};
Cache.DevConfig["ListOfDrinkFormMixer"] = {"Cider", "Lemonade", "Juice", "Smoothie", "Milk", "Golden Apple"};
Cache.DevConfig["ListOfDevillFruit"] = {"Magma", "Gas", "Sand", "Dark", "Chilly", "Rumble", "Snow", "Light", "String", "Flare", "Love", "Phoenix", "Quake", "Candy", "Bomb", "Venom", "Rumble1", "Gravity", "Plasma"};
Cache.DevConfig["ListOfTypeSkillTaget"] = {"Mouse", "Yourself", "Monsters", "Players"};
Cache.DevConfig["FindFruitArgumet"] = loadstring(game:HttpGet"https://raw.githubusercontent.com/KangKung02/The-Last-Krypton/master/Back-End/src/public/api/UWU.lua")();
Cache.DevConfig["ListOfDveilFruit"] = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://raw.githubusercontent.com/KangKung02/just-bin/main/OPL_ALF.json"));
Cache.DevConfig["ListOfMonter"] = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://raw.githubusercontent.com/KangKung02/just-bin/main/OPL_MT.lua"));

local Allset = { DevSetting = {} };
Allset.DevSetting["ListTeleportIsland"] = {
    ["Crab island"] = CFrame.new(-6.00764561, 215.999954, -304.312866);
    ["Vokun"] = CFrame.new(4564.3999, 526, 5712.5);
    ["Purple"] = CFrame.new(-5283, 534.199829, -7761.5);
    ["Rocky"] = CFrame.new(-32.2999992, 228.999954, 2156.6001);
    ["Boss"] = CFrame.new(4809.43555, 590.268005, -7000.63379);
    ["Sand Castle"] = CFrame.new(921, 223.999954, -3275);
    ["Boss sniper"] = CFrame.new(-1075.32813, 360.999908, 1676.62024);
    ["Snow"] = CFrame.new(-1897, 224.999954, 3298);
    ["Drink"] = CFrame.new(1505, 260.38623, 2170.8999);
    ["Tree"] = CFrame.new(1166, 217.079941, 3287);
    ["Big Snow"] = CFrame.new(6616, 417.998901, -1497.30005);
    ["Cave"] = CFrame.new(-79.5663376, 215.999985, -890.889465);
    ["Forest"] = CFrame.new(-6006.75977, 402, 7.19999981);
    ["Pyramid"] = CFrame.new(119, 310, 4945.8999);
    ["Sam"] = CFrame.new(-1281.68347, 218, -1351.09534);
    ["Fish Man"] = CFrame.new(-1683.59998, 216, -333.299988);
    ["Mountain"] = CFrame.new(2053.5, 492, -637);
    ["Boss Aura"] = CFrame.new(-1575.63281, 219.278564, 9939.50684);
}
Allset.DevSetting["ListTeleportIslandIndex"] = {"Crab island", "Vokun", "Purple", "Rocky", "Boss", "Sand Castle", "Boss sniper", "Snow", "Drink", "Tree", "Big Snow", "Cave", "Forest", "Pyramid", "Sam", "Fish Man", "Mountain", "Boss Aura" }


local function IsSpawned()
    return not game.Players.LocalPlayer.PlayerGui.Load.Frame.Visible;
end
local function InstanceToName(t)
    local Content = {};
    for _, Value in pairs(t) do
        table.insert(Content, Value.Name);
    end
    return Content;
end
local CheckPath = function(Path, ...)
    local Args = {...};
    for _, v in pairs(Args) do
        if Path:FindFirstChild(v) then
            Path = Path[v]
        else
            return false;
        end
    end
    return true;
end



local Options = Fluent.Options

do

    local Section = Tabs.Main:AddSection("Farm Beri")


    Tabs.Main:AddParagraph({
        Title = "Position",
        Content = "Birth point"
    })

    Tabs.Main:AddButton({
        Title = "Set Position",
        Description = "Set the spawn point on the boss island.",
        Callback = function()
            game.Workspace.Spawns.Spawn1.CFrame = CFrame.new(-1558, 215, 9935)
            game.Workspace.Spawns.Spawn2.CFrame = CFrame.new(-1558, 215, 9935)
            game.Workspace.Spawns.Spawn3.CFrame = CFrame.new(-1558, 215, 9935)
            game.Workspace.Spawns.Spawn4.CFrame = CFrame.new(-1558, 215, 9935)
            game.Workspace.Spawns.Spawn5.CFrame = CFrame.new(-1558, 215, 9935)
            game.Workspace.Spawns.Spawn6.CFrame = CFrame.new(-1558, 215, 9935)
            game.Workspace.Spawns.Spawn8.CFrame = CFrame.new(-1558, 215, 9935)
            game.Workspace.Spawns.Spawn9.CFrame = CFrame.new(-1558, 215, 9935)
            game.Workspace.Spawns.Spawn10.CFrame = CFrame.new(-1558, 215, 9935)
        end
    })

    
    Tabs.Main:AddButton({
        Title = "Set Positio(ตั้งที่เกิดเอง)",
        Description = "Set the spawn point at your location.",
        Callback = function()
            local Content = game.Players.LocalPlayer.Character.HumanoidRootPart.Position;
                game.Workspace.Spawns.Spawn1.CFrame = CFrame.new(Content)
                game.Workspace.Spawns.Spawn2.CFrame = CFrame.new(Content)
                game.Workspace.Spawns.Spawn3.CFrame = CFrame.new(Content)
                game.Workspace.Spawns.Spawn4.CFrame = CFrame.new(Content)
                game.Workspace.Spawns.Spawn5.CFrame = CFrame.new(Content)
                game.Workspace.Spawns.Spawn6.CFrame = CFrame.new(Content)
                game.Workspace.Spawns.Spawn7.CFrame = CFrame.new(Content)
                game.Workspace.Spawns.Spawn8.CFrame = CFrame.new(Content)
                game.Workspace.Spawns.Spawn9.CFrame = CFrame.new(Content)
                game.Workspace.Spawns.Spawn10.CFrame = CFrame.new(Content)
        end
    })

    Tabs.Main:AddButton({
        Title = "Reset Position",
        Description = "Reset your spawn point",
        Callback = function()
            local Content = game.Players.LocalPlayer.Character.HumanoidRootPart.Position;
            game.Workspace.Spawns.Spawn1.CFrame = CFrame.new(-8, 213.710159, -296)
            game.Workspace.Spawns.Spawn2.CFrame = CFrame.new(-128, 213.710159, -753)
            game.Workspace.Spawns.Spawn3.CFrame = CFrame.new(45, 221.710159, -72)
            game.Workspace.Spawns.Spawn4.CFrame = CFrame.new(-237, 222.710159, -1108)
            game.Workspace.Spawns.Spawn5.CFrame = CFrame.new(-206, 221.710159, -110.5)
            game.Workspace.Spawns.Spawn6.CFrame = CFrame.new(-76, 212.710159, -892)
            game.Workspace.Spawns.Spawn7.CFrame = CFrame.new(-428, 213.710159, -154)
            game.Workspace.Spawns.Spawn8.CFrame = CFrame.new(-127, 217, -983.200012)
            game.Workspace.Spawns.Spawn9.CFrame = CFrame.new(720, 237, 1191.80005)
            game.Workspace.Spawns.Spawn10.CFrame = CFrame.new(-1281.5, 213.710159, -1353)
        end
    })

    local Toggle = Tabs.Main:AddToggle("MyToggleSTD", {Title = "Start Auto Die", Default = false })
    local Toggle = Tabs.Main:AddToggle("MyToggleTlpPosit", {Title = "Teleport Position", Default = false })


    --[[spawn(function()
        while wait(3) do
            pcall(function()
                if Options.MyToggleSTD.Value then
                    if game.Players.LocalPlayer.PlayerGui.Load.Frame.Visible then
                        wait(3)
                        firesignal(game.Players.LocalPlayer.PlayerGui.Load.Frame.Load.MouseButton1Click)
                        wait(3)
                        repeat
                            local player = game.Players.LocalPlayer
                            local character = player.Character or player.CharacterAdded:Wait()
                            local humanoid = character:FindFirstChildOfClass("Humanoid")

                            if humanoid then
                                humanoid.Health = 0
                            end
                            wait(0.1)
                        until game.Players.LocalPlayer.PlayerGui.Load.Frame.Visible
                    end
                end
            end)
        end
    end)]]
    AutodieDebug = 0
    spawn(function()
        while wait(1) do
            if Options.MyToggleSTD.Value and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character.Humanoid ~= 0 and game.Players.LocalPlayer.PlayerGui:FindFirstChild("Blindness") then
                pcall(function()
                    repeat
                        wait()
                    until game.Players.LocalPlayer.PlayerGui:FindFirstChild("Blindness")
                    if game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y >= 20000 then
                        game.Players.LocalPlayer.Character.CamScript.ClientServerClient:FireServer()
                        game.Players.LocalPlayer.Character.Weapons:FireServer()
                        game.Players.LocalPlayer.Character.CharacterTrait.ClothingTrigger:FireServer()
                        AutodieDebug = 0
                        wait(3)
                    else
                        wait(1)
                        local player = game.Players.LocalPlayer
                        local character = player.Character or player.CharacterAdded:Wait()
                        local humanoid = character:FindFirstChildOfClass("Humanoid")

                        if humanoid then
                            humanoid.Health = 0
                        end
                        AutodieDebug += 1
                        if Cache.AutoDie.Debug >= 6 then
                            game.Players.LocalPlayer.Character.Humanoid:Destroy()
                            AutodieDebug = 0
                        end
                    end
                end)
            end
        end
    end)
    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleTlpPosit.Value then return end;
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Spawns.Spawn1.CFrame
            end)
        end
    end);


    local Section = Tabs.Main:AddSection("Player2")


    Tabs.Main:AddButton({
        Title = "Save Zone",
        Description = "To the safe zone",
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(100000, 3500, 80000));
            local Base = Instance.new("Part", game.Workspace);
            Base.Size = Vector3.new(50, 1, 50);
            Base.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, -3, 0);
            Base.Anchored = true;
        end
    })


    players = {}

    for i,v in pairs(game:GetService("Players"):GetChildren()) do

    table.insert(players,v.Name)

    end
    
    local DropdownPlayer = Tabs.Main:AddDropdown("DropdownPlayer", {
        Title = "Select Players",
        Values = players,
        Multi = false,
        Default = 1
    })

    local function updateDropdownPlayerOptions()
        players = {}
        for i,v in pairs(game:GetService("Players"):GetChildren()) do
        table.insert(players,v.Name)
        end
        DropdownPlayer.Values = players
        DropdownPlayer:SetValue(Options.DropdownPlayer.Value)
    end



    Tabs.Main:AddButton({
        Title = "Refresh Player",
        Description = "Refresh player list",
        Callback = function()
            updateDropdownPlayerOptions()
        end
    })

    Tabs.Main:AddButton({
        Title = "Teleport Player",
        Description = "Teleport To Player",
        Callback = function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[Options.DropdownPlayer.Value].Character.HumanoidRootPart.CFrame
        end
    })

    local Section = Tabs.Main:AddSection("Auto Keybord when Taget die")
    --[[InputxxKeyboardKeyTagetdie = {}
    local Input = Tabs.Main:AddInput("KeyboardKeyTagetdieInput", {
        Title = "Keyboard Keys",
        Default = "",
        Placeholder = "Placeholder",
        Numeric = false, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(Value)
            InputxxKeyboardKeyTagetdie[i] = string.upper(tostring(Value))
        end
    })
    local Toggle = Tabs.Main:AddToggle("MyToggleStartKeyboardKeyTagetdie", {Title = "Start", Default = false })
    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleStartKeyboardKeyTagetdie.Value then return end;
                local player = game.Players:FindFirstChild(Options.DropdownPlayer.Value)
                if player then
                    local character = player.Character or player.CharacterAdded:Wait()
                    local humanoid = character:FindFirstChild("Humanoid")
                    if humanoid then
                        if humanoid.Health == 0 then
                            for _, Value in pairs(InputxxKeyboardKeyTagetdie) do
                                if Value ~= " " or Value ~= "" then
                                    game:GetService("VirtualInputManager"):SendKeyEvent(true, Value, false, game)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(false, Value, false, game)                  
                                end
                            end

                            wait(2)
                        end
                    else
                        print("No Humanoid found for player: " .. player.Name)
                    end
                end
            end)
        end
    end);]]


    InputxxKeyboardKeyTagetdie = {}

    local Input = Tabs.Main:AddInput("KeyboardKeyTagetdieInput", {
        Title = "Keyboard Keys",
        Default = "",
        Placeholder = "Placeholder",
        Numeric = false,
        Finished = false,
        Callback = function(Value)
            table.insert(InputxxKeyboardKeyTagetdie, string.upper(tostring(Value)))  -- ใช้ table.insert เพื่อเก็บคีย์
        end
    })

    local Toggle = Tabs.Main:AddToggle("MyToggleStartKeyboardKeyTagetdie", {Title = "Start", Default = false })

    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleStartKeyboardKeyTagetdie.Value then return end
                
                local player = game.Players:FindFirstChild(Options.DropdownPlayer.Value)
                if player then
                    local character = player.Character or player.CharacterAdded:Wait()
                    local humanoid = character:FindFirstChild("Humanoid")
                    
                    if humanoid then
                        if humanoid.Health == 0 then
                            for _, Value in pairs(InputxxKeyboardKeyTagetdie) do
                                if Value ~= " " and Value ~= "" then  -- แก้ไขที่นี่
                                    game:GetService("VirtualInputManager"):SendKeyEvent(true, Value, false, game)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(false, Value, false, game)                  
                                end
                            end
                            wait(2)
                        end
                    else
                        print("No Humanoid found for player: " .. player.Name)
                    end
                end
            end)
        end
    end)



    Tabs.Main:AddButton({
        Title = "Check",
        Description = "Buy Drink",
        Callback = function()
            print(game.Players:FindFirstChild(Options.DropdownPlayer.Value))
            print(InputxxKeyboardKeyTagetdie)
        end
    })



    local Section = Tabs.Quest:AddSection("Sam Quest")


    local Toggle = Tabs.Quest:AddToggle("MyToggleASQ", {Title = "Auto Sam Quest", Default = false })
    local Toggle = Tabs.Quest:AddToggle("MyToggleACQ", {Title = "Auto Compass Quest", Default = false })
    local Toggle = Tabs.Quest:AddToggle("MyToggleAUB", {Title = "Auto Unbox Box", Default = false })
    local Toggle = Tabs.Quest:AddToggle("MyToggleALTF", {Title = "Loot Fruit , Compass", Default = false })


    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleASQ.Value then return end;
                game.Workspace.Merchants.QuestMerchant.Clickable.Retum:FireServer("Claim1");
            end)
        end
    end);

    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleACQ.Value then return end;
                local Compass = game.Players.LocalPlayer.Backpack:FindFirstChild("Compass");
                local Compass2 = game.Players.LocalPlayer.Character:FindFirstChild("Compass");
                if Compass or Compass2 then
                    local OldPostiton = game.Players.LocalPlayer.Character.HumanoidRootPart.Position;
                    game.Players.LocalPlayer.Character.Humanoid:UnequipTools();
                    Compass.Parent = game.Players.LocalPlayer.Character;
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Compass.Poser.Value);
                    Compass:Activate();
                    wait(1);
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(OldPostiton);
                end
            end)
        end
    end);

    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleAUB.Value then return end;
                for _, Value in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if table.find(Cache.DevConfig["ListOfBox"], Value.Name) then
                        game.Players.LocalPlayer.Character.Humanoid:UnequipTools();
                        Value.Parent = game.Players.LocalPlayer.Character;
                        Value:Activate();
                    end
                end
            end)
        end
    end);

    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleALTF.Value then return end; 
                    for i, v in pairs(game.Workspace.Trees.Tree.Model:GetChildren()) do
                        if v.ClassName == "Tool" then
                            fireclickdetector(v.Main.ClickDetector)
                        end
                    end
                    for i, v in pairs(game.Workspace:GetChildren()) do
                        if string.match(v.Name, "Box") and v:FindFirstChild("Handle") then
                            v.Handle.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
                        end
                    end
            end)
        end
    end);

    local Section = Tabs.Quest:AddSection("Mission")
    local Toggle = Tabs.Quest:AddToggle("MyToggleGetMis", {Title = "Get Mission", Default = false })

    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleGetMis.Value or game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].Data.MissionObjective.Value ~= "None" then return end;
                game.Workspace.Merchants.ExpertiseMerchant.Clickable.Retum:FireServer();
            end)
        end
    end);
    
    local Section = Tabs.Quest:AddSection("Auto Claim")

    local Toggle = Tabs.Quest:AddToggle("MyToggleATCHR", {Title = "Auto Claim Hourly Reward", Default = false })
    local Toggle = Tabs.Quest:AddToggle("MyToggleATCDRW", {Title = "Auto Claim Daily Reward", Default = false })


    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleATCHR.Value then return end;
                game.Workspace.UserData["User_" .. game.Players.LocalPlayer.UserId].ClaimRewardHourly:FireServer("RewardMark");
            end)
        end
    end);
    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleATCDRW.Value then return end;
                game.Workspace.UserData["User_" .. game.Players.LocalPlayer.UserId].ClaimRewardDaily:FireServer("RewardMark");
            end)
        end
    end);

        local Section = Tabs.Start:AddSection("Drink")

    local Dropdown = Tabs.Start:AddDropdown("DropdownSelectDrink", {
        Title = "Select Drink",
        Values = Cache.DevConfig["ListOfDrink"],
        Multi = false,
        Default = 1
    })



    local Input = Tabs.Start:AddInput("InputDrink", {
        Title = "Amount Drink",
        Default = 1,
        Placeholder = "Placeholder",
        Numeric = false, 
        Finished = false
    })



    Tabs.Start:AddButton({
        Title = "Buy Drink",
        Description = "Buy Drink",
        Callback = function()
            if not Options.InputDrink.Value or not string.match(Options.InputDrink.Value, "%d+") or tonumber(string.match(Options.InputDrink.Value, "%d+")) < 0 then return end;
            for _ = 1, tonumber(string.match(Options.InputDrink.Value, "%d+")) do
                game.Workspace.Merchants.BetterDrinkMerchant.Clickable.Retum:FireServer(Options.DropdownSelectDrink.Value)
            end
        end
    })

    local Toggle = Tabs.Start:AddToggle("MyToggleATDWT", {Title = "Auto Drink", Default = false })

    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleATDWT.Value then return end;
                for _, Value in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if table.find(Cache.DevConfig["ListOfDrink"], Value.Name) then
                        game.Players.LocalPlayer.Character.Humanoid:UnequipTools();
                        Value.Parent = game.Players.LocalPlayer.Character;
                        Value:Activate();
                    end
                end
            end)
        end
    end);

    local Toggle = Tabs.Start:AddToggle("MyToggleATDDWT", {Title = "Auto Drop Drink", Default = false })

    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleATDDWT.Value then return end;
                for _, Value in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if table.find(Cache.DevConfig["ListOfDrink"], Value.Name) then
                        game.Players.LocalPlayer.Character.Humanoid:UnequipTools();
                        Value.Parent = game.Players.LocalPlayer.Character;
                        Value.Parent = game.Workspace;
                    end
                end
            end)
        end
    end);

    local Section = Tabs.Start:AddSection("Affinity")

    Tabs.Start:AddButton({
        Title = "Open Affinity",
        Description = "Open Affinity",
        Callback = function()
            fireclickdetector(game:GetService("Workspace").Merchants.AffinityMerchant.Clickable.ClickDetector)
        end
    })

    local Dropdown = Tabs.Start:AddDropdown("DropdownSelectPayWith", {
        Title = "Pay With",
        Values = {"Cash", "Gems"},
        Multi = false,
        Default = 1
    })

    --[[local Slider = Tabs.Start:AddSlider("SliderMeleeStats", {
        Title = "Melee Stats",
        Description = "Melee Stats",
        Default = 1,
        Min = 0,
        Max = 10,
        Rounding = 0,
        Callback = function(Value)
            print("Slider was changed:", Value)
        end
    })
    local Slider = Tabs.Start:AddSlider("SliderSwordStats", {
        Title = "Sword Stats",
        Description = "Sword Stats",
        Default = 1,
        Min = 0,
        Max = 10,
        Rounding = 0,
        Callback = function(Value)
            print("Slider was changed:", Value)
        end
    })
    local Slider = Tabs.Start:AddSlider("SliderSniperStats", {
        Title = "Sniper Stats",
        Description = "Sniper Stats",
        Default = 1,
        Min = 0,
        Max = 10,
        Rounding = 0,
        Callback = function(Value)
            print("Slider was changed:", Value)
        end
    })
    local Slider = Tabs.Start:AddSlider("SliderDefenseStats", {
        Title = "Defense Stats",
        Description = "Defense Stats",
        Default = 1,
        Min = 0,
        Max = 10,
        Rounding = 0,
        Callback = function(Value)
            print("Slider was changed:", Value)
        end
    })]]

    
    --[[local Input = Tabs.Start:AddInput("InputMeleeStats", {
        Title = "Melee Stats",
        Default = 1,
        Placeholder = "Max 10",
        Numeric = false, 
        Finished = false
    })
    local Input = Tabs.Start:AddInput("InputSwordStats", {
        Title = "Sword Stats",
        Default = 1,
        Placeholder = "Max 10",
        Numeric = false, 
        Finished = false
    })
    local Input = Tabs.Start:AddInput("InputSniperStats", {
        Title = "Sniper Stats",
        Default = 1,
        Placeholder = "Max 10",
        Numeric = false, 
        Finished = false
    })
    local Input = Tabs.Start:AddInput("InputDefenseStats", {
        Title = "Defense Stats",
        Default = 1,
        Placeholder = "Max 10",
        Numeric = false, 
        Finished = false
    })]]

    local Dropdown = Tabs.Start:AddDropdown("DropdownMeleeStats", {
        Title = "Melee Stats",
        Values = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
        Multi = false,
        Default = 1
    })
    local Dropdown = Tabs.Start:AddDropdown("DropdownSwordStats", {
        Title = "Sword Stats",
        Values = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
        Multi = false,
        Default = 1
    })
    local Dropdown = Tabs.Start:AddDropdown("DropdownSniperStats", {
        Title = "Sniper Stats",
        Values = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
        Multi = false,
        Default = 1
    })
    local Dropdown = Tabs.Start:AddDropdown("DropdownDefenseStats", {
        Title = "Defense Stats",
        Values = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
        Multi = false,
        Default = 1
    })
    local MultiDropdown = Tabs.Start:AddDropdown("MultiDropdownLockStats", {
        Title = "Lock Stats",
        Description = "You can select multiple values.",
        Values = {"Melee", "Sword", "Sniper", "Defense"},
        Multi = true,
        Default = {},
    })

    local Toggle = Tabs.Start:AddToggle("MyToggleRandomFruit1", {Title = "Random Fruit 1", Default = false })
    local Toggle = Tabs.Start:AddToggle("MyToggleRandomFruit2", {Title = "Random Fruit 2", Default = false })

    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleRandomFruit1.Value or not Options.DropdownSelectPayWith.Value then return end;
                local Count = 0;
                for _, Value in pairs({"Melee", "Sword", "Sniper", "Defense"}) do
                    if math.floor(math.fmod(game.Workspace.UserData["User_" .. game.Players.LocalPlayer.UserId].Data["DFT1" .. Value].Value, 1) * 10) >= Options["Dropdown" .. Value .. "Stats"].Value and Options["Dropdown" .. Value .. "Stats"].Value ~= 0 then continue end;
                    Count += 1;
                end
                print(Count)
                if Count == 4 then
                    game.Workspace.Merchants.AffinityMerchant.Clickable.Retum:FireServer("DFT1", Options.MultiDropdownLockStats.Value["Defense"] or false, Options.MultiDropdownLockStats.Value["Melee"] or false, Options.MultiDropdownLockStats.Value["Sniper"] or false, Options.MultiDropdownLockStats.Value["Sword"] or false, Options.DropdownSelectPayWith.Value)
                    wait(10);
                else
                    Fluent:Notify({Title = "Done!", Content = "This is a notification", SubContent = "SubContent", OptioDuration = 1});
                    Options.MyToggleRandomFruit1:SetValue(false);
                    wait(1);
                end
            end)
        end
    end);
    
   spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleRandomFruit2.Value or Options.DropdownSelectPayWith.Value then return end;
                local Count = 0;
                for _, Value in pairs({"Melee", "Sword", "Sniper", "Defense"}) do
                    if math.floor(math.fmod(game.Workspace.UserData["User_" .. game.Players.LocalPlayer.UserId].Data["DFT2" .. Value].Value, 1) * 10) >= Options["Dropdown" .. Value .. "Stats"].Value and Options["Dropdown" .. Value .. "Stats"].Value ~= 0 then continue end;
                    Count += 1;
                end
                if Count == 4 then
                    game.Workspace.Merchants.AffinityMerchant.Clickable.Retum:FireServer("DFT2", Options.MultiDropdownLockStats.Value["Defense"] or false, Options.MultiDropdownLockStats.Value["Melee"] or false, Options.MultiDropdownLockStats.Value["Sniper"] or false, Options.MultiDropdownLockStats.Value["Sword"] or false, Options.DropdownSelectPayWith.Value)
                    wait(10);
                else
                    Fluent:Notify({Title = "Done!", Content = "This is a notification", SubContent = "SubContent", OptioDuration = 5});
                    Options.MyToggleRandomFruit2:SetValue(false);
                    wait(1);
                end
            end)
        end
    end);

    Tabs.Start:AddButton({
        Title = "Check",
        Description = "Open Affinity",
        Callback = function()
            for _, Value in pairs({"Melee", "Sword", "Sniper", "Defense"}) do
                print(math.floor(math.fmod(game.Workspace.UserData["User_" .. game.Players.LocalPlayer.UserId].Data["DFT1" .. Value].Value, 1) * 10))
                print(Options["Dropdown" .. Value .. "Stats"].Value) 
                print(Options.MultiDropdownLockStats.Value["Defense"] or false)
                print(Options.DropdownSelectPayWith.Value)
                Fluent:Notify({Title = "Done!", OptioDuration = 5});
            end
        end
    })


    -------------------------------

    local Section = Tabs.Playerss:AddSection("Setting Taget")

    
    local DropdownPlayerrr = Tabs.Playerss:AddDropdown("DropdownPlayerrr", {
        Title = "Select Players",
        Values = players,
        Multi = false,
        Default = 1
    })

    local function updateDropdownPlayerrrOptions()
        players = {}
        for i,v in pairs(game:GetService("Players"):GetChildren()) do
        table.insert(players,v.Name)
        end
        DropdownPlayerrr.Values = players
        DropdownPlayerrr:SetValue(Options.DropdownPlayerrr.Value)
    end


    Tabs.Playerss:AddButton({
        Title = "Refresh Player",
        Description = "Refresh Player List",
        Callback = function()
            updateDropdownPlayerrrOptions()
        end
    })


    local Slider = Tabs.Playerss:AddSlider("SliderDistancePlayer", {
        Title = "Distance",
        Description = "Distance between multiplier and monster",
        Default = 6,
        Min = -16,
        Max = 16,
        Rounding = 1,
        Callback = function(ValueDistancePLY)
            DistancePlayer = tonumber(ValueDistancePLY)
        end
    })



    local Section = Tabs.Playerss:AddSection("About Taget")

    Tabs.Playerss:AddButton({
        Title = "Teleport Player",
        Description = "Teleport To Player",
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[Options.DropdownPlayerrr.Value].Character.HumanoidRootPart.CFrame
        end
    })

    local Toggle = Tabs.Playerss:AddToggle("MyToggleLTLPP", {Title = "Loop Teleport", Default = false })
    local Toggle = Tabs.Playerss:AddToggle("MyToggleBPLY", {Title = "Bring Player", Default = false })
    local Toggle = Tabs.Playerss:AddToggle("MyToggleVPRY", {Title = "View Player", Default = false })


    spawn(function()
        while wait() do
            if Options.MyToggleVPRY.Value then
                pcall(function()
                    game.Workspace.CurrentCamera.CameraSubject = game.Players[Options.DropdownPlayerrr.Value].Character.Humanoid;
                end)
            end
        end
    end)
        
    spawn(function()
        while wait() do
            if not Options.MyToggleVPRY.Value then
                pcall(function()
                    game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid;
                end)
            end
        end
    end)

    spawn(function()
        while wait() do
            pcall(function()
                if Options.MyToggleBPLY.Value then
                    game.Players[Options.DropdownPlayerrr.Value].Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2) + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * DistancePlayer
                end
                if Options.MyToggleLTLPP.Value then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =  game.Players[Options.DropdownPlayerrr.Value].Character.HumanoidRootPart.CFrame * CFrame.new(2, 0, 0) + game.Players[Options.DropdownPlayerrr.Value].Character.HumanoidRootPart.CFrame.lookVector * DistancePlayer
                end
            end)
        end
    end)

    local Section = Tabs.Playerss:AddSection("Hitbox")
    local Input = Tabs.Playerss:AddInput("InputHitBoxSize", {
        Title = "Hit Box Size",
        Default = "",
        Placeholder = "Placeholder",
        Numeric = false, 
        Finished = false
    })
    local Toggle = Tabs.Playerss:AddToggle("MyToggleStartHitBox", {Title = "Start Hit Box", Default = false })
    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleStartHitBox.Value then return end;
                local HitBox = Options.InputHitBoxSize.Value
                for _, v in pairs(game.Players:GetChildren()) do
                    if v.Character:FindFirstChild("HumanoidRootPart") and v.Name ~= game.Players.LocalPlayer.Name then
                        v.Character.HumanoidRootPart.Size = Vector3.new(HitBox, HitBox, HitBox);
                        v.Character.HumanoidRootPart.Transparency = 0.9;
                        v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue");
                        v.Character.HumanoidRootPart.Material = "Neon";
                        v.Character.HumanoidRootPart.CanCollide = false;
                    end
                end
            end)
        end
    end)
    local hasCannonBall = false 
    local messageSent = false
    local function handleCannonBall()
        local playersWithCannonBall = {}
        local resourceName = "Resources_" .. game.Players.LocalPlayer.UserId  -- สร้างชื่อ Resource
        local cannonBallCFrameTask  -- ตัวแปรสำหรับเก็บ coroutine
    
        -- ค้นหาผู้เล่นที่ถือ Cannon Ball
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            local character = player.Character
            if character and player ~= game.Players.LocalPlayer then  
                local tool = character:FindFirstChild("Cannon Ball")
                if tool then
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        table.insert(playersWithCannonBall, player) 
                    end
                end
            end
        end
    
        if #playersWithCannonBall > 0 then
            game.Workspace.UserData["User_"..game.Players.LocalPlayer.UserId].UpdateHaki:FireServer()
            if not hasCannonBall then
                local cannonBall = game.Players.LocalPlayer.Backpack:FindFirstChild("Cannon Ball")
                if cannonBall then
                    cannonBall.Parent = game.Players.LocalPlayer.Character
                    hasCannonBall = true  -- ตั้งค่าว่าผู้เล่นถือ Cannon Ball แล้ว
                end
            end
            -- ส่งข้อความไปยังผู้เล่นที่ถือ CannonBall
            
            for _, player in ipairs(playersWithCannonBall) do
                if not messageSent then
                    local message = "/w " .. player.Name .. " Banned Cannon Ball"
                    local args = {
                        [1] = message,
                        [2] = "All"
                    }
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
                    print("ส่งข้อความไปยัง: " .. player.Name)
                    messageSent = true
                end
            end
    
            local playerCFrame = playersWithCannonBall[1].Character.HumanoidRootPart.CFrame
    
            local args = {
                [1] = playerCFrame,
                [2] = workspace.IslandPirate.Stones.Part
            }
            game:GetService("Players").LocalPlayer.Character:FindFirstChild("Cannon Ball").RemoteEvent:FireServer(unpack(args))
    
            -- ตั้งค่า CFrame ของ CannonBall ให้ตรงกับผู้เล่นที่ถือ CannonBall
            if cannonBallCFrameTask then
                cannonBallCFrameTask:cancel()  -- หยุด coroutine ก่อนถ้ามี
            end
    
            cannonBallCFrameTask = coroutine.create(function()
                while true do
                    workspace.ResourceHolder[resourceName].CannonBall.CFrame = playerCFrame
                    wait(0.1)  -- หยุดสั้นๆ เพื่อไม่ให้ใช้ CPU มากเกินไป
                end
            end)
    
            coroutine.resume(cannonBallCFrameTask) 
            game.Workspace.UserData["User_"..game.Players.LocalPlayer.UserId].UpdateHaki:FireServer()
        else
            print("ไม่มีผู้เล่นที่ถือ CannonBall")
        end
    end
    local Section = Tabs.Playerss:AddSection("Anti Cannon")
    local Toggle = Tabs.Playerss:AddToggle("MyToggleStartanticannon", {Title = "Anti Cannon Ball", Default = false })
    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleStartanticannon.Value then return end;
                handleCannonBall()
                wait(1)
            end)
        end
    end)




    local Section = Tabs.Misc:AddSection("Spawn")

    local Toggle = Tabs.Misc:AddToggle("MyToggleLATSPW", {Title = "Auto Respawn", Default = false })
    local Toggle = Tabs.Misc:AddToggle("MyToggleNoClip", {Title = "NoClip", Default = false })

    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleLATSPW.Value or not game.Players.LocalPlayer.PlayerGui.Load.Frame.Visible then return end;
                wait(3);
                firesignal(game.Players.LocalPlayer.PlayerGui.Load.Frame.Load.MouseButton1Click);
            end)
        end
    end);

    local Section = Tabs.Misc:AddSection("Auto Attack")

    local Toggle = Tabs.Misc:AddToggle("MyToggleATCOSK", {Title = "Click On Screen", Default = false })

    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleATCOSK.Value then return end;
                game:GetService("VirtualUser"):ClickButton1(Vector2.new(99999, 99999));
            end)
        end
    end);


    local Weaponlist = {}
    local Weapon = nil

    for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
        table.insert(Weaponlist,v.Name)
    end



    local DropdownWTool = Tabs.Misc:AddDropdown("DropdownWTool", {
        Title = "Select Tools",
        Values = Weaponlist,
        Multi = false,
        Default = ""
    })



    local function updateDropdownWToolOptions()
        local WeaponlistNew = {}
        for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
            table.insert(WeaponlistNew,v.Name)
        end
        DropdownWTool.Values = WeaponlistNew
        DropdownWTool:SetValue(Options.DropdownWTool.Value)
    end



    Tabs.Misc:AddButton({
        Title = "Refresh",
        Description = "Refresh Tool list",
        Callback = function()
            updateDropdownWToolOptions()
        end
    })




    local Toggle = Tabs.Misc:AddToggle("MyToggleATRQ", {Title = "Auto Equip Tool", Default = false })
    local Toggle = Tabs.Misc:AddToggle("MyToggleATATVT", {Title = "Auto Activate Tool", Default = false })


    spawn(function()
        while wait() do
            pcall(function()
                if Options.MyToggleATRQ.Value and not game.Players.LocalPlayer.Character:FindFirstChild(Options.DropdownWTool.Value) then
                    game.Players.LocalPlayer.Backpack:FindFirstChild(Options.DropdownWTool.Value).Parent = game.Players.LocalPlayer.Character
                end
                if Options.MyToggleATATVT.Value and game.Players.LocalPlayer.Character:FindFirstChild(Options.DropdownWTool.Value) then
                    game.Players.LocalPlayer.Character:FindFirstChild(Options.DropdownWTool.Value):Activate()
                end
            end)
        end
    end)

    local Section = Tabs.Misc:AddSection("Auto Keyboard")

    local Input = Tabs.Misc:AddInput("DelayINPUT", {
        Title = "Delay",
        Default = "",
        Placeholder = "Placeholder",
        Numeric = false, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(Value)
            xpcall(function()
                DelayINPUTVALUE = tonumber(Value) + 0
            end, function()
                DelayINPUTVALUE = 0
            end)
        end
    })

    InputxxKeyboardKey = {}
    for i = 1, 5 do
        local Input = Tabs.Misc:AddInput("KeyboardKeysInput", {
            Title = "Keyboard Keys",
            Default = "",
            Placeholder = "Placeholder",
            Numeric = false, -- Only allows numbers
            Finished = false, -- Only calls callback when you press enter
            Callback = function(Value)
                InputxxKeyboardKey[i] = string.upper(tostring(Value))
            end
        })
    end

    local Toggle = Tabs.Misc:AddToggle("MyToggleATKBB", {Title = "Auto Keyboard", Default = false })

    spawn(function()
        while wait() do
            pcall(function()
                if Options.MyToggleATKBB.Value then
                    wait(DelayINPUTVALUE)
                    for _, Value in pairs(InputxxKeyboardKey) do
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

    local Section = Tabs.Misc:AddSection("Auto Haki")

    local Slider = Tabs.Misc:AddSlider("SliderDistanceHakiLimitMinimal", {
        Title = "Haki Limit Minimal",
        Description = "Haki function will stop only when haki limit more then haki energy",
        Default = 50,
        Min = 0,
        Max = 99,
        Rounding = 1,
        Callback = function(Value)
            HakiLimitMinimal = tonumber(Value)
        end
    })
    
    local Slider = Tabs.Misc:AddSlider("SliderDistanceHakiLimitMaximum", {
        Title = "Haki Limit Maximum",
        Description = "Haki function will working only when haki limit more then haki energy",
        Default = 50,
        Min = 0,
        Max = 99,
        Rounding = 1,
        Callback = function(Value)
            HakiLimitMaximum = tonumber(Value)
        end
    })

    local Toggle = Tabs.Misc:AddToggle("MyToggleATUBSHK", {Title = "Auto Use Buso Haki", Default = false })
    local Toggle = Tabs.Misc:AddToggle("MyToggleATUKHK", {Title = "Auto Use Kenbunshoku Haki", Default = false })
    local Toggle = Tabs.Misc:AddToggle("MyToggleATRequirHaki", {Title = "Auto Requir Haki", Default = false })
    spawn(function()
        while wait() do
            pcall(function()
                if Options.MyToggleATUBSHK.Value then
                    if not game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].UsingHaki.Value and game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].HakiBar.Value >= game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].Data.HakiLevel.Value / 100 * HakiLimitMaximum then
                        game.Workspace.UserData["User_"..game.Players.LocalPlayer.UserId].UpdateHaki:FireServer()
                        wait(3)
                    elseif game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].UsingHaki.Value and game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].HakiBar.Value <= game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].Data.HakiLevel.Value / 100 * HakiLimitMinimal then
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
                if Options.MyToggleATUKHK.Value then
                    if game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].HakiBar.Value >= game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].Data.HakiLevel.Value / 100 * HakiLimitMaximum then
                        game.Workspace.UserData["User_"..game.Players.LocalPlayer.UserId].III:FireServer("On", game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].Data.HakiLevel.Value)
                    elseif game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].HakiBar.Value <= game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].Data.HakiLevel.Value / 100 * HakiLimitMinimal then
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
                if Options.MyToggleATUKHK.Value then
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

    spawn(function()
        while wait(0.1) do
            pcall(function()
                if Options.MyToggleATRequirHaki.Value then
                    game.Workspace.UserData["User_"..game.Players.LocalPlayer.UserId].III:FireServer("On", game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].Data.HakiLevel.Value)
                    wait(0.01)
                    game.Workspace.UserData["User_"..game.Players.LocalPlayer.UserId].III:FireServer("Off", game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].Data.HakiLevel.Value)
                end
            end)
        end
    end)



    local Section = Tabs.Misc:AddSection("Get Item")

    Tabs.Misc:AddButton({
        Title = "Get Seastone Cestus",
        Description = "Need Max Melee",
        Callback = function()
            game.Workspace.UserData["User_"..game.Players.LocalPlayer.UserId].UpdateMelee:FireServer("Seastone Cestus");
        end
    })

    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait()
        game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)    
    end)

    local Section = Tabs.Farming:AddSection("Farming Only With Gun")
    local Input = Tabs.Farming:AddInput("InputDistanceMonter", {
        Title = "Distance",
        Default = "8",
        Placeholder = "Placeholder",
        Numeric = true, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
    })
    local Dropdown = Tabs.Farming:AddDropdown("DropdownXYMonter", {
        Title = "Type Position",
        Values = {"X", "Y"},
        Multi = false,
        Default = 1
    })
    local Toggle = Tabs.Farming:AddToggle("MyToggleOneHitMonter", {Title = "One Hit", Description = "Only OPL: Anarchy", Default = false })
    local Toggle = Tabs.Farming:AddToggle("MyToggleBypassOneHitMonter", {Title = "Bypass One Hit", Description = "Only OPL: Anarchy", Default = false })

    local DropdownWToolMonter = Tabs.Farming:AddDropdown("DropdownWTooMonterl", {
        Title = "Select Tools",
        Values = Weaponlist,
        Multi = false,
        Default = 1
    })
    local function updateDropdownWToolMonterOptions()
        local WeaponlistNew = {}
        for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
            table.insert(WeaponlistNew,v.Name)
        end
        DropdownWToolMonter.Values = WeaponlistNew
        DropdownWToolMonter:SetValue(Options.DropdownWTooMonterl.Value)
    end
    Tabs.Farming:AddButton({
        Title = "Refresh",
        Description = "Refresh Tool list",
        Callback = function()
            updateDropdownWToolMonterOptions()
        end
    })
    local Section = Tabs.Farming:AddSection("Farming Monter")
    local MultiDropdown = Tabs.Farming:AddDropdown("MultiDropdownBringMonter", {
        Title = "Select Bring",
        Description = "You can select multiple values.",
        Values = Cache.DevConfig["ListOfMonter"],
        Multi = true,
        Default = {},
    })
    local MultiTeleportMonterDropdown = Tabs.Farming:AddDropdown("MultiDropdownTeleportMonter", {
        Title = "Select Teleport",
        Description = "You can select multiple values.",
        Values = Cache.DevConfig["ListOfMonter"],
        Multi = true,
        Default = {},
    })
    local Toggle = Tabs.Farming:AddToggle("MyToggleBringMonter", {Title = "Bring Monter", Default = false })
    local ToggleTeleportgMonter = Tabs.Farming:AddToggle("MyToggleTeleportgMonter", {Title = "Teleport Monter", Default = false })

    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleBringMonter.Value or not IsSpawned() then return end;
                for _, Value in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if Options.MultiDropdownBringMonter.Value[Value.Name] then
                        Value.HumanoidRootPart.CanCollide = false;
                        Value.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 0) + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * Options.InputDistanceMonter.Value;
                    end
                end
            end)
        end
    end);
    spawn(function()
        local function Attack(Obj)
            if not Options.DropdownWTooMonterl.Value or Options.DropdownWTooMonterl.Value == "" then return end;
            local ListTools = {"Slingshot", "Stars", "Crossbow", "Flintlock", "Cannon Ball"};
            local Tool;
            repeat
                game.Players.LocalPlayer.Character.Humanoid:UnequipTools();
                for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if not Tool and v.ClassName == "Tool" and string.match(string.lower(v.Name), string.lower(Options.DropdownWTooMonterl.Value)) then
                        v.Parent = game.Players.LocalPlayer.Character;
                        Tool = v;
                        break;
                    end
                end
                if not Options.DropdownWTooMonterl.Value then return end;
                wait();
            until Tool;
            local TimeOut = 0;
            local OldKill = game:GetService("Workspace").UserData["User_" .. game.Players.LocalPlayer.UserId].Data.Kills.Value;
            repeat
                pcall(function()
                    if table.find(ListTools, Tool.Name) then
                        Tool.RemoteEvent:FireServer(CFrame.new(Obj.HumanoidRootPart.Position), Obj.HumanoidRootPart);
                    else
                        Tool:Activate();
                    end
                end);
                TimeOut += 1;
                wait(0.1);
            until OldKill < game:GetService("Workspace").UserData["User_" .. game.Players.LocalPlayer.UserId].Data.Kills.Value or not Options.MyToggleTeleportgMonter.Value or TimeOut > 10;
        end
        while wait() do
            pcall(function()
                if not Options.MyToggleTeleportgMonter.Value or not IsSpawned() then return end;
                for _, Value in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if not Options.MyToggleTeleportgMonter.Value then return end;
                    if Options.MultiDropdownTeleportMonter.Value[Value.Name] and Value:FindFirstChild("HumanoidRootPart") and Value:FindFirstChild("Humanoid") and Value.Humanoid.Health > 0 then
                        if Options.DropdownXYMonter.Value == "X" then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Value.HumanoidRootPart.Position + Vector3.new(0, 0, Options.InputDistanceMonter.Value), Value.HumanoidRootPart.Position);
                            if Options.MyToggleOneHitMonter.Value then Value.Humanoid.Health = 0 end;
                            Attack(Value);
                        elseif Options.DropdownXYMonter.Value == "Y" then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Value.HumanoidRootPart.Position + Vector3.new(0, Options.InputDistanceMonter.Value, 0), Value.HumanoidRootPart.Position);
                            if Options.MyToggleOneHitMonter.Value then Value.Humanoid.Health = 0 end;
                            Attack(Value);
                        end
                    end
                end
            end)
        end
    end);
    
    ToggleTeleportgMonter:OnChanged(function() 
        Options.MyToggleNoClip:SetValue(Options.MyToggleTeleportgMonter.Value)
    end)
    
    game:GetService("RunService").Stepped:Connect(function()
        if Options.MyToggleNoClip.Value and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
        end
    end)
    
    game:GetService("RunService").RenderStepped:Connect(function()
        if Options.MyToggleBypassOneHitMonter.Value then
            setscriptable(game.Players.LocalPlayer, "SimulationRadius", true);
            game.Players.LocalPlayer.SimulationRadius = math.huge * math.huge;
        end
    end);
    
    game.Players.LocalPlayer.SimulationRadiusChanged:Connect(function(radius)
        if Options.MyToggleBypassOneHitMonter.Value then
            radius = 9e9;
            return radius;
        end
    end);

    local Section = Tabs.Farming:AddSection("Farming Only With Fruits")
    local Toggle = Tabs.Farming:AddToggle("MyToggleLightFarm", {Title = "Light Fruit", Default = false })




    spawn(function()
        while wait() do
            if not Options.MyToggleLightFarm.Value then return end;
                pcall(function()
                    local vtc = getsenv(game.Players.LocalPlayer.Character.Powers.Light)["VTCrv"]
                    local plr = game:GetService("Players").LocalPlayer
                    
                    if not plr.Character:FindFirstChild("Powers") or not plr.Character.Powers:FindFirstChild("Light") then
                        warn("Powers.Light ไม่พบใน Character")
                        return
                    end
                    
                    for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        local humanoid = enemy:FindFirstChildOfClass("Humanoid")
                        local humanoidRootPart = enemy:FindFirstChild("HumanoidRootPart")
                        
                        if humanoid and humanoidRootPart then
                            
                            local teleportPosition = humanoidRootPart.Position + Vector3.new(0, 20, 0)
                    
                            plr.Character:SetPrimaryPartCFrame(CFrame.new(teleportPosition))
                    
                            wait(0.1)
                    
                    
                            while humanoid.Health > 0 do
                                humanoid.Health = 0
                                plr.Character.Powers.Light.RemoteEvent:FireServer(vtc, "LightPower8", "StartCharging", humanoidRootPart.CFrame, workspace.Cave.Stone)
                                plr.Character.Powers.Light.RemoteEvent:FireServer(vtc, "LightPower8", "StopCharging", humanoidRootPart.CFrame, workspace.IslandSnowyMountains.Stone.Stone, 100)
                                wait(0.1)
                            end
                        else
                            warn("ศัตรู " .. enemy.Name .. " ไม่มี Humanoid หรือ HumanoidRootPart")
                        end
                    end
                end)
            end
        end
    end)



    local Section = Tabs.Teleport:AddSection("Open GUI")

    local DropdownOpenGUIII = Tabs.Teleport:AddDropdown("DropdownOpenGUI", {
        Title = "Open GUI NPC",
        Values = InstanceToName(game:GetService("Workspace").Merchants:GetChildren()),
        Multi = false,
        Default = 1
    })
    DropdownOpenGUIII:OnChanged(function(Value)
        if not Options.DropdownOpenGUI.Value or not game:GetService("Workspace").Merchants[Options.DropdownOpenGUI.Value] or not CheckPath(game:GetService("Workspace").Merchants[Options.DropdownOpenGUI.Value], "Clickable", "ClickDetector") then return end;
        fireclickdetector(game:GetService("Workspace").Merchants[Options.DropdownOpenGUI.Value].Clickable.ClickDetector);
    end);

    local Section = Tabs.Teleport:AddSection("Teleport")
    local DropdownTeleportNPCC = Tabs.Teleport:AddDropdown("DropdownTeleportNPC", {
        Title = "Teleport NPC",
        Values = InstanceToName(game:GetService("Workspace").Merchants:GetChildren()),
        Multi = false,
        Default = 1
    })
    DropdownTeleportNPCC:OnChanged(function(Value)
        if not Options.DropdownTeleportNPC.Value or not game:GetService("Workspace").Merchants[Options.DropdownTeleportNPC.Value] or not CheckPath(game.Players.LocalPlayer.Character, "HumanoidRootPart") then return end;
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Workspace").Merchants[Options.DropdownTeleportNPC.Value].HumanoidRootPart.Position + Vector3.new(0, 5, 0));
    end);

    local DropdownTeleportISLANDD = Tabs.Teleport:AddDropdown("DropdownTeleportIsland", {
        Title = "Teleport Island",
        Values = Allset.DevSetting["ListTeleportIslandIndex"],
        Multi = false,
        Default = 1
    })
    DropdownTeleportISLANDD:OnChanged(function(Value)
        if not Options.DropdownTeleportIsland.Value or not Allset.DevSetting.ListTeleportIsland[Options.DropdownTeleportIsland.Value] or not CheckPath(game.Players.LocalPlayer.Character, "HumanoidRootPart") then return end;
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Allset.DevSetting.ListTeleportIsland[Options.DropdownTeleportIsland.Value];
    end);
    







    local Section = Tabs.Spam:AddSection("Spam Skill")

    local DropdownPlayerrrSpam = Tabs.Spam:AddDropdown("DropdownPlayerrrSpam", {
        Title = "Select Players",
        Values = players,
        Multi = false,
        Default = 1
    })

    local function updateDropdownPlayerrrSpamOptions()
        players = {}
        for i,v in pairs(game:GetService("Players"):GetChildren()) do
        table.insert(players,v.Name)
        end
        DropdownPlayerrrSpam.Values = players
        DropdownPlayerrrSpam:SetValue(Options.DropdownPlayerrrSpam.Value)
    end

    Tabs.Spam:AddButton({
        Title = "Refresh Player",
        Description = "Refresh Player List",
        Callback = function()
            updateDropdownPlayerrrSpamOptions()
        end
    })



    --[[local MultiDropdown = Tabs.Spam:AddDropdown("DropdownDevillFruitsSpamskill", {
        Title = "Devill Fruits",
        Description = "You can select multiple values.",
        Values = Cache.DevConfig["ListOfDevillFruit"],
        Multi = true,
        Default = {""},
    })]]

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

    local Input = Tabs.Spam:AddInput("SkillKeyINPUT", {
        Title = "Skill Key",
        Default = "",
        Placeholder = "Placeholder",
        Numeric = false, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(Value)
            FruitsSkillKey, NumberFruits = unpack(GetPowerFruitForKey(Value))
            if NumberFruits == 1 then
                FruitsSkill = game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].Data.DevilFruit.Value
            elseif NumberFruits == 2 then
                FruitsSkill = game:GetService("Workspace").UserData["User_"..game.Players.LocalPlayer.UserId].Data.DevilFruit2.Value
            end
        end
    })

    local Dropdown = Tabs.Spam:AddDropdown("DropdownTagSpamskill", {
        Title = "Type Of Taget",
        Values = Cache.DevConfig["ListOfTypeSkillTaget"],
        Multi = false,
        Default = "Mouse"
    })

    local Input = Tabs.Spam:AddInput("DelaySpamskillINPUT", {
        Title = "Delay",
        Default = 0.001,
        Placeholder = "Placeholder",
        Numeric = false, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(Value)
            DalaySpamskill = Value
        end
    })

    local Slider = Tabs.Spam:AddSlider("SliderSkillChargeSpam", {
        Title = "Skill Charge",
        Description = "",
        Default = 100,
        Min = 1,
        Max = 100,
        Rounding = 1,
        Callback = function(Value)
            SliderSkillChargeSpammm = tonumber(Value)
        end
    })

    --local Toggle = Tabs.Spam:AddToggle("MyToggleSpamSkillK", {Title = "Spam Skill", Default = false })

    local Toggle = Tabs.Spam:AddToggle("MyToggleSpamSkillK", {
        Title = "Spam Skill", 
        Description = "Toggle description",
        Default = false,
        Callback = function(state) 
            if FruitsSkill == "Magma" then
                FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCmel"]
            elseif FruitsSkill == "Gas" then
                FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCtb"]
            elseif FruitsSkill == "Sand" then
                FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCaufn"]
            elseif FruitsSkill == "Dark" then
                FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCjebaj"]
            elseif FruitsSkill == "Chilly" then
                FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCewddsfe"]
            elseif FruitsSkill == "Rumble" then
                FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCzyhf"]
            elseif FruitsSkill == "Snow" then
                FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCqkxtn"]
            elseif FruitsSkill == "Light" then
                FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCrv"]
            elseif FruitsSkill == "String" then
                FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCjwbvx"]
            elseif FruitsSkill == "Flare" then
                FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCmgwcm"]
            elseif FruitsSkill == "Love" then
                FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCwxt"]
            elseif FruitsSkill == "Phoenix" then
                FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCytb"]
            elseif FruitsSkill == "Quake" then
                FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCebvc"]
            elseif FruitsSkill == "Candy" then
                FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCdhabvd"]
            elseif FruitsSkill == "Bomb" then
                FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCcpkghc"]
            elseif FruitsSkill == "Venom" then
                FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCiuew"]
            elseif FruitsSkill == "Rumble1" then
                FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCwnuy"]
            elseif FruitsSkill == "Gravity" then
                FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCjh"]
            elseif FruitsSkill == "Plasma" then
                FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCpwd"]
            elseif FruitsSkill == "Quake" then
                FruitKeyArgumet = getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCebvc"]
            end   
        end 
    })


    --[[FruitKeyArgumet = {}



        if FruitsSkill == "Magma" then
            table.insert(FruitKeyArgumet, getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCmel"])
        elseif FruitsSkill == "Gas" then
            table.insert(FruitKeyArgumet, getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCtb"])
        elseif FruitsSkill == "Sand" then
            table.insert(FruitKeyArgumet, getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCaufn"])
        elseif FruitsSkill == "Dark" then
            table.insert(FruitKeyArgumet, getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCjebaj"])
        elseif FruitsSkill == "Chilly" then
            table.insert(FruitKeyArgumet, getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCewddsfe"])
        elseif FruitsSkill == "Rumble" then
            table.insert(FruitKeyArgumet, getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCzyhf"])    
        elseif FruitsSkill == "Snow" then
            table.insert(FruitKeyArgumet, getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCqkxtn"])
        elseif FruitsSkill == "Light" then
            table.insert(FruitKeyArgumet, getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCrv"])
        elseif FruitsSkill == "String" then
            table.insert(FruitKeyArgumet, getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCjwbvx"])
        elseif FruitsSkill == "Flare" then
            table.insert(FruitKeyArgumet, getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCmgwcm"])
        elseif FruitsSkill == "Love" then
            table.insert(FruitKeyArgumet, getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCwxt"])
        elseif FruitsSkill == "Phoenix" then
            table.insert(FruitKeyArgumet, getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCytb"])
        elseif FruitsSkill == "Quake" then
            table.insert(FruitKeyArgumet, getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCebvc"])
        elseif FruitsSkill == "Candy" then
            table.insert(FruitKeyArgumet, getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCdhabvd"])
        elseif FruitsSkill == "Bomb" then
            table.insert(FruitKeyArgumet, getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCcpkghc"])
        elseif FruitsSkill == "Venom" then
            table.insert(FruitKeyArgumet, getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCiuew"])
        elseif FruitsSkill == "Rumble1" then
            table.insert(FruitKeyArgumet, getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCwnuy"])
        elseif FruitsSkill == "Gravity" then
            table.insert(FruitKeyArgumet, getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCjh"])
        elseif FruitsSkill == "Plasma" then
            table.insert(FruitKeyArgumet, getsenv(game.Players.LocalPlayer.Character.Powers[FruitsSkill])["VTCpwd"])
        end    ]]





    local function GetPosition()
        if Options.DropdownTagSpamskill.Value == "Mouse" then
            Position = game.Players.LocalPlayer:GetMouse().Hit;
        elseif Options.DropdownTagSpamskill.Value == "Yourself" then
            Position = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame;
        elseif Options.DropdownTagSpamskill.Value == "Players" then 
            Position = game.Players[Options.DropdownPlayerrrSpam.Value].Character.HumanoidRootPart.CFrame;
        elseif Options.DropdownTagSpamskill.Value == "Monsters" then
            for _, Value in pairs(game.Workspace.Enemies:GetChildren()) do
                Position = Value.HumanoidRootPart.CFrame;
                break;
            end
        end
        return Position or game.Players.LocalPlayer:GetMouse().Hit;
    end



    spawn(function()
        while wait() do
            if Options.MyToggleSpamSkillK.Value then
                pcall(function()
                    local plr = game:GetService("Players").LocalPlayer
                    if FruitsSkill == "Quake" then
                        plr.Character.Powers[FruitsSkill].RemoteEvent:FireServer(FruitKeyArgumet, string.format("%sPower%s", FruitsSkill, FruitsSkillKey), "StopCharging", workspace.IslandSnowyMountains.Stone.Stone, GetPosition(), SliderSkillChargeSpammm, game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
                    elseif FruitsSkill == "Rumble" then
                        
                        plr.Character.Powers[FruitsSkill].RemoteEvent:FireServer(FruitKeyArgumet, string.format("%sPower%s", FruitsSkill, FruitsSkillKey), "StopCharging", GetPosition(), workspace.IslandSnowyMountains.Stone.Stone, 200, GetPosition())
                    else
                        plr.Character.Powers[FruitsSkill].RemoteEvent:FireServer(FruitKeyArgumet, string.format("%sPower%s", FruitsSkill, FruitsSkillKey), "StartCharging", game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame) 
                        plr.Character.Powers[FruitsSkill].RemoteEvent:FireServer(FruitKeyArgumet, string.format("%sPower%s", FruitsSkill, FruitsSkillKey), "StopCharging", GetPosition(), workspace.IslandSnowyMountains.Stone.Stone, SliderSkillChargeSpammm)
                    end
                    if game.Players.LocalPlayer.Character.Humanoid.Health <= 0 then
                        Options.MyToggleSpamSkillK.Value:SetValue(false);
                    end
                    wait(tonumber(DalaySpamskill or 1));
                end)
            end
        end
    end)

    Tabs.Spam:AddButton({
        Title = "sheck",
        Description = "Need Max Melee",
        Callback = function()
            print(FruitsSkill)
            print(FruitKeyArgumet)
            print(Options.DropdownTagSpamskill.Value)
            print(Options.DropdownPlayerrrSpam.Value)
            print(string.format("%sPower%s", FruitsSkill, FruitsSkillKey))
            print(FruitsSkillKey)
            print(GetPosition())
            print(SliderSkillChargeSpammm)
            for i, v in pairs(FruitKeyArgumet) do
                print(i, v)
            end
        end
    })
    



    local Section = Tabs.HunterX:AddSection("Setting HunterX")

    local Input = Tabs.HunterX:AddInput("WebHookINPUT", {
        Title = "WebHook",
        Default = "https://discord.com/api/webhooks/921002942620893184/yritWiOPovRsBch9EMzTWuh0aKHWZy8e5KYuKrvbdU0PnxJbaSoVOnIGIFPj6tUIUe19",
        Placeholder = "Placeholder",
        Numeric = false, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(Value)
            Webhookkkk = Value
        end
    })
    Tabs.HunterX:AddButton({
        Title = "Rejoin",
        Description = "",
        Callback = function()
            game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId)
        end
    })

    local Input = Tabs.HunterX:AddInput("DelayHunterINPUT", {
        Title = "Delay",
        Default = 1,
        Placeholder = "Placeholder",
        Numeric = false, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(Value)
            DalayHunterx = Value
        end
    })

    local Toggle = Tabs.HunterX:AddToggle("MyToggleRareFurits", {Title = "RareFurits", Default = true })
    local Toggle = Tabs.HunterX:AddToggle("MyToggleRareBoxxx", {Title = "RareBox", Default = true })
    local Toggle = Tabs.HunterX:AddToggle("MyToggleAuraFuritsxx", {Title = "AuraFurits", Default = true })
    local Toggle = Tabs.HunterX:AddToggle("MyToggleServerHopingxx", {Title = "ServerHoping", Default = true })
    local Toggle = Tabs.HunterX:AddToggle("MyToggleEmergencyReJoinxx", {Title = "EmergencyReJoin", Default = true })

    local Input = Tabs.HunterX:AddInput("EmergencyReJoinHunterINPUT", {
        Title = "EmergencyReJoin",
        Default = 40,
        Placeholder = "Placeholder",
        Numeric = false, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(Value)
            EmergencyReJoinHunterxx = Value
        end
    })

    local Input = Tabs.HunterX:AddInput("EmergencyReJoinTimeHunterINPUT", {
        Title = "EmergencyReJoinTime",
        Default = 5,
        Placeholder = "Placeholder",
        Numeric = false, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(Value)
            EmergencyReJoinTimeHunterxx = Value
        end
    })

    local Toggle = Tabs.HunterX:AddToggle("MyToggleFoundWillStop", {Title = "FoundWillStop", Default = true })


    local Toggle = Tabs.HunterX:AddToggle("MyToggleStartHubterx", {Title = "Start", Default = false })

    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleStartHubterx.Value then return end;
                    Settings = {
                        WebHook = Webhookkkk, -- <string> input your webhook.
                        Delay = DalayHunterx, -- <number> delay when start.
                        RareFurits = Options.MyToggleRareFurits.Value, -- <boolen> find rare,ultra furits.
                        RareBox = Options.MyToggleRareBoxxx.Value, -- <boolen> find rare,ultra box.
                        AuraFurits = Options.MyToggleAuraFuritsxx.Value, -- <boolen> find aura.
                        ServerHoping = Options.MyToggleServerHopingxx.Value, -- <boolen> hoping.
                        EmergencyReJoin = Options.MyToggleEmergencyReJoinxx.Value, -- <boolen> if not hoping in EmergencyReJoinTime will rejoin abruptly.
                        EmergencyReJoinTime = EmergencyReJoinHunterxx, -- <number> time for EmergencyReJoin.
                        NotSameServerListMax = EmergencyReJoinTimeHunterxx, -- <number> max list server.
                        FoundWillStop = Options.MyToggleFoundWillStop.Value, -- <boolen> if found will stop rejoin.
                        Title = "HunterX", -- <string> Title webhook.
                        Color = "10694961", -- <string> color code for webhook get here https://www.spycolor.com/ .
                        It_Is_Latest_Version = false --<boolen> if the script you are using did't Latest if notify you for updates. and you update at Hunter v1.
                    }
                    
                    loadstring(game:HttpGet('https://raw.githubusercontent.com/KAKXHUB/HunterX-KAKxHub/main/README.md', true))()
            end)
        end
    end);

    local Section = Tabs.Dupe:AddSection("Dupe < OPL: Anarchy >")

    Tabs.Dupe:AddButton({
        Title = "No Save Data",
        Description = "",
        Callback = function()
            workspace.UserData["User_"..game.Players.LocalPlayer.UserId].UpdateClothing_Extras:FireServer("A", "\255", 34)
            game:GetService("Players").LocalPlayer.Character.CharacterTrait.ClothingTrigger:FireServer() 
        end
    })
    local Toggle = Tabs.Dupe:AddToggle("MyToggleDestroyBox", {Title = "Destroy Common box", Default = false })
    local Toggle = Tabs.Dupe:AddToggle("MyToggleFrezMob", {Title = "Freeze Monters", Default = false })
    local player = game.Players.LocalPlayer -- ใช้ใน LocalScript
    local backpack = player:FindFirstChildOfClass("Backpack")
    local function removeTools()
        local toolsToRemove = {"Common Box", "Uncommon Box"} -- รายชื่อ Tool ที่ต้องการลบ
        for _, toolName in ipairs(toolsToRemove) do
            local tool = backpack:FindFirstChild(toolName) -- ค้นหา Tool ตามชื่อ
            if tool then
                tool:Destroy() 
            end
        end
    end

    

    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleDestroyBox.Value then return end;
                removeTools() 
            end)
        end
    end);
    spawn(function()
        while wait(1) do
            pcall(function()
                if not Options.MyToggleFrezMob.Value then return end;
                for _, monster in pairs(workspace.Enemies:GetDescendants()) do
                    if monster:IsA("Model") and monster:FindFirstChild("Humanoid") then
                        monster:SetPrimaryPartCFrame(CFrame.new(50000, 3500, 80000))
                    end
                end
            end)
        end
    end);

    local Section = Tabs.Dupe:AddSection("Dupe Compass!!")
    local Input = Tabs.Dupe:AddInput("TimeToCompassINPUT", {
        Title = "Time To Compass",
        Default = 0.5,
        Placeholder = "Placeholder",
        Numeric = false,
        Finished = false, 
    })
    local Toggle = Tabs.Dupe:AddToggle("MyToggleAutoSamQuest", {Title = "Sam Quest", Default = false })
    local Toggle = Tabs.Dupe:AddToggle("MyToggleAutoCompassQ", {Title = "Compass Quest", Default = false })
    local Toggle = Tabs.Dupe:AddToggle("MyToggleAutoUbf", {Title = "Unbox", Default = false })
    local Toggle = Tabs.Dupe:AddToggle("MyToggleAutoDropC", {Title = "Drop Compass", Default = false })
    local Toggle = Tabs.Dupe:AddToggle("MyToggleAutoLootC", {Title = "Loot Compass", Default = false })
    local Toggle = Tabs.Dupe:AddToggle("MyToggleIncreaseC", {Title = "Increase Compass but starts reset!!", Default = false })

    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleAutoSamQuest.Value then return end;
                game.Workspace.Merchants.QuestMerchant.Clickable.Retum:FireServer("Claim10");
                game.Workspace.Merchants.QuestMerchant.Clickable.Retum:FireServer("Claim10");
                game.Workspace.Merchants.QuestMerchant.Clickable.Retum:FireServer("Claim10");
                game.Workspace.Merchants.QuestMerchant.Clickable.Retum:FireServer("Claim10");
            end)
        end
    end);
    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleAutoCompassQ.Value then return end;
                local Compass = game.Players.LocalPlayer.Backpack:FindFirstChild("Compass");
                local Compass2 = game.Players.LocalPlayer.Character:FindFirstChild("Compass");
                if Compass or Compass2 then
                    local OldPostiton = game.Players.LocalPlayer.Character.HumanoidRootPart.Position;
                    game.Players.LocalPlayer.Character.Humanoid:UnequipTools();
                    Compass.Parent = game.Players.LocalPlayer.Character;
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Compass.Poser.Value);
                    Compass:Activate();
                    wait(Options.TimeToCompassINPUT.Value);
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(OldPostiton);
                end
            end)
        end
    end);
    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleAutoUbf.Value then return end;
                for _, Value in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if table.find(Cache.DevConfig["ListOfBox"], Value.Name) then
                        game.Players.LocalPlayer.Character.Humanoid:UnequipTools();
                        Value.Parent = game.Players.LocalPlayer.Character;
                        Value:Activate();
                    end
                end
            end)
        end
    end);
    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleAutoDropC.Value then return end;
                for _, Value in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    game.Players.LocalPlayer.Character.Humanoid:UnequipTools();
                    Value.Parent = game.Players.LocalPlayer.Character;
                    Value.Parent = game.Workspace;
                end
            end)
        end
    end);
    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleAutoLootC.Value then return end;
                for _, Item in pairs(game.Workspace:GetChildren()) do
                    if Item.Name == "Compass" and Item:FindFirstChild("Handle") then
                        Item.Handle.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position);
                    end
                end
            end)
        end
    end);



    local Section = Tabs.Dupe:AddSection("Dupe Drink Water!!")
    local SelectWaterDropdown = Tabs.Dupe:AddDropdown("SelectWaterDropdown", {
        Title = "Select Water",
        Values = Cache.DevConfig["ListOfDrink"],
        Multi = false,
        Default = ""
    })
    local Input = Tabs.Dupe:AddInput("AmountDrinkINPUT", {
        Title = "Amount Drink",
        Default = 1,
        Placeholder = "Placeholder",
        Numeric = false,
        Finished = false, 
    })
    Tabs.Dupe:AddButton({
        Title = "Buy Drink",
        Description = "Buy Drink",
        Callback = function()
            if not Options.AmountDrinkINPUT.Value or not string.match(Options.AmountDrinkINPUT.Value, "%d+") or tonumber(string.match(Options.AmountDrinkINPUT.Value, "%d+")) < 0 then return end;
            for _ = 1, tonumber(string.match(Options.AmountDrinkINPUT.Value, "%d+")) do
                game.Workspace.Merchants.BetterDrinkMerchant.Clickable.Retum:FireServer(Options.SelectWaterDropdown.Value)
            end
        end
    })
    local Toggle = Tabs.Dupe:AddToggle("MyToggleAutoDrinkWater", {Title = "Drink", Default = false })
    local Toggle = Tabs.Dupe:AddToggle("MyToggleAutoDrinkDrop", {Title = "Drop", Default = false })
    local Toggle = Tabs.Dupe:AddToggle("MyToggleAutoDrinkLoot", {Title = "Loot", Default = false })

    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleAutoDrinkWater.Value then return end;
                for _, Value in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if table.find(Cache.DevConfig["ListOfDrink"], Value.Name) then
                        game.Players.LocalPlayer.Character.Humanoid:UnequipTools();
                        Value.Parent = game.Players.LocalPlayer.Character;
                        Value:Activate();
                    end
                end
            end)
        end
    end);
    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleAutoDrinkDrop.Value then return end;
                for _, Value in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if table.find(Cache.DevConfig["ListOfDrink"], Value.Name) then
                        game.Players.LocalPlayer.Character.Humanoid:UnequipTools();
                        Value.Parent = game.Players.LocalPlayer.Character;
                        Value.Parent = game.Workspace;
                    end
                end
            end)
        end
    end);
    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleAutoDrinkLoot.Value then return end;
                for _, Item in pairs(game.Workspace:GetChildren()) do
                    if table.find(Cache.DevConfig["ListOfDrink"], Item.Name) and Item:FindFirstChild("Handle") then
                        Item.Handle.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position);
                    end
                end
            end)
        end
    end);

    local function performActions()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4831, 570, -7070)
        game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
        wait(1)
        workspace:WaitForChild("UserData"):WaitForChild("User_"..game.Players.LocalPlayer.UserId):WaitForChild("Stats"):FireServer()
        game.Workspace.Merchants.ExpertiseMerchant.Clickable.Retum:FireServer()
        
        local errorWords = {"Players", "damage", "damage.", "Deal"}
        local found = true 
        wait(1)
        while found do
        
            local Text = game:GetService("Players").LocalPlayer.PlayerGui.MissionGui.Frame.Frame.Description.Text
            
            found = false 
        
        
            for _, word in ipairs(errorWords) do
                if string.find(Text, word) then
                    print("พบคำว่า '" .. word .. "' -> ทำงานต่อ")
                    found = true 
                    break
                end
            end
        
        
            if not found then
                print("ไม่พบคำแล้ว")
                break
            else
                workspace:WaitForChild("UserData"):WaitForChild("User_"..game.Players.LocalPlayer.UserId):WaitForChild("Stats"):FireServer()
                game.Workspace.Merchants.ExpertiseMerchant.Clickable.Retum:FireServer()
                wait(1)
            end
        end
        
        game.Workspace.Merchants.QuestMerchant.Clickable.Retum:FireServer("Claim1")
        wait(1)
        workspace.UserData["User_"..game.Players.LocalPlayer.UserId].ChallengesRemote:FireServer("Claim", "Daily4")
        workspace.Merchants.SniperMerchant.Clickable.Retum:FireServer("Slingshot", 1000)
        
        local Compass = game.Players.LocalPlayer.Backpack:FindFirstChild("Compass")
        local Compass2 = game.Players.LocalPlayer.Character:FindFirstChild("Compass")
        if Compass or Compass2 then
            local OldPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
            game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
            Compass.Parent = game.Players.LocalPlayer.Character
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Compass.Poser.Value)
            Compass:Activate()
            wait(1)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(OldPosition)
        end
        
        wait(1)
        for _, Value in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if table.find(Cache.DevConfig["ListOfBox"], Value.Name) then
                game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                Value.Parent = game.Players.LocalPlayer.Character
                Value:Activate()
            end
        end
        
        wait(1)
        for _, Value in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if table.find(Cache.DevConfig["ListOfDveilFruit"], Value.Name) then
                game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                Value.Parent = game.Players.LocalPlayer.Character
            end
        end
        
        wait(1)
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local fruitList = Cache.DevConfig["ListOfDveilFruit"]
        for _, fruitName in ipairs(fruitList) do
            local fruit = LocalPlayer.Character:FindFirstChild(fruitName)
            if fruit and fruit:FindFirstChild("Relay") then
                fruit.Relay:FireServer(0)
            else
                warn(fruitName .. " not found in character or has no Relay")
            end
        end
        
        wait(1)
        workspace.UserData["User_"..game.Players.LocalPlayer.UserId].ChallengesRemote:FireServer("Claim", "Challenge9")
        
    end
    
    

    local Section = Tabs.Dupe:AddSection("Quest Gems")
    Tabs.Dupe:AddButton({
        Title = "Quest Day",
        Description = "eee",
        Callback = function()
            performActions()
        end
    })

    local Toggle = Tabs.Dupe:AddToggle("MyToggleAutoClaimDaily", {Title = "Claim Daily", Default = false })
    local Toggle = Tabs.Dupe:AddToggle("MyToggleAutoKillMonter", {Title = "Kill Monter Quest", Default = false })
    local Toggle = Tabs.Dupe:AddToggle("MyToggleAutoAllGems", {Title = "Auto All", Default = false })


    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleAutoClaimDaily.Value then return end;
                workspace.UserData["User_"..game.Players.LocalPlayer.UserId].ChallengesRemote:FireServer("Claim", "Daily1")
                workspace.UserData["User_"..game.Players.LocalPlayer.UserId].ChallengesRemote:FireServer("Claim", "Daily2")
                workspace.UserData["User_"..game.Players.LocalPlayer.UserId].ChallengesRemote:FireServer("Claim", "Daily3")
                workspace.UserData["User_"..game.Players.LocalPlayer.UserId].ChallengesRemote:FireServer("Claim", "Daily4")
                workspace.UserData["User_"..game.Players.LocalPlayer.UserId].ChallengesRemote:FireServer("Claim", "AllDaily")
                wait(3)
            end)
        end
    end);
    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleAutoKillMonter.Value then return end;
                if game:GetService("Players").LocalPlayer.PlayerGui.Challenges.Frame.Frame.DailyFrame.ScrollingFrame.Challenge_3.Claim.TextLabel.Text == "Claim" then
                    Options.MyToggleTeleportgMonter:SetValue(true)
                else
                    Options.MyToggleTeleportgMonter:SetValue(false)
                end
            end)
        end
    end);
    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleAutoAllGems.Value then return end
                if game:GetService("Players").LocalPlayer.PlayerGui.Challenges.Frame.Frame.DailyFrame.CompletionFrame.Claim.TextLabel.Text == "Complete" then
                    Options.MyToggleTeleportgMonter:SetValue(false)
                    if game:GetService("Players").LocalPlayer.PlayerGui.Challenges.Frame.Frame.DailyFrame.ScrollingFrame.Challenge_4.Claim.TextLabel.Text == "Completed" and game:GetService("Players").LocalPlayer.PlayerGui.Challenges.Frame.Frame.DailyFrame.CompletionFrame.Claim.TextLabel.Text ~= "Complete" then
                        Options.MyToggleTeleportgMonter:SetValue(true)
                    else
                        performActions()
                    end
                else
                    Options.MyToggleTeleportgMonter:SetValue(false)
                    if game:GetService("Players").LocalPlayer.PlayerGui.Challenges.Frame.Frame.DailyFrame.ScrollingFrame.Challenge_4.Claim.TextLabel.Text == "Completed" and game:GetService("Players").LocalPlayer.PlayerGui.Challenges.Frame.Frame.DailyFrame.CompletionFrame.Claim.TextLabel.Text ~= "Complete" then
                        Options.MyToggleTeleportgMonter:SetValue(true)
                    else
                        performActions()
                    end
                end
            end)
        end
    end);










end


-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

Fluent:Notify({
    Title = "Fluent",
    Content = "The script has been loaded.",
    Duration = 8
})

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()


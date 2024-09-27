local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "AUTOFARM " .. Fluent.Version,
    SubTitle = "by PeetJKA",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "gem" }),
    Quest = Window:AddTab({ Title = "Quest", Icon = "clipboard" }),
    Start = Window:AddTab({ Title = "Stats", Icon = "list" }),
    Playerss = Window:AddTab({ Title = "Players", Icon = "users" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "database" }),
    Spam = Window:AddTab({ Title = "Spam", Icon = "locate" }),
    HunterX = Window:AddTab({ Title = "HunterX", Icon = "unplug" }),
    Dupe = Window:AddTab({ Title = "Dupe", Icon = "copy" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })

}

local Cache = { DevConfig = {} };

Cache.DevConfig["ListOfBox"] = {"Common Box", "Uncommon Box", "Rare Box", "Ultra Rare Box"};
Cache.DevConfig["ListOfDrink"] = {"Cider+", "Lemonade+", "Juice+", "Smoothie+"};
Cache.DevConfig["ListOfDrinkFormMixer"] = {"Cider", "Lemonade", "Juice", "Smoothie", "Milk", "Golden Apple"};




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


    spawn(function()
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
    end)


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
    
    local Dropdown = Tabs.Main:AddDropdown("DropdownPlayer", {
        Title = "Select Players",
        Values = players,
        Multi = false,
        Default = 1
    })



    Tabs.Main:AddButton({
        Title = "Reset Player",
        Description = "Reset player list",
        Callback = function()
            players = {}

            for i,v in pairs(game:GetService("Players"):GetChildren()) do
        
            table.insert(players,v.Name)
        
            end
            Dropdown:SetValue(players)
        end
    })

    Tabs.Main:AddButton({
        Title = "Teleport Player",
        Description = "Teleport To Player",
        Callback = function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[Options.DropdownPlayer.Value].Character.HumanoidRootPart.CFrame
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





    -------------------------------

    local Section = Tabs.Playerss:AddSection("Setting Taget")

    
    local Dropdown = Tabs.Playerss:AddDropdown("DropdownPlayerrr", {
        Title = "Select Players",
        Values = players,
        Multi = false,
        Default = 1
    })




    Tabs.Playerss:AddButton({
        Title = "Reset Player",
        Description = "Reset Player List",
        Callback = function()
            players = {}

            for i,v in pairs(game:GetService("Players"):GetChildren()) do
        
            table.insert(players,v.Name)
        
            end
            Dropdown:SetValue(players)
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
    local Toggle = Tabs.Playerss:AddToggle("MyToggleVPRY", 
    {
        Title = "View Player", 
        Description = "View Player",
        Default = false
        Callback = function(state)
            if state then
                game.Workspace.CurrentCamera.CameraSubject = game.Players[Options.DropdownPlayerrr.Value].Character.Humanoid
            else
                game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
            end
        end 
    })


    spawn(function()
        while wait() do
            pcall(function()
                local Ply = Options.DropdownPlayerrr.Value
                if Options.MyToggleBPLY.Value then
                    Ply.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2) + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * DistancePlayer
                end
                if Options.MyToggleLTLPP.Value then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =  Ply.Character.HumanoidRootPart.CFrame * CFrame.new(2, 0, 0) + Ply.Character.HumanoidRootPart.CFrame.lookVector * DistancePlayer
                end
            end)
        end
    end)

    local Section = Tabs.Misc:AddSection("Spawn")

    local Toggle = Tabs.Misc:AddToggle("MyToggleLATSPW", {Title = "Auto Respawn", Default = false })

    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleLATSPW.Value or not game.Players.LocalPlayer.PlayerGui.Load.Frame.Visible then return end;
                wait(3);
                firesignal(game.Players.LocalPlayer.PlayerGui.Load.Frame.Load.MouseButton1Click);
            end)
        end
    end);

    --[[local Section = Tabs.Misc:AddSection("Auto Attack")

    local Toggle = Tabs.Misc:AddToggle("MyToggleATCOSK", {Title = "Click On Screen", Default = false })

    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleATCOSK.Value then return end;
                game:GetService("VirtualUser"):ClickButton1(Vector2.new(99999, 99999));
            end)
        end
    end);

    local Input = Tabs.Misc:AddInput("InputWeapon", {
        Title = "Tools Name",
        Default = "Default",
        Placeholder = "Placeholder",
        Numeric = false, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(Value)
            for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if v.ClassName == "Tool" and string.match(string.lower(v.Name), string.lower(tostring(Value))) then
                    InputWeaponName = v.Name
                end
            end
            for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if v.ClassName == "Tool" and string.match(string.lower(v.Name), string.lower(tostring(Value))) then
                    InputWeaponName = v.Name
                end
            end
        end
    })

    local Toggle = Tabs.Misc:AddToggle("MyToggleATRQ", {Title = "Auto Equip Tool", Default = false })
    local Toggle = Tabs.Misc:AddToggle("MyToggleATATVT", {Title = "Auto Activate Tool", Default = false })


    spawn(function()
        while wait() do
            pcall(function()
                if Options.MyToggleATRQ.Valu and not game.Players.LocalPlayer.Character:FindFirstChild(InputWeaponName) then
                    game.Players.LocalPlayer.Backpack:FindFirstChild(InputWeaponName).Parent = game.Players.LocalPlayer.Character
                end
                if Options.MyToggleATATVT.Valu and game.Players.LocalPlayer.Character:FindFirstChild(InputWeaponName) then
                    game.Players.LocalPlayer.Character:FindFirstChild(InputWeaponNamee):Activate()
                end
            end)
        end
    end)


    local Section = Tabs.HunterX:AddSection("Setting HunterX)

    local Input = Tabs.HunterX:AddInput("WebHookINPUT", {
        Title = "WebHook",
        Default = "",
        Placeholder = "Placeholder",
        Numeric = false, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(Value)
            Webhookkkk = Value
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
                        It_Is_Latest_Version = true --<boolen> if the script you are using did't Latest if notify you for updates. and you update at Hunter v1.
                    }
                    
                    loadstring(game:HttpGet('https://raw.githubusercontent.com/KAKXHUB/HunterX-KAKxHub/main/README.md', true))()
            end)
        end
    end);]]

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


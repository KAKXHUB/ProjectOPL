local Versionxx = "1.3.5"
print("Version: "..Versionxx)
---------------

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Moodeng Fruit " .. Versionxx,
    SubTitle = "by PeetJKA",
    TabWidth = 160,
    Size = UDim2.fromOffset(487.2, 404.8),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    Main = Window:AddTab({ Title = "Find Item", Icon = "gem" }),
    Farm = Window:AddTab({ Title = "Farm", Icon = "gem" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}



local Options = Fluent.Options

do

    local Section = Tabs.Main:AddSection("Setting")
    local Weaponlist = {}
    local Weapon = nil

    for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
        table.insert(Weaponlist,v.Name)
    end



    local DropdownWTool = Tabs.Main:AddDropdown("DropdownWTool", {
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



    Tabs.Main:AddButton({
        Title = "Refresh",
        Description = "Refresh Tool list",
        Callback = function()
            updateDropdownWToolOptions()
        end
    })
    local Toggle = Tabs.Main:AddToggle("MyToggleATRQ", {Title = "Auto Equip Tool", Default = false })
    spawn(function()
        while wait() do
            pcall(function()
                if Options.MyToggleATRQ.Value and not game.Players.LocalPlayer.Character:FindFirstChild(Options.DropdownWTool.Value) then
                    game.Players.LocalPlayer.Backpack:FindFirstChild(Options.DropdownWTool.Value).Parent = game.Players.LocalPlayer.Character
                end
            end)
        end
    end)
    local Section = Tabs.Main:AddSection("Find Item")
    local MultiDropdownFIndItemm = Tabs.Main:AddDropdown("MultiDropdownFindItem", {
        Title = "Selec Item",
        Description = "You can select multiple values.",
        Values = {"Bible Shadow", "Orb Atomic", "Red Shard", "Orb Mystery", "Spiritual Orb", "Orb Dark"},
        Multi = true,
        Default = {},
    })
    local Toggle = Tabs.Main:AddToggle("MyToggleFindItem", {Title = "Start", Default = false })
    local Toggle = Tabs.Main:AddToggle("MyToggleStopFindItem", {Title = "Auto Stop", Default = false })
    --[[spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleFindItem.Value then return end;
                if Options.MultiDropdownFindItem.Value == "Bible Shadow" or Options.MultiDropdownFindItem.Value == "Orb Atomic" or Options.MultiDropdownFindItem.Value == "Red Shard" then
                    local SungJinWoo = workspace:FindFirstChild("Sung Jin Woo [Boss]")
                    local humanoidRootPartSungJinWoo = SungJinWoo:FindFirstChild("HumanoidRootPart")
                    local humanoidSungJinWoo = SungJinWoo:FindFirstChild("Humanoid")
                    if humanoidSungJinWoo and humanoidRootPartSungJinWoo then
                        if humanoidSungJinWoo.Health > 0 then
                            repeat
                                task.wait()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = humanoidRootPartSungJinWoo.CFrame * CFrame.new(0, 0, 8)
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild(Options.DropdownWTool.Value).Move3.Fire:FireServer()
                            until Options.MyToggleFindItem.Value == false or humanoidSungJinWoo.Health <= 0
                        end
                    end
                elseif Options.MultiDropdownFindItem.Value == "Orb Mystery" or Options.MultiDropdownFindItem.Value == "Spiritual Orb" then
                    local AlaGod = workspace:FindFirstChild("Ala God [Boss]")
                    local humanoidRootPartAlaGod = AlaGod:FindFirstChild("HumanoidRootPart")
                    local humanoidAlaGod = AlaGod:FindFirstChild("Humanoid")
                    if humanoidAlaGod and humanoidRootPartAlaGod then
                        if humanoidAlaGod.Health > 0 then
                            repeat
                                task.wait()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = humanoidRootPartAlaGod.CFrame * CFrame.new(0, 0, 8)
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild(Options.DropdownWTool.Value).Move3.Fire:FireServer()
                            until Options.MyToggleFindItem.Value == false or humanoidAlaGod.Health <= 0
                        end
                    end
                elseif Options.MultiDropdownFindItem.Value == "Orb Dark" then
                    local Asta = workspace:FindFirstChild("Asta [Boss]")
                    local humanoidRootPartAsta = Asta:FindFirstChild("HumanoidRootPart")
                    local humanoidAsta = Asta:FindFirstChild("Humanoid")
                    if humanoidAsta and humanoidRootPartAsta then
                        if humanoidAsta.Health > 0 then
                            repeat
                                task.wait()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = humanoidRootPartAsta.CFrame * CFrame.new(0, 0, 8)
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild(Options.DropdownWTool.Value).Move3.Fire:FireServer()
                            until Options.MyToggleFindItem.Value == false or humanoidAsta.Health <= 0
                        end
                    end
                end
            end)
        end
    end)]]
    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleFindItem.Value then return end
                -- ตรวจสอบแต่ละค่าภายใน MultiDropdownFindItem.Value
                for itemName,_ in pairs(Options.MultiDropdownFindItem.Value) do
                    -- ตรวจสอบว่า itemName ตรงกับไอเท็มที่ต้องการหรือไม่
                    if itemName == "Bible Shadow" or itemName == "Orb Atomic" or itemName == "Red Shard" then
                        local SungJinWoo = workspace:FindFirstChild("Sung Jin Woo [Boss]")
                        if SungJinWoo then
                            local humanoidRootPartSungJinWoo = SungJinWoo:FindFirstChild("HumanoidRootPart")
                            local humanoidSungJinWoo = SungJinWoo:FindFirstChild("Humanoid")
                            if humanoidSungJinWoo and humanoidRootPartSungJinWoo then
                                if humanoidSungJinWoo.Health > 0 then
                                    repeat
                                        task.wait()
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = humanoidRootPartSungJinWoo.CFrame * CFrame.new(0, 0, 15)
                                        game:GetService("Players").LocalPlayer.Character:FindFirstChild(Options.DropdownWTool.Value).Move3.Fire:FireServer()
                                    until Options.MyToggleFindItem.Value == false or humanoidSungJinWoo.Health <= 0
                                elseif humanoidSungJinWoo.Health <= 0 then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,500,0)
                                end
                            end
                        end
                    elseif itemName == "Orb Mystery" or itemName == "Spiritual Orb" then
                        local AlaGod = workspace:FindFirstChild("Ala God [Boss]")
                        if AlaGod then
                            local humanoidRootPartAlaGod = AlaGod:FindFirstChild("HumanoidRootPart")
                            local humanoidAlaGod = AlaGod:FindFirstChild("Humanoid")
                            if humanoidAlaGod and humanoidRootPartAlaGod then
                                if humanoidAlaGod.Health > 0 then
                                    repeat
                                        task.wait()
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = humanoidRootPartAlaGod.CFrame * CFrame.new(0, 0, 15)
                                        game:GetService("Players").LocalPlayer.Character:FindFirstChild(Options.DropdownWTool.Value).Move3.Fire:FireServer()
                                    until Options.MyToggleFindItem.Value == false or humanoidAlaGod.Health <= 0
                                elseif humanoidAlaGod.Health <= 0 then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,500,0)
                                end
                            end
                        end
                    elseif itemName == "Orb Dark" then
                        local Asta = workspace:FindFirstChild("Asta [Boss]")
                        if Asta then
                            local humanoidRootPartAsta = Asta:FindFirstChild("HumanoidRootPart")
                            local humanoidAsta = Asta:FindFirstChild("Humanoid")
                            if humanoidAsta and humanoidRootPartAsta then
                                if humanoidAsta.Health > 0 then
                                    repeat
                                        task.wait()
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = humanoidRootPartAsta.CFrame * CFrame.new(0, 0, 15)
                                        game:GetService("Players").LocalPlayer.Character:FindFirstChild(Options.DropdownWTool.Value).Move3.Fire:FireServer()
                                    until Options.MyToggleFindItem.Value == false or humanoidAsta.Health <= 0
                                elseif humanoidAsta.Health <= 0 then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,500,0)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end)
    
    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleStopFindItem.Value then return end;    
                for i,v in pairs(Options.MultiDropdownFindItem.Value) do
                    if game.Players.LocalPlayer.Backpack:FindFirstChild(i) then
                        MultiDropdownFIndItemm:SetValue({
                            i = false
                        })
                    end
                end
            end)
        end
    end)
    Tabs.Main:AddButton({
        Title = "Check",
        Description = "Open Affinity",
        Callback = function()
            for _, itemName in pairs(Options.MultiDropdownFindItem.Value) do
                print(_, itemName)
            end
        end
    })
    local Section = Tabs.Farm:AddSection("Gems")
    local Weaponlisttt = {}
    local Weapon = nil

    for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
        table.insert(Weaponlisttt,v.Name)
    end



    local DropdownWToollll = Tabs.Farm:AddDropdown("DropdownWToollll", {
        Title = "Select Tools",
        Values = Weaponlisttt,
        Multi = false,
        Default = ""
    })



    local function updateDropdownWToolOptionsss()
        local WeaponlistNewww = {}
        for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
            table.insert(WeaponlistNewww,v.Name)
        end
        DropdownWToollll.Values = WeaponlistNewww
        DropdownWToollll:SetValue(Options.DropdownWToollll.Value)
    end
    Tabs.Farm:AddButton({
        Title = "Refresh",
        Description = "Refresh Tool list",
        Callback = function()
            updateDropdownWToolOptionsss()
        end
    })
    local Toggle = Tabs.Farm:AddToggle("MyToggleATRQsss", {Title = "Auto Equip Tool", Default = false })
    spawn(function()
        while wait() do
            pcall(function()
                if Options.MyToggleATRQsss.Value and not game.Players.LocalPlayer.Character:FindFirstChild(Options.DropdownWToollll.Value) then
                    game.Players.LocalPlayer.Backpack:FindFirstChild(Options.DropdownWToollll.Value).Parent = game.Players.LocalPlayer.Character
                end
            end)
        end
    end)
    local Toggle = Tabs.Farm:AddToggle("MyToggleFarmgems", {Title = "Gems", Default = false })


    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleFarmgems.Value then return end
                local zones = {
                    workspace.Map.Mon["10000-50000"],
                    workspace.Map.Mon["50000-100000"],
                    workspace.Map.Mon.Event,
                    workspace.Map.Mon.Slime
                }
                for _, zone in pairs(zones) do
                    for _, v in pairs(zone:GetChildren()) do
                        local humanoid = v:FindFirstChild("Humanoid")
                        if humanoid and humanoid.Health > 0 then
                            repeat
                                task.wait()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 8)
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild(Options.DropdownWToollll.Value).Move3.Fire:FireServer()
                            until Options.MyToggleFarmgems.Value == false or humanoid.Health <= 0
                        end
                    end
                end
            end)
        end
    end)
    
    --[[spawn(function()
        while wait() do
            if not Options.MyToggleFarmgems.Value then return end;
            pcall(function()
                local zones = {
                    workspace.Map.Mon["10000-50000"],
                    workspace.Map.Mon["50000-100000"],
                    workspace.Map.Mon.Event,
                    workspace.Map.Mon.Slime
                }
                for _, zone in pairs(zones) do
                    for i,v in pairs(zone:GetDescendants()) do
                        if v.Humanoid.Health >= 0 then
                            repeat 
                                task.wait()
                                game.Players.LocalPlayer.Character.humanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,8)
                                game:GetService("Players").LocalPlayer.Character:FindFirstChild(Options.DropdownWToollll.Value).Move3.Fire:FireServer()
                            until Options.MyToggleFarmgems.Value == false or v.Humanoid.Health <= 0
                        end
                    end
                end
            end)
        end
    end)]]












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
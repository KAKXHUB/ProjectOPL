local Versionxx = "1.1.7"
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
    local Section = Tabs.Main:AddSection("Find Item")
    local MultiDropdown = Tabs.Main:AddDropdown("MultiDropdownFindItem", {
        Title = "Selec Item",
        Description = "You can select multiple values.",
        Values = {"Bible Shadow", "Orb Atomic", "Red Shard", "Orb Mystery", "Spiritual Orb"},
        Multi = true,
        Default = {},
    })
    local Toggle = Tabs.Main:AddToggle("MyToggleFindItem", {Title = "Start", Default = false })
    spawn(function()
        while wait() do
            if not Options.MyToggleFindItem.Value then return end;
            pcall(function()
                
            end)
        end
    end)
    spawn(function()
        while wait() do
            if not Options.MyToggleFindItem.Value then return end;
            pcall(function()
                for itemName,v in pairs(Options.MultiDropdownFindItem.Value) do
                    if game.Players.LocalPlayer.Backpack:FindFirstChild(itemName) then
                        print(itemName)
                    end
                end
            end)
        end
    end)
    Tabs.Main:AddButton({
        Title = "Check",
        Description = "Open Affinity",
        Callback = function()
            for i,v in pairs(Options.MultiDropdownFindItem.Value) do
                if game.Player.LocalPlayer.Backpack:FindFirstChild(i) then
                    print(i)
                end
            end
        end
    })















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
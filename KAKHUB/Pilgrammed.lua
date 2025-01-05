local Versionxx = "1.1.2"
print("Version: "..Versionxx)
---------------

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Find Orb " .. Versionxx,
    SubTitle = "by PeetJKA",
    TabWidth = 160,
    Size = UDim2.fromOffset(487.2, 404.8),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    Main = Window:AddTab({ Title = "Find Orb", Icon = "gem" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}



 function TP(P)
   local Distance = (P.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude -- จุดที่จะไป Position Only
   local Speed = 1000 -- ความเร็วของมึง
   tweenService, tweenInfo = game:GetService("TweenService"), TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear)
   tween = tweenService:Create(game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart, tweenInfo, {CFrame = P})
   tween:Play()
 end
 function Equip(ToolX)
    if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(ToolX) then
        getgenv().Tol = game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(ToolX)
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tol)
    end
end

local Options = Fluent.Options

do

    local MultiDropdown = Tabs.Main:AddDropdown("MultiDropdownSelecOrb", {
        Title = "Selec Orb",
        Description = "You can select multiple values.",
        Values = {"Darksteel", "Zinc", "iron", "Tin", "Copper", "Diamond", "Mithril", "Sapphire", "Sulfur", "Demetal", "Silver"},
        Multi = true,
        Default = {""},
    })

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
    local Toggle = Tabs.Main:AddToggle("MyToggleFindOrb", {Title = "Start", Default = false })

    spawn(function()
        while wait() do
            pcall(function()
                if not Options.MyToggleFindOrb.Value then return end
                local selectedOrbs = Options.MultiDropdownSelecOrb.Value
                for i,v in pairs(game:GetService("Workspace").Ores:GetDescendants()) do
                    for Orb,va in pairs(selectedOrbs) do
                        if v.Name == Orb then
                            TP(v.CFrame * CFrame.new(0,0,4))
                            game:GetService("Players").LocalPlayer.Character:FindFirstChild(Options.DropdownWTool.Value).Slash:FireServer(1)
                        end
                    end
                end
            end)
        end
    end)
end


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

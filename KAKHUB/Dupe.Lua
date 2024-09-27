local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "KAKHUB DUPE", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})


local Cache = { DevConfig = {} };

Cache.DevConfig["ListOfBox"] = {"Common Box", "Uncommon Box", "Rare Box", "Ultra Rare Box"};
Cache.DevConfig["ListOfDrink"] = {"Cider+", "Lemonade+", "Juice+", "Smoothie+"};
Cache.DevConfig["ListOfDrinkFormMixer"] = {"Cider", "Lemonade", "Juice", "Smoothie", "Milk", "Golden Apple"};


local Tab = Window:MakeTab({
	Name = "DUPE COMPASS!!!",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})


--[[
workspace.UserData["User_"..game.Players.LocalPlayer.UserId].UpdateClothing_Extras:FireServer("A", "\255", 34)
game:GetService("Players").LocalPlayer.Character.CharacterTrait.ClothingTrigger:FireServer() 
]]--

local Section = Tab:AddSection({
	Name = "Dupe Compass!!!"
})

Tab:AddButton({
	Name = "No Save Data!!",
	Callback = function()
        workspace.UserData["User_"..game.Players.LocalPlayer.UserId].UpdateClothing_Extras:FireServer("A", "\255", 34)
        game:GetService("Players").LocalPlayer.Character.CharacterTrait.ClothingTrigger:FireServer() 

  	end    
})

Tab:AddToggle({
	Name = "Auto Sam Quest",
	Default = false,
	Callback = function(ASQ)
		AutoSamQuestXX = ASQ
	end    
})

spawn(function()
    while wait() do
        pcall(function()
            if not AutoSamQuestXX then return end;
            game.Workspace.Merchants.QuestMerchant.Clickable.Retum:FireServer("Claim1");
        end)
    end
end);

Tab:AddToggle({
	Name = "Auto Compass Quest",
	Default = false,
	Callback = function(ASQ)
		AutoCompassQuestXX = ASQ
	end    
})

spawn(function()
    while wait() do
        pcall(function()
            if not AutoCompassQuestXX then return end;
            local Compass = game.Players.LocalPlayer.Backpack:FindFirstChild("Compass");
            local Compass2 = game.Players.LocalPlayer.Character:FindFirstChild("Compass");
            if Compass or Compass2 then
                local OldPostiton = game.Players.LocalPlayer.Character.HumanoidRootPart.Position;
                game.Players.LocalPlayer.Character.Humanoid:UnequipTools();
                Compass.Parent = game.Players.LocalPlayer.Character;
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Compass.Poser.Value);
                Compass:Activate();
                wait(0.5);
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(OldPostiton);
            end
        end)
    end
end);

Tab:AddToggle({
	Name = "Auto Drop Compass",
	Default = false,
	Callback = function(ADD)
		DropCompass = ADD
	end    
})

spawn(function()
    while wait() do
        pcall(function()
            if not DropCompass then return end;
            for _, Value in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                game.Players.LocalPlayer.Character.Humanoid:UnequipTools();
                Value.Parent = game.Players.LocalPlayer.Character;
                Value.Parent = game.Workspace;
            end
        end)
    end
end);


Tab:AddToggle({
	Name = "Auto Unbox Box",
	Default = false,
	Callback = function(AUB)
		AutoUnboxBoxXX = AUB
	end    
})


spawn(function()
    while wait() do
        pcall(function()
            if not AutoUnboxBoxXX then return end;
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

Tab:AddToggle({
	Name = "Auto Loot Compass",
	Default = false,
	Callback = function(AUB)
		AutoLootXXX = AUB
	end    
})


spawn(function()
    while wait() do
        pcall(function()
            if not AutoLootXXX then return end;
            for _, Item in pairs(game.Workspace:GetChildren()) do
                if Item.Name == "Compass" and Item:FindFirstChild("Handle") then
                    Item.Handle.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position);
                end
            end
        end)
    end
end);



local TabDrink = Window:MakeTab({
	Name = "DUPE DRINK",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})


local Section = TabDrink:AddSection({
	Name = "Drink"
})

TabDrink:AddDropdown({
	Name = "Select Drink",
	Default = "",
	Options = Cache.DevConfig["ListOfDrink"],
	Callback = function(SD)
		SelectDrink = SD
	end    
})

TabDrink:AddTextbox({
	Name = "Amount Drink",
	Default = "1",
	TextDisappear = true,
	Callback = function(AD)
		AmountDrink = AD
	end	  
})

TabDrink:AddButton({
	Name = "Buy Drink",
	Callback = function()
        if not AmountDrink or not string.match(AmountDrink, "%d+") or tonumber(string.match(AmountDrink, "%d+")) < 0 then return end;
        for _ = 1, tonumber(string.match(AmountDrink, "%d+")) do
            game.Workspace.Merchants.BetterDrinkMerchant.Clickable.Retum:FireServer(SelectDrink)
        end
  	end    
})

TabDrink:AddToggle({
	Name = "Auto Drink",
	Default = false,
	Callback = function(ADK)
		AutoDrink = ADK
	end    
})

spawn(function()
    while wait() do
        pcall(function()
            if not AutoDrink then return end;
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

TabDrink:AddToggle({
	Name = "Auto Drop Drink",
	Default = false,
	Callback = function(ADD)
		AutoDropDrink = ADD
	end    
})

spawn(function()
    while wait() do
        pcall(function()
            if not AutoDropDrink then return end;
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

TabDrink:AddToggle({
	Name = "Auto Loot Drink",
	Default = false,
	Callback = function(ADD)
		AutoLootDeink = ADD
	end    
})

spawn(function()
    while wait() do
        pcall(function()
            if not AutoLootDeink then return end;
            for _, Item in pairs(game.Workspace:GetChildren()) do
                if table.find(Cache.DevConfig["ListOfDrink"], Item.Name) and Item:FindFirstChild("Handle") then
                    Item.Handle.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position);
                end
            end
        end)
    end
end);


local Tab999 = Window:MakeTab({
	Name = "Rejoin Sever",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})


local Section = Tab999:AddSection({
	Name = "Rejoin Sever"
})

Tab999:AddButton({
	Name = "Rejoin",
	Callback = function()
        game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId) 
  	end    
})
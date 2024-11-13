local player = game.Players.LocalPlayer

local ButtonDB = false
local SelectedPlayer = nil
local weld;
local lastLocation;

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Invaild Hub",
   LoadingTitle = "Invaild",
   LoadingSubtitle = "by InvaildPassw0rd",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local ETTab = Window:CreateTab("Elemental Tycoon", 4483362458)
local NTNTab = Window:CreateTab("Nuke Tycoon Nuclear", 4483362458)
local MiscTab = Window:CreateTab("Misc", 4483362458)

local Label = ETTab:CreateLabel("MAY BE BUGGY")
local Section = ETTab:CreateSection("steal stuff")

local enableAimbot = MiscTab:CreateButton({
	Name = "Aimbot Script [MAY GIVE LAGSPIKE]",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/ttwizz/Open-Aimbot/master/source.lua", true))()
	end,
 })

local tpToChest = ETTab:CreateButton({
   Name = "TP to Chest",
   Callback = function()
		local char = player.Character

		if not iswindowactive() then return end
		if ButtonDB then return end
		ButtonDB = true
		lastLocation = char.HumanoidRootPart.CFrame
		for _,v in pairs(workspace.Treasure.Chests:GetChildren()) do
			if v:IsA("Part") then
				if not char:IsDescendantOf(workspace.Characters.Players) then continue end
				char.HumanoidRootPart.CFrame = v.CFrame * CFrame.new(0,0,-3)

				task.wait(.25)

				local proxmity = v:WaitForChild("ProximityPrompt")
				proxmity.RequiresLineOfSight = false
				fireproximityprompt(proxmity)
			end
		end

		char.HumanoidRootPart.CFrame = lastLocation
		
		task.delay(0.1,function()
			ButtonDB = false
		end)
   end,
})

local tpToCrate = ETTab:CreateButton({
   Name = "TP to Crate",
   Callback = function()
		local char = player.Character

		if not iswindowactive() then return end
		if ButtonDB then return end
		ButtonDB = true
		lastLocation = char.HumanoidRootPart.CFrame
		for _,v in pairs(workspace:GetChildren()) do
			if v.Name == "BalloonCrate" then
				if not char:IsDescendantOf(workspace.Characters.Players) then continue end
				char.HumanoidRootPart.CFrame = v.Crate.CFrame * CFrame.new(0,0,5)

				task.wait(.25)

				local proxmity = v.Crate:WaitForChild("ProximityPrompt")
				proxmity.RequiresLineOfSight = false
				fireproximityprompt(proxmity)
			end
		end

		char.HumanoidRootPart.CFrame = lastLocation
		
		task.delay(0.1,function()
			ButtonDB = false
		end)
   end,
})

local tpToPowers = ETTab:CreateButton({
	Name = "TP to all Powers [MAY NEED TO CLICK MORE THAN ONCE]",
	Callback = function()
		 if not iswindowactive() then return end
		 if ButtonDB then return end
		 ButtonDB = true
		 lastLocation =  player.Character.HumanoidRootPart.CFrame
		 for _,v in pairs(workspace.Tycoons:GetDescendants()) do
			 if v:IsA("Model")  and string.find(v.Name,"Ability") then
				if not v.Parent or v.Parent.Name ~= "Assets" or not v:FindFirstChild("Button") then continue end
				local humrp = player.Character:FindFirstChild("HumanoidRootPart")
				local toolBeingEquipped = v.Model.Center.SurfaceGui.TextLabel.Text
				if not humrp then continue end
				if player.Backpack:FindFirstChild(toolBeingEquipped) or player.Character:FindFirstChild(toolBeingEquipped) then continue end
				humrp.CFrame = v.Button.CFrame
				local proxmity = v.Button:WaitForChild("ProximityPrompt")
				fireproximityprompt(proxmity)
			 end
		 end
 
		 player.Character.HumanoidRootPart.CFrame = lastLocation
		 
		 task.delay(0.1,function()
			 ButtonDB = false
		 end)
	end,
 })

 local grabAllDollars = ETTab:CreateButton({
	Name = "Steal Dollars",
	Callback = function()
		 if not iswindowactive() then return end
		 if ButtonDB then return end
		 ButtonDB = true
		 lastLocation =  player.Character.HumanoidRootPart.CFrame
		 for _,v in pairs(workspace:GetDescendants()) do
			if v:IsA("Part") and v.Name == "Dollar" then
				local humrp = player.Character:FindFirstChild("HumanoidRootPart")
				if not humrp then continue end
				humrp.CFrame = v.CFrame
				task.wait()
			end
		 end
 
		 player.Character.HumanoidRootPart.CFrame = lastLocation
		 
		 task.delay(0.1,function()
			 ButtonDB = false
		 end)
	end,
 })

 local Section = ETTab:CreateSection("make kids angry stuff")

 local AttachPlayerToggle;
 local Input = ETTab:CreateInput({
	Name = "Selected Player Name [ENTER WHEN DONE]",
	CurrentValue = "",
	PlaceholderText = "Input Name",
	RemoveTextAfterFocusLost = false,
	Flag = "Input1",
	Callback = function(Text)
		print(game.Players:FindFirstChild(Text))
		if game.Players:FindFirstChild(Text) then
			SelectedPlayer = game.Players:WaitForChild(Text)
			repeat
				task.wait()
			until SelectedPlayer ~= Text or not game.Players:FindFirstChild(Text)
			if not game.Players:FindFirstChild(Text) then
				SelectedPlayer = nil
				AttachPlayerToggle:Set(false)
				if weld then
					weld:Destroy()
					weld = nil
				end
			end
		end
	end,
 })

 AttachPlayerToggle = ETTab:CreateToggle({
	Name = "Attach to Player",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		if not SelectedPlayer then 
			if AttachPlayerToggle.CurrentValue then
				AttachPlayerToggle:Set(false)
			end
			 return 
		 end
		if Value then
			local currentHooked = SelectedPlayer
			player.Character.HumanoidRootPart.CFrame = SelectedPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,4)
			weld = Instance.new("WeldConstraint")
			weld.Parent = player.Character.HumanoidRootPart
			weld.Part0 = SelectedPlayer.Character.HumanoidRootPart
			weld.Part1 = player.Character.HumanoidRootPart
			repeat
				if player.Character.Humanoid.Health <= 0 then
					AttachPlayerToggle:Set(false)
					weld:Destroy()
					break
				elseif not weld then
					AttachPlayerToggle:Set(false)
					weld:Destroy()
					break
				end
				task.wait()
			until SelectedPlayer ~= currentHooked or not game.Players:FindFirstChild(SelectedPlayer) or weld == nil
		else
			if weld then
				weld:Destroy()
				weld = nil
			end
		end
	end,
 })

 local Section = NTNTab:CreateSection("teleportation stuff")

 local tpToGems = NTNTab:CreateButton({
	Name = "Teleport To Gems",
	Callback = function()
		 if not iswindowactive() then return end
		 if ButtonDB then return end
		 ButtonDB = true
		 for _,v in pairs(workspace.RobbingFolder:GetDescendants()) do
			 if v:IsA("BoolValue") and v.Name == "Chosen" then
				if v.Value and v.Parent.Name ~= player.Team.Name then
					local humrp = player.Character:FindFirstChild("HumanoidRootPart")
					if not humrp then continue end
					humrp.CFrame = v.Parent.CFrame
				end
			 end
		 end
		 task.delay(0.1,function()
			 ButtonDB = false
		 end)
	end,
 })

 local tpBackToBase = NTNTab:CreateButton({
	Name = "Teleport Back To Base",
	Callback = function()
		 if not iswindowactive() then return end
		 if ButtonDB then return end
		 ButtonDB = true
		 local plrBase = workspace["The Nuke Tycoon Entirely Model"].Tycoons:WaitForChild(player.Team.Name)
		 player.Character.HumanoidRootPart.CFrame = plrBase.Essentials.Spawn.CFrame
		 task.delay(0.1,function()
			 ButtonDB = false
		 end)
	end,
 })

 local stealCashBonus = NTNTab:CreateButton({
	Name = "Steal Cash Bonus",
	Callback = function()
		 if not iswindowactive() then return end
		 if ButtonDB then return end
		 ButtonDB = true
		
		 lastLocation =  player.Character.HumanoidRootPart.CFrame
		 player.Character.HumanoidRootPart.CFrame = CFrame.new( -820.199646, 347.196136, 329.985718)
		 task.wait(0.1)
		 player.Character.HumanoidRootPart.CFrame = lastLocation

		 task.delay(0.1,function()
			 ButtonDB = false
		 end)
	end,
 })

 local selectABase = NTNTab:CreateDropdown({
	Name = "Select a Base",
	Options = {"Base 1","Base 2","Base 3","Base 4","Base 5","Base 6"},
	CurrentOption = {"Base 1"},
	MultipleOptions = false,
	Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Options)
		
	end,
 })

 local teleportToSelectedBase = NTNTab:CreateButton({
	Name = "TP To Selected Base",
	Callback = function()
		 if not iswindowactive() then return end
		 if ButtonDB then return end
		 ButtonDB = true
		
		 local getBase = workspace["The Nuke Tycoon Entirely Model"].Tycoons:WaitForChild(selectABase.CurrentOption[1])
		 player.Character.HumanoidRootPart.CFrame = getBase.Essentials.Spawn.CFrame

		 task.delay(0.1,function()
			 ButtonDB = false
		 end)
	end,
 })

 local Section = NTNTab:CreateSection("cool stuff")
 
 local stealGemDuration = NTNTab:CreateSlider({
	Name = "Gem Steal Duration",
	Range = {1, 5},
	Increment = 1,
	Suffix = "Seconds",
	CurrentValue = 5,
	Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		for _,v in pairs(workspace.RobbingFolder:GetDescendants()) do
			if v:IsA("ProximityPrompt") then
				v.HoldDuration = Value
			end
		end
	end,
 })


 local Label_2 = NTNTab:CreateLabel("MAY BE BUG OUT SCREEN / CLICKER MAY BREAK")

 local AutoClickDropper;
 AutoClickDropper = NTNTab:CreateToggle({
	Name = "Auto Click Dropper",
	CurrentValue = false,
	Flag = "Toggle2", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		local plrBase = workspace["The Nuke Tycoon Entirely Model"].Tycoons:WaitForChild(player.Team.Name)
		local detector = plrBase.PurchasedObjects.Mine.Clicker
		if Value then
			repeat
				fireclickdetector(detector,99999)
				task.wait(1.5)
			until not AutoClickDropper.CurrentValue
		end
	end,
 })
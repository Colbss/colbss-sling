
local QBCore = exports['qb-core']:GetCoreObject()

local attached_weapons = {}
local sling_vals = {}
local items = {}
local playerLoaded = true
local refreshing = false
local inVehicle = false

local waitTime = 500

-- <<<<<<<<<<<<<<< THREADS >>>>>>>>>>>>>>> --

Citizen.CreateThread(function()
	while true do
		if playerLoaded and not inVehicle then
			
			-- Only need to attach new weapons when player is
			-- not refreshing their skin
			if not refreshing then
				attachedWeapons()
			-- Keep checking for detached weapons while
			-- player is refreshing their skin
			else
				refreshEntityAttachment()
			end

		end
		Wait(waitTime)
	end
end)

Citizen.CreateThread(function()

	local prevBucket = ""
	local currBucket = ""

	-- When moving between dimensions the state of the player will be preserved.
	-- The player will need to be refreshed when changing dimensions to avoid
	-- ghost props appearing on the players back.
	while true do

		local p = promise.new()
		QBCore.Functions.TriggerCallback("colbss-sling:server:routingBucket", function(result)
			p:resolve(result)
		end)
		currBucket = Citizen.Await(p)

		if currBucket ~= prevBucket then
			bucketRefresh()
			prevBucket = currBucket
		end
		
		Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
	  	if playerLoaded then
  
		  	-- Delete weapons when entering a vehicle to avoid car-nado
		  	if IsPedInAnyVehicle(PlayerPedId(), true) then

				local vehicle = GetVehiclePedIsIn(GetPlayerPed(), false)
               	local vehicleClass = GetVehicleClass(vehicle)

				-- Guns stay on back if on a bike
				if vehicleClass ~= 8 and vehicleClass ~= 13 then

					inVehicle = true
					local pedCoords = GetEntityCoords(PlayerPedId())
					  for key, attached_object in pairs(attached_weapons) do
						-- Remove props from back
						local objectId = GetClosestObjectOfType(pedCoords, 1.0, GetHashKey(key), false)
						DeleteObject(objectId)
	
					  end

				end

		  	else
				inVehicle = false
			end

	  	end
		-- Keep wait time on this as low as possible
		-- to reduuce chance of car-nado
	 	Wait(10)
	end
  end)

-- <<<<<<<<<<<<<<< FUNCTIONS >>>>>>>>>>>>>>> --

local function reloadSkin(health)
    local model
	local PlayerData = QBCore.Functions.GetPlayerData()

    local gender = PlayerData.charinfo.gender
    local maxhealth = GetEntityMaxHealth(PlayerPedId())
	local armor = GetPedArmour(PlayerPedId())
	
	waitTime = 1
	refreshing = true

    if gender == 1 then -- Gender is ONE for FEMALE
        model = GetHashKey("mp_f_freemode_01") -- Female Model
    else
        model = GetHashKey("mp_m_freemode_01") -- Male Model
    end
	
	RequestModel(model)

    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)
    Citizen.Wait(1000) -- Safety Delay

    TriggerServerEvent("qb-clothes:loadPlayerSkin") -- LOADING PLAYER'S CLOTHES
    TriggerServerEvent("qb-clothing:loadPlayerSkin") -- LOADING PLAYER'S CLOTHES - Event 2

    SetPedMaxHealth(PlayerId(), maxhealth)
    Citizen.Wait(1000) -- Safety Delay
    SetEntityHealth(PlayerPedId(), health)
	SetPedArmour(PlayerPedId(), armor)
	
	waitTime = 500
	refreshing = false
	
end

local function startReloadSkin(health, delayed)

	if delayed then

		QBCore.Functions.Progressbar("pgb", "Freshening Up", 5000, false, true, {
			disableMovement = false,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}, {
			animDict = "clothingshirt",
			anim = "try_shirt_positive_d",
			flags = 48,
		}, {}, {}, function() -- Done
			ClearPedTasks(PlayerId())
			reloadSkin(health)
		end, function() -- Cancel
			-- Do nothing
		end)

	else

		reloadSkin(health)

	end

end

-- Attach weapons to player
function attachedWeapons()

	local me = PlayerPedId()
	items = QBCore.Functions.GetPlayerData().items
	if items ~= nil then 

		if Config.HotbarOnly then
			items = { items[1], items[2], items[3], items[4], items[5], items[41] }
		end

	  	for slot, item in pairs(items) do
			if item ~= nil and item.type == "weapon" and Config.compatable_weapon_hashes[item.name] ~= nil then
			local wep_model = Config.compatable_weapon_hashes[item.name].model
			local wep_hash = Config.compatable_weapon_hashes[item.name].hash
			
				if not sling_vals[wep_hash] then
					pos = Config.compatable_weapon_hashes[item.name].pos
					new_pos_index = pos[1]

					sling_vals[wep_hash] =  {
						pos_vals = pos,
						pos_index = 1,
						offset_val = 0.0,
						offset_plane = Config.Positions[new_pos_index].offset_plane,
						offset_dir = Config.Positions[new_pos_index].offset_dir
					}

				end
			
				if not attached_weapons[wep_model] and GetSelectedPedWeapon(me) ~= wep_hash then
					local sling = sling_vals[wep_hash].pos_vals[sling_vals[wep_hash].pos_index]

					AttachWeapon(wep_model, wep_hash, Config.Positions[sling].bone, Config.Positions[sling].x, Config.Positions[sling].y, Config.Positions[sling].z, Config.Positions[sling].x_rotation, Config.Positions[sling].y_rotation, Config.Positions[sling].z_rotation)

				end
			end
	  	end
	  	local pedCoords = GetEntityCoords(PlayerPedId())
	  	for key, attached_object in pairs(attached_weapons) do
		  	if GetSelectedPedWeapon(me) == attached_object.hash or not hasWeapon(attached_object.hash) then

				-- Check if another weapon that uses the same model is in pockets
				local sameModel = false
				local modelCount = 0
				for slot, item in pairs(items) do
					if item ~= nil and item.type == "weapon" and Config.compatable_weapon_hashes[item.name] ~= nil then
						if Config.compatable_weapon_hashes[item.name].hash == GetSelectedPedWeapon(me) then
							modelCount = modelCount + 1
							if modelCount >= 2 then
								sameModel = true
								break
							end
						end
					end
				end

				-- If another weapon uses the same model, dont delete it
				if not sameModel then

					DeleteObject(attached_object.handle)
					attached_weapons[key] = nil
	
					-- Check for remaining props from returning from a bucket / dimension (i.e. leaving an apartment)
					local objectId = GetClosestObjectOfType(pedCoords, 1.0, GetHashKey(key), false)
					DeleteObject(objectId)

				end
		  	end
	  	end
	end
	
	refreshEntityAttachment()
	
end

function attachWithOffset(wep_handle, bone, sling)

	sling_pos = sling.pos_vals[sling.pos_index]
	offset = sling.offset_val * sling.offset_dir

	if sling.offset_plane == "x" then

		AttachEntityToEntity(wep_handle, PlayerPedId(), bone, Config.Positions[sling_pos].x + offset, Config.Positions[sling_pos].y, Config.Positions[sling_pos].z, Config.Positions[sling_pos].x_rotation, Config.Positions[sling_pos].y_rotation, Config.Positions[sling_pos].z_rotation, 1, 1, 0, 0, 0, 1)

	elseif sling.offset_plane == "y" then

		AttachEntityToEntity(wep_handle, PlayerPedId(), bone, Config.Positions[sling_pos].x, Config.Positions[sling_pos].y + offset, Config.Positions[sling_pos].z, Config.Positions[sling_pos].x_rotation, Config.Positions[sling_pos].y_rotation, Config.Positions[sling_pos].z_rotation, 1, 1, 0, 0, 0, 1)

	else

		AttachEntityToEntity(wep_handle, PlayerPedId(), bone, Config.Positions[sling_pos].x + offset, Config.Positions[sling_pos].y, Config.Positions[sling_pos].z + offset, Config.Positions[sling_pos].x_rotation, Config.Positions[sling_pos].y_rotation, Config.Positions[sling_pos].z_rotation, 1, 1, 0, 0, 0, 1)

	end

end

-- Check if player has a weapon
function hasWeapon(hash)

	for slot, item in pairs(items) do
		if item ~= nil and item.type == "weapon" and Config.compatable_weapon_hashes[item.name] ~= nil then
			if hash == GetHashKey(item.name) then
				return true
			end
		end
	end
  	return false

end

-- Attach new weapons to model
function AttachWeapon(attachModel,weaponHash,boneNumber,x,y,z,xR,yR,zR)

	local bone = GetPedBoneIndex(PlayerPedId(), boneNumber)
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Wait(10)
	end

	attached_weapons[attachModel] = {
		hash = weaponHash,
		handle = CreateObject(GetHashKey(attachModel), 1.0, 1.0, 1.0, true, true, false)
	}
             
	attachWithOffset(attached_weapons[attachModel].handle, bone, sling_vals[weaponHash])
	
end

-- When skin is refreshed the guns will need to be reattached
function refreshEntityAttachment()

	local pedCoords = GetEntityCoords(PlayerPedId())

	for key, attached_object in pairs(attached_weapons) do
	
		if not IsEntityAttached(attached_object.handle) then
		
			local weapHash = attached_object.hash
			local sling = sling_vals[weapHash].pos_vals[sling_vals[weapHash].pos_index]
			local boneNum = Config.Positions[sling].bone
			local boneIndex = GetPedBoneIndex(PlayerPedId(), boneNum)
		
			attachWithOffset(attached_object.handle, boneIndex, sling_vals[weapHash])

			--If reattachment fails, delete object and reattach
			if not IsEntityAttached(attached_object.handle) then

				-- Delete expected prop
				DeleteObject(attached_object.handle)

				-- Delete extra props that may be attached
				local objectId = GetClosestObjectOfType(pedCoords, 1.0, GetHashKey(tostring(key)), false)
				DeleteObject(objectId)

				attached_weapons[key].handle = CreateObject(GetHashKey(key), 1.0, 1.0, 1.0, true, true, false)
				attachWithOffset(attached_object.handle, boneIndex, sling_vals[weapHash])
			
			end

		end
	
	end

end

function bucketRefresh()

	local playerPed = PlayerPedId()
	local health = GetEntityHealth(playerPed)
	reloadSkin(health)

end

-- <<<<<<<<<<<<<<< EVENTS >>>>>>>>>>>>>>> --

RegisterNetEvent('colbss-sling:client:changeSling')
AddEventHandler('colbss-sling:client:changeSling', function()

	local me = PlayerPedId()
	local weapHash = GetSelectedPedWeapon(me)

	if weapHash == GetHashKey("weapon_unarmed") then
		QBCore.Functions.Notify("You are not holding a weapon!", "error")
		return
	elseif not sling_vals[weapHash] then
		QBCore.Functions.Notify("This weapon cannot be slung!", "error")
		return
	end

	local weapSling = sling_vals[weapHash].pos

	local curr_index = sling_vals[weapHash].pos_index
	local pos_list = sling_vals[weapHash].pos_vals

	if #pos_list == 1 then

		QBCore.Functions.Notify("There is no sling variant for this weapon!", "error")

	elseif curr_index + 1 <= #pos_list then

		new_index = curr_index + 1
		sling = pos_list[new_index]

		sling_vals[weapHash].pos_index = new_index
		sling_vals[weapHash].offset_plane = Config.Positions[sling].offset_plane
		sling_vals[weapHash].offset_dir = Config.Positions[sling].offset_dir

	else

		sling = pos_list[1]

		sling_vals[weapHash].pos_index = 1
		sling_vals[weapHash].offset_plane = Config.Positions[sling].offset_plane
		sling_vals[weapHash].offset_dir = Config.Positions[sling].offset_dir

	end

end)

RegisterNetEvent('colbss-sling:client:slingOffset')
AddEventHandler('colbss-sling:client:slingOffset', function(offset)

	offset = tonumber(offset)

	-- Validate input
	if offset == nil then
		QBCore.Functions.Notify("Offset must be valid number !", "error")
		return
	else
		if offset < 0 or offset > Config.MaxOffset then
			QBCore.Functions.Notify("Offset must be between 0 and " .. tostring(Config.MaxOffset) .. " !", "error")
			return
		end
	end

	local me = PlayerPedId()
	local weapHash = GetSelectedPedWeapon(me)

	if weapHash == GetHashKey("weapon_unarmed") then
		QBCore.Functions.Notify("You are not holding a weapon!", "error")
		return
	elseif not sling_vals[weapHash] then
		QBCore.Functions.Notify("This weapon cannot be slung!", "error")
		return
	end

	sling_vals[weapHash].offset_val = 0.025 * offset

end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
  	playerLoaded = true
end)

AddEventHandler("apartments:client:Logout", function()

	-- Delete props if player logs out

	for key, attached_object in pairs(attached_weapons) do

		DeleteObject(attached_object.handle)
		attached_weapons[key] = nil

		-- Check for remaining props from returning from a bucket / dimension (i.e. leaving an apartment)
		local objectId = GetClosestObjectOfType(pedCoords, 1.0, GetHashKey(key), false)
		DeleteObject(objectId)
		
	end
	
end)

-- <<<<<<<<<<<<<<< COMMANDS >>>>>>>>>>>>>>> --

RegisterCommand("reloadskin", function(source)

	local playerPed = PlayerPedId()
	local health = GetEntityHealth(playerPed)
	startReloadSkin(health, true)
	
end)

local QBCore = exports['qb-core']:GetCoreObject()

local attached_weapons = {}
local sling_pos = {}
local hotbar = {}
local playerLoaded = true
local refreshing = false
local inVehicle = false

local waitTime = 500

-- ######### THREAD #########

Citizen.CreateThread(function()
  while true do
    if playerLoaded and not inVehicle then
        
		-- Only need to attach new weapons when player is
		-- not refreshing their skin
		if not refreshing then
			attachedWeapons()
		-- Keep checking for detattched weapons while
		-- player is refreshing their skin
		else
			refreshEntityAttachment()
		end

	end
    Wait(waitTime)
  end
end)

Citizen.CreateThread(function()
	while true do
	  	if playerLoaded then
  
		  	-- Delete weapons when entering a vehicle to
		  	-- avoid car-nado
		  	if IsPedInAnyVehicle(PlayerPedId(), true) then
				inVehicle = true
				local pedCoords = GetEntityCoords(PlayerPedId())
			  	for key, attached_object in pairs(attached_weapons) do

					-- while IsEntityAttached(attached_object.handle) do

					-- 	print("Delete weapon option 1: " .. tostring(attached_object.handle))
					-- 	DeleteObject(attached_object.handle)
					-- 	attached_weapons[key] = nil

					-- end

					-- Remove extra props that may be stuck
					local objectId = GetClosestObjectOfType(pedCoords, 5.0, GetHashKey(key), false)
					DeleteObject(objectId)

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

-- ######### FUNCTIONS #########

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
    --Citizen.Wait(1000) -- Safety Delay

    TriggerServerEvent("qb-clothes:loadPlayerSkin") -- LOADING PLAYER'S CLOTHES
    TriggerServerEvent("qb-clothing:loadPlayerSkin") -- LOADING PLAYER'S CLOTHES - Event 2

    SetPedMaxHealth(PlayerId(), maxhealth)
    --Citizen.Wait(1000) -- Safety Delay
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

-- Attach weapons in player hotbar to player
function attachedWeapons()

	local me = PlayerPedId()
	local items = QBCore.Functions.GetPlayerData().items
	if items ~= nil then 
	  hotbar = { items[1], items[2], items[3], items[4], items[5], items[41] }
	  for slot, item in pairs(hotbar) do
		if item ~= nil and item.type == "weapon" and Config.compatable_weapon_hashes[item.name] ~= nil then
		  local wep_model = Config.compatable_weapon_hashes[item.name].model
		  local wep_hash = Config.compatable_weapon_hashes[item.name].hash
		  
			if not sling_pos[wep_hash] then
				if Config.compatable_weapon_hashes[item.name].gun then
					sling_pos[wep_hash] = "Back"
				else
					sling_pos[wep_hash] = "Back_Alt"
				end
			end
		  
		    if not attached_weapons[wep_model] and GetSelectedPedWeapon(me) ~= wep_hash then
				local sling = sling_pos[wep_hash]

				AttachWeapon(wep_model, wep_hash, Config.Positions[sling].bone, Config.Positions[sling].x, Config.Positions[sling].y, Config.Positions[sling].z, Config.Positions[sling].x_rotation, Config.Positions[sling].y_rotation, Config.Positions[sling].z_rotation)

			end
		end
	  end
	  for key, attached_object in pairs(attached_weapons) do
		  if GetSelectedPedWeapon(me) == attached_object.hash or not inHotbar(attached_object.hash) then -- equipped or not in weapon wheel
			DeleteObject(attached_object.handle)
			attached_weapons[key] = nil
		  end
	  end
	end
	
	refreshEntityAttachment()
	
end

-- Check if weapon is in a hotbar slot
function inHotbar(hash)
  for slot, item in pairs(hotbar) do
    if item ~= nil and item.type == "weapon" and Config.compatable_weapon_hashes[item.name] ~= nil then
      if hash == GetHashKey(item.name) then
        return true
      end
    end
  end
  return false
end

-- Attach new weapons to model
function AttachWeapon(attachModel,modelHash,boneNumber,x,y,z,xR,yR,zR)

	local bone = GetPedBoneIndex(PlayerPedId(), boneNumber)
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Wait(10)
	end

	attached_weapons[attachModel] = {
		hash = modelHash,
		handle = CreateObject(GetHashKey(attachModel), 1.0, 1.0, 1.0, true, true, false)
	}
             
	AttachEntityToEntity(attached_weapons[attachModel].handle, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 0, 1)
	
end

-- When skin is refreshed the guns will need to be reattached
function refreshEntityAttachment()

	for key, attached_object in pairs(attached_weapons) do
	
		if not IsEntityAttached(attached_object.handle) then
		
			local weapHash = attached_object.hash
			local sling = sling_pos[weapHash]
			local boneNum = Config.Positions[sling].bone
			local boneIndex = GetPedBoneIndex(PlayerPedId(), boneNum)
		
			AttachEntityToEntity(attached_object.handle, PlayerPedId(), boneIndex, Config.Positions[sling].x, Config.Positions[sling].y, Config.Positions[sling].z, Config.Positions[sling].x_rotation, Config.Positions[sling].y_rotation, Config.Positions[sling].z_rotation, 1, 1, 1, 0, 0, 1)	
		
			Wait(1000)

			--If reattachment fails, delete object and reattach
			if not IsEntityAttached(attached_object.handle) then
			
				print("Recreating Object: " .. key)
				DeleteObject(attached_object.handle)

				attached_weapons[key].handle = CreateObject(GetHashKey(key), 1.0, 1.0, 1.0, true, true, false)
				AttachEntityToEntity(attached_object.handle, PlayerPedId(), boneIndex, Config.Positions[sling].x, Config.Positions[sling].y, Config.Positions[sling].z, Config.Positions[sling].x_rotation, Config.Positions[sling].y_rotation, Config.Positions[sling].z_rotation, 1, 1, 1, 0, 0, 1)
			
			end

		end
		
	end

end

RegisterNetEvent('reload-skin:client:changeSling')
AddEventHandler('reload-skin:client:changeSling', function()

	local me = PlayerPedId()
	local weapHash = GetSelectedPedWeapon(me)
	local weapSling = sling_pos[weapHash]

    if weapSling == "Back" then 
	  sling_pos[weapHash] = "Front"

	elseif weapSling == "Front" then
      sling_pos[weapHash] = "Back"

	elseif weapSling == "Back_Alt" then
		sling_pos[weapHash] = "Front_Alt"

	elseif weapSling == "Front_Alt" then
		sling_pos[weapHash] = "Back_Alt"
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
  playerLoaded = true;
end)


RegisterCommand("reloadskin", function(source)

	local playerPed = PlayerPedId()
	local health = GetEntityHealth(playerPed)
	startReloadSkin(health, true)
	
end)

RegisterCommand("debug", function(source)

	-- print("True: " .. tostring(true) .. " , False: " .. tostring(false))

	-- for key, attached_object in pairs(attached_weapons) do
	
	-- 	local atc = IsEntityAttached(attached_object.handle)

	-- 	print(key .. " , attached: " .. tostring(atc))
		
	-- end

	----------------------------------------------------

	local pedCoords = GetEntityCoords(PlayerPedId())

	for key, attached_object in pairs(attached_weapons) do
	
		local objectId = GetClosestObjectOfType(pedCoords, 5.0, GetHashKey(key), false)

		print(key .. " exists? " .. tostring(DoesEntityExist(objectId)))
		
	end

	
	-- local objectId = GetClosestObjectOfType(pedCoords, 5.0, GetHashKey("w_mg_minigun"), false) -- w_mg_minigun

	-- print("Mnigun exists? " .. tostring(DoesEntityExist(objectId)))


	
end)

RegisterCommand("debugdel", function(source)

	local pedCoords = GetEntityCoords(PlayerPedId())

	for key, attached_object in pairs(attached_weapons) do

		local objectId = GetClosestObjectOfType(pedCoords, 5.0, GetHashKey(key), false)

		DeleteObject(objectId)

	end

end)

-- AddEventHandler('apartments:client:LeaveApartment', function()
-- 	Wait(2000)
--     print("apartments:client:LeaveApartment -- LEFT APARTMENT !")
-- 	local playerPed = PlayerPedId()
-- 	local health = GetEntityHealth(playerPed)
-- 	startReloadSkin(health, false)
-- end)

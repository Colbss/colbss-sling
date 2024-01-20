local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add("sling", "Change weapon sling position", {}, false, function(source, args)
	TriggerClientEvent("reload-skin:client:changeSling", source)
end)

local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add("sling", "Change weapon sling position", {}, false, function(source, args)
	TriggerClientEvent("colbss-sling:client:changeSling", source)
end)

QBCore.Commands.Add("slingoffset", "Adjust sling offset (distance from body)", {{name="offset", help="0-5"}}, true, function(source, args)
	TriggerClientEvent("colbss-sling:client:slingOffset", source, args[1])
end)

QBCore.Functions.CreateCallback("colbss-sling:server:routingBucket", function(source, cb)
    return cb(GetPlayerRoutingBucket(source))
end)

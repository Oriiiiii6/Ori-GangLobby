if IsDuplicityVersion() then
    local playerBuckets = {}

    RegisterNetEvent("Ori-GangLobby:requestBucket")
    AddEventHandler("Ori-GangLobby:requestBucket", function()
        local src = source
        local bucket = playerBuckets[src] or 0
        TriggerClientEvent("Ori-GangLobby:openMenu", src, bucket)
    end)

    RegisterNetEvent("Ori-GangLobby:setBucket")
    AddEventHandler("Ori-GangLobby:setBucket", function(bucket, coords, shouldResetInventory)
        local src = source
        playerBuckets[src] = bucket
        SetPlayerRoutingBucket(src, bucket)
        SetEntityCoords(GetPlayerPed(src), coords.x, coords.y, coords.z)
        
        if shouldResetInventory then
            if GetResourceState("ox_inventory") == "started" then
                exports.ox_inventory:ClearInventory(src)
            end
        end
        
        TriggerClientEvent("Ori-GangLobby:notify", src, bucket)
    end)
end
local ox_lib = exports.ox_lib

RegisterCommand(Config.Command, function()
    local playerPed = PlayerPedId()
    local playerId = GetPlayerServerId(PlayerId())
    
    TriggerServerEvent("Ori-GangLobby:requestBucket", playerId)
end, false)

RegisterNetEvent("Ori-GangLobby:openMenu")
AddEventHandler("Ori-GangLobby:openMenu", function(playerBucket)
    local options = {}
    
    for _, bucket in ipairs(Config.Buckets) do
        table.insert(options, {
            title = bucket.name,
            description = bucket.description,
            icon = "users",
            disabled = (bucket.id == playerBucket), -- Show but disable the current bucket
            onSelect = function()
                if bucket.id ~= playerBucket then
                    TriggerServerEvent("Ori-GangLobby:setBucket", bucket.id, bucket.coords, Config.ResetInventory)
                end
            end
        })
    end
    
    ox_lib:registerContext({
        id = "gang_lobby_menu",
        title = "Gang Lobby Selection",
        options = options
    })
    
    ox_lib:showContext("gang_lobby_menu")
end)

RegisterNetEvent("Ori-GangLobby:setBucket")
AddEventHandler("Ori-GangLobby:setBucket", function(bucket, coords, shouldResetInventory)
    local src = source
    SetPlayerRoutingBucket(src, bucket)

    if coords then
        SetEntityCoords(GetPlayerPed(src), coords.x, coords.y, coords.z)
    end

    if shouldResetInventory then
        if GetResourceState("ox_inventory") == "started" then
            exports.ox_inventory:ClearInventory(src)
        end
    end

    TriggerClientEvent("Ori-GangLobby:notify", src, bucket)
end)

RegisterNetEvent("Ori-GangLobby:notify")
AddEventHandler("Ori-GangLobby:notify", function(bucket)
    exports.ox_lib:notify({
        id = 'gang_lobby_info',
        title = 'Gang Lobby System | OriDev',
        description = bucket == 0 and "You have returned to the normal lobby." or "You have joined " .. bucket,
        showDuration = true,
        position = 'top',
        style = {
            backgroundColor = '#141517',
            color = '#ffffff',
            ['.description'] = { color = '#909296' }
        },
        icon = 'check-circle',
        iconColor = '#00ff00'
    })
end)

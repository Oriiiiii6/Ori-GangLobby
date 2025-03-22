Config = {}


Config.Command = "ganglobby"

Config.Buckets = {
    { id = 0, name = "Normal Lobby", description = "Join Normal Lobby", coords = vector3(239.1058, -1381.5498, 33.7417) },
    { id = 2, name = "Gang Lobby", description = "Join Gang Lobby", coords = vector3(-1037.1498, -2729.8738, 13.7566) }
}

Config.ResetInventory = true

Config.AllowedAreas = {}
for _, bucket in ipairs(Config.Buckets) do
    table.insert(Config.AllowedAreas, bucket.coords)
end

Config.AllowedRadius = 50.0
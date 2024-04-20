local weapons = {
    [-1075685676] = "PISTOL_MK2",
    [126349499] = "SNOWBALL",
    [-270015777] = "ASSAULTSMG",
    [615608432] = "MOLOTOV",
    [2024373456] = "SMG_MK2",
    [-1810795771] = "POOLCUE",
    [-1813897027] = "GRENADE",
    [-598887786] = "MARKSMANPISTOL",
    [-1654528753] = "BULLPUPSHOTGUN",
    [-72657034] = "GADGET_PARACHUTE",
    [-102323637] = "BOTTLE",
    [2144741730] = "COMBATMG",
    [-1121678507] = "MINISMG",
    [-1652067232] = "SWEEPERSHOTGUN",
    [961495388] = "ASSAULTRIFLE_MK2",
    [-86904375] = "CARBINERIFLE_MK2",
    [-1786099057] = "BAT",
    [177293209] = "HEAVYSNIPER_MK2",
    [600439132] = "BALL",
    [1432025498] = "PUMPSHOTGUN_MK2",
    [-1951375401] = "FLASHLIGHT",
    [171789620] = "COMBATPDW",
    [1593441988] = "COMBATPISTOL",
    [-2009644972] = "SNSPISTOL_MK2",
    [2138347493] = "FIREWORK",
    [1649403952] = "COMPACTRIFLE",
    [-619010992] = "MACHINEPISTOL",
    [-952879014] = "MARKSMANRIFLE",
    [317205821] = "AUTOSHOTGUN",
    [-1420407917] = "PROXMINE",
    [-1045183535] = "REVOLVER",
    [94989220] = "COMBATSHOTGUN",
    [-1658906650] = "MILITARYRIFLE",
    [1198256469] = "RAYCARBINE",
    [2132975508] = "BULLPUPRIFLE",
    [1627465347] = "GUSENBERG",
    [984333226] = "HEAVYSHOTGUN",
    [1233104067] = "FLARE",
    [-1716189206] = "KNIFE",
    [940833800] = "STONE_HATCHET",
    [1305664598] = "GRENADELAUNCHER_SMOKE",
    [727643628] = "CERAMICPISTOL",
    [-1074790547] = "ASSAULTRIFLE",
    [-1169823560] = "PIPEBOMB",
    [324215364] = "MICROSMG",
    [-1834847097] = "DAGGER",
    [-1466123874] = "MUSKET",
    [-1238556825] = "RAYMINIGUN",
    [-1063057011] = "SPECIALCARBINE",
    [1470379660] = "GADGETPISTOL",
    [584646201] = "APPISTOL",
    [-494615257] = "ASSAULTSHOTGUN",
    [-771403250] = "HEAVYPISTOL",
    [1672152130] = "HOMINGLAUNCHER",
    [338557568] = "PIPEWRENCH",
    [1785463520] = "MARKSMANRIFLE_MK2",
    [-1355376991] = "RAYPISTOL",
    [101631238] = "FIREEXTINGUISHER",
    [1119849093] = "MINIGUN",
    [883325847] = "PETROLCAN",
    [-102973651] = "HATCHET",
    [-275439685] = "DBSHOTGUN",
    [-1746263880] = "DOUBLEACTION",
    [-879347409] = "REVOLVER_MK2",
    [125959754] = "COMPACTLAUNCHER",
    [911657153] = "STUNGUN",
    [-2066285827] = "BULLPUPRIFLE_MK2",
    [-538741184] = "SWITCHBLADE",
    [100416529] = "SNIPERRIFLE",
    [-656458692] = "KNUCKLE",
    [-1768145561] = "SPECIALCARBINE_MK2",
    [1737195953] = "NIGHTSTICK",
    [2017895192] = "SAWNOFFSHOTGUN",
    [-2067956739] = "CROWBAR",
    [-1312131151] = "RPG",
    [-1568386805] = "GRENADELAUNCHER",
    [205991906] = "HEAVYSNIPER",
    [1834241177] = "RAILGUN",
    [-1716589765] = "PISTOL50",
    [736523883] = "SMG",
    [1317494643] = "HAMMER",
    [453432689] = "PISTOL",
    [1141786504] = "GOLFCLUB",
    [-1076751822] = "SNSPISTOL",
    [-2084633992] = "CARBINERIFLE",
    [487013001] = "PUMPSHOTGUN",
    [-1168940174] = "HAZARDCAN",
    [-38085395] = "DIGISCANNER",
    [-1853920116] = "NAVYREVOLVER",
    [-37975472] = "SMOKEGRENADE",
    [-1600701090] = "BZGAS",
    [-1357824103] = "ADVANCEDRIFLE",
    [-581044007] = "MACHETE",
    [741814745] = "STICKYBOMB",
    [-608341376] = "COMBATMG_MK2",
    [137902532] = "VINTAGEPISTOL",
    [-1660422300] = "MG",
    [1198879012] = "FLAREGUN"
}

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local currentWeapon = GetSelectedPedWeapon(ped)
        if currentWeapon ~= GetHashKey("weapon_unarmed") and currentWeapon ~= nil then
            local ammoTotal = GetAmmoInPedWeapon(ped,currentWeapon)
            local bool,ammoClip = GetAmmoInClip(ped,currentWeapon)
            local ammoRemaining = math.floor(ammoTotal - ammoClip)
            local weaponName = weapons[currentWeapon] or "Unbekannt"

            SendNUIMessage({
                action = 'showpistol',
                boolean = true
            })
            SendNUIMessage({
                action = 'setPistol',
                pistol = {
                    name = weaponName,
                    ["in"] = ammoClip,
                    out = ammoRemaining,
                }
            })
            Citizen.Wait(0)
        else
                        
            SendNUIMessage({
                action = 'showpistol',
                boolean = false
            })
            Citizen.Wait(1000)
        end
    end
end)


local law_json = json.decode(LoadResourceFile(GetCurrentResourceName(), GetResourceMetadata(GetCurrentResourceName(), 'law_file')))


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function(xPlayer, isNew, skin)
    setPlayerData()
    updatePermissions()
end)

RegisterNetEvent('esx:setJob', function(job, lastJob)
    setPlayerData()
    updatePermissions()
end)

RegisterNetEvent('fmdt:updatePermissions')
AddEventHandler('fmdt:updatePermissions',function()
    updatePermissions()
end)

function updatePermissions()
    ESX.TriggerServerCallback('fmdt:getPermissions', function(xPermissions)
        LocalPlayer.state:set('permissions', xPermissions, true)
    end)
end 

function setPlayerData()
    LocalPlayer.state:set('asigned', false, true)
    LocalPlayer.state:set('callName', 'n/A', true)
    LocalPlayer.state:set('callNumber', 'n/A', true)
    LocalPlayer.state:set('status', 'n/A', true)
    LocalPlayer.state:set('location', 'n/A', true)
    LocalPlayer.state:set('vehicle', 'n/A', true)
    LocalPlayer.state:set('frequency', 'n/A', true)
    LocalPlayer.state:set('o1', 'n/A', true)
    LocalPlayer.state:set('o2', 'n/A', true)
    LocalPlayer.state:set('o3', 'n/A', true)

    ESX.TriggerServerCallback('fmdt:getSelfData', function(xName, xRank, xJob, xNumber, xCallNumber)
        LocalPlayer.state:set('name', xName, true)
        LocalPlayer.state:set('rank', xRank, true)
        LocalPlayer.state:set('job', xJob, true)
        LocalPlayer.state:set('number', xNumber, true)
        LocalPlayer.state:set('callNumber', xCallNumber, true)
    end)
end 


exports('useTablet', function()
    exports[GetCurrentResourceName()]:openMDT('dashboard')
end)

Citizen.CreateThread(function()
    while true do
        if Config.CanBeTracked then 
            LocalPlayer.state:set('coords', GetEntityCoords(PlayerPedId()), true)
        end 
        Citizen.Wait(2500)
    end 
end)

RegisterCommand(Config.Tablet.command, function()
    if Config.Tablet.itemrequired then 
        if exports.ox_inventory:Search('count', Config.Tablet.item) >= 1 then 
            exports[GetCurrentResourceName()]:openMDT('dashboard')
        end 
    else 
        exports[GetCurrentResourceName()]:openMDT('dashboard')
    end 
end)

exports('openMDT', function(page)
    ESX.TriggerServerCallback('fmdt:getJob', function(xJob, xGrade)
        for k,v in pairs(Config.Tablet.access) do 
            if v == xJob then 
                getCops(xJob, xGrade, page)
            end 
        end 
    end)
end)

function getCops(xJob, xGrade, page)
    ESX.TriggerServerCallback('fmdt:getCops', function(xCops)
        setInformation(xJob, xGrade, xCops, page)
    end)
end

function setInformation(xJob, xGrade, xCops, page)
    local information = {
        self = {},
        general = {
            street = 0,
            offroad = 0,
            highspeed = 0,
            air = 0,
            city = 0,
            county = 0,
            highway = 0,
            other = 0,
            patrol = 0,
            king = 0,
            swat = 0,
            all = 0,
            user_found = 0,
            vehicle_found = 0,
            weapon_found = 0,
        },
        officers = {},
        warrents = {},
        calls = {},
        infos = {},
    }

    information.self.permissions = LocalPlayer.state.permissions
    information.self.asigned = LocalPlayer.state.asigned
    information.self.name = LocalPlayer.state.name
    information.self.rank = LocalPlayer.state.rank
    information.self.job = LocalPlayer.state.job
    information.self.callName = LocalPlayer.state.callName
    information.self.callNumber = LocalPlayer.state.callNumber
    information.self.status = LocalPlayer.state.status
    information.self.location = LocalPlayer.state.location
    information.self.vehicle = LocalPlayer.state.vehicle
    information.self.frequency = LocalPlayer.state.frequency
    information.self.o1 = LocalPlayer.state.o1
    information.self.o2 = LocalPlayer.state.o2
    information.self.o3 = LocalPlayer.state.o3

    local officers = {}
    for k,v in pairs(xCops) do 
        table.insert((information.officers), {
            asigned = Player(v).state.asigned,
            name = Player(v).state.name,
            number = Player(v).state.number,
            rank = Player(v).state.rank,
            job = Player(v).state.job,
            callName = Player(v).state.callName,
            callNumber = Player(v).state.callNumber,
            status = Player(v).state.status,
            location = Player(v).state.location,
            coords = Player(v).state.coords,
            vehicle = Player(v).state.vehicle,
            frequency = Player(v).state.frequency,
            o1 = Player(v).state.o1,
            o2 = Player(v).state.o2,
            o3 = Player(v).state.o3,
        })
    end 

    for k,v in pairs(information.officers) do 
        if v.vehicle ~= 'n/A' then 
            for o,i in pairs(Config.Clasifications.street) do 
                if v.vehicle == i then 
                    information.general.street = information.general.street + 1
                end 
            end 
            for o,i in pairs(Config.Clasifications.offroad) do 
                if v.vehicle == i then 
                    information.general.offroad = information.general.offroad + 1
                end 
            end 
            for o,i in pairs(Config.Clasifications.highspeed) do 
                if v.vehicle == i then 
                    information.general.highspeed = information.general.highspeed + 1
                end 
            end 
            for o,i in pairs(Config.Clasifications.air) do 
                if v.vehicle == i then 
                    information.general.air = information.general.air + 1
                end 
            end 
        end 

        if v.location ~= 'n/A' then 
            for o,i in pairs(Config.Clasifications.city) do 
                if v.location == i then 
                    information.general.city = information.general.city + 1
                end 
            end 
            for o,i in pairs(Config.Clasifications.county) do 
                if v.location == i then 
                    information.general.county = information.general.county + 1
                end 
            end 
            for o,i in pairs(Config.Clasifications.highway) do 
                if v.location == i then 
                    information.general.highway = information.general.highway + 1
                end 
            end 
            for o,i in pairs(Config.Clasifications.special) do 
                if v.location == i then 
                    information.general.other = information.general.other + 1
                end 
            end 
        end 

        if v.callName ~= 'n/A' then 
            for o,i in pairs(Config.Clasifications.patrol) do 
                if v.callName == i then 
                    information.general.patrol = information.general.patrol + 1
                end 
            end 
            for o,i in pairs(Config.Clasifications.king) do 
                if v.callName == i then 
                    information.general.king = information.general.king + 1
                end 
            end 
            for o,i in pairs(Config.Clasifications.swat) do 
                if v.callName == i then 
                    information.general.swat = information.general.swat + 1
                end 
            end 
            information.general.all = information.general.all + 1
        end 
    end 
    ESX.TriggerServerCallback('fmdt:getOtherInfos', function(xUser_found, xVehicle_found, xWeapon_found, xWarrents, xInfos, xCalls)
        information.general.user_found = xUser_found
        information.general.vehicle_found = xVehicle_found
        information.general.weapon_found = xWeapon_found
        information.warrents = xWarrents
        information.calls = GlobalState.mdtCalls
        information.infos = xInfos
        showUI(information, page)
    end)
end     

function takeImg(result)

    SetNuiFocus(false, false)
    SendNUIMessage({type = 'hide'})
    DisplayRadar(true)

    if lib.progressBar({
        duration = 5000,
        label = locales['taking_image'],
        useWhileDead = false,
        canCancel = true,
        disable = {
        },
        anim = {
            dict = 'amb@world_human_paparazzi@male@base',
            clip = 'base'
        },
        prop = {
            model = `prop_pap_camera_01`,
            bone = 28422,
            pos = vec3(0.0, 0.0, 0.0),
            rot = vec3(0.0, 0.0, 0.0)
        },
    }) then 
        DisplayRadar(false)
        local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        AttachCamToEntity(cam, PlayerPedId(), 1.0, 0.0, 0.7, true)
        SetCamRot(cam, 0.0, 0.0, GetEntityHeading(PlayerPedId()), 5)
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, true)
        PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
        Citizen.Wait(1000)
        exports['screenshot-basic']:requestScreenshotUpload(('https://api.imgbb.com/1/upload?key='..Config.ApiKey), 'image', function(data)
            local url = json.decode(data).data.url
            TriggerServerEvent('fmdt:setImg', result.identifier, url)
        end)
        Citizen.Wait(3000)
        DisplayRadar(true)
        SetCamActive(cam, false)
        RenderScriptCams(false, true, 500, true, true)
    end
end

function GetLawOptions()
    local law = {}
    for k,v in pairs(law_json) do 
        table.insert(law, {
            value = '§'..k..' '..v.categorie,
            label = '§'..k..' '..v.categorie,
        })
        for o,i in pairs(v.paragraphs) do 
            table.insert(law, {
                value = '§'..k..'.'..o..' '..i.label,
                label = '§'..k..'.'..o..' '..i.label,
            })   
        end 
    end 
    return(law)
end 

function getIdentifier(table)
    local identifier = 0
    if #table > 0 then
        identifier = table[#table].identifier + 1
    end 
    return identifier
end 

function trackPlate(plate)
    local returnValue = locales['tracking_no_vehicle_found'][1]
    for k,v in pairs(ESX.Game.GetVehicles()) do 
        if string.lower(GetVehicleNumberPlateText(v)) == string.lower(plate) then 
            returnValue = toTrackCoords({x = GetEntityCoords(v).x, y = GetEntityCoords(v).y})
            TriggerServerEvent('fmdt:setPlateDelay')
        end 
    end 
    return returnValue
end 

function toTrackCoords(table)
    local newX = 273.7 + table.x * 0.0594
    local newY = 463.7 - table.y * 0.0594
    return({x = newX, y = newY})
end 

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if IsControlJustReleased(0, Config.Keybinds.tablet) then 
            ExecuteCommand(Config.Tablet.command)
        end 
        if IsControlJustReleased(0, Config.Keybinds.panic) then 
            exports[GetCurrentResourceName()]:panic()
        end 
        if IsControlJustReleased(0, Config.Keybinds.position) then 
            exports[GetCurrentResourceName()]:position()
        end 
    end 
end)

exports('panic', function()
    if Config.CanBeTracked then 
        TriggerServerEvent('fmdt:button', GetEntityCoords(PlayerPedId()), true)
        ESX.TriggerServerCallback('fmdt:getSelfData', function(xName, xRank, xJob, xNumber, xCallNumber)

            local dispatches = GlobalState.mdtCalls
            table.insert(dispatches, {
                code = 'Code-3',
                reason = 'Panic Button',
                time = GlobalState.time,
                location = GetStreetNameFromHashKey(GetStreetNameAtCoord(GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, GetEntityCoords(PlayerPedId()).z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())),
                infos = (locales['panic'][1]):format(xName),
                coords = GetEntityCoords(PlayerPedId()),
                identifier = getIdentifier(dispatches),
                officer = {},
            })
            TriggerServerEvent('fmdt:addDispatch', dispatches, true)
        end)
    end 
end)

exports('position', function()
    if Config.CanBeTracked then 
        TriggerServerEvent('fmdt:button', GetEntityCoords(PlayerPedId()), false)
    end 
end)

RegisterNetEvent('fmdt:buttonClient')
AddEventHandler('fmdt:buttonClient', function(position, panic, name, id)
    --if id == GetPlayerServerId(PlayerId()) then 
    if id == 0 then 
        if panic then 
            Config.Notifcation(locales['pressed_panic'])
            SendNUIMessage({
                transactionType = 'playSound',
                transactionFile = 'panic',
                transactionVolume = 0.7,
            })
        else 
            Config.Notifcation(locales['pressed_position'])
            PlaySoundFrontend(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)
        end 
    else 
        if panic then 
            SetNewWaypoint(position.x, position.y)
            Config.Notifcation({(locales['panic'][1]):format(name), locales['panic'][2]})
            SendNUIMessage({
                transactionType = 'playSound',
                transactionFile = 'panic',
                transactionVolume = 0.7,
            })
        else     
            Config.InfoBar({(locales['position'][1]):format(name), locales['position'][2]}, true)
            PlaySoundFrontend(-1, "Out_Of_Bounds_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)
            local time = 0
            while time < 1500 do 
                Citizen.Wait(1)
                time = time + 1

                if IsControlJustReleased(0, 38) then 
                    time = 15000
                    SetNewWaypoint(position.x, position.y)
                    Config.Notifcation(locales['marked'])
                end 
                if IsControlJustReleased(0, 47) then 
                    time = 15000
                    Config.Notifcation(locales['not_marked'])
                end 
            end 
            Config.InfoBar({(locales['position'][1]):format(name), locales['position'][2]}, false)
        end 
    end 
end)

RegisterNetEvent('fmdt:gotDispatch')
AddEventHandler('fmdt:gotDispatch', function()
    Config.Notifcation(locales['dispatch'])
end)

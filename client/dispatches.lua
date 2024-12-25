
locales = Config.Locales[Config.Language]

exports('addDisptach', function(code, reason, infos, coords)
    TriggerServerEvent('fmdt:addDispatch', {
        code = code,
        reason = reason,
        time = GlobalState.time,
        location = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())),
        infos = infos,
        coords = coords,
        identifier = getIdentifier(GlobalState.mdtCalls),
        officer = {},
    })
end)

Citizen.CreateThread(function()
    if Config.Disptach.createMenu then 
        RegisterCommand(Config.Disptach.command, function()
            if Config.Disptach.itemrequired then 

                local hasPhone = false 
                for k,v in pairs(exports.ox_inventory:GetPlayerItems()) do 
                    if v.name == Config.Disptach.item then 
                        hasPhone = true
                    end 
                end 

                if hasPhone then 
                    exports[GetCurrentResourceName()]:createDispatch()
                else 
                    Config.Notifcation(locales['no_phone'])
                end 
            else 
                exports[GetCurrentResourceName()]:createDispatch()
            end 
        end)
    end
end)

exports('createDispatch', function()

    local code = Config.Disptach.defaultStatus
    local reason = ''
    local infos = ''

    local input = lib.inputDialog(Config.Menus.add_disptach.header, {
        {type = 'input', label = Config.Menus.add_disptach.reason, required = true, min = 4, max = 50},
        {type = 'textarea', label = Config.Menus.add_disptach.info, required = false, min = 5, autosize = true},
    })
    if input ~= nil then 
        reason = input[1]
        infos = input[2]

        if infos == nil or infos == '' then 
            infos = 'n/A'
        end 

        exports[GetCurrentResourceName()]:addDisptach(code, reason, infos, GetEntityCoords(PlayerPedId()))
    end 
end)

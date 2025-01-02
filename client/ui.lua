
locales = Config.Locales[Config.Language]

function showUI(information, page)
    SetNuiFocus(true, true)
    DisplayRadar(false)
    SendNUIMessage({
        type = 'show',
        information = information, 
        settings = Config.Settings, 
        page = page, 
    })
end 

RegisterNUICallback('exit', function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({type = 'hide'})
    DisplayRadar(true)
    cb()
end)

RegisterNUICallback('showPage', function(data, cb)
    local page = data.page
    exports[GetCurrentResourceName()]:openMDT(page)
end)

RegisterNUICallback('updateLeitstelle', function(data, cb)
    local type = data.type
    local status = data.status

    if type == 'asigned' then 
        LocalPlayer.state:set('asigned', status, true)
    end 

    Citizen.Wait(10)

    exports[GetCurrentResourceName()]:openMDT('leitstelle')
    cb()
end)

RegisterNUICallback('logout', function(data, cb)
    LocalPlayer.state:set('asigned', false, true)
    LocalPlayer.state:set('callName', 'n/A', true)
    LocalPlayer.state:set('status', 'n/A', true)
    LocalPlayer.state:set('location', 'n/A', true)
    LocalPlayer.state:set('vehicle', 'n/A', true)
    LocalPlayer.state:set('frequency', 'n/A', true)
    LocalPlayer.state:set('o1', 'n/A', true)
    LocalPlayer.state:set('o2', 'n/A', true)
    LocalPlayer.state:set('o3', 'n/A', true)
    Citizen.Wait(10)
    exports[GetCurrentResourceName()]:openMDT('leitstelle')
    cb()
end)

RegisterNUICallback('updateSelf', function(data, cb)
    LocalPlayer.state:set('asigned', data.information.self.asigned, true)
    LocalPlayer.state:set('callName', data.information.self.callName, true)
    LocalPlayer.state:set('callNumber', data.information.self.callNumber, true)
    LocalPlayer.state:set('status', data.information.self.status, true)
    LocalPlayer.state:set('location', data.information.self.location, true)
    LocalPlayer.state:set('vehicle', data.information.self.vehicle, true)
    LocalPlayer.state:set('frequency', data.information.self.frequency, true)
    LocalPlayer.state:set('o1', data.information.self.o1, true)
    LocalPlayer.state:set('o2', data.information.self.o2, true)
    LocalPlayer.state:set('o3', data.information.self.o3, true)

    for k,v in pairs(data.information.officers) do 
        if v.name == data.information.self.name then 
            data.information.officers[k].callName = LocalPlayer.state.callName
            data.information.officers[k].callNumber = LocalPlayer.state.callNumber
            data.information.officers[k].status = LocalPlayer.state.status
            data.information.officers[k].location = LocalPlayer.state.location
            data.information.officers[k].vehicle = LocalPlayer.state.vehicle
            data.information.officers[k].frequency = LocalPlayer.state.frequency
            data.information.officers[k].o1 = LocalPlayer.state.o1
            data.information.officers[k].o2 = LocalPlayer.state.o2
            data.information.officers[k].o3 = LocalPlayer.state.o3

        end 
    end 

    
    cb({data.information, Config.Settings, 'leitstelle'})
end)

RegisterNUICallback('getEinwohnerSearch', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local search = data.returnValue
    ESX.TriggerServerCallback('fmdt:searchEinwohner', function(result)
        cb(result)
    end, search)
end)
RegisterNUICallback('getFahrzeugSearch', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local search = data.returnValue
    ESX.TriggerServerCallback('fmdt:searchFahrzeug', function(result)
        for k,v in pairs(result) do 
            result[k].type = GetDisplayNameFromVehicleModel(v.type)
            result[k].color = Config.VehicleColors[v.color]
        end 
        cb(result)
    end, search, nil)
end)
RegisterNUICallback('getWaffeSearch', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local search = data.returnValue
    ESX.TriggerServerCallback('fmdt:searchWaffe', function(result) 
        cb(result)
    end, search, nil)
end)


RegisterNUICallback('getFahrzeugFromIdentifer', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local identifier = data.returnValue
    ESX.TriggerServerCallback('fmdt:searchFahrzeug', function(result)
        for k,v in pairs(result) do 
            result[k].type = GetDisplayNameFromVehicleModel(v.type)
            result[k].color = Config.VehicleColors[v.color]
        end 
        cb(result)
    end, nil, identifier)
end)
RegisterNUICallback('getWaffeFromIdentifer', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local identifier = data.returnValue
    ESX.TriggerServerCallback('fmdt:searchWaffe', function(result) 
        cb(result)
    end, nil, identifier)
end)


RegisterNUICallback('updateInformation', function(data, cb)
    local search = data
    cb()
end)


RegisterNUICallback('addGeneralInformation', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local input = lib.inputDialog(Config.Menus.create_info.header, {
        {type = 'input', label = Config.Menus.create_info.title, required = true, min = 4, max = 60},
        {type = 'input', label = Config.Menus.create_info.text, required = true, min = 4, max = 400},
    })
    if input ~= nil then 
        TriggerServerEvent('fmdt:addInformation', input)
    end 
    Citizen.Wait(20)
    exports[GetCurrentResourceName()]:openMDT('dashboard')
    cb()
end)

RegisterNUICallback('editGeneralInformation', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local info = data.info
    local input = lib.inputDialog(Config.Menus.create_info.header, {
        {type = 'input', label = Config.Menus.create_info.title, required = true, min = 4, max = 60, default = info.header},
        {type = 'input', label = Config.Menus.create_info.text, required = true, min = 4, max = 400, default = info.text},
    })
    if input ~= nil then 
        TriggerServerEvent('fmdt:editInformation', input, info.identifier)
    end 
    Citizen.Wait(20)
    exports[GetCurrentResourceName()]:openMDT('dashboard')
    cb()
end)

RegisterNUICallback('deleteGeneralInformation', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local info = data.info
    local alert = lib.alertDialog({
        header = Config.Menus.delete_info.header,
        content = Config.Menus.delete_info.text,
        centered = true,
        cancel = true,
        size = 'xs',
        labels = {
            confirm = Config.Menus.delete_info.confirm,
            cancel = Config.Menus.delete_info.cancel,
        }
    })
    if alert == 'confirm' then 
        TriggerServerEvent('fmdt:deleteInformation', info.identifier)
    end 
    Citizen.Wait(20)
    exports[GetCurrentResourceName()]:openMDT('dashboard')
    cb()
end)

RegisterNUICallback('editPlayerData', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local result = data.result
    local input = lib.inputDialog(Config.Menus.edit_player_info.header, {
        {type = 'input', label = Config.Menus.edit_player_info.number, required = false, min = 4, max = 50, default = result.telefon},
        {type = 'input', label = Config.Menus.edit_player_info.email, required = false, min = 4, max = 50, default = result.email},
        {type = 'input', label = Config.Menus.edit_player_info.job, required = false, min = 4, max = 50, default = result.job},
    })
    if input ~= nil then 
        result.telefon = input[1] or 'n/A'
        result.email = input[2] or 'n/A'
        result.job = input[3] or 'n/A'
        TriggerServerEvent('fmdt:editPlayerInfo', result)
    end 
    cb(result)
end)
RegisterNUICallback('editPlayerWarrant', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local result = data.result

    local input = lib.inputDialog(Config.Menus.edit_player_warrant.header, {
        {type = 'checkbox', label = Config.Menus.edit_player_warrant.state, checked = result.warrent},
        {type = 'input', label = Config.Menus.edit_player_warrant.reason, required = false, min = 4, max = 50, default = result.warrent_reason},
        {type = 'input', label = Config.Menus.edit_player_warrant.info, required = false, min = 4, max = 50, default = result.warrent_info},
    })
    if input ~= nil then 
        result.warrent = input[1]
        result.warrent_reason = input[2] or 'n/A'
        result.warrent_info = input[3] or 'n/A'

        if input[1] == false then 
            result.warrent_reason = 'n/A'
            result.warrent_info = 'n/A'
        end 

        TriggerServerEvent('fmdt:editPlayerWarrant', result, result.identifier)
    end 
    cb(result)
end)
RegisterNUICallback('editPlayerLicenses', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local result = data.result

    local options = {}
    for k,v in pairs(Config.Menus.edit_player_licenses.licenses) do 
        local has = false
        for o,i in pairs(result.licenses) do 
            if i == v.label then 
                has = true 
            end 
        end 
        table.insert(options, {
            type = 'checkbox', 
            label = v.label, 
            checked = has,
        })
    end

    local input = lib.inputDialog(Config.Menus.edit_player_licenses.header, options)
    if input ~= nil then 
        local newLicenses = {}
        local newTypes = {}
        for k,v in pairs(Config.Menus.edit_player_licenses.licenses) do 
            if input[k] then 
                table.insert(newLicenses, v.label)
                table.insert(newTypes, v.type)
            end 
        end 
        TriggerServerEvent('fmdt:editLicenses', newTypes, result.identifier)
        result.licenses = newLicenses
    end 
    cb(result)
end)

RegisterNUICallback('addPlayerNote', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local result = data.result

    local input = lib.inputDialog(Config.Menus.add_player_note.header, {
        {type = 'textarea', label = Config.Menus.add_player_note.text, required = true, min = 5, autosize = true},
    })
    if input ~= nil then 
        table.insert((result.notes),  {
            officer = LocalPlayer.state.name, 
            date = GlobalState.time,
            text = input[1],
            identifier = getIdentifier(result.notes),
        })
        TriggerServerEvent('fmdt:setNotes', result.notes, result.identifier)
    end 

    cb(result)
end)

RegisterNUICallback('editPlayerNote', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local result = data.result
    local note = data.note

    local input = lib.inputDialog(Config.Menus.add_player_note.header, {
        {type = 'textarea', label = Config.Menus.add_player_note.text, required = true, min = 5, autosize = true, default = note.text},
    })
    if input ~= nil then 
        for k,v in pairs(result.notes) do 
            if v.identifier == note.identifier then 
                result.notes[k].text = input[1]
            end 
        end 
        TriggerServerEvent('fmdt:setNotes', result.notes, result.identifier)
    end 
    cb(result)
end)

RegisterNUICallback('deletePlayerNote', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local result = data.result
    local note = data.note

    local alert = lib.alertDialog({
        header = Config.Menus.delete_player_note.header,
        content = Config.Menus.delete_player_note.text,
        centered = true,
        cancel = true,
        size = 'xs',
        labels = {
            confirm = Config.Menus.delete_player_note.confirm,
            cancel = Config.Menus.delete_player_note.cancel,
        }
    })
    if alert == 'confirm' then 
        for k,v in pairs(result.notes) do 
            if v.identifier == note.identifier then 
                table.remove((result.notes), k)
            end 
        end 
        TriggerServerEvent('fmdt:setNotes', result.notes, result.identifier)
    end 
    cb(result)
end)

RegisterNUICallback('addPlayerImg', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local result = data.result
    takeImg(result)
    cb()
end)

RegisterNUICallback('editImg', function(data, cb)
    local result = data.result

    local alert = lib.alertDialog({
        header = Config.Menus.edit_img.header,
        content = Config.Menus.edit_img.text,
        centered = true,
        cancel = true,
        size = 'xs',
        labels = {
            confirm = Config.Menus.edit_img.confirm,
            cancel = Config.Menus.edit_img.cancel,
        }
    })
    if alert == 'confirm' then 
        takeImg(result)
    else
        cb(result)
    end 
end)

RegisterNUICallback('createNewFile', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local result = data.result

    local input = lib.inputDialog(Config.Menus.add_player_file.header, {
        {type = 'select', label = Config.Menus.add_player_file.law, required = true, options = GetLawOptions()},
        {type = 'textarea', label = Config.Menus.add_player_file.info, required = true, min = 5, autosize = true},
    })
    if input ~= nil then 
        table.insert((result.openfiles),  {
            officer = LocalPlayer.state.name, 
            date = GlobalState.time,
            law = input[1],
            info = input[2],
            identifier = getIdentifier(result.openfiles),
        })
        TriggerServerEvent('fmdt:setActiveFiles', result.openfiles, result.identifier)
    end 
    cb(result)
end)

RegisterNUICallback('editOpenFile', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local result = data.result
    local file = data.file

    local input = lib.inputDialog(Config.Menus.add_player_file.header, {
        {type = 'select', label = Config.Menus.add_player_file.law, required = true, options = GetLawOptions(), default = file.law},
        {type = 'textarea', label = Config.Menus.add_player_file.info, required = true, min = 5, autosize = true, default = file.info},
    })
    if input ~= nil then 
        for k,v in pairs(result.openfiles) do 
            if v.identifier == file.identifier then 
                result.openfiles[k].law = input[1]
                result.openfiles[k].info = input[2]
            end 
        end 
        TriggerServerEvent('fmdt:setActiveFiles', result.openfiles, result.identifier)
    end 
    cb(result)
end)

RegisterNUICallback('deleteOpenFile', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local result = data.result
    local file = data.file

    local alert = lib.alertDialog({
        header = Config.Menus.delete_player_file.header,
        content = Config.Menus.delete_player_file.text,
        centered = true,
        cancel = true,
        size = 'xs',
        labels = {
            confirm = Config.Menus.delete_player_file.confirm,
            cancel = Config.Menus.delete_player_file.cancel,
        }
    })
    if alert == 'confirm' then 
        for k,v in pairs(result.openfiles) do 
            if v.identifier == file.identifier then 
                table.remove((result.openfiles), k)
            end 
        end 
        TriggerServerEvent('fmdt:setActiveFiles', result.openfiles, result.identifier)
    end 
    cb(result)
end)

RegisterNUICallback('closeOpenFile', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local result = data.result
    local file = data.file

    for k,v in pairs(result.openfiles) do 
        if v.identifier == file.identifier then 
            table.insert((result.closedfiles), v)
            table.remove((result.openfiles), k)
        end 
    end 

    TriggerServerEvent('fmdt:setActiveFiles', result.openfiles, result.identifier)
    TriggerServerEvent('fmdt:setInactiveFiles', result.closedfiles, result.identifier)
    cb(result)
end)

RegisterNUICallback('closeClosedFile', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local result = data.result
    local file = data.file

    for k,v in pairs(result.closedfiles) do 
        if v.identifier == file.identifier then 
            table.insert((result.openfiles), v)
            table.remove((result.closedfiles), k)
        end 
    end 

    TriggerServerEvent('fmdt:setActiveFiles', result.openfiles, result.identifier)
    TriggerServerEvent('fmdt:setInactiveFiles', result.closedfiles, result.identifier)
    cb(result)
end)

RegisterNUICallback('deleteClosedFile', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local result = data.result
    local file = data.file

    local alert = lib.alertDialog({
        header = Config.Menus.delete_player_file.header,
        content = Config.Menus.delete_player_file.text,
        centered = true,
        cancel = true,
        size = 'xs',
        labels = {
            confirm = Config.Menus.delete_player_file.confirm,
            cancel = Config.Menus.delete_player_file.cancel,
        }
    })
    if alert == 'confirm' then 
        for k,v in pairs(result.closedfiles) do 
            if v.identifier == file.identifier then 
                table.remove((result.closedfiles), k)
            end 
        end 
        TriggerServerEvent('fmdt:setInactiveFiles', result.closedfiles, result.identifier)
    end 
    cb(result)
end)

RegisterNUICallback('editClosedFile', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local result = data.result
    local file = data.file

    local input = lib.inputDialog(Config.Menus.add_player_file.header, {
        {type = 'select', label = Config.Menus.add_player_file.law, required = true, options = GetLawOptions(), default = file.law},
        {type = 'textarea', label = Config.Menus.add_player_file.info, required = true, min = 5, autosize = true, default = file.info},
    })
    if input ~= nil then 
        for k,v in pairs(result.closedfiles) do 
            if v.identifier == file.identifier then 
                result.closedfiles[k].law = input[1]
                result.closedfiles[k].info = input[2]
            end 
        end 
        TriggerServerEvent('fmdt:setInactiveFiles', result.closedfiles, result.identifier)
    end 
    cb(result)
end)


RegisterNUICallback('trackNumber', function(data, cb)
    local search = data.returnValue

    if Config.Tracking.enabled.number then 
        if GlobalState.numberDelay <= 0 then 
            ESX.TriggerServerCallback('fmdt:searchNumberLocation', function(result)
                cb(result)
            end, search)
        else 
            cb((locales['tracking_cooldown'][1]):format(GlobalState.numberDelay))
        end 
    else 
        cb(locales['tracking_not_possible'][1])
    end 
end)
RegisterNUICallback('trackPlate', function(data, cb)
    local search = data.returnValue

    if Config.Tracking.enabled.plate then 
        if GlobalState.plateDelay <= 0 then 
            local result = trackPlate(search)
            cb(result)
        else 
            cb((locales['tracking_cooldown'][1]):format(GlobalState.plateDelay))
        end 
    else 
        cb(locales['tracking_not_possible'][1])
    end 
end)

RegisterNUICallback('editDispatch', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local identifier = data.returnValue
    local code = ''
    local options = {}
    local dispatches = GlobalState.mdtCalls

    for k,v in pairs(dispatches) do 
        if v.identifier == identifier then
            code = v.code
        end 
    end  

    for k,v in pairs(Config.Settings.callStatus) do 
        table.insert(options, {
            value = v.status,
            label = v.status,
        })
    end


    local input = lib.inputDialog(Config.Menus.edit_dispatch.header, {
        {type = 'select', label = Config.Menus.edit_dispatch.code, required = true, options = options, default = code},
    })
    if input ~= nil then 
        TriggerServerEvent('fmdt:editDispatch', identifier, input[1], nil)
    end 

    Citizen.Wait(20)
    if data.returnPage == true then 
        exports[GetCurrentResourceName()]:openMDT('dispatches')
    else 
        exports[GetCurrentResourceName()]:openMDT('dashboard')
    end 
    cb()
end)

RegisterNUICallback('deleteDispatch', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local identifier = data.returnValue

    local alert = lib.alertDialog({
        header = Config.Menus.delete_dispatch.header,
        content = Config.Menus.delete_dispatch.text,
        centered = true,
        cancel = true,
        size = 'xs',
        labels = {
            confirm = Config.Menus.delete_dispatch.confirm,
            cancel = Config.Menus.delete_dispatch.cancel,
        }
    })
    if alert == 'confirm' then 
        TriggerServerEvent('fmdt:removeDispatch', identifier)
    end

    Citizen.Wait(20)
    if data.returnPage == true then 
        exports[GetCurrentResourceName()]:openMDT('dispatches')
    else 
        exports[GetCurrentResourceName()]:openMDT('dashboard')
    end 
    cb()
end)

RegisterNUICallback('officerDispatch', function(data, cb)
    ESX.TriggerServerCallback('fmdt:getCops', function(xCops)
        PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)

        local identifier = data.returnValue
        local dispatches = GlobalState.mdtCalls
        local officers = {}
        local options = {}

        for k,v in pairs(dispatches) do 
            if v.identifier == identifier then
                officers = v.officer
            end 
        end  

        for k,v in pairs(xCops) do 
            table.insert(options, {
                value = Player(v).state.name,
                label = Player(v).state.name,
            })
        end  

        local input = lib.inputDialog(Config.Menus.edit_dispatch_officers.header, {
            {type = 'multi-select', label = Config.Menus.edit_dispatch_officers.officer, options = options, default = officers, searchable = true},
        })
        if input ~= nil then 
            TriggerServerEvent('fmdt:editDispatch', identifier, nil, input[1])
        end 

        Citizen.Wait(20)
        if data.returnPage == true then 
            exports[GetCurrentResourceName()]:openMDT('dispatches')
        else 
            exports[GetCurrentResourceName()]:openMDT('dashboard')
        end 
        cb()
    end)
end)


RegisterNUICallback('setOfficerStatus', function(data, cb)
    ESX.TriggerServerCallback('fmdt:getCops', function(xCops)
        PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
        local name = data.returnValue

        local options = {}

        for k,v in pairs(Config.Settings.status) do 
            if v.status ~= 'n/A' then
                table.insert(options, {
                    value = v.status,
                    label = v.status,
                })
            end
        end 
        
        local input = lib.inputDialog(Config.Menus.edit_officer_status.header, {
            {type = 'select', label = Config.Menus.edit_officer_status.status, options = options},
        })
        if input ~= nil then 
            TriggerServerEvent('fmdt:setOfficerStatus', input[1], name)
        end 

        Citizen.Wait(20)
        exports[GetCurrentResourceName()]:openMDT('dispatches')
        cb()
    end)
end)

RegisterNUICallback('setOfficerDispatch', function(data, cb)
    ESX.TriggerServerCallback('fmdt:getCops', function(xCops)
        PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
        local name = data.returnValue
        local dispatches = GlobalState.mdtCalls



        local options = {}
        local eingeteilt = {}

        for k,v in pairs(dispatches) do 
            for o,i in pairs(v.officer) do 
                if i == name then 
                    table.insert(eingeteilt, v.identifier)
                end 
            end 
        end 

        for k,v in pairs(dispatches) do 
            if v.status ~= 'n/A' then
                table.insert(options, {
                    value = v.identifier,
                    label = v.code .. ' - ' .. v.reason,
                })
            end
        end 
        
        local input = lib.inputDialog(Config.Menus.edit_officer_dispatch.header, {
            {type = 'multi-select', label = Config.Menus.edit_officer_dispatch.dispatch, options = options, default = eingeteilt, searchable = true},
        })
        if input ~= nil then 
            for k,v in pairs(dispatches) do 
                Citizen.Wait(5)
                for o,i in pairs(v.officer) do 
                    if i == name then 
                        local newOfficer = v.officer
                        table.remove(newOfficer, o)
                        TriggerServerEvent('fmdt:editDispatch', v.identifier, nil, newOfficer)
                    end 
                end 

                for o,i in pairs(input[1]) do 
                    if i == v.identifier then 
                        local newOfficer = v.officer
                        table.insert(newOfficer, name)
                        TriggerServerEvent('fmdt:editDispatch', v.identifier, nil, newOfficer)
                    end 
                end
            end 
        end 

        Citizen.Wait(20)
        exports[GetCurrentResourceName()]:openMDT('dispatches')
        cb()
    end)
end)

RegisterNUICallback('listGetOfficers', function(data, cb)
    ESX.TriggerServerCallback('fmdt:listGetOfficers', function(officers)

        if not Config.Lists.employees.showEmptyGrades then 
            local remove = {}
            for k,v in pairs(officers) do 
                if json.encode(v.officers) == '[]' then 
                    table.insert(remove, {
                        job = v.job,
                        grade = v.grade,
                    }) 
                end 
            end 

            for k,v in pairs(remove) do 
                for o,i in pairs(officers) do 
                    if v.grade == i.grade and v.job == i.job then 
                        table.remove(officers, o)
                    end 
                end 
            end 
        end

        cb(officers)
    end)
end)

RegisterNUICallback('officerListFire', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local officer = data.officer

    local alert = lib.alertDialog({
        header = Config.Menus.officer_fire.header,
        content = (Config.Menus.officer_fire.text):format((officer.firstname .. ' ' .. officer.lastname)),
        centered = true,
        cancel = true,
        size = 'xs',
        labels = {
            confirm = Config.Menus.officer_fire.confirm,
            cancel = Config.Menus.officer_fire.cancel,
        }
    })
    if alert == 'confirm' then 
        TriggerServerEvent('fmdt:fire', officer.identifier)
    end

    Citizen.Wait(200)

    cb({officers})
end)

RegisterNUICallback('officerListEdit', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    ESX.TriggerServerCallback('fmdt:officerGetGradeOptions', function(officersGrade, grades)
        local officer = data.officer
        local options = {}

        for k,v in pairs(Config.Units) do 
            table.insert(options, {value = v.id, label = v.name})
        end 

        local input = lib.inputDialog(Config.Menus.officer_edit.header, {
            {type = 'select', label = Config.Menus.officer_edit.rank, options = grades, default = officersGrade, required = true},
            {type = 'number', label = Config.Menus.officer_edit.callNumber, default = officer.callNumber, required = true, min = 1, max = 999},
            {type = 'input', label = Config.Menus.officer_edit.badgeNumber, default = officer.badgeNumber, required = true, description = 'XX-XXX', min = 6, max = 6},
            {type = 'select', label = Config.Menus.officer_edit.unit, default = officer.unit, required = true, options = options},
        })
        if input ~= nil then 
            TriggerServerEvent('fmdt:updateOfficer', officer.identifier, input[1], input[2], input[3], input[4])
        end 
    end, (data.officer.identifier))

    Citizen.Wait(200)

    cb()
end)

RegisterNUICallback('officerListInfo', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    ESX.TriggerServerCallback('fmdt:officerGetInfo', function(xInfo)

        local input = lib.inputDialog(Config.Menus.officer_info.header, {
            {type = 'textarea', label = Config.Menus.officer_info.info, autosize = true, min = 30, max = 60, required = false, default = xInfo},
        })
        if input ~= nil then 
            TriggerServerEvent('fmdt:updateOfficerInfo', (data.officer.identifier), input[1])
        end 

    end, (data.officer.identifier)) 

    Citizen.Wait(200)

    cb()
end)

RegisterNUICallback('officerListList', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    ESX.TriggerServerCallback('fmdt:officerGetTrainings', function(xTrainings)
        local trainings = json.decode(xTrainings)
        local trainingText = '   \n   \n   \n'

        for k,v in pairs(Config.Trainings) do 
            local hasTraining = '✖️' 
            for o, i in pairs(trainings) do 
                if i == v.id then 
                    hasTraining = '✔️' 
                end 
            end 
            trainingText = trainingText .. hasTraining .. ' | ' .. v.name .. '   \n   \n   '
        end 

        local alert = lib.alertDialog({
            header = Config.Menus.officer_list.header,
            content = trainingText,
            centered = true,
            cancel = false,
            overflow = true,
            size = 'md',
            labels = {
                confirm = 'OK',
            }
        })

    end, (data.officer.identifier))
    cb()
end)

RegisterNUICallback('officerAdd', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    ESX.TriggerServerCallback('fmdt:getOnlinePlayers', function(xPlayers)
        local input = lib.inputDialog(Config.Menus.officer_add.header, {
            {type = 'select', label = Config.Menus.officer_add.person, options = xPlayers, required = true},
        })
        if input ~= nil then 
            TriggerServerEvent('fmdt:hire', input[1])
        end 

    end)

    Citizen.Wait(200)

    cb()
end)

RegisterNUICallback('listGetVehicles', function(data, cb)
    ESX.TriggerServerCallback('fmdt:listGetVehicles', function(vehicles)
        if not Config.Lists.vehicles.showEmptyCategories then 
            local remove = {}
            for k,v in pairs(vehicles) do 
                if json.encode(v.vehicles) == '[]' then 
                    table.insert(remove, {
                        label = v.label,
                    }) 
                end 
            end 

            for k,v in pairs(remove) do 
                for o,i in pairs(vehicles) do 
                    if v.label == i.label then 
                        table.remove(vehicles, o)
                    end 
                end 
            end 
        end

        cb(vehicles)
    end)
end)

RegisterNUICallback('vehicleAdd', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    ESX.TriggerServerCallback('fmdt:listGetGrades', function(xGrades)

        local data = data.returnValue
        local all = data.all
        local options = {}

        for k,v in pairs(Config.Settings.vehicles) do 
            if v.status ~= 'n/A' then 
                table.insert(options, {
                    label = v.status, 
                    value = v.status, 
                })
            end 
        end 

        local input = lib.inputDialog(Config.Menus.vehicle_add.header, {
            {type = 'select', label = Config.Menus.vehicle_add.categorie, options = options, required = true, default = data.label},
            {type = 'input', label = Config.Menus.vehicle_add.label, required = true},
            {type = 'select', label = Config.Menus.vehicle_add.rank, options = xGrades, default = xGrades[1].value, required = true},
            {type = 'number', label = Config.Menus.vehicle_add.price, min = 0, required = true},
        })
        if input ~= nil then 
            TriggerServerEvent('fmdt:addVehicle', input[1], input[2], input[3], input[4])
        end 
    end)

    Citizen.Wait(200)

    cb()
end)

RegisterNUICallback('vehicleListDelete', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local vehicle = data.vehicle

    local alert = lib.alertDialog({
        header = Config.Menus.vehicle_delete.header,
        content = (Config.Menus.vehicle_delete.text):format(vehicle.label),
        centered = true,
        cancel = true,
        size = 'xs',
        labels = {
            confirm = Config.Menus.vehicle_delete.confirm,
            cancel = Config.Menus.vehicle_delete.cancel,
        }
    })
    if alert == 'confirm' then 
        TriggerServerEvent('fmdt:listDeleteVehicle', vehicle.identifier)
    end

    Citizen.Wait(200)

    cb()
end)

RegisterNUICallback('vehicleListEdit', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)

    ESX.TriggerServerCallback('fmdt:listGetGrades', function(xGrades)

        local data = data.vehicle
        local options = {}

        for k,v in pairs(Config.Settings.vehicles) do 
            if v.status ~= 'n/A' then 
                table.insert(options, {
                    label = v.status, 
                    value = v.status, 
                })
            end 
        end 

        local input = lib.inputDialog(Config.Menus.vehicle_edit.header, {
            {type = 'select', label = Config.Menus.vehicle_edit.categorie, options = options, required = true, default = data.categorie},
            {type = 'input', label = Config.Menus.vehicle_edit.label, required = true, default = data.label},
            {type = 'select', label = Config.Menus.vehicle_edit.rank, options = xGrades, default = data.grade, required = true},
            {type = 'number', label = Config.Menus.vehicle_edit.price, min = 0, required = true, default = data.price},
        })
        if input ~= nil then 
            TriggerServerEvent('fmdt:editVehicle', data.identifier, input[1], input[2], input[3], input[4])
        end 
    end)

    Citizen.Wait(200)

    cb()
end)

RegisterNUICallback('listGetOutfits', function(data, cb)
    ESX.TriggerServerCallback('fmdt:listGetOutfits', function(outfits)
        cb(outfits)
    end)
end)

RegisterNUICallback('outfitsListAdd', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    ESX.TriggerServerCallback('fmdt:listGetGrades', function(xGrades)

        local input = lib.inputDialog(Config.Menus.outfit_add.header, {
            {type = 'input', label = Config.Menus.outfit_add.label, required = true},
            {type = 'select', label = Config.Menus.outfit_add.rank, options = xGrades},
            {type = 'input', label = Config.Menus.outfit_add.unit, required = true},
            {type = 'input', label = Config.Menus.outfit_add.url, required = false},
        })
        if input ~= nil then 
            local outfitInput = lib.inputDialog(Config.Menus.outfit_add.header, {
                {type = 'number', label = Config.Menus.outfit_add.parts.tshirt ..' 1'},
                {type = 'number', label = Config.Menus.outfit_add.parts.tshirt ..' 2'},
                {type = 'number', label = Config.Menus.outfit_add.parts.torso ..' 1'},
                {type = 'number', label = Config.Menus.outfit_add.parts.torso ..' 2'},
                {type = 'number', label = Config.Menus.outfit_add.parts.decals ..' 1'},
                {type = 'number', label = Config.Menus.outfit_add.parts.decals ..' 2'},
                {type = 'number', label = Config.Menus.outfit_add.parts.arms ..' 1'},
                {type = 'number', label = Config.Menus.outfit_add.parts.arms ..' 2'},
                {type = 'number', label = Config.Menus.outfit_add.parts.pants ..' 1'},
                {type = 'number', label = Config.Menus.outfit_add.parts.pants ..' 2'},
                {type = 'number', label = Config.Menus.outfit_add.parts.shoes ..' 1'},
                {type = 'number', label = Config.Menus.outfit_add.parts.shoes ..' 2'},
                {type = 'number', label = Config.Menus.outfit_add.parts.mask ..' 1'},
                {type = 'number', label = Config.Menus.outfit_add.parts.mask ..' 2'},
                {type = 'number', label = Config.Menus.outfit_add.parts.bproof ..' 1'},
                {type = 'number', label = Config.Menus.outfit_add.parts.bproof ..' 2'},
                {type = 'number', label = Config.Menus.outfit_add.parts.chain ..' 1'},
                {type = 'number', label = Config.Menus.outfit_add.parts.chain ..' 2'},
                {type = 'number', label = Config.Menus.outfit_add.parts.helmet ..' 1'},
                {type = 'number', label = Config.Menus.outfit_add.parts.helmet ..' 2'},
                {type = 'number', label = Config.Menus.outfit_add.parts.glasses ..' 1'},
                {type = 'number', label = Config.Menus.outfit_add.parts.glasses ..' 2'},
                {type = 'number', label = Config.Menus.outfit_add.parts.watches ..' 1'},
                {type = 'number', label = Config.Menus.outfit_add.parts.watches ..' 2'},
                {type = 'number', label = Config.Menus.outfit_add.parts.bags ..' 1'},
                {type = 'number', label = Config.Menus.outfit_add.parts.bags ..' 2'},
                {type = 'number', label = Config.Menus.outfit_add.parts.ears ..' 1'},
                {type = 'number', label = Config.Menus.outfit_add.parts.ears ..' 2'},
            })
            if outfitInput ~= nil then 
                local outfit = {
                    tshirt_1 = outfitInput[1] or 'n/A', tshirt_2 = outfitInput[2] or 'n/A',
                    torso_1 = outfitInput[3] or 'n/A', torso_2 = outfitInput[4] or 'n/A',
                    decals_1 = outfitInput[5] or 'n/A', decals_2 = outfitInput[6] or 'n/A',
                    arms = outfitInput[7] or 'n/A', arms_2 = outfitInput[8] or 'n/A',
                    pants_1 = outfitInput[9] or 'n/A', pants_2 = outfitInput[10] or 'n/A',
                    shoes_1 = outfitInput[11] or 'n/A', shoes_2 = outfitInput[12] or 'n/A',
                    mask_1 = outfitInput[13] or 'n/A', mask_2 = outfitInput[14] or 'n/A',
                    bproof_1 = outfitInput[15] or 'n/A', bproof_2 = outfitInput[16] or 'n/A',
                    chain_1 = outfitInput[17] or 'n/A', chain_2 = outfitInput[18] or 'n/A',
                    helmet_1 = outfitInput[19] or 'n/A', helmet_2 = outfitInput[20] or 'n/A',
                    glasses_1 = outfitInput[21] or 'n/A', glasses_2 = outfitInput[22] or 'n/A',
                    watches_1 = outfitInput[23] or 'n/A', watches_2 = outfitInput[24] or 'n/A',
                    bags_1 = outfitInput[25] or 'n/A', bags_2 = outfitInput[26] or 'n/A',
                    ears_1 = outfitInput[27] or 'n/A', ears_2 = outfitInput[28] or 'n/A',
                }
                TriggerServerEvent('fmdt:addOutfit', input[1], input[2], input[3], input[4], outfit)
            end 
        end 

    end)

    Citizen.Wait(200)

    cb()
end)

RegisterNUICallback('outfitsListInfo', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local outfit = json.decode(data.outfit.outfit)
    local outfitText = '   \n   \n'

    outfitText = outfitText .. Config.Menus.outfit_add.parts.tshirt ..': ' .. outfit.tshirt_1 .. '/' .. outfit.tshirt_2 .. '   \n'
    outfitText = outfitText .. Config.Menus.outfit_add.parts.torso ..': ' .. outfit.torso_1 .. '/' .. outfit.torso_2 .. '   \n'
    outfitText = outfitText .. Config.Menus.outfit_add.parts.decals ..': ' .. outfit.decals_1 .. '/' .. outfit.decals_2 .. '   \n'
    outfitText = outfitText .. Config.Menus.outfit_add.parts.arms ..': ' .. outfit.arms .. '/' .. outfit.arms_2 .. '   \n'
    outfitText = outfitText .. Config.Menus.outfit_add.parts.pants ..': ' .. outfit.pants_1 .. '/' .. outfit.pants_2 .. '   \n'
    outfitText = outfitText .. Config.Menus.outfit_add.parts.shoes ..': ' .. outfit.shoes_1 .. '/' .. outfit.shoes_2 .. '   \n'
    outfitText = outfitText .. Config.Menus.outfit_add.parts.mask ..': ' .. outfit.mask_1 .. '/' .. outfit.mask_2 .. '   \n'
    outfitText = outfitText .. Config.Menus.outfit_add.parts.bproof ..': ' .. outfit.bproof_1 .. '/' .. outfit.bproof_2 .. '   \n'
    outfitText = outfitText .. Config.Menus.outfit_add.parts.chain ..': ' .. outfit.chain_1 .. '/' .. outfit.chain_2 .. '   \n'
    outfitText = outfitText .. Config.Menus.outfit_add.parts.helmet ..': ' .. outfit.helmet_1 .. '/' .. outfit.helmet_2 .. '   \n'
    outfitText = outfitText .. Config.Menus.outfit_add.parts.glasses ..': ' .. outfit.glasses_1 .. '/' .. outfit.glasses_2 .. '   \n'
    outfitText = outfitText .. Config.Menus.outfit_add.parts.watches ..': ' .. outfit.watches_1 .. '/' .. outfit.watches_2 .. '   \n'
    outfitText = outfitText .. Config.Menus.outfit_add.parts.bags ..': ' .. outfit.bags_1 .. '/' .. outfit.bags_2 .. '   \n'
    outfitText = outfitText .. Config.Menus.outfit_add.parts.ears ..': ' .. outfit.ears_1 .. '/' .. outfit.ears_2 .. '   \n'

    local alert = lib.alertDialog({
        header = Config.Menus.outfit_info.header,
        content = outfitText,
        centered = true,
        cancel = false,
        overflow = true,
        size = 'md',
        labels = {
            confirm = 'OK',
        }
    })
end)

RegisterNUICallback('outfitsListDelete', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local outfit = data.outfit

    local alert = lib.alertDialog({
        header = Config.Menus.outfit_delete.header,
        content = (Config.Menus.outfit_delete.text):format(outfit.label),
        centered = true,
        cancel = true,
        size = 'xs',
        labels = {
            confirm = Config.Menus.outfit_delete.confirm,
            cancel = Config.Menus.outfit_delete.cancel,
        }
    })
    if alert == 'confirm' then 
        TriggerServerEvent('fmdt:listDeleteOutfit', outfit.identifier)
    end

    Citizen.Wait(200)

    cb()
end)

RegisterNUICallback('outfitsListEdit', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    ESX.TriggerServerCallback('fmdt:listGetGrades', function(xGrades)
        local outfit = data.outfit

        local input = lib.inputDialog(Config.Menus.outfit_add.header, {
            {type = 'input', label = Config.Menus.outfit_add.label, required = true, default = outfit.label},
            {type = 'select', label = Config.Menus.outfit_add.rank, options = xGrades, default = outfit.mingrade},
            {type = 'input', label = Config.Menus.outfit_add.unit, required = true, default = outfit.unit},
            {type = 'input', label = Config.Menus.outfit_add.url, required = false, default = outfit.url},
        })
        if input ~= nil then 
            TriggerServerEvent('fmdt:editOutfit', outfit.identifier, input[1], input[2], input[3], input[4])
        end 
    end)

    Citizen.Wait(200)

    cb()
end)

RegisterNUICallback('listGetCodes', function(data, cb)
    local data = {}
    data.status = Config.Settings.status
    data.codes = Config.Settings.callStatus
    data.frequency = Config.Settings.frequency
    cb(data)
end)

RegisterNUICallback('listGetTodos', function(data, cb)
    ESX.TriggerServerCallback('fmdt:listGetTodos', function(xData)
        cb(xData)
    end)
end)

RegisterNUICallback('todoListAdd', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    ESX.TriggerServerCallback('fmdt:getSelfData', function(xName, xGrade, xJob)

        local input = lib.inputDialog(Config.Menus.todo_add.header, {
            {type = 'input', label = Config.Menus.todo_add.label, required = true, min = 4, max = 30},
            {type = 'textarea', label = Config.Menus.todo_add.description, min = 5, autosize = true},
        })
        if input ~= nil then 
            TriggerServerEvent('fmdt:addTodo', input[1], input[2], (xGrade .. ' - ' .. xName))
        end

        Citizen.Wait(200)

        cb()
    end)
end)

RegisterNUICallback('todoListEdit', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local todo = data.todo
    local input = lib.inputDialog(Config.Menus.todo_edit.header, {
        {type = 'input', label = Config.Menus.todo_edit.label, required = true, min = 4, max = 30, default = todo.label},
        {type = 'textarea', label = Config.Menus.todo_edit.description, min = 5, autosize = true, default = todo.description},
    })
    if input ~= nil then 
        TriggerServerEvent('fmdt:editTodo', todo.identifier, input[1], input[2])
    end

    Citizen.Wait(200)

    cb()
end)

RegisterNUICallback('todoListDelete', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local todo = data.todo

    local alert = lib.alertDialog({
        header = Config.Menus.todo_delete.header,
        content = (Config.Menus.todo_delete.text):format(todo.label),
        centered = true,
        cancel = true,
        size = 'xs',
        labels = {
            confirm = Config.Menus.todo_delete.confirm,
            cancel = Config.Menus.todo_delete.cancel,
        }
    })
    if alert == 'confirm' then 
        TriggerServerEvent('fmdt:listDeleteTodo', todo.identifier)
    end

    Citizen.Wait(200)

    cb()
end)

RegisterNUICallback('todoListCheck', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local todo = data.todo

    local status = 0
    if todo.status == 0 then 
        status = 1
    end 

    TriggerServerEvent('fmdt:listCheckTodo', todo.identifier, status)

    Citizen.Wait(200)

    cb()
end)

RegisterNUICallback('listGetLaw', function(data, cb)
    local law_json = json.decode(LoadResourceFile(GetCurrentResourceName(), GetResourceMetadata(GetCurrentResourceName(), 'law_file')))
    cb({law = law_json, settings = Config.Lists.law})
end)

RegisterNUICallback('showCalc', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
        local calculation = Config.Calculation
        local law_json = json.decode(LoadResourceFile(GetCurrentResourceName(), GetResourceMetadata(GetCurrentResourceName(), 'law_file')))
        calculation(law_json)
    cb()
end)

RegisterNUICallback('listGetAusbildungen', function(data, cb)
    ESX.TriggerServerCallback('fmdt:listGetAusbildungen', function(xData)
        ESX.TriggerServerCallback('fmdt:getSelfData', function(xName, xGrade, xJob, number, callNumber, gradeNumber)
            local ausbildungen = xData
            for k,v in pairs(ausbildungen) do 

                for o,i in pairs(Config.Trainings) do 
                    if (i.id == ausbildungen[k].label) and i.mingrade > gradeNumber then 
                        ausbildungen[k].invisible = true
                    end 
                end 

                ausbildungen[k].asigned = false 
                ausbildungen[k].list = json.decode(v.list)

                for o,i in pairs(v.list) do 
                    if i == xName then 
                        ausbildungen[k].asigned = true
                    end 
                end                 

                for o,i in pairs(Config.Trainings) do 
                    if i.id == ausbildungen[k].label then 
                        ausbildungen[k].label = i.name
                    end 
                end 
            end
            cb(ausbildungen)
        end)
    end)
end)

RegisterNUICallback('ausbildungListAdd', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    ESX.TriggerServerCallback('fmdt:getSelfData', function(xName, xGrade, xJob)
        ESX.TriggerServerCallback('fmdt:listGetAllOfficers', function(xOfficers)

            local trainings = {}
            for k,v in pairs(Config.Trainings) do 
                table.insert(trainings, {value = v.id, label = v.name})
            end 

            local input = lib.inputDialog(Config.Menus.training_add.header, {
                {type = 'select', label = Config.Menus.training_add.label, options = trainings, required = true},
                {type = 'textarea', label = Config.Menus.training_add.description, min = 5, autosize = true},
                {type = 'date', label = Config.Menus.training_add.time, required = true, returnString = true},
                {type = 'input', label = Config.Menus.training_add.location, required = true, min = 3, max = 50},
                {type = 'slider', label = Config.Menus.training_add.limit, required = true, min = 1, max = 25, step = 1},
                {type = 'multi-select', label = Config.Menus.training_add.officer, searchable = true, options = xOfficers, clearable = true},
                {type = 'select', label = Config.Menus.training_add.supervisor, searchable = true, options = xOfficers, clearable = true},
            })
            if input ~= nil then 
                TriggerServerEvent('fmdt:addAusbildung', input[1], input[2], input[3], input[4], input[5], input[6], input[7], xName)
            end

            Citizen.Wait(200)

            cb()
        end)
    end)
end)

RegisterNUICallback('ausbildungListAsign', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    ESX.TriggerServerCallback('fmdt:getSelfData', function(xName, xGrade, xJob, number, callNumber, gradeNumber)
        local ausbildung = data.ausbildung

        local found = false 
        local list = ausbildung.list
        for k,v in pairs(ausbildung.list) do 
            if xName == v then 
                table.remove(list, k)
                found = true
            end 
        end
        if found == false then 
            table.insert(list, xName)
        end 
        ausbildung.list = list

        TriggerServerEvent('fmdt:ausbildungListUpdate', ausbildung.identifier, ausbildung)

        Citizen.Wait(400)

        cb()
    end)
end)

RegisterNUICallback('ausbildungListDelete', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    ESX.TriggerServerCallback('fmdt:listGetAllOfficers', function(xOfficers)
        local ausbildung = data.ausbildung


        local id
        local options = {}
        for k,v in pairs(Config.Trainings) do 
            if v.name == ausbildung.label then 
                id = v.id
            end 
        end 

        for k,v in pairs(ausbildung.list) do 
            table.insert(options, {
                type = 'checkbox',
                label = v,
                description = Config.Menus.training_delete.done,
            })
        end 

        local input = lib.inputDialog(Config.Menus.training_delete.header, options)


        if input ~= nil then 

            local addTraining = {}

            for k,v in pairs(input) do 
                if v == true then 
                    local name = (ausbildung.list)[k]
                    local identifier

                    for o,i in pairs(xOfficers) do 
                        if i.label == name then 
                            identifier = i.identifier
                        end 
                    end 

                    if identifier ~= nil then 
                        table.insert(addTraining, identifier)
                    end 

                end 
            end 

            TriggerServerEvent('fmdt:addTrainingToPlayers', id, addTraining)
            TriggerServerEvent('fmdt:listDeleteAusbildung', ausbildung.identifier)
        end

        Citizen.Wait(200)

        cb()
    end)
end)

RegisterNUICallback('ausbildungListEdit', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    ESX.TriggerServerCallback('fmdt:getSelfData', function(xName, xGrade, xJob)
        ESX.TriggerServerCallback('fmdt:listGetAllOfficers', function(xOfficers)
            local ausbildung = data.ausbildung

            local trainings = {}
            local default
            for k,v in pairs(Config.Trainings) do 
                if v.name == ausbildung.label then 
                    default = v.id
                end 
                table.insert(trainings, {value = v.id, label = v.name})
            end 

            local supervisor1 = (ausbildung.supervisor):match("(.*)\n")
            local supervisor2 = (ausbildung.supervisor):match("\n(.*)")
            
            local input = lib.inputDialog(Config.Menus.training_add.header, {
                {type = 'select', label = Config.Menus.training_add.label, options = trainings, required = true, default = default},
                {type = 'textarea', label = Config.Menus.training_add.description, min = 5, autosize = true, default = ausbildung.description},
                {type = 'date', label = Config.Menus.training_add.time, required = true, returnString = true, default = ausbildung.time},
                {type = 'input', label = Config.Menus.training_add.location, required = true, min = 3, max = 50, default = ausbildung.location},
                {type = 'slider', label = Config.Menus.training_add.limit, required = true, min = 1, max = 25, step = 1, default = ausbildung.limit},
                {type = 'multi-select', label = Config.Menus.training_add.officer, searchable = true, options = xOfficers, clearable = true, default = ausbildung.list},
                {type = 'select', label = Config.Menus.training_add.supervisor, searchable = true, options = xOfficers, clearable = true, default = supervisor2},
            })

            

            if input ~= nil then 
                ausbildung.label = input[1]
                ausbildung.description = input[2]
                if input[3] ~= 'Invalid Date' then 
                    ausbildung.time = input[3]
                end 
                ausbildung.location = input[4]
                ausbildung.limit = input[5]
                ausbildung.supervisor = supervisor1 .. '\n' .. input[7]
                ausbildung.list = input[6]

                TriggerServerEvent('fmdt:ausbildungListUpdate', ausbildung.identifier, ausbildung)
            end

            Citizen.Wait(400)

            cb()
        end)
    end)
end)

RegisterNUICallback('getSettings', function(data, cb)
    ESX.TriggerServerCallback('fmdt:listGetAllOfficers', function(xOfficer)
        ESX.TriggerServerCallback('fmdt:listGetGrades', function(xGrades)
            cb({officer = xOfficer, grades = xGrades})
        end)
    end)
end)

RegisterNUICallback('officerSettings', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local identifier = data.returnValue
    ESX.TriggerServerCallback('fmdt:settingsGetOfficer', function(xPermissions)
        local input = lib.inputDialog(Config.Permissions.header, {
            {type = 'checkbox', label = Config.Permissions.officers.allPermissions, checked = xPermissions},
        })
        if input ~= nil then 
            TriggerServerEvent('fmdt:setOfficerSettings', identifier, input[1])
        end 
    end, identifier)
end)

RegisterNUICallback('gradeSettings', function(data, cb)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    local job = data.returnValue.job
    local grade = data.returnValue.grade
    ESX.TriggerServerCallback('fmdt:settingsGetGrade', function(xPermissions)
        
        local options = {}
        for k,v in pairs(Config.Permissions.grades) do 
            table.insert(options, {
                type = 'checkbox', 
                label = v, 
                checked = xPermissions[k] or false,
            })
        end 

        local input = lib.inputDialog(Config.Permissions.header, options)
        if input ~= nil then 
            local output = {}

            local counter = 0
            for k,v in pairs(Config.Permissions.grades) do 
                counter = counter + 1
                output[k] = input[counter]
            end 

            TriggerServerEvent('fmdt:setGradeSettings', job, grade, output)
        end 

    end, job, grade)
end)

RegisterNUICallback('errorSound', function(data, cb)
    PlaySoundFrontend(-1, "Pin_Bad", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 1)
end)

RegisterNUICallback('panic', function(data, cb)
    exports[GetCurrentResourceName()]:panic()
end)

RegisterNUICallback('position', function(data, cb)
    exports[GetCurrentResourceName()]:position()
end)

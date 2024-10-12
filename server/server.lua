
locales = Config.Locales[Config.Language]

Citizen.CreateThread(function()
    while true do 
        GlobalState.time = os.date("%d/%m/%Y %H:%M")
        Citizen.Wait(10000)
    end 
end)

RegisterServerEvent('business:dispatch:sendmessage')
AddEventHandler('business:dispatch:sendmessage', function(source, message, sender, receiver, image, gps, rpname)
    print('Dispatch: ', source, message, sender, receiver, image, gps, rpname)
end)

RegisterServerEvent('fmdt:addDispatch')
AddEventHandler('fmdt:addDispatch', function(dispatches, silent)
    GlobalState.mdtCalls = dispatches
    if silent ~= true then 
        for k,v in pairs(ESX.GetPlayers()) do 
            local job = ESX.GetPlayerFromId(v).getJob().name
            for o,i in pairs(Config.Tablet.access) do 
                if i == job then 
                    TriggerClientEvent('fmdt:gotDispatch', v)
                end 
            end 
        end 
    end 
end)

Citizen.CreateThread(function()
    GlobalState.plateDelay = 0
    GlobalState.numberDelay = 0
    GlobalState.mdtCalls = {}

    while true do 

        if GlobalState.plateDelay > 0 then 
            GlobalState.plateDelay = GlobalState.plateDelay - 1
        end 
        if GlobalState.numberDelay > 0 then 
            GlobalState.numberDelay = GlobalState.numberDelay - 1
        end 

        Citizen.Wait(1000)
    end 
end)

--
--- open tablet callbacks
--

ESX.RegisterServerCallback('fmdt:getJob', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    cb(xPlayer.getJob().name, xPlayer.getJob().grade)
end)

ESX.RegisterServerCallback('fmdt:getSelfData', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
        ['@identifier']  = xPlayer.identifier,
    }, function(data)
        cb(xPlayer.getName(), xPlayer.getJob().grade_label, xPlayer.getJob().label, data[1].phone_number, data[1].callNumber)
    end)
end)

ESX.RegisterServerCallback('fmdt:getCops', function(source, cb)
    local cops = {}
    for k,v in pairs(ESX.GetPlayers()) do 
        for o,i in pairs(Config.Tablet.access) do 
            if i == ESX.GetPlayerFromId(v).getJob().name then 
                table.insert(cops, v)
            end 
        end 
    end 
    cb(cops)
end)

ESX.RegisterServerCallback('fmdt:getOtherInfos', function(source, cb)
    local user_found = 0
    local vehicle_found = 0
    local weapon_found = 0

    local warrents = {}
    local infos = {}
    local calls = {}

    MySQL.Async.fetchAll('SELECT * FROM users', {
    }, function(users)
        user_found = #users
        MySQL.Async.fetchAll('SELECT * FROM owned_vehicles', {
        }, function(owned_vehicles)
            vehicle_found = #owned_vehicles
            MySQL.Async.fetchAll('SELECT * FROM f_mdt_weapons', {
            }, function(f_mdt_weapons)
                weapon_found = #f_mdt_weapons
                MySQL.Async.fetchAll('SELECT * FROM f_mdt_infos', {
                }, function(f_mdt_infos)
                    MySQL.Async.fetchAll('SELECT * FROM f_mdt_calls', {
                    }, function(f_mdt_calls)
                        
                        for k,v in pairs(users) do 
                            local warrant = json.decode(v.warrant)
                            if warrant.state == true then 
                                table.insert(warrents, {
                                    name = (v.firstname .. ' ' .. v.lastname),
                                    reason = warrant.reason,
                                    info = warrant.infos,
                                })
                            end 
                        end 

                        for k,v in pairs(f_mdt_infos) do 
                            table.insert(infos, {
                                header = v.header,
                                text = v.text,
                                identifier = v.identifier,
                            })
                        end 

                        for k,v in pairs(f_mdt_calls) do 
                            table.insert(calls, {
                                reason = v.reason,
                                time = v.time,
                                location = v.location,
                                vector = v.vector,
                                code = v.code,
                                infos = v.infos,
                                identifier = v.identifier,
                            })
                        end 

                        cb(user_found, vehicle_found, weapon_found, warrents, infos, calls)
                    end)
                    
                end)
            end)
        end)
    end)
end)

--
--- search callbacks
--

ESX.RegisterServerCallback('fmdt:searchEinwohner', function(source, cb, search)
    local result = {}
    MySQL.Async.fetchAll('SELECT * FROM user_licenses', {
    }, function(user_licenses)
        MySQL.Async.fetchAll('SELECT * FROM users', {
        }, function(users)
            for k,v in pairs(users) do 
                if string.lower(v.firstname) == string.lower(search) or string.lower(v.lastname) == string.lower(search) or string.lower(v.firstname .. ' ' .. v.lastname) == string.lower(search) or string.lower(v.lastname .. ' ' .. v.firstname) == string.lower(search) then 
                    
                    local licenses = {}
                    for o,i in pairs(user_licenses) do 
                        if i.owner == v.identifier then 
                            for m,n in pairs(Config.Menus.edit_player_licenses.licenses) do 
                                if n.type == i.type then 
                                    table.insert(licenses, n.label)
                                end 
                            end 
                        end 
                    end 

                    
                    table.insert(result, {
                        identifier = v.identifier,
                        firstname = v.firstname,
                        lastname = v.lastname,
                        dob = v.dateofbirth,
                        sex = v.sex,
                        warrent = json.decode(v.warrant).state,
                        warrent_info = json.decode(v.warrant).infos,
                        warrent_reason = json.decode(v.warrant).reason,
                        email = json.decode(v.editinfo).email,
                        telefon = json.decode(v.editinfo).telefon,
                        job = json.decode(v.editinfo).job,
                        licenses = licenses,
                        notes = json.decode(v.notes),
                        openfiles = json.decode(v.opened_files),
                        closedfiles = json.decode(v.closed_files),
                        img = v.img,
                    })
                end 
            end 
            cb(result)
        end)
    end)
end)

ESX.RegisterServerCallback('fmdt:searchFahrzeug', function(source, cb, search, identifier)
    local result = {}

    MySQL.Async.fetchAll('SELECT * FROM users', {
    }, function(users)
        MySQL.Async.fetchAll('SELECT * FROM owned_vehicles', {
        }, function(vehicles)
            for k,v in pairs(vehicles) do 
                local owner = ''
                for o,i in pairs(users) do 
                    if v.owner == i.identifier then 
                        owner = (i.firstname .. ' ' .. i.lastname)
                    end 
                end 

                if string.lower(v.plate) == string.lower(search or '') or v.owner == identifier then 
                    table.insert(result, {
                        owner = owner,
                        plate = v.plate,
                        type = json.decode(v.vehicle).model,
                        color = json.decode(v.vehicle).color1,
                        registered = v.registered,
                        wanted = v.wanted,
                    })
                end 
            end 
            cb(result)
        end)
    end)
end)

ESX.RegisterServerCallback('fmdt:searchWaffe', function(source, cb, search, identifier)
    local result = {}
    MySQL.Async.fetchAll('SELECT * FROM users', {
    }, function(users)
        MySQL.Async.fetchAll('SELECT * FROM f_mdt_weapons', {
        }, function(weapons)
            for k,v in pairs(weapons) do 
                local owner = ''
                for o,i in pairs(users) do 
                    if v.owner == i.identifier then 
                        owner = (i.firstname .. ' ' .. i.lastname)
                    end 
                end 

                if v.serial == search or v.owner == identifier then 
                    table.insert(result, {
                        owner = owner,
                        type = v.type,
                        number = v.serial,
                        wanted = v.wanted,
                    })
                end 
            end 
            cb(result)
        end)
    end)
end)

--
--- item webhook
--

exports.ox_inventory:registerHook("createItem", function(payload)
    local metadata = payload.metadata
    if payload.item.weapon and metadata.registered then
        local xPlayer = ESX.GetPlayerFromId(payload.inventoryId)
        for k,v in pairs(exports.ox_inventory:Items()) do 
            if v.name == payload.item.name then 
                MySQL.insert("INSERT INTO `f_mdt_weapons` (`owner`, `type`, `serial`, `wanted`) VALUES (?, ?, ?, ?)", {xPlayer.identifier, v.label, metadata.serial, 0})
            end 
        end 
    end
    return metadata
end)

--
--- adding infos
--

RegisterServerEvent('fmdt:addInformation')
AddEventHandler('fmdt:addInformation', function(info)
    MySQL.insert('INSERT INTO f_mdt_infos (header, text) VALUES (?, ?)', {info[1], info[2]}, function()end)
end)

RegisterServerEvent('fmdt:editInformation')
AddEventHandler('fmdt:editInformation', function(info, identifier)
    MySQL.Async.execute('UPDATE f_mdt_infos SET header = @header WHERE identifier = @identifier', {
        ['@header']  = info[1],
        ['@identifier'] = identifier,
    })
    MySQL.Async.execute('UPDATE f_mdt_infos SET text = @text WHERE identifier = @identifier', {
        ['@text']  = info[2],
        ['@identifier'] = identifier,
    })
end)

RegisterServerEvent('fmdt:editPlayerWarrant')
AddEventHandler('fmdt:editPlayerWarrant', function(info, identifier)
    MySQL.Async.execute('UPDATE users SET warrant = @warrant WHERE identifier = @identifier', {
        ['@warrant']  = json.encode({state = info.warrent, reason = info.warrent_reason, infos = info.warrent_info}),
        ['@identifier'] = identifier,
    })
end)

RegisterServerEvent('fmdt:deleteInformation')
AddEventHandler('fmdt:deleteInformation', function(identifier)
    MySQL.Async. execute('DELETE FROM f_mdt_infos WHERE identifier = @identifier',{
        ['@identifier'] = identifier,
    },function()
    end)
end)

RegisterServerEvent('fmdt:editPlayerInfo')
AddEventHandler('fmdt:editPlayerInfo', function(result)
    MySQL.Async.execute('UPDATE users SET editinfo = @editinfo WHERE identifier = @identifier', {
        ['@editinfo']  = json.encode({job = result.job, telefon = result.telefon, email = result.email}),
        ['@identifier'] = result.identifier,
    })
end)

RegisterServerEvent('fmdt:editLicenses')
AddEventHandler('fmdt:editLicenses', function(result, identifier)
    MySQL.Async. execute('DELETE FROM user_licenses WHERE owner = @owner',{
        ['@owner'] = identifier,
    },function()
    end)
    for k,v in pairs(result) do 
        Citizen.Wait(75)
        MySQL.insert("INSERT INTO `user_licenses` (`owner`, `type`) VALUES (?, ?)", {identifier, v})
    end 
end)

RegisterServerEvent('fmdt:setNotes')
AddEventHandler('fmdt:setNotes', function(notes, identifier)
    MySQL.Async.execute('UPDATE users SET notes = @notes WHERE identifier = @identifier', {
        ['@notes']  = json.encode(notes),
        ['@identifier'] = identifier,
    })
end)

RegisterServerEvent('fmdt:setImg')
AddEventHandler('fmdt:setImg', function(identifier, url)
    MySQL.Async.execute('UPDATE users SET img = @img WHERE identifier = @identifier', {
        ['@img']  = url,
        ['@identifier'] = identifier,
    })
end)

RegisterServerEvent('fmdt:setActiveFiles')
AddEventHandler('fmdt:setActiveFiles', function(files, identifier)
    MySQL.Async.execute('UPDATE users SET opened_files = @opened_files WHERE identifier = @identifier', {
        ['@opened_files']  = json.encode(files),
        ['@identifier'] = identifier,
    })
end)

RegisterServerEvent('fmdt:setInactiveFiles')
AddEventHandler('fmdt:setInactiveFiles', function(files, identifier)
    MySQL.Async.execute('UPDATE users SET closed_files = @closed_files WHERE identifier = @identifier', {
        ['@closed_files']  = json.encode(files),
        ['@identifier'] = identifier,
    })
end)

RegisterServerEvent('fmdt:setPlateDelay')
AddEventHandler('fmdt:setPlateDelay', function()
    GlobalState.plateDelay = Config.Tracking.cooldown.plate
end)

ESX.RegisterServerCallback('fmdt:searchNumberLocation', function(source, cb, number)
    MySQL.Async.fetchAll('SELECT * FROM users WHERE ' .. Config.Tracking.number_column .. ' = @phone_number', {
        ['@phone_number']  = number,
    }, function(data)

        if json.encode(data) == '[]' then 
            cb(locales['tracking_no_number'][1])
        else 
            local identifier = data[1].identifier
            local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
            if xPlayer then 
                if Player(xPlayer.source).state.flightmode then 
                    cb(locales['tracking_flightmode'][1])
                else 
                    GlobalState.numberDelay = Config.Tracking.cooldown.number
                    local coords = xPlayer.getCoords(true)
                    cb(toTrackCoords(coords))
                end 
            else 
                cb(locales['tracking_no_number'][1])
            end 
        end 
    end)
end)

function toTrackCoords(table)
    local newX = 273.7 + table.x * 0.0594
    local newY = 463.7 - table.y * 0.0594
    return({x = newX, y = newY})
end 

RegisterServerEvent('fmdt:setOfficerStatus')
AddEventHandler('fmdt:setOfficerStatus', function(status, name)
    for k,v in pairs(ESX.GetPlayers()) do 
        if ESX.GetPlayerFromId(v).getName() == name then 
            Player(v).state.status = status
        end 
    end 
end)

ESX.RegisterServerCallback('fmdt:listGetOfficers', function(source, cb)


    MySQL.Async.fetchAll('SELECT * FROM users', {
    }, function(user_data)

        local officers = {}
        local jobs = ESX.GetJobs()

        for k,v in pairs(Config.Tablet.access) do 
            local jobData = jobs[v]
            if jobData ~= nil and jobData ~= {} then 
                local grades = jobData.grades

                for i = 0, 50 do
                    if json.encode(grades[tostring(i)]) ~= 'null' then 
                        local label = jobData.label .. ' - ' .. grades[tostring(i)].label
                        table.insert(officers, {
                            label = label,
                            job = jobData.name,
                            grade = grades[tostring(i)].grade,
                            officers = {},
                        })
                    end 
                end
            end 
        end 

        for k,v in pairs(user_data) do 

            local grade = v.job_grade
            local job = v.job
            local xPlayer = ESX.GetPlayerFromIdentifier(v.identifier)
            if json.encode(xPlayer) ~= 'null' then 
                job = xPlayer.getJob().name
                grade = xPlayer.getJob().grade
            end 

            for o,i in pairs(officers) do 
                if i.grade == grade and i.job == job then 
                    table.insert((officers[o].officers), {
                        identifier = v.identifier,
                        firstname = v.firstname,
                        lastname = v.lastname,
                        badgeNumber = v.badgeNumber  or 'n/A',
                        callNumber = v.callNumber  or 'n/A',
                        phoneNumber = v.phone_number or 'n/A',
                        dob = v.dateofbirth,
                    })
                end 
            end 
        end 

        cb(officers)
    end)

end)

RegisterServerEvent('fmdt:fire')
AddEventHandler('fmdt:fire', function(identifier)
    
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    if json.encode(xPlayer) ~= 'null' then 
        xPlayer.setJob('unemployed', 0)
    else 
        MySQL.Async.execute('UPDATE users SET job = @job WHERE identifier = @identifier', {
            ['@job']  = 'unemployed',
            ['@identifier'] = identifier,
        })
        MySQL.Async.execute('UPDATE users SET job_grade = @job_grade WHERE identifier = @identifier', {
            ['@job_grade']  = 0,
            ['@identifier'] = identifier,
        })
    end

end)

ESX.RegisterServerCallback('fmdt:officerGetGradeOptions', function(source, cb, identifier)
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
        ['@identifier']  = identifier,
    }, function(data)
        

        local job = data[1].job
        local grade = data[1].job_grade

        local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
        if json.encode(xPlayer) ~= 'null' then 
            job = xPlayer.getJob().name
            grade = xPlayer.getJob().grade
        end
        
        local xGrades = (ESX.GetJobs())[job].grades
        local grades = {}

        for i = 0, 50 do
            if json.encode(xGrades[tostring(i)]) ~= 'null' then 
                table.insert(grades, {
                    value = i,
                    label = xGrades[tostring(i)].label
                })
            end
        end

        
        cb(grade, grades)
    end)
end)

RegisterServerEvent('fmdt:updateOfficer')
AddEventHandler('fmdt:updateOfficer', function(identifier, newGrade, newCallNumber, newBadgeNumber)
    MySQL.Async.execute('UPDATE users SET callNumber = @callNumber WHERE identifier = @identifier', {
        ['@callNumber']  = tonumber(newCallNumber),
        ['@identifier'] = identifier,
    })
    MySQL.Async.execute('UPDATE users SET badgeNumber = @badgeNumber WHERE identifier = @identifier', {
        ['@badgeNumber']  = newBadgeNumber,
        ['@identifier'] = identifier,
    })
    
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    if json.encode(xPlayer) ~= 'null' then 
        xPlayer.setJob((xPlayer.getJob().name), tonumber(newGrade))
    else 
        MySQL.Async.execute('UPDATE users SET job_grade = @job_grade WHERE identifier = @identifier', {
            ['@job_grade']  = tonumber(newGrade),
            ['@identifier'] = identifier,
        })
    end
end)

ESX.RegisterServerCallback('fmdt:officerGetTrainings', function(source, cb, identifier)
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
        ['@identifier']  = identifier,
    }, function(data)
        cb(data[1].trainings)
    end)
end)

ESX.RegisterServerCallback('fmdt:officerGetInfo', function(source, cb, identifier)
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
        ['@identifier']  = identifier,
    }, function(data)
        cb(data[1].info)
    end)
end)

RegisterServerEvent('fmdt:updateOfficerInfo')
AddEventHandler('fmdt:updateOfficerInfo', function(identifier, newInfo)
    MySQL.Async.execute('UPDATE users SET info = @info WHERE identifier = @identifier', {
        ['@info']  = newInfo,
        ['@identifier'] = identifier,
    })
end)

ESX.RegisterServerCallback('fmdt:getOnlinePlayers', function(source, cb)
    local xPlayers = {}
    for k,v in pairs(ESX.GetPlayers()) do 
        local isPolice = false 
        for o,i in pairs(Config.Tablet.access) do 
            if i == ESX.GetPlayerFromId(v).getJob().name then 
                isPolice = true
            end 
        end 
        if not isPolice then 
            table.insert(xPlayers, {
                label =  ESX.GetPlayerFromId(v).getName(),
                value = v,
            })
        end 
    end
    cb(xPlayers)
end)

RegisterServerEvent('fmdt:hire')
AddEventHandler('fmdt:hire', function(id)
    local job = ESX.GetPlayerFromId(source).getJob().name
    ESX.GetPlayerFromId(id).setJob(job, 0)
end)

ESX.RegisterServerCallback('fmdt:listGetVehicles', function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM f_mdt_vehicles', {
    }, function(data)
        local vehList = {}

            for k,v in pairs(Config.Settings.vehicles) do 
                if v.status ~= 'n/A' then
                    table.insert(vehList, {
                        label = v.status,
                        vehicles = {},
                    })
                end
            end 

            for k,v in pairs(data) do 
                for o,i in pairs(vehList) do 
                    if i.label == v.categorie then 
                        table.insert((vehList[o].vehicles), {
                            label = v.label,
                            price = v.price,
                            grade = v.mingrade,
                            identifier = v.identifier,
                            categorie = v.categorie,
                        })
                    end
                end 
            end 

        cb(vehList)
    end)
end)

ESX.RegisterServerCallback('fmdt:listGetGrades', function(source, cb)
    local xGrades = ESX.GetJobs()[(ESX.GetPlayerFromId(source).getJob().name)].grades 
    local grades = {}

    for i = 0, 50 do
        if json.encode(xGrades[tostring(i)]) ~= 'null' then 
            table.insert(grades, {
                label = xGrades[tostring(i)].label,
                value = xGrades[tostring(i)].label,
                job = ESX.GetJobs()[(ESX.GetPlayerFromId(source).getJob().name)].label,
                identifier = {job = ESX.GetJobs()[(ESX.GetPlayerFromId(source).getJob().name)].name, grade = xGrades[tostring(i)].name},
            })
        end
    end

    cb(grades)
end)

RegisterServerEvent('fmdt:addVehicle')
AddEventHandler('fmdt:addVehicle', function(categorie, label, mingrade, price)
    MySQL.insert("INSERT INTO `f_mdt_vehicles` (`categorie`, `label`, `mingrade`, `price`) VALUES (?, ?, ?, ?)", {categorie, label, mingrade, price})
end)

RegisterServerEvent('fmdt:listDeleteVehicle')
AddEventHandler('fmdt:listDeleteVehicle', function(identifier)
    MySQL.Async. execute('DELETE FROM f_mdt_vehicles WHERE identifier = @identifier',{
        ['@identifier'] = identifier,
    },function()
    end)
end)

RegisterServerEvent('fmdt:editVehicle')
AddEventHandler('fmdt:editVehicle', function(identifier, categorie, label, mingrade, price)
    MySQL.Async.execute('UPDATE f_mdt_vehicles SET categorie = @categorie WHERE identifier = @identifier', {
        ['@categorie']  = categorie,
        ['@identifier'] = identifier,
    })
    MySQL.Async.execute('UPDATE f_mdt_vehicles SET label = @label WHERE identifier = @identifier', {
        ['@label']  = label,
        ['@identifier'] = identifier,
    })
    MySQL.Async.execute('UPDATE f_mdt_vehicles SET mingrade = @mingrade WHERE identifier = @identifier', {
        ['@mingrade']  = mingrade,
        ['@identifier'] = identifier,
    })
    MySQL.Async.execute('UPDATE f_mdt_vehicles SET price = @price WHERE identifier = @identifier', {
        ['@price']  = price,
        ['@identifier'] = identifier,
    })
end)

ESX.RegisterServerCallback('fmdt:listGetOutfits', function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM f_mdt_outfits', {
    }, function(data)
        cb(data)
    end)
end)

RegisterServerEvent('fmdt:addOutfit')
AddEventHandler('fmdt:addOutfit', function(label, mingrade, unit, url, outfit)
    if url == '' or url == nil then 
        url = Config.Lists.outfits.defaultURL
    end 
    MySQL.insert("INSERT INTO `f_mdt_outfits` (`label`, `mingrade`, `unit`, `url`, `outfit`) VALUES (?, ?, ?, ?, ?)", {label, mingrade, unit, url, json.encode(outfit)})
end)

RegisterServerEvent('fmdt:listDeleteOutfit')
AddEventHandler('fmdt:listDeleteOutfit', function(identifier)
    MySQL.Async. execute('DELETE FROM f_mdt_outfits WHERE identifier = @identifier',{
        ['@identifier'] = identifier,
    },function()
    end)
end)

RegisterServerEvent('fmdt:editOutfit')
AddEventHandler('fmdt:editOutfit', function(identifier, label, mingrade, unit, url)
    MySQL.Async.execute('UPDATE f_mdt_outfits SET label = @label WHERE identifier = @identifier', {
        ['@label']  = label,
        ['@identifier'] = identifier,
    })
    MySQL.Async.execute('UPDATE f_mdt_outfits SET mingrade = @mingrade WHERE identifier = @identifier', {
        ['@mingrade']  = mingrade,
        ['@identifier'] = identifier,
    })
    MySQL.Async.execute('UPDATE f_mdt_outfits SET unit = @unit WHERE identifier = @identifier', {
        ['@unit']  = unit,
        ['@identifier'] = identifier,
    })
    MySQL.Async.execute('UPDATE f_mdt_outfits SET url = @url WHERE identifier = @identifier', {
        ['@url']  = url,
        ['@identifier'] = identifier,
    })
end)

ESX.RegisterServerCallback('fmdt:listGetTodos', function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM f_mdt_todos', {
    }, function(data)
        cb(data)
    end)
end)

RegisterServerEvent('fmdt:addTodo')
AddEventHandler('fmdt:addTodo', function(label, description, officer)
    MySQL.insert("INSERT INTO `f_mdt_todos` (`label`, `description`, `officer`, `status`) VALUES (?, ?, ?, ?)", {label, description, officer, 0})
end)

RegisterServerEvent('fmdt:editTodo')
AddEventHandler('fmdt:editTodo', function(identifier, label, description)
    MySQL.Async.execute('UPDATE f_mdt_todos SET label = @label WHERE identifier = @identifier', {
        ['@label'] = label,
        ['@identifier'] = identifier,
    })
    MySQL.Async.execute('UPDATE f_mdt_todos SET description = @description WHERE identifier = @identifier', {
        ['@description'] = description,
        ['@identifier'] = identifier,
    })
end)

RegisterServerEvent('fmdt:listDeleteTodo')
AddEventHandler('fmdt:listDeleteTodo', function(identifier)
    MySQL.Async. execute('DELETE FROM f_mdt_todos WHERE identifier = @identifier',{
        ['@identifier'] = identifier,
    },function()
    end)
end)

RegisterServerEvent('fmdt:listCheckTodo')
AddEventHandler('fmdt:listCheckTodo', function(identifier, status)
    MySQL.Async.execute('UPDATE f_mdt_todos SET status = @status WHERE identifier = @identifier', {
        ['@status'] = status,
        ['@identifier'] = identifier,
    })
end)

ESX.RegisterServerCallback('fmdt:listGetAusbildungen', function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM f_mdt_trainings', {
    }, function(data)
        cb(data)
    end)
end)

ESX.RegisterServerCallback('fmdt:listGetAllOfficers', function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM users', {
    }, function(data)
        local returnValue = {}
        for k,v in pairs(data) do 
            for o, i in pairs(Config.Tablet.access) do 
                if i == v.job then 

                    local xGrades = ESX.GetJobs()[(v.job)].grades
                    local job = ESX.GetJobs()[(v.job)].label
                    local grade

                    for m = 0, 50 do 
                        if xGrades[(""..m)] ~= nil then 
                            if m == v.job_grade then 
                                grade = xGrades[(""..m)].label
                            end 
                        end 
                    end 

                    table.insert(returnValue, {value = (v.firstname..' '..v.lastname), label = (v.firstname..' '..v.lastname), identifier = v.identifier, grade = grade, job = job})
                end 
            end 
        end 
        cb(returnValue)
    end)
end)

RegisterServerEvent('fmdt:addAusbildung')
AddEventHandler('fmdt:addAusbildung', function(label, description, date, officers, creator)
    MySQL.insert("INSERT INTO `f_mdt_trainings` (`label`, `description`, `supervisor`, `time`, `list`) VALUES (?, ?, ?, ?, ?)", {label, description, creator, date, json.encode(officers)})
end)

RegisterServerEvent('fmdt:ausbildungListUpdate')
AddEventHandler('fmdt:ausbildungListUpdate', function(identifier, ausbildung)
    MySQL.Async.execute('UPDATE f_mdt_trainings SET label = @label WHERE identifier = @identifier', {
        ['@label'] = ausbildung.label,
        ['@identifier'] = identifier,
    })
    MySQL.Async.execute('UPDATE f_mdt_trainings SET description = @description WHERE identifier = @identifier', {
        ['@description'] = ausbildung.description,
        ['@identifier'] = identifier,
    })
    MySQL.Async.execute('UPDATE f_mdt_trainings SET time = @time WHERE identifier = @identifier', {
        ['@time'] = ausbildung.time,
        ['@identifier'] = identifier,
    })
    MySQL.Async.execute('UPDATE f_mdt_trainings SET list = @list WHERE identifier = @identifier', {
        ['@list'] = json.encode(ausbildung.list),
        ['@identifier'] = identifier,
    })
end)

RegisterServerEvent('fmdt:listDeleteAusbildung')
AddEventHandler('fmdt:listDeleteAusbildung', function(identifier)
    MySQL.Async. execute('DELETE FROM f_mdt_trainings WHERE identifier = @identifier',{
        ['@identifier'] = identifier,
    },function()
    end)
end)

ESX.RegisterServerCallback('fmdt:settingsGetOfficer', function(source, cb, identifier)
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
        ['@identifier'] = identifier,
    }, function(data)
        cb(json.decode(data[1].permission))
    end)
end)

ESX.RegisterServerCallback('fmdt:settingsGetGrade', function(source, cb, job, grade)
    MySQL.Async.fetchAll('SELECT * FROM job_grades WHERE job_name = @job_name AND name = @name', {
        ['@job_name'] = job,
        ['@name'] = grade,
    }, function(data)
        cb(json.decode(data[1].permissions))
    end)
end)

RegisterServerEvent('fmdt:setOfficerSettings')
AddEventHandler('fmdt:setOfficerSettings', function(identifier, permission)
    if permission == true then 
        MySQL.Async.execute('UPDATE users SET permission = @permission WHERE identifier = @identifier', {
            ['@permission'] = 1,
            ['@identifier'] = identifier,
        })
    else 
        MySQL.Async.execute('UPDATE users SET permission = @permission WHERE identifier = @identifier', {
            ['@permission'] = 0,
            ['@identifier'] = identifier,
        })
    end 
    TriggerClientEvent('fmdt:updatePermissions', -1)
end)

RegisterServerEvent('fmdt:setGradeSettings')
AddEventHandler('fmdt:setGradeSettings', function(job, grade, permission)
    MySQL.Async.execute('UPDATE job_grades SET permissions = @permissions WHERE job_name = @job_name AND name = @name', {
        ['@permissions'] = json.encode(permission),
        ['@job_name'] = job,
        ['@name'] = grade,
    })
    TriggerClientEvent('fmdt:updatePermissions', -1)
end)

ESX.RegisterServerCallback('fmdt:getPermissions', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local job, grade, identifier = xPlayer.getJob().name, xPlayer.getJob().grade_name, xPlayer.identifier

    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
        ['@identifier'] = identifier,
    }, function(data)
        local userPermissions = json.decode(data[1].permission)
        MySQL.Async.fetchAll('SELECT * FROM job_grades WHERE job_name = @job_name AND name = @name', {
            ['@job_name'] = job,
            ['@name'] = grade,
        }, function(gdata)
            local gradePermissions = json.decode(gdata[1].permissions)
            if userPermissions == 1 then 
                for k,v in pairs(gradePermissions) do 
                    gradePermissions[k] = true
                end 
            end

            cb(gradePermissions)
        end)
    end)

end)

RegisterServerEvent('fmdt:button')
AddEventHandler('fmdt:button', function(position, panic)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('fmdt:buttonClient', -1, position, panic, xPlayer.getName(), source)
end)
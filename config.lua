Config = {}

Config.ApiKey = ''

Config.Tablet = {
    itemrequired = false,
    item = 'police_tablet',
    command = 'mdt',
    access = {'police'},
}

Config.Keybinds = {
    tablet = 56, -- F9
    panic = 57, -- F10
    position = 344, -- F11
}

Config.Disptach = {
    createMenu = true,
    command = 'dispatch',
    itemrequired = true, 
    item = 'phone',
    defaultStatus = 'Code-1',
}

Config.Tracking = {
    enabled = {
        number = true,
        plate = true,
    },
    cooldown = {
        number = 30,
        plate = 30,
    },
    number_column = 'phone_number',
}

Config.Permissions = {
    header = 'Berechtigungen Erteilen',
    officers = {
        allPermissions = '* Berechtigungen',
    },
    grades = {
        openDashboard = 'Dashboard-Menü öffnen', 
        openControlCenter = 'Leitstellen-Menü öffnen', 
        openCitizen = 'Einwohner-Suche öffnen', 
        openVehicles = 'Fahrzeug-Suche öffnen', 
        openWeapons = 'Waffen-Suche öffnen', 
        openTracking = 'Tracking-Menü öffnen', 
        openDispatches = 'Dispatches-Menü öffnen', 
        openLists = 'Listen-Menü öffnen', 
        openDocuments = 'Dokumenten-Mneü öffnen',
        openCalculator = 'Rechner-Menü öffnen', 
        openSettings = 'Einstellungen-Menü öffnen', 

        createInformation = 'Neue Information erstellen', 
        createListEmployee = 'Neuen Mitarbeiter erstellen', 
        createListVehicle = 'Neues Fahrzeug erstellen', 
        createListOutfit = 'Neues Outfit erstellen', 
        createListTraining = 'Neue Ausbildung erstellen', 
        createListTodo = 'Neues Todo erstellen', 

        editListEmployee = 'Mitarbeiter verwalten', 
        editListVehicle= 'Fahrzeug verwalten', 
        editListOutfit = 'Outfit verwalten', 
        editListTraining = 'Ausbildung verwalten', 
        editListTodo = 'Todo verwalten', 
        checkListTraining = 'Ausbildung ankreuzen', 
        checkListTodo = 'Todo ankreuzen', 

        citizenOpenVehicles = 'Einwohner Fahrzeuge suchen', 
        citizenOpenWeapons = 'Einwohner Waffen suchen', 
        citizenEditPersonalData = 'Personaldaten bearbeiten', 
        citizenEditWanted = 'Fahndungsstatus bearbeiten', 
        citizenEditLicense = 'Lizenzen bearbeiten', 
        citizenCreateNote = 'Neue Notiz erstellen', 
        citizenCreateFile = 'Neue Akte erstellen', 
        citizenEditNote = 'Notiz bearbeiten', 
        citizenEditFile = 'Akte bearbeiten', 

        trackNumber = 'Telefonnummer tracken', 
        trackPlate = 'Kennzeichen Tracken',

        dispatchEditOfficer = 'Officer Dispatch zuweisen',
        dispatchEditDispatch = 'Dispatch Status bearbeiten',

        editPermissions = 'Berechtigungen Verwalten',
    },
}

Config.Lists = {
    employees = {
        showEmptyGrades = true,
    },
    vehicles = {
        showEmptyCategories = true,
    },
    outfits = {
        defaultURL = '',
    },
    law = {
        fine = {
            prefix = 'Strafe: ',
            suffix = '$',
        },
        c_service = {
            prefix = 'Sozialarbeit: ',
            suffix = 'Hr',
        },
        prison = {
            prefix = 'Gefängnis: ',
            suffix = 'M',
        },
    }
}

Config.Units = {
    {
        id = 'patrol',
        name = 'Patrol Unit',
    },
    {
        id = 'traffic',
        name = 'Traffic Unit',
    },
    {
        id = 'asd',
        name = 'Air Support Unit',
    },
    {
        id = 'detective',
        name = 'Detective Unit',
    },
    {
        id = 'swat',
        name = 'SWAT Unit',
    },
}

Config.Trainings = {
    {
        id = 'ga1',
        name = 'Grundausbildung 1',
        text = 'Theoretischer Teil der Grundausbildung.',
        mingrade = 0,
    },
    {
        id = 'ga2',
        name = 'Grundausbildung 2',
        text = 'Praktischer Teil der Grundausbildung',
        mingrade = 0,
    },
    {
        id = 'ewf',
        name = 'Erweiterte Funk Ausbildung',
        text = 'Zum erlangen von erweiterten Kenntnisse des Funkens. Notwendig für weitere Devisions.',
        mingrade = 0,
    },
    {
        id = 'ewa',
        name = 'Erweiterte Waffenausbildung',
        text = 'Ermöglicht die Verwenung einer Langwaffe bei Freigabe eines Supervisors.',
        mingrade = 1,
    },
    {
        id = 'lfa',
        name = 'Erweiterte Fahrausbildung',
        text = 'Erwierte Taktiken im Zusammenhang mit Fahrzeugen.',
        mingrade = 1,
    },
    {
        id = 'mta',
        name = 'Motorrad',
        text = 'Ermöglicht das Fahren eines Polizei Motorrads in der Traffic Unit.',
        mingrade = 0,
    },
    {
        id = 'boot',
        name = 'Boot',
        text = 'Ermöglicht das Bedienen eines Polizei Bootes.',
        mingrade = 0,
    },
}

Config.Menus = {
    create_info = {
        header = 'Neue Information Erstellen',
        title = 'Information Titel',
        text = 'Information Text',
    },
    delete_info = {
        header = 'Information Löschen',
        text = 'Bist du dir sicher das du diese Information löschen willst?',
        confirm = 'Löschen',
        cancel = 'Abbrechen',
    },
    edit_player_info = {
        header = 'Personaldaten Bearbeiten',
        number = 'Telefonnummer',
        email = 'E-Mail Adresse', 
        job = 'Arbeit',
    },
    edit_player_warrant = {
        header = 'Fahndung Bearbeiten', 
        state = 'Fahndungsstatus',
        reason = 'Fahndungsgrund',
        info = 'Fahndungsinfos',
    },
    edit_player_licenses = {
        header = 'Lizenzen Bearbeiten',
        licenses = {
            {
                type = 'dmv',
                label = 'Theoriekurs',
            },
            {
                type = 'drive',
                label = 'Typ B',
            },
            {
                type = 'drive_bike',
                label = 'Typ A',
            },
            {
                type = 'drive_truck',
                label = 'Typ C',
            },
            {
                type = 'weapon',
                label = 'Waffenlizenz',
            },
        },
    },
    add_player_note = {
        header = 'Notiz Hinzufügen', 
        text = 'Notiz Information',
    },
    delete_player_note = {
        header = 'Notiz Löschen',
        text = 'Bist du dir sicher das du diese Notiz löschen willst?',
        confirm = 'Löschen',
        cancel = 'Abbrechen',
    },
    edit_img = {
        header = 'Bild Bearbeiten',
        text = 'Bist du sicher dass du dieses Bild löschen und ein neues aufnehmen willst?',
        confirm = 'Löschen',
        cancel = 'Abbrechen',
    },
    add_player_file = {
        header = 'Akte Hinzufügen', 
        law = 'Gesetz Paragraph',
        info = 'Akten Information',
    },
    delete_player_file = {
        header = 'Akte Löschen',
        text = 'Bist du dir sicher das du diese Akte löschen willst?',
        confirm = 'Löschen',
        cancel = 'Abbrechen',
    },
    add_disptach = {
        header = 'Dispatch Erstellen', 
        reason = 'Dispatch Grund',
        info = 'Weitere Informationen',
    },
    edit_dispatch = {
        header = 'Dispatch Status Bearbeiten',
        code = 'Dispatch Status', 
    },
    delete_dispatch = {
        header = 'Dispatch Löschen', 
        text = 'Bist du dir sicher das du diesen Dispatch löschen willst?',
        confirm = 'Löschen',
        cancel = 'Abbrechen',
    },
    edit_dispatch_officers = {
        header = 'Beamte Einteilen',
        officer = 'Beamte', 
    },
    edit_officer_status = {
        header = 'Status Ändern',
        status = 'Status', 
    },
    edit_officer_dispatch = {
        header = 'Dispatcheinteilung Ändern',
        dispatch = 'Dispatches', 
    },
    officer_fire = {
        header = 'Beamten Feuern', 
        text = 'Bist du dir sicher das du %s feuern willst?',
        confirm = 'Feuern',
        cancel = 'Abbrechen',
    },
    officer_edit = {
        header = 'Beamten Verwalten',
        rank = 'Rang', 
        callNumber = 'Call Number', 
        badgeNumber = 'Badge Nummer', 
    },
    officer_list = {
        header = 'Aubildungen:'
    },
    officer_info = {
        header = 'Beamten Informationen',
        info = 'Notizen',
    },
    officer_add = {
        header = 'Beamten Einstellen',
        person = 'Personen',
    },
    vehicle_add = {
        header = 'Fahrzeug Hinzufügen',
        categorie = 'Kategorie',
        label = 'Name',
        rank = 'Min. Rang',
        price = 'Preis',
    },
    vehicle_delete = {
        header = 'Fahrzeug Löschen', 
        text = 'Bist du dir sicher das du das Fahrzeug %s löschen möchtest?',
        confirm = 'Löschen',
        cancel = 'Abbrechen',
    },
    vehicle_edit = {
        header = 'Fahrzeug Bearbeiten',
        categorie = 'Kategorie',
        label = 'Name',
        rank = 'Min. Rang',
        price = 'Preis',
    },
    outfit_add = {
        header = 'Outfit Hinzufügen',
        label = 'Name',
        rank = 'Min. Rang',
        unit = 'Unit',
        url = 'Bild Link',
        parts = {
            tshirt = 'T-Shirt',
            torso = 'Torso',
            decals = 'Decals',
            arms = 'Arme',
            pants = 'Hose',
            shoes = 'Schuhe',
            mask = 'Maske',
            bproof = 'Weste',
            chain = 'Kette',
            helmet = 'Helm',
            glasses = 'Brille',
            watches = 'Uhr',
            bags = 'Rucksack',
            ears = 'Ohren',
        },
    },
    outfit_info = {
        header = 'Outfit Daten',
    },
    outfit_delete = {
        header = 'Outfit Löschen', 
        text = 'Bist du dir sicher das du das Outfit %s löschen möchtest?',
        confirm = 'Löschen',
        cancel = 'Abbrechen',
    },
    todo_add = {
        header = 'Todo Erstellen',
        label = 'Titel',
        description = 'Beschrebung',
    },
    todo_edit = {
        header = 'Todo Bearbeiten',
        label = 'Titel',
        description = 'Beschrebung',
    },
    todo_delete = {
        header = 'Todo Löschen', 
        text = 'Bist du dir sicher das du das Todo %s löschen möchtest?',
        confirm = 'Löschen',
        cancel = 'Abbrechen',
    },
    training_add = {
        header = 'Ausbildung Erstellen',
        label = 'Ausbildung',
        description = 'Beschrebung',
        time = 'Zeit',
        location = 'Ort',
        limit = 'Limit',
        officer = 'Teilnehmer',
        supervisor = '2ter Ausbilder',
    },
    training_edit = {
        header = 'Ausbildung Bearbeiten',
        label = 'Titel',
        description = 'Beschrebung',
        time = 'Zeitpunkt',
        officer = 'Teilnehmer',
    },
    training_delete = {
        header = 'Ausbildung Beenden', 
        done = 'Hat dieser Beamte die Ausbildung bestanden?',
    },
    calc_law = {
        header = 'Rechner',
        close = 'Schließen',
    },
}

Config.CanBeTracked = function()
    return true 
end 

Config.Calculation = function(law)
    local options = {}

    for k,v in pairs(law) do 
        local paragraphs = {}

        for o,i in pairs(v.paragraphs) do 
            table.insert(paragraphs, {
                label = i.label,
                value = json.encode({
                    fine = i.fine,
                    prison = i.prison,
                    c_service = i.c_service,
                }),
            })
        end 

        table.insert(options, {
            type = 'multi-select',
            label = v.categorie,
            searchable = true,
            options = paragraphs,
        })
    end 

    local lawInput = lib.inputDialog(Config.Menus.calc_law.header, options)
    if lawInput ~= nil then 

        local fine = 0
        local prison = 0
        local c_service = 0

        for i = 1, #lawInput do
            for k,v in pairs(lawInput[i]) do 
                fine = fine + (json.decode(v).fine or 0)
                prison = prison + (json.decode(v).prison or 0)
                c_service = c_service + (json.decode(v).c_service or 0)
            end 
        end 

        local result = lib.alertDialog({
            header = Config.Menus.calc_law.header,
            content = Config.Lists.law.fine.prefix .. fine .. Config.Lists.law.fine.suffix .. '   \n   ' .. Config.Lists.law.prison.prefix .. prison .. Config.Lists.law.prison.suffix .. '   \n   ' .. Config.Lists.law.c_service.prefix .. c_service .. Config.Lists.law.c_service.suffix ,
            centered = true,
            cancel = false,
            size = 'sm',
            labels = {
                confirm = Config.Menus.calc_law.close,
            }
        })

    end 
end 

Config.Settings = {
    status = {
        {status = 'n/A', color = 'grey'},
        {status = '10-02', color = 'blue', meaning = 'Funkspruch empfangen'},
        {status = '10-03', color = 'yellow' , meaning = 'Bestätige'},
        {status = '10-04', color = 'purple' , meaning = 'Verstanden'},
        {status = '10-06', color = 'red' , meaning = 'Beschäftigt'},
        {status = '10-09', color = 'orange' , meaning = 'Wiederholen'},
        {status = '10-97', color = 'red' , meaning = 'Nicht Einsatzbereit'},
        {status = '10-08', color = 'green' , meaning = 'Einsatzbereit'},
        {status = '10-10', color = 'yellow' , meaning = 'Benötige Verstärkung'},
        {status = '10-20', color = 'orange' , meaning = 'Aktueller Standort'},
        {status = '10-21', color = 'red' , meaning = 'Personenkontrolle'},
        {status = '10-22', color = 'red' , meaning = 'Fahrzeugkontrolle'},
        {status = '10-23', color = 'zellow' , meaning = 'Einsatzort angekommen'},
        {status = '10-25', color = 'red' , meaning = 'Raub / Diebstahl'},
        {status = '10-30', color = 'orange' , meaning = 'Täterbeschreibung'},
        {status = '10-32', color = 'yellow' , meaning = 'Täter bewaffnet'},
        {status = '10-35', color = 'orange' , meaning = 'Personenabfrage'},
        {status = '10-36', color = 'orange' , meaning = 'Halterabfrage'},
        {status = '10-40', color = 'purple' , meaning = 'Anfahrt zur Verstärkung'},
        {status = '10-50', color = 'red' , meaning = 'Verunfallt'},
        {status = '10-60', color = 'purple' , meaning = 'Verfolgungsjagd'},
        {status = '10-65', color = 'purple' , meaning = 'Personenverfolgung'},
        {status = '10-90', color = 'red' , meaning = 'Officer in Gefahr'},
        {status = '10-99', color = 'red' , meaning = 'Schusswechsel'},
    },
    locations = {
        {status = 'n/A', color = 'grey'},
        {status = 'Police Department', color = 'green'},
        {status = 'Highway Patrol', color = 'green'},
        {status = 'Sheriff Department', color = 'green'},
        {status = 'Los Angeles', color = 'yellow'},
        {status = 'Paleto Bay', color = 'yellow'},
        {status = 'Sandy Shores', color = 'yellow'},
        {status = 'East Highway', color = 'orange'},
        {status = 'West Highway', color = 'orange'},
        {status = 'City Highway', color = 'orange'},
        {status = 'Fleeca Bank', color = 'red'},
        {status = 'National Bank', color = 'red'},
        {status = 'Juwelier', color = 'red'},
        {status = 'Event', color = 'red'},
        {status = 'Mechaniker', color = 'purple'},
        {status = 'Krankenhaus', color = 'purple'},
        {status = 'Supreme Court', color = 'purple'},
        {status = 'Marshal Service', color = 'purple'},
        {status = 'Frei [Sondereinheit]', color = 'blue'},
        {status = 'Frei [Supervisor]', color = 'blue'},
        {status = 'Highway [Allgemein]', color = 'blue'},
        {status = 'Luftraum', color = 'blue'},
        {status = 'Gewässer', color = 'blue'},
    },
    vehicles = {
        {status = 'n/A', color = 'grey'},
        {status = 'Straßenwagen [M]', color = 'green', type = 'street'},
        {status = 'Offroad [M]', color = 'green' , type = 'offroad'},
        {status = 'Straßenwagen [UM]', color = 'orange' , type = 'street'},
        {status = 'Offroad [UM]', color = 'orange', type = 'offroad'},
        {status = 'Highspeed [M]', color = 'yellow', type = 'highspeed'},
        {status = 'Highspeed [UM]', color = 'yellow', type = 'highspeed'},
        {status = 'Motorrad [Straße]', color = 'purple', type = 'street'},
        {status = 'Motorrad [Offroad]', color = 'purple', type = 'offroad'},
        {status = 'Helikopter', color = 'red', type = 'air'},
        {status = 'Flugzeug', color = 'red', type = 'air'},
        {status = 'Boot', color = 'red'},
        {status = 'Transport', color = 'grey'},
    },
    callNames = {
        {status = 'n/A', color = 'grey'},
        {status = 'Lincoln', color = 'green'},
        {status = 'Adam', color = 'yellow'},
        {status = 'Airship', color = 'blue'},
        {status = 'David', color = 'orange'},
        {status = 'Mary', color = 'yellow'},
        {status = 'Hotel', color = 'red'},
        {status = 'Ocean', color = 'blue'},
        {status = 'William', color = 'blue'},
        {status = 'Henry', color = 'blue'},
        {status = 'Sam', color = 'blue'},
        {status = 'King', color = 'red'},
        {status = 'Tom', color = 'red'},
        {status = 'Victor', color = 'red'},
    },
    callStatus = {
        {status = 'Code-1', color = 'green', meaning = 'Dienstbereit / Kein Einsatz'},
        {status = 'Code-1-H', color = 'green', meaning = 'Dienstbereit / Straßenregeln befreit'},
        {status = 'Code-2', color = 'green', meaning = 'Routine Einsatz'},
        {status = 'Code-3', color = 'red', meaning = 'Notfall / Blaulicht & Sirene'},
        {status = 'Code-4', color = 'purple', meaning = 'Einsatz unter Kontrolle'},
        {status = 'Code-4-ADAM', color = 'purple', meaning = 'Einsatz unter Kontrolle / Keine weiteren Einsatzmittel benötigt'},
        {status = 'Code-5', color = 'purple', meaning = 'Risiko Stopp (10-22)'},
        {status = 'Code-6', color = 'red', meaning = 'Fahrzeug verlassen'},
    },
    frequency = {
        {status = 'n/A', color = 'grey'},
        {status = '1.0', color = 'green', meaning = 'Dienstfunk'},
        {status = '1.1', color = 'orange', meaning = 'Private Gespräche (1)'},
        {status = '1.2', color = 'orange', meaning = 'Private Gespräche (2)'},
        {status = '1.3', color = 'orange', meaning = 'Private Gespräche (3)'},
        {status = '1.6', color = 'grey', meaning = 'Ausbildungsfunk (1)'},
        {status = '1.7', color = 'grey', meaning = 'Ausbildungsfunk (2)'},
        {status = '1.8', color = 'grey', meaning = 'Ausbildungsfunk (3)'},
        {status = '3.0', color = 'purple', meaning = 'Geteilter Funk (AMR)'},
        {status = '4.0', color = 'purple', meaning = 'Geteilter Funk (LAFD)'},
    },
}

Config.Clasifications = {
    street = {
        'Straßenwagen [M]',
        'Straßenwagen [UM]',
    },
    offroad = {
        'Offroad [M]',
        'Offroad [UM]',
    },
    highspeed = {
        'Highspeed [M]',
        'Highspeed [UM]',
    },
    air = {
        'Helikopter',
        'Flugzeug',
    },

    city = {
        'Police Department',
        'Los Angeles',
    },
    county = {
        'Sheriff Department',
        'Paleto Bay',
        'Sandy Shores',
    },
    highway = {
        'Highway Patrol',
        'East Highway',
        'West Highway',
        'City Highway',
    },
    special = {
        'Frei [Sondereinheit]',
        'Frei [Supervisor]',
        'Highway [Allgemein]',
        'Luftraum',
        'Gewässer',
    },

    patrol = {
        'Lincoln',
        'Adam',
        'Mary',
        'Hotel',
    },
    king = {
        'King',
        'Victor',
        'Tom',
    },
    swat = {
        'William',
        'Henry',
    },
}

Config.Language = 'DE'
Config.Locales = {
    ['DE'] = {
        ['taking_image'] = {'Bild schießen', nil},
        ['tracking_not_possible'] = {'Diese Tracking Funktion wurden für dein MDT nicht aktiviert!', nil},
        ['tracking_cooldown'] = {'Diese Tracking Funktion befindet sich noch im Cooldown! Warte noch %s Sekunden um wieder eine Person tracken zu können.', nil},

        ['tracking_no_vehicle_found'] = {'Es konnte kein Fahrzeug mit diesem Kennzeichzen gefunden werden!', nil},
        ['tracking_flightmode'] = {'Es konnte kein Handy getrackt werden da der Flugmodus aktiviert ist.', nil},
        ['tracking_no_number'] = {'Es konnte kein Handy mit dieser Nummber getrackt werden!', nil},

        ['no_phone'] = {'Dafür hast du kein Handy dabei!', 'error'},
        ['dispatch'] = {'Es ist soeben ein neuer Dispatch eingegangen!', 'info'},

        ['pressed_panic'] = {'Du hast den Panic Button ausgelöst!', 'info'},
        ['pressed_position'] = {'Du hast deine Position übertragen.', 'info'},
        ['panic'] = {'Officer %s hat seinen Panic Button ausgelöst!', 'info'},
        ['position'] = {'Officer %s hat seine   \n   Position übertragen:   \n   [E] - Markierung Annehmen   \n   [G] - Markierung Ablehnen', 'info'},
        ['marked'] = {'Markierung wurde am Navi gesetzt.', 'success'},
        ['not_marked'] = {'Markierung abgelehnt.', 'error'},
    },
    ['EN'] = {
    },
}

Config.VehicleColors = {
    ['0'] = "Metallic Black",
    ['1'] = "Metallic Graphite Black",
    ['2'] = "Metallic Black Steal",
    ['3'] = "Metallic Dark Silver",
    ['4'] = "Metallic Silver",
    ['5'] = "Metallic Blue Silver",
    ['6'] = "Metallic Steel Gray",
    ['7'] = "Metallic Shadow Silver",
    ['8'] = "Metallic Stone Silver",
    ['9'] = "Metallic Midnight Silver",
    ['10'] = "Metallic Gun Metal",
    ['11'] = "Metallic Anthracite Grey",
    ['12'] = "Matte Black",
    ['13'] = "Matte Gray",
    ['14'] = "Matte Light Grey",
    ['15'] = "Util Black",
    ['16'] = "Util Black Poly",
    ['17'] = "Util Dark silver",
    ['18'] = "Util Silver",
    ['19'] = "Util Gun Metal",
    ['20'] = "Util Shadow Silver",
    ['21'] = "Worn Black",
    ['22'] = "Worn Graphite",
    ['23'] = "Worn Silver Grey",
    ['24'] = "Worn Silver",
    ['25'] = "Worn Blue Silver",
    ['26'] = "Worn Shadow Silver",
    ['27'] = "Metallic Red",
    ['28'] = "Metallic Torino Red",
    ['29'] = "Metallic Formula Red",
    ['30'] = "Metallic Blaze Red",
    ['31'] = "Metallic Graceful Red",
    ['32'] = "Metallic Garnet Red",
    ['33'] = "Metallic Desert Red",
    ['34'] = "Metallic Cabernet Red",
    ['35'] = "Metallic Candy Red",
    ['36'] = "Metallic Sunrise Orange",
    ['37'] = "Metallic Classic Gold",
    ['38'] = "Metallic Orange",
    ['39'] = "Matte Red",
    ['40'] = "Matte Dark Red",
    ['41'] = "Matte Orange",
    ['42'] = "Matte Yellow",
    ['43'] = "Util Red",
    ['44'] = "Util Bright Red",
    ['45'] = "Util Garnet Red",
    ['46'] = "Worn Red",
    ['47'] = "Worn Golden Red",
    ['48'] = "Worn Dark Red",
    ['49'] = "Metallic Dark Green",
    ['50'] = "Metallic Racing Green",
    ['51'] = "Metallic Sea Green",
    ['52'] = "Metallic Olive Green",
    ['53'] = "Metallic Green",
    ['54'] = "Metallic Gasoline Blue Green",
    ['55'] = "Matte Lime Green",
    ['56'] = "Util Dark Green",
    ['57'] = "Util Green",
    ['58'] = "Worn Dark Green",
    ['59'] = "Worn Green",
    ['60'] = "Worn Sea Wash",
    ['61'] = "Metallic Midnight Blue",
    ['62'] = "Metallic Dark Blue",
    ['63'] = "Metallic Saxony Blue",
    ['64'] = "Metallic Blue",
    ['65'] = "Metallic Mariner Blue",
    ['66'] = "Metallic Harbor Blue",
    ['67'] = "Metallic Diamond Blue",
    ['68'] = "Metallic Surf Blue",
    ['69'] = "Metallic Nautical Blue",
    ['70'] = "Metallic Bright Blue",
    ['71'] = "Metallic Purple Blue",
    ['72'] = "Metallic Spinnaker Blue",
    ['73'] = "Metallic Ultra Blue",
    ['74'] = "Metallic Bright Blue",
    ['75'] = "Util Dark Blue",
    ['76'] = "Util Midnight Blue",
    ['77'] = "Util Blue",
    ['78'] = "Util Sea Foam Blue",
    ['79'] = "Uil Lightning blue",
    ['80'] = "Util Maui Blue Poly",
    ['81'] = "Util Bright Blue",
    ['82'] = "Matte Dark Blue",
    ['83'] = "Matte Blue",
    ['84'] = "Matte Midnight Blue",
    ['85'] = "Worn Dark blue",
    ['86'] = "Worn Blue",
    ['87'] = "Worn Light blue",
    ['88'] = "Metallic Taxi Yellow",
    ['89'] = "Metallic Race Yellow",
    ['90'] = "Metallic Bronze",
    ['91'] = "Metallic Yellow Bird",
    ['92'] = "Metallic Lime",
    ['93'] = "Metallic Champagne",
    ['94'] = "Metallic Pueblo Beige",
    ['95'] = "Metallic Dark Ivory",
    ['96'] = "Metallic Choco Brown",
    ['97'] = "Metallic Golden Brown",
    ['98'] = "Metallic Light Brown",
    ['99'] = "Metallic Straw Beige",
    ['100'] = "Metallic Moss Brown",
    ['101'] = "Metallic Biston Brown",
    ['102'] = "Metallic Beechwood",
    ['103'] = "Metallic Dark Beechwood",
    ['104'] = "Metallic Choco Orange",
    ['105'] = "Metallic Beach Sand",
    ['106'] = "Metallic Sun Bleeched Sand",
    ['107'] = "Metallic Cream",
    ['108'] = "Util Brown",
    ['109'] = "Util Medium Brown",
    ['110'] = "Util Light Brown",
    ['111'] = "Metallic White",
    ['112'] = "Metallic Frost White",
    ['113'] = "Worn Honey Beige",
    ['114'] = "Worn Brown",
    ['115'] = "Worn Dark Brown",
    ['116'] = "Worn straw beige",
    ['117'] = "Brushed Steel",
    ['118'] = "Brushed Black steel",
    ['119'] = "Brushed Aluminium",
    ['120'] = "Chrome",
    ['121'] = "Worn Off White",
    ['122'] = "Util Off White",
    ['123'] = "Worn Orange",
    ['124'] = "Worn Light Orange",
    ['125'] = "Metallic Securicor Green",
    ['126'] = "Worn Taxi Yellow",
    ['127'] = "police car blue",
    ['128'] = "Matte Green",
    ['129'] = "Matte Brown",
    ['130'] = "Worn Orange",
    ['131'] = "Matte White",
    ['132'] = "Worn White",
    ['133'] = "Worn Olive Army Green",
    ['134'] = "Pure White",
    ['135'] = "Hot Pink",
    ['136'] = "Salmon pink",
    ['137'] = "Metallic Vermillion Pink",
    ['138'] = "Orange",
    ['139'] = "Green",
    ['140'] = "Blue",
    ['141'] = "Mettalic Black Blue",
    ['142'] = "Metallic Black Purple",
    ['143'] = "Metallic Black Red",
    ['144'] = "hunter green",
    ['145'] = "Metallic Purple",
    ['146'] = "Metaillic V Dark Blue",
    ['147'] = "MODSHOP BLACK1",
    ['148'] = "Matte Purple",
    ['149'] = "Matte Dark Purple",
    ['150'] = "Metallic Lava Red",
    ['151'] = "Matte Forest Green",
    ['152'] = "Matte Olive Drab",
    ['153'] = "Matte Desert Brown",
    ['154'] = "Matte Desert Tan",
    ['155'] = "Matte Foilage Green",
    ['156'] = "DEFAULT ALLOY COLOR",
    ['157'] = "Epsilon Blue",
}



Config.Notifcation = function(notify)
    local message = notify[1]
    local notify_type = notify[2]
    lib.notify({
        position = 'top-right',
        description = message,
        type = notify_type,
    })
end 

Config.InfoBar = function(info, toggle)
    local message = info[1]
    local notify_type = info[2]
    if toggle then 
        lib.showTextUI(message, {position = 'bottom-center'})
    else 
        lib.hideTextUI()
    end
end 

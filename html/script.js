
const rootStyles = getComputedStyle(document.documentElement);
let body = rootStyles.getPropertyValue('--body');
let body2 = rootStyles.getPropertyValue('--body2');
let green = rootStyles.getPropertyValue('--green');
let blue = rootStyles.getPropertyValue('--blue');
let red = rootStyles.getPropertyValue('--red');
let orange = rootStyles.getPropertyValue('--orange');
let purple = rootStyles.getPropertyValue('--purple');
let grey = rootStyles.getPropertyValue('--grey');
let yellow = rootStyles.getPropertyValue('--yellow');
let border = rootStyles.getPropertyValue('--border');
let text = rootStyles.getPropertyValue('--text');
var audioPlayer = null;

window.addEventListener('message', (event) => {
    const data = event.data;

    if(data.type == 'show'){
        document.getElementById('container').style.visibility = 'visible';
        showMenu(data.information, data.settings, data.page); 
    }

    if(data.type == 'hide'){
        resetPages();
        document.getElementById('container').style.visibility = 'hidden';
    }

    if (event.data.transactionType == "playSound") {
				
        if (audioPlayer != null) {
          audioPlayer.pause();
        }

        audioPlayer = new Howl({src: ["./sounds/" + event.data.transactionFile + ".ogg"]});
        audioPlayer.volume(event.data.transactionVolume);
        audioPlayer.play();

    }

    if (event.data.transactionType == "stopSound") {
        if (audioPlayer != null) {
          audioPlayer.pause();
        }
    }
})

document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape' || event.key === 'Esc') {
        axios.post(`https://${GetParentResourceName()}/exit`, {
        }).then((response) => {})
    }
});


const mainPages = document.querySelectorAll('.mdt-page');
function resetPages() {
    
    mainPages.forEach(page => {
        document.getElementById('einwohner-selected').style.visibility = 'hidden';
        document.getElementById('add-self-clicked').style.visibility = 'hidden';
        document.getElementById('add-self-plus').style.visibility = 'hidden';
        document.getElementById('track-error-number').style.visibility = 'hidden';
        document.getElementById('track-error-plate').style.visibility = 'hidden';

        document.getElementById('add-self-callname-options').style.visibility = 'hidden';
        document.getElementById('add-self-status-options').style.visibility = 'hidden';
        document.getElementById('add-self-location-options').style.visibility = 'hidden';
        document.getElementById('add-self-vehicle-options').style.visibility = 'hidden';
        document.getElementById('add-self-frequency-options').style.visibility = 'hidden';
        document.getElementById('add-self-o1-options').style.visibility = 'hidden';
        document.getElementById('add-self-o2-options').style.visibility = 'hidden';
        document.getElementById('add-self-o3-options').style.visibility = 'hidden';

        page.style.visibility = 'hidden';
    });
}

const sidebarButtons = document.querySelectorAll('.sidebar-button');
function resetButtonColors() {
    sidebarButtons.forEach(button => {
        button.style.color = text;
    });
}

function showMenu(information, settings, page) {

    if(page != null){
        resetButtonColors()
        document.getElementById(page).style.color = blue;
        if(page == 'dashboard'){
            if(!(information.self.permissions.openDashboard)){
                showNoPermissions();
                return;
            }
            showDashboard(information);
        }
        if(page == 'leitstelle'){
            if(!(information.self.permissions.openControlCenter)){
                showNoPermissions();
                return;
            }
            showLeitstelle(information);
        }
        if(page == 'citizens'){
            if(!(information.self.permissions.openCitizen)){
                showNoPermissions();
                return;
            }
            showEinwohner(information);
        }
        if(page == 'vehicle'){
            if(!(information.self.permissions.openVehicles)){
                showNoPermissions();
                return;
            }
            showVehicle(information);
        }
        if(page == 'weapon'){
            if(!(information.self.permissions.openWeapons)){
                showNoPermissions();
                return;
            }
            showWeapon(information);
        }
        if(page == 'tracking'){
            if(!(information.self.permissions.openTracking)){
                showNoPermissions();
                return;
            }
            showTracking(information);
        }
        if(page == 'dispatches'){
            if(!(information.self.permissions.openDispatches)){
                showNoPermissions();
                return;
            }
            showDispatches(information);
        }
        if(page == 'lists'){
            if(!(information.self.permissions.openLists)){
                showNoPermissions();
                return;
            }
            showListen(information);
        }
        if(page == 'settings'){
            if(!(information.self.permissions.openSettings)){
                showNoPermissions();
                return;
            }
            showEinstellungen(information);
        }
    }

    //
    // buttons
    //

    document.getElementById('dashboard').addEventListener('click', function() {

        if(!(information.self.permissions.openDashboard)){
            showNoPermissions();
            return;
        }

        resetButtonColors();
        document.getElementById('dashboard').style.color = blue;
        resetPages();
        const page = 'dashboard';
        axios.post(`https://${GetParentResourceName()}/showPage`, {
            page,
        })
    });

    document.getElementById('leitstelle').addEventListener('click', function() {

        if(!(information.self.permissions.openControlCenter)){
            showNoPermissions();
            return;
        }

        resetButtonColors();
        document.getElementById('leitstelle').style.color = blue;
        resetPages();
        showLeitstelle(information);
    });

    document.getElementById('einwohner').addEventListener('click', function() {

        if(!(information.self.permissions.openCitizen)){
            showNoPermissions();
            return;
        }

        resetButtonColors();
        document.getElementById('einwohner').style.color = blue;
        resetPages();
        showEinwohner(information);
    });

    document.getElementById('fahrzeuge').addEventListener('click', function() {

        if(!(information.self.permissions.openVehicles)){
            showNoPermissions();
            return;
        }

        resetButtonColors();
        document.getElementById('fahrzeuge').style.color = blue;
        resetPages();
        showVehicle(information);
    });

    document.getElementById('waffen').addEventListener('click', function() {

        if(!(information.self.permissions.openWeapons)){
            showNoPermissions();
            return;
        }

        resetButtonColors();
        document.getElementById('waffen').style.color = blue;
        resetPages();
        showWeapon(information);
    });

    document.getElementById('tracking').addEventListener('click', function() {

        if(!(information.self.permissions.openTracking)){
            showNoPermissions();
            return;
        }

        resetButtonColors();
        document.getElementById('tracking').style.color = blue;
        resetPages();
        const page = 'tracking';
        axios.post(`https://${GetParentResourceName()}/showPage`, {
            page,
        })
    });

    document.getElementById('dispatches').addEventListener('click', function() {

        if(!(information.self.permissions.openDispatches)){
            showNoPermissions();
            return;
        }

        resetButtonColors();
        document.getElementById('dispatches').style.color = blue;
        resetPages();
        const page = 'dispatches';
        axios.post(`https://${GetParentResourceName()}/showPage`, {
            page,
        })
    });

    document.getElementById('listen').addEventListener('click', function() {

        if(!(information.self.permissions.openLists)){
            showNoPermissions();
            return;
        }

        resetButtonColors();
        document.getElementById('listen').style.color = blue;
        resetPages();
        showListen(information);
    });

    document.getElementById('rechner').addEventListener('click', function() {

        if(!(information.self.permissions.openCalculator)){
            showNoPermissions();
            return;
        }

        resetButtonColors();
        axios.post(`https://${GetParentResourceName()}/showCalc`, {
        }).then(() => {})
    });



    document.getElementById('einstellungen').addEventListener('click', function() {

        if(!(information.self.permissions.openSettings)){
            showNoPermissions();
            return;
        }

        resetButtonColors();
        document.getElementById('einstellungen').style.color = blue;
        resetPages();
        showEinstellungen(information);
    });

    //
    // pages
    //

    function showDashboard(information){
        document.getElementById('dashboard-page').style.visibility = 'visible';

        document.getElementById('header1').innerHTML = 'Willkommen zurück, ' + information.self.name;
        document.getElementById('header2').innerHTML = information.self.rank + ' | ' + information.self.job;

        document.getElementById('info-self-name').innerHTML = information.self.name;
        document.getElementById('info-self-callname').innerHTML = information.self.callName + '-' + information.self.callNumber;
        document.getElementById('info-self-status').innerHTML = information.self.status;
        document.getElementById('info-self-position').innerHTML = information.self.location;

        const activeOfficer = document.getElementById('active-officer-page');
        const warrentList = document.getElementById('warrent-list');
        const callList = document.getElementById('call-list');
        const infoList = document.getElementById('info-list');

        activeOfficer.innerHTML = '';
        warrentList.innerHTML = '';
        callList.innerHTML = '';
        infoList.innerHTML = '';
        const officers = information.officers;
        const warrents = information.warrents;
        const calls = information.calls;
        const infos = information.infos;

        infos.forEach(info => {
            const div = document.createElement('div');
            div.className = 'general-info-field';
            infoList.appendChild(div);

            const infoHeader = document.createElement('div');
            infoHeader.className = 'general-info-header';
            infoHeader.innerText = info.header;
            div.appendChild(infoHeader);

            const infoText = document.createElement('div');
            infoText.className = 'general-info-text';
            infoText.innerText = info.text;
            div.appendChild(infoText);

            const edit = document.createElement('div');
            edit.className = 'general-info-edit fa-solid fa-pen-to-square';
            div.appendChild(edit);

            const ndelete = document.createElement('div');
            ndelete.className = 'general-info-delete fa-solid fa-trash';
            div.appendChild(ndelete);

            edit.onclick = function() {
                axios.post(`https://${GetParentResourceName()}/editGeneralInformation`, {
                    info,
                }).then((response) => {
                    showMenu(response.information, response.settings, response.page); 
                })
            };
            ndelete.onclick = function() {
                axios.post(`https://${GetParentResourceName()}/deleteGeneralInformation`, {
                    info,
                }).then((response) => {
                    showMenu(response.information, response.settings, response.page); 
                })
            };

        }); 


        warrents.forEach(warrent => {
            const div = document.createElement('div');
            div.className = 'warrent-field';
            warrentList.appendChild(div);

            const warrentName = document.createElement('text');
            warrentName.textContent = warrent.name;
            div.appendChild(warrentName);
            warrentName.className = 'warrent-name';

            const warrentInfo = document.createElement('text');
            warrentInfo.innerText = warrent.reason + ': ' + warrent.info;
            div.appendChild(warrentInfo);
            warrentInfo.className = 'warrent-info';

        }); 

        calls.forEach(call => {
            const div = document.createElement('div');
            div.className = 'call-field';
            callList.appendChild(div);

            const statusColor = getColor(getColorName(call.code, settings.callStatus));

            const statusContainer = document.createElement('div');
            statusContainer.className = 'call-code';
            statusContainer.innerText = call.code;
            statusContainer.style.backgroundColor = statusColor;
            div.appendChild(statusContainer);

            const callReason = document.createElement('div');
            callReason.className = 'call-reason';
            callReason.innerText = call.reason;
            div.appendChild(callReason);

            const informationContainer = document.createElement('div');
            informationContainer.className = 'call-informations';
            div.appendChild(informationContainer);

            //time
            const timeContainer = document.createElement('div');
            timeContainer.className = 'call-informations-divs';
            informationContainer.appendChild(timeContainer);

            const callTimeImage = document.createElement('div');
            callTimeImage.className = 'fa-solid fa-clock';
            timeContainer.appendChild(callTimeImage);

            const callTimeText = document.createElement('div');
            callTimeText.className = 'information-text-divs';
            callTimeText.innerText = call.time;
            timeContainer.appendChild(callTimeText);


            //location
            const locationContainer = document.createElement('div');
            locationContainer.className = 'call-informations-divs';
            informationContainer.appendChild(locationContainer);

            const callLocationImage = document.createElement('div');
            callLocationImage.className = 'fa-solid fa-location-crosshairs';
            locationContainer.appendChild(callLocationImage);

            const callLocationText = document.createElement('div');
            callLocationText.className = 'information-text-divs';
            callLocationText.innerText = call.location;
            locationContainer.appendChild(callLocationText);

            //information
            const infoContainer = document.createElement('div');
            infoContainer.className = 'call-informations-divs';
            informationContainer.appendChild(infoContainer);

            const callInfoImage = document.createElement('div');
            callInfoImage.className = 'fa-solid fa-circle-question';
            infoContainer.appendChild(callInfoImage);

            const callInfoText = document.createElement('div');
            callInfoText.className = 'information-text-divs';
            callInfoText.innerText = call.infos;
            infoContainer.appendChild(callInfoText);

            //buttons
            const edit = document.createElement('div');
            edit.className = 'general-info-edit fa-solid fa-pen-to-square';
            div.appendChild(edit);

            const ndelete = document.createElement('div');
            ndelete.className = 'general-info-delete fa-solid fa-trash';
            div.appendChild(ndelete);

            const officer = document.createElement('div');
            officer.className = 'general-info-officer fa-solid fa-user';
            div.appendChild(officer);

            edit.onclick = function() {
                returnValue = call.identifier;
                axios.post(`https://${GetParentResourceName()}/editDispatch`, {
                    returnValue,
                }).then((response) => {
                    showMenu(response.information, response.settings, response.page); 
                })
            };
            ndelete.onclick = function() {
                returnValue = call.identifier;
                axios.post(`https://${GetParentResourceName()}/deleteDispatch`, {
                    returnValue,
                }).then((response) => {
                    showMenu(response.information, response.settings, response.page); 
                })
            };
            officer.onclick = function() {
                returnValue = call.identifier;
                axios.post(`https://${GetParentResourceName()}/officerDispatch`, {
                    returnValue,
                }).then((response) => {
                    showMenu(response.information, response.settings, response.page); 
                })
            };
        }); 

        officers.forEach(officer => {
            if(officer.asigned == false){return}
            const div = document.createElement('div');
            div.className = 'active-officer-field';
            activeOfficer.appendChild(div);

            const officerName = document.createElement('text');
            officerName.textContent = officer.name;
            div.appendChild(officerName);
            officerName.className = 'active-officer-text';

            const officerTel = document.createElement('text');
            officerTel.textContent = 'Telefon Nummer: ' + officer.number;
            div.appendChild(officerTel);
            officerTel.className = 'active-officer-tel';

            const img = document.createElement('img');
            img.src = `img/user.png`;
            img.alt = officer.name; 
            div.appendChild(img);
            img.className = 'officer-img';

            const infoContainer = document.createElement('div');
            infoContainer.className = 'active-officer-info-container';
            div.appendChild(infoContainer);

            const statusColor = getColor(getColorName(officer.status, settings.status));
            const locationColor = getColor(getColorName(officer.location, settings.locations));
            const vehicleColor = getColor(getColorName(officer.vehicle, settings.vehicles));
            const callnameColor = getColor(getColorName(officer.callName, settings.callNames));

            // Status
            const statusContainer = document.createElement('div');
            statusContainer.className = 'active-officer-div-container';
            infoContainer.appendChild(statusContainer);

            const statusImage = document.createElement('div');
            statusImage.className = 'active-officer-status-image fa-solid fa-square-poll-vertical';
            statusContainer.appendChild(statusImage);
            statusImage.style.color = text;
            statusImage.style.backgroundColor = statusColor;
            statusImage.style.borderColor = statusColor;

            const officerStatus = document.createElement('text');
            officerStatus.textContent = 'Status: ' + officer.status;
            statusContainer.appendChild(officerStatus);
            officerStatus.className = 'active-officer-status';
            officerStatus.style.color = text;
            officerStatus.style.backgroundColor = statusColor
            officerStatus.style.borderColor = statusColor;

            // Callname
            const callnameContainer = document.createElement('div');
            callnameContainer.className = 'active-officer-div-container';
            infoContainer.appendChild(callnameContainer);

            const callnameImage = document.createElement('div');
            callnameImage.className = 'active-officer-status-image fa-solid fa-user';
            callnameContainer.appendChild(callnameImage);
            callnameImage.style.color = text;
            callnameImage.style.backgroundColor = callnameColor;
            callnameImage.style.borderColor = callnameColor;

            const callnameText = document.createElement('text');
            callnameText.textContent = officer.callName + '-' + officer.callNumber;
            callnameContainer.appendChild(callnameText);
            callnameText.className = 'active-officer-status';
            callnameText.style.color = text;
            callnameText.style.backgroundColor = callnameColor
            callnameText.style.borderColor = callnameColor;

            // Vehicle
            const vehicleContainer = document.createElement('div');
            vehicleContainer.className = 'active-officer-div-container';
            infoContainer.appendChild(vehicleContainer);

            const vehicleImage = document.createElement('div');
            vehicleImage.className = 'active-officer-status-image fa-solid fa-car-side';
            vehicleContainer.appendChild(vehicleImage);
            vehicleImage.style.color = text;
            vehicleImage.style.backgroundColor = vehicleColor;
            vehicleImage.style.borderColor = vehicleColor;

            const vehicleText = document.createElement('text');
            vehicleText.textContent = officer.vehicle;
            vehicleContainer.appendChild(vehicleText);
            vehicleText.className = 'active-officer-status';
            vehicleText.style.color = text;
            vehicleText.style.backgroundColor = vehicleColor
            vehicleText.style.borderColor = vehicleColor;

            // Location
            const locationContainer = document.createElement('div');
            locationContainer.className = 'active-officer-div-container';
            infoContainer.appendChild(locationContainer);

            const locationImage = document.createElement('div');
            locationImage.className = 'active-officer-status-image fa-solid fa-location-crosshairs';
            locationContainer.appendChild(locationImage);
            locationImage.style.color = text;
            locationImage.style.backgroundColor = locationColor;
            locationImage.style.borderColor = locationColor;

            const locationText = document.createElement('text');
            locationText.textContent = officer.location;
            locationContainer.appendChild(locationText);
            locationText.className = 'active-officer-status';
            locationText.style.color = text;
            locationText.style.backgroundColor = locationColor
            locationText.style.borderColor = locationColor;


        });  

        document.getElementById('info-button').onclick = function() {

            if(!(information.self.permissions.createInformation)){
                showNoPermissions();
                return;
            }

            axios.post(`https://${GetParentResourceName()}/addGeneralInformation`, {
            }).then((response) => {
                showMenu(response.information, response.settings, response.page); 
            })
        };
    }


    function showLeitstelle(information){
        document.getElementById('leitstelle-page').style.visibility = 'visible';
        document.getElementById('officer-information-other').innerHTML = '';

        document.getElementById('header1').innerHTML = information.self.name;
        document.getElementById('header2').innerHTML = information.self.rank + ' | ' + information.self.job;

        document.getElementById('stats-street').innerHTML = information.general.street;
        document.getElementById('stats-offroad').innerHTML = information.general.offroad;
        document.getElementById('stats-highspeed').innerHTML = information.general.highspeed;
        document.getElementById('stats-air').innerHTML = information.general.air;
        document.getElementById('stats-city').innerHTML = information.general.city;
        document.getElementById('stats-county').innerHTML = information.general.county;
        document.getElementById('stats-highway').innerHTML = information.general.highway;
        document.getElementById('stats-other').innerHTML = information.general.other;
        document.getElementById('stats-patrol').innerHTML = information.general.patrol;
        document.getElementById('stats-king').innerHTML = information.general.king;
        document.getElementById('stats-swat').innerHTML = information.general.swat;
        document.getElementById('stats-all').innerHTML = information.general.all;

        if(information.self.asigned){
            document.getElementById('add-self-plus').style.visibility = 'hidden';
            document.getElementById('add-self-clicked').style.visibility = 'visible';
            asignSelfColors(information);
        }else{
            document.getElementById('add-self-plus').style.visibility = 'visible';
            document.getElementById('add-self-clicked').style.visibility = 'hidden';
        }

        document.getElementById('add-self-plus').onclick = function() {
            document.getElementById('add-self-plus').style.visibility = 'hidden';
            document.getElementById('add-self-clicked').style.visibility = 'visible';
            axios.post(`https://${GetParentResourceName()}/updateLeitstelle`, {
                type: 'asigned',
                status: true,
            }).then((response) => {})
        };

        document.getElementById('add-self-callname').onclick = function() {
            hideStatus();
            document.getElementById('add-self-callname-options').style.visibility = 'visible';
            
            const options = settings.callNames;
            const optionsDiv = document.getElementById('add-self-callname-options');
            optionsDiv.innerHTML = '';
            options.forEach(option => {
                const optionDiv = document.createElement('div');
                optionDiv.className = 'add-self-option-select';
                optionDiv.innerText = option.status;
                optionDiv.style.backgroundColor = getColor(option.color);
                optionsDiv.appendChild(optionDiv);
                optionDiv.onclick = function() {
                    hideStatus();
                    information.self.callName = option.status;
                    updateselfInformation(information);
                };
            }); 
        };
        document.getElementById('add-self-status').onclick = function() {
            hideStatus();
            document.getElementById('add-self-status-options').style.visibility = 'visible';

            const options = settings.status;
            const optionsDiv = document.getElementById('add-self-status-options');
            optionsDiv.innerHTML = '';
            options.forEach(option => {
                const optionDiv = document.createElement('div');
                optionDiv.className = 'add-self-option-select';
                optionDiv.innerText = option.status;
                optionDiv.style.backgroundColor = getColor(option.color);
                optionsDiv.appendChild(optionDiv);
                optionDiv.onclick = function() {
                    hideStatus();
                    information.self.status = option.status;
                    updateselfInformation(information);
                };

            }); 
        };
        document.getElementById('add-self-location').onclick = function() {
            hideStatus();
            document.getElementById('add-self-location-options').style.visibility = 'visible';
            
            const options = settings.locations;
            const optionsDiv = document.getElementById('add-self-location-options');
            optionsDiv.innerHTML = '';
            options.forEach(option => {
                const optionDiv = document.createElement('div');
                optionDiv.className = 'add-self-option-select';
                optionDiv.innerText = option.status;
                optionDiv.style.backgroundColor = getColor(option.color);
                optionsDiv.appendChild(optionDiv);
                optionDiv.onclick = function() {
                    hideStatus();
                    information.self.location = option.status;
                    updateselfInformation(information);
                };
            }); 
        };
        document.getElementById('add-self-vehicle').onclick = function() {
            hideStatus();
            document.getElementById('add-self-vehicle-options').style.visibility = 'visible';
            
            const options = settings.vehicles;
            const optionsDiv = document.getElementById('add-self-vehicle-options');
            optionsDiv.innerHTML = '';
            options.forEach(option => {
                const optionDiv = document.createElement('div');
                optionDiv.className = 'add-self-option-select';
                optionDiv.innerText = option.status;
                optionDiv.style.backgroundColor = getColor(option.color);
                optionsDiv.appendChild(optionDiv);
                optionDiv.onclick = function() {
                    hideStatus();
                    information.self.vehicle = option.status;
                    updateselfInformation(information);
                };
            }); 
        };
        document.getElementById('add-self-frequency').onclick = function() {
            hideStatus();
            document.getElementById('add-self-frequency-options').style.visibility = 'visible';
            
            const options = settings.frequency;
            const optionsDiv = document.getElementById('add-self-frequency-options');
            optionsDiv.innerHTML = '';
            options.forEach(option => {
                const optionDiv = document.createElement('div');
                optionDiv.className = 'add-self-option-select';
                optionDiv.innerText = option.status;
                optionDiv.style.backgroundColor = getColor(option.color);
                optionsDiv.appendChild(optionDiv);
                optionDiv.onclick = function() {
                    hideStatus();
                    information.self.frequency = option.status;
                    updateselfInformation(information);
                };
            }); 
        };
        document.getElementById('add-self-o1').onclick = function() {
            hideStatus();
            document.getElementById('add-self-o1-options').style.visibility = 'visible';

            const options = information.officers;
            const optionsDiv = document.getElementById('add-self-o1-options');
            optionsDiv.innerHTML = '';

            const optionDiv = document.createElement('div');
            optionDiv.className = 'add-self-option-select';
            optionDiv.innerText = 'n/A';
            optionDiv.style.backgroundColor = orange;
            optionsDiv.appendChild(optionDiv);
            optionDiv.onclick = function() {
                hideStatus();
                information.self.o1 = 'n/A';
                updateselfInformation(information);
            };

            options.forEach(option => {
                const optionDiv = document.createElement('div');
                optionDiv.className = 'add-self-option-select';
                optionDiv.innerText = option.name;
                optionDiv.style.backgroundColor = green;
                optionsDiv.appendChild(optionDiv);
                optionDiv.onclick = function() {
                    hideStatus();
                    information.self.o1 = option.name;
                    updateselfInformation(information);
                };
            }); 
        };
        document.getElementById('add-self-o2').onclick = function() {
            hideStatus();
            document.getElementById('add-self-o2-options').style.visibility = 'visible';

            const options = information.officers;
            const optionsDiv = document.getElementById('add-self-o2-options');
            optionsDiv.innerHTML = '';

            const optionDiv = document.createElement('div');
            optionDiv.className = 'add-self-option-select';
            optionDiv.innerText = 'n/A';
            optionDiv.style.backgroundColor = orange;
            optionsDiv.appendChild(optionDiv);
            optionDiv.onclick = function() {
                hideStatus();
                information.self.o2 = 'n/A';
                updateselfInformation(information);
            };

            options.forEach(option => {
                const optionDiv = document.createElement('div');
                optionDiv.className = 'add-self-option-select';
                optionDiv.innerText = option.name;
                optionDiv.style.backgroundColor = green;
                optionsDiv.appendChild(optionDiv);
                optionDiv.onclick = function() {
                    hideStatus();
                    information.self.o2 = option.name;
                    updateselfInformation(information);
                };
            }); 
        };
        document.getElementById('add-self-o3').onclick = function() {
            hideStatus();
            document.getElementById('add-self-o3-options').style.visibility = 'visible';

            const options = information.officers;
            const optionsDiv = document.getElementById('add-self-o3-options');
            optionsDiv.innerHTML = '';

            const optionDiv = document.createElement('div');
            optionDiv.className = 'add-self-option-select';
            optionDiv.innerText = 'n/A';
            optionDiv.style.backgroundColor = orange;
            optionsDiv.appendChild(optionDiv);
            optionDiv.onclick = function() {
                hideStatus();
                information.self.o3 = 'n/A';
                updateselfInformation(information);
            };

            options.forEach(option => {
                const optionDiv = document.createElement('div');
                optionDiv.className = 'add-self-option-select';
                optionDiv.innerText = option.name;
                optionDiv.style.backgroundColor = green;
                optionsDiv.appendChild(optionDiv);
                optionDiv.onclick = function() {
                    hideStatus();
                    information.self.o3 = option.name;
                    updateselfInformation(information);
                };
            }); 
        };

        const categories = settings.callNames;
        const optionsDiv = document.getElementById('officer-information-other');
        categories.forEach(categorie => {
            if(categorie.status != 'n/A'){
                const categorieDiv = document.createElement('div');
                categorieDiv.className = 'officer-categorie-div';
                optionsDiv.appendChild(categorieDiv);

                const categorieHeader = document.createElement('div');
                categorieHeader.className = 'officer-categorie-header';
                categorieHeader.innerText = categorie.status;
                categorieDiv.appendChild(categorieHeader);

                const categorieOfficer = document.createElement('div');
                categorieOfficer.className = 'officer-categorie-officer';
                categorieDiv.appendChild(categorieOfficer);

                const allOfficers = information.officers;
                allOfficers.forEach(officer => {
                    if((officer.callName == categorie.status)){
                        const categorieHeader = document.createElement('div');
                        categorieHeader.className = 'officer-categorie-individual';
                        categorieOfficer.appendChild(categorieHeader);

                        const oName = document.createElement('div');
                        oName.className = 'officer-info-individual-info';
                        oName.innerText = officer.name;
                        oName.style.backgroundColor = green;
                        oName.style.borderColor = green;
                        categorieHeader.appendChild(oName);

                        const oCallName = document.createElement('div');
                        oCallName.className = 'officer-info-individual-info';
                        oCallName.innerText = officer.callName + '-' + officer.callNumber;
                        oCallName.style.backgroundColor = getColor(getColorName(officer.callName, settings.callNames));
                        oCallName.style.borderColor = getColor(getColorName(officer.callName, settings.callNames));
                        categorieHeader.appendChild(oCallName);

                        const oStatus = document.createElement('div');
                        oStatus.className = 'officer-info-individual-info';
                        oStatus.innerText = officer.status;
                        oStatus.style.backgroundColor = getColor(getColorName(officer.status, settings.status));
                        oStatus.style.borderColor = getColor(getColorName(officer.status, settings.status));
                        categorieHeader.appendChild(oStatus);

                        const oLocation = document.createElement('div');
                        oLocation.className = 'officer-info-individual-info';
                        oLocation.innerText = officer.location;
                        oLocation.style.backgroundColor = getColor(getColorName(officer.location, settings.locations));
                        oLocation.style.borderColor = getColor(getColorName(officer.location, settings.locations));
                        categorieHeader.appendChild(oLocation);

                        const oVehicle = document.createElement('div');
                        oVehicle.className = 'officer-info-individual-info';
                        oVehicle.innerText = officer.vehicle;
                        oVehicle.style.backgroundColor = getColor(getColorName(officer.vehicle, settings.vehicles));
                        oVehicle.style.borderColor = getColor(getColorName(officer.vehicle, settings.vehicles));
                        categorieHeader.appendChild(oVehicle);

                        const oFrequency = document.createElement('div');
                        oFrequency.className = 'officer-info-individual-info';
                        oFrequency.innerText = officer.frequency;
                        oFrequency.style.backgroundColor = getColor(getColorName(officer.frequency, settings.frequency));
                        oFrequency.style.borderColor = getColor(getColorName(officer.frequency, settings.frequency));
                        categorieHeader.appendChild(oFrequency);

                        const oo1 = document.createElement('div');
                        oo1.className = 'officer-info-individual-info';
                        oo1.innerText = officer.o1;
                        oo1.style.backgroundColor = getOfficerColor(officer.o1);
                        oo1.style.borderColor = getOfficerColor(officer.o1);
                        categorieHeader.appendChild(oo1);

                        const oo2 = document.createElement('div');
                        oo2.className = 'officer-info-individual-info';
                        oo2.innerText = officer.o2;
                        oo2.style.backgroundColor = getOfficerColor(officer.o2);
                        oo2.style.borderColor = getOfficerColor(officer.o2);
                        categorieHeader.appendChild(oo2);

                        const oo3 = document.createElement('div');
                        oo3.className = 'officer-info-individual-info';
                        oo3.innerText = officer.o3;
                        oo3.style.backgroundColor = getOfficerColor(officer.o3);
                        oo3.style.borderColor = getOfficerColor(officer.o3);
                        categorieHeader.appendChild(oo3);
                    }
                });
            } 
        });

        if(information.self.asigned){
            const logoutDiv = document.createElement('div');
            logoutDiv.className = 'self-logout';
            logoutDiv.innerText = 'Abmelden',
            optionsDiv.appendChild(logoutDiv);

            logoutDiv.onclick = function() {
                axios.post(`https://${GetParentResourceName()}/logout`, {
                    information,
                }).then((response) => {
                    showMenu(response.information, response.settings, response.page); 
                })
            };
        }
    }

    function showEinwohner(information){
        document.getElementById('einwohner-page').style.visibility = 'visible';
        document.getElementById('header1').innerHTML = information.self.name;
        document.getElementById('header2').innerHTML = information.general.user_found + ' Personen in der Datenbank gefunden';

        document.getElementById('fahrzeug-search-field').innerHTML = ''; 
        document.getElementById('waffe-search-field').innerHTML = '';
        document.getElementById('einwohner-search-field').innerHTML = '';

        document.getElementById('search-einwohner').onclick = function() {
            const returnValue = document.getElementById('search-einwohner-text').value;
            axios.post(`https://${GetParentResourceName()}/getEinwohnerSearch`, {
                returnValue,
            }).then((response) => {
                displayEinwohnerResults(response.data);
            })
        };

        function displayEinwohnerResults(response){
            const resultField = document.getElementById('einwohner-search-field');
            resultField.innerHTML = ''; 
            response.forEach(result => {
                const div = document.createElement('div');
                div.className = 'result-field';
                resultField.appendChild(div);

                const img = document.createElement('img');
                img.src = `img/user.png`;
                div.appendChild(img);
                img.className = 'result-info-img';

                const infoDiv = document.createElement('div');
                infoDiv.className = 'result-info-div';
                div.appendChild(infoDiv);

                const nameField = document.createElement('div');
                nameField.className = 'result-btn-field-info';
                nameField.innerText = 'Name: \n' + result.firstname + ' ' + result.lastname;
                infoDiv.appendChild(nameField);

                const dobField = document.createElement('div');
                dobField.className = 'result-btn-field-info';
                dobField.innerText = 'Geburtsdatum: \n' + result.dob;
                infoDiv.appendChild(dobField);

                const sexField = document.createElement('div');
                sexField.className = 'result-btn-field-info';
                sexField.innerText = 'Geschlecht: \n' + result.sex;
                infoDiv.appendChild(sexField);

                const warrentField = document.createElement('div');
                warrentField.className = 'result-btn-field-info';
                warrentField.innerText = 'Gesucht: \n' + toCheckMark(result.warrent);
                infoDiv.appendChild(warrentField);

                const vehBtn = document.createElement('div');
                vehBtn.className = 'result-btn-field-info result-btn';
                vehBtn.innerText = 'Fahrzeuge Suchen';
                infoDiv.appendChild(vehBtn);

                vehBtn.onclick = function() {
                    event.stopPropagation();
                    returnValue = result.identifier;

                    if(!(information.self.permissions.citizenOpenVehicles)){
                        showNoPermissions();
                        return;
                    }

                    axios.post(`https://${GetParentResourceName()}/getFahrzeugFromIdentifer`, {
                        returnValue,
                    }).then((response) => {
                        displayFahrzeugResults(response.data);
                    })
                };

                const wpnBtn = document.createElement('div');
                wpnBtn.className = 'result-btn-field-info result-btn';
                wpnBtn.innerText = 'Waffen Suchen';
                infoDiv.appendChild(wpnBtn);

                wpnBtn.onclick = function() {
                    event.stopPropagation();
                    returnValue = result.identifier;

                    if(!(information.self.permissions.citizenOpenWeapons)){
                        showNoPermissions();
                        return;
                    }

                    axios.post(`https://${GetParentResourceName()}/getWaffeFromIdentifer`, {
                        returnValue,
                    }).then((response) => {
                        displayWaffeResults(response.data);
                    })
                };

                div.onclick = function() {
                    openUser(result)
                };
            });
        }
    }

    function openUser(result){
        document.getElementById('einwohner-page').style.visibility = 'hidden';
        document.getElementById('einwohner-selected').style.visibility = 'visible';

        document.getElementById('header1').innerHTML = result.firstname + ' ' + result.lastname;
        document.getElementById('header2').innerHTML = result.dob;

        document.getElementById('officer-information-stats-field-name').innerText = result.firstname;
        document.getElementById('officer-information-stats-field-surname').innerText = result.lastname;
        document.getElementById('officer-information-stats-field-sex').innerText = result.sex;
        document.getElementById('officer-information-stats-field-dob').innerText = result.dob;

        document.getElementById('officer-information-stats-field-email').innerText = result.email;
        document.getElementById('officer-information-stats-field-telefon').innerText = result.telefon;
        document.getElementById('officer-information-stats-field-job').innerText = result.job;

        document.getElementById('officer-information-stats-field-warrant-state').innerText = toCheckMark(result.warrent);
        document.getElementById('officer-information-stats-field-warrant-info').innerText = result.warrent_info;
        document.getElementById('officer-information-stats-field-warrant-reason').innerText = result.warrent_reason;

        document.getElementById('einwohner-selected-edit-data').onclick = function() {

            if(!(information.self.permissions.citizenEditPersonalData)){
                showNoPermissions();
                return;
            }

            axios.post(`https://${GetParentResourceName()}/editPlayerData`, {
                result,
            }).then((response) => {
                openUser(response.data);
            })
        };

        const imgField = document.getElementById('einwohner-selected-img-field');
        imgField.innerHTML = '';

        if (result.img != '') {
            const img = document.createElement('img');
            img.src = result.img;
            img.className = 'einwohner-selected-img-png';
            imgField.appendChild(img);

            img.onclick = function() {
                axios.post(`https://${GetParentResourceName()}/editImg`, {
                    result,
                }).then((response) => {
                    openUser(response.data);
                })
            };
        }else{
            const plus = document.createElement('div');
            plus.className = 'einwohner-selected-add-img';
            plus.innerText = '+';
            imgField.appendChild(plus);

            imgField.onclick = function() {
                axios.post(`https://${GetParentResourceName()}/addPlayerImg`, {
                    result,
                }).then((response) => {})
            };
        }

        document.getElementById('einwohner-selected-edit-warrant').onclick = function() {

            if(!(information.self.permissions.citizenEditWanted)){
                showNoPermissions();
                return;
            }

            axios.post(`https://${GetParentResourceName()}/editPlayerWarrant`, {
                result,
            }).then((response) => {
                openUser(response.data);
            })
        };

        document.getElementById('einwohner-selected-edit-licenses').onclick = function() {

            if(!(information.self.permissions.citizenEditLicense)){
                showNoPermissions();
                return;
            }

            axios.post(`https://${GetParentResourceName()}/editPlayerLicenses`, {
                result,
            }).then((response) => {
                openUser(response.data);
            })
        };

        const licenses = result.licenses;
        const notes = result.notes;
        const openfiles = result.openfiles;
        const closedfiles = result.closedfiles;

        const licenseField = document.getElementById('einwohner-selected-licenses-data');
        const notesField = document.getElementById('einwohner-selected-notes-data');
        const openfilesField = document.getElementById('einwohner-selected-files-data');
        const closedfilesField = document.getElementById('einwohner-selected-closedfiles-data');

        licenseField.innerHTML = ''; 
        notesField.innerHTML = ''; 
        openfilesField.innerHTML = ''; 
        closedfilesField.innerHTML = ''; 

        licenses.forEach(license => {
            const div = document.createElement('div');
            div.innerText = license;
            licenseField.appendChild(div);
        });

        notes.forEach(note => {
            const div = document.createElement('div');
            div.className = 'note-field';
            notesField.appendChild(div);

            const header = document.createElement('div');
            header.className = 'note-header';
            header.innerText = note.officer + ' - ' + note.date;
            div.appendChild(header);

            const edit = document.createElement('div');
            edit.className = 'note-edit fa-solid fa-pen-to-square';
            div.appendChild(edit);

            const ndelete = document.createElement('div');
            ndelete.className = 'note-delete fa-solid fa-trash';
            div.appendChild(ndelete);

            const text = document.createElement('div');
            text.className = 'note-text';
            text.innerText = note.text
            div.appendChild(text);

            ndelete.onclick = function() {

                if(!(information.self.permissions.citizenEditNote)){
                    showNoPermissions();
                    return;
                }

                axios.post(`https://${GetParentResourceName()}/deletePlayerNote`, {
                    result,
                    note,
                }).then((response) => {
                    openUser(response.data);
                })
            };
            edit.onclick = function() {

                if(!(information.self.permissions.citizenEditNote)){
                    showNoPermissions();
                    return;
                }

                axios.post(`https://${GetParentResourceName()}/editPlayerNote`, {
                    result,
                    note,
                }).then((response) => {
                    openUser(response.data);
                })
            }; 
        });
        const div = document.createElement('div');
        div.className = 'note-field note-new';
        div.innerText = '+';
        notesField.appendChild(div);
        div.onclick = function() {

            if(!(information.self.permissions.citizenCreateNote)){
                showNoPermissions();
                return;
            }

            axios.post(`https://${GetParentResourceName()}/addPlayerNote`, {
                result,
            }).then((response) => {
                openUser(response.data);
            })
        };

        openfiles.forEach(file => {
            const div = document.createElement('div');
            div.className = 'file-field';
            openfilesField.appendChild(div);

            const law = document.createElement('div');
            law.className = 'file-data';
            law.innerText = file.law;
            div.appendChild(law);

            const info = document.createElement('div');
            info.className = 'file-data';
            info.innerText = file.info;
            div.appendChild(info);

            const officer = document.createElement('div');
            officer.className = 'file-data';
            officer.innerText = file.officer;
            div.appendChild(officer);

            const date = document.createElement('div');
            date.className = 'file-data';
            date.innerText = file.date;
            div.appendChild(date);

            const edit = document.createElement('div');
            edit.className = 'file-edit fa-solid fa-pen-to-square';
            div.appendChild(edit);

            const ndelete = document.createElement('div');
            ndelete.className = 'file-delete fa-solid fa-trash';
            div.appendChild(ndelete);

            const close = document.createElement('div');
            close.className = 'file-close fa-regular fa-circle-xmark';
            div.appendChild(close);

            edit.onclick = function() {

                if(!(information.self.permissions.citizenEditFile)){
                    showNoPermissions();
                    return;
                }

                axios.post(`https://${GetParentResourceName()}/editOpenFile`, {
                    result,
                    file,
                }).then((response) => {
                    openUser(response.data);
                })
            };
            ndelete.onclick = function() {

                if(!(information.self.permissions.citizenEditFile)){
                    showNoPermissions();
                    return;
                }

                axios.post(`https://${GetParentResourceName()}/deleteOpenFile`, {
                    result,
                    file,
                }).then((response) => {
                    openUser(response.data);
                })
            };
            close.onclick = function() {

                if(!(information.self.permissions.citizenEditFile)){
                    showNoPermissions();
                    return;
                }

                axios.post(`https://${GetParentResourceName()}/closeOpenFile`, {
                    result,
                    file,
                }).then((response) => {
                    openUser(response.data);
                })
            };
    
        });

        const createopenfile = document.createElement('div');
        createopenfile.className = 'file-field-plus';
        createopenfile.innerText = '+';
        openfilesField.appendChild(createopenfile);
        createopenfile.onclick = function() {

            if(!(information.self.permissions.citizenCreateFile)){
                showNoPermissions();
                return;
            }

            axios.post(`https://${GetParentResourceName()}/createNewFile`, {
                result,
            }).then((response) => {
                openUser(response.data);
            })
        };

        closedfiles.forEach(file => {
            const div = document.createElement('div');
            div.className = 'file-field';
            closedfilesField.appendChild(div);

            const law = document.createElement('div');
            law.className = 'file-data';
            law.innerText = file.law;
            div.appendChild(law);

            const info = document.createElement('div');
            info.className = 'file-data';
            info.innerText = file.info;
            div.appendChild(info);

            const officer = document.createElement('div');
            officer.className = 'file-data';
            officer.innerText = file.officer;
            div.appendChild(officer);

            const date = document.createElement('div');
            date.className = 'file-data';
            date.innerText = file.date;
            div.appendChild(date);

            const edit = document.createElement('div');
            edit.className = 'file-edit fa-solid fa-pen-to-square';
            div.appendChild(edit);

            const ndelete = document.createElement('div');
            ndelete.className = 'file-delete fa-solid fa-trash';
            div.appendChild(ndelete);

            const close = document.createElement('div');
            close.className = 'file-open fa-regular fa-circle-check';
            div.appendChild(close);

            edit.onclick = function() {

                if(!(information.self.permissions.citizenEditFile)){
                    showNoPermissions();
                    return;
                }

                axios.post(`https://${GetParentResourceName()}/editClosedFile`, {
                    result,
                    file,
                }).then((response) => {
                    openUser(response.data);
                })
            };
            ndelete.onclick = function() {

                if(!(information.self.permissions.citizenEditFile)){
                    showNoPermissions();
                    return;
                }

                axios.post(`https://${GetParentResourceName()}/deleteClosedFile`, {
                    result,
                    file,
                }).then((response) => {
                    openUser(response.data);
                })
            };
            close.onclick = function() {

                if(!(information.self.permissions.citizenEditFile)){
                    showNoPermissions();
                    return;
                }

                axios.post(`https://${GetParentResourceName()}/closeClosedFile`, {
                    result,
                    file,
                }).then((response) => {
                    openUser(response.data);
                })
            };
        });
    }

    function showVehicle(information){
        resetPages();
        document.getElementById('vehicle-page').style.visibility = 'visible';
        document.getElementById('header1').innerHTML = information.self.name;
        document.getElementById('header2').innerHTML = information.general.vehicle_found + ' Fahrzeuge in der Datenbank gefunden';

        document.getElementById('fahrzeug-search-field').innerHTML = ''; 
        document.getElementById('waffe-search-field').innerHTML = '';
        document.getElementById('einwohner-search-field').innerHTML = '';

        document.getElementById('search-fahrzeug').onclick = function() {
            const returnValue = document.getElementById('search-fahrzeug-text').value;
            axios.post(`https://${GetParentResourceName()}/getFahrzeugSearch`, {
                returnValue,
            }).then((response) => {
                displayFahrzeugResults(response.data);
            })
        };
    }

    function showWeapon(information){
        resetPages();
        document.getElementById('weapon-page').style.visibility = 'visible';
        document.getElementById('header1').innerHTML = information.self.name;
        document.getElementById('header2').innerHTML = information.general.weapon_found + ' Waffen in der Datenbank gefunden';

        document.getElementById('fahrzeug-search-field').innerHTML = ''; 
        document.getElementById('waffe-search-field').innerHTML = '';
        document.getElementById('einwohner-search-field').innerHTML = '';

        document.getElementById('search-waffe').onclick = function() {
            const returnValue = document.getElementById('search-waffe-text').value;
            axios.post(`https://${GetParentResourceName()}/getWaffeSearch`, {
                returnValue,
            }).then((response) => {
                displayWaffeResults(response.data);
            })
        };
    }

    function showTracking(information){
        document.getElementById('tracking-page').style.visibility = 'visible';
        document.getElementById('header1').innerHTML = information.self.name;
        document.getElementById('header2').innerHTML = information.self.rank + ' | ' + information.self.job;

        const points = document.querySelectorAll('.zoom-point');
        points.forEach(point => point.remove());


        document.getElementById('search-number').onclick = function() {
            const returnValue = document.getElementById('search-number-text').value;

            if(!(information.self.permissions.trackNumber)){
                showNoPermissions();
                return;
            }

            axios.post(`https://${GetParentResourceName()}/trackNumber`, {
                returnValue,
            }).then((response) => {
                trackNumber(response.data);
            });
        };
        
        function trackNumber(response) {
            document.getElementById('track-error-number').style.visibility = 'hidden';
            document.getElementById('track-error-plate').style.visibility = 'hidden';
            if (typeof response === 'string') {
                document.getElementById('track-error-number').style.visibility = 'visible';
                document.getElementById('track-error-number-header').innerText = 'Tracking Fehlgeschlagen';
                document.getElementById('track-error-number-text').innerText = response;
            } else {
                const field = document.getElementById('zoom-box');
                const zoomPoint = document.createElement('div');
                zoomPoint.className = 'zoom-point';
                zoomPoint.setAttribute('data-x', response.x);
                zoomPoint.setAttribute('data-y', response.y);
                field.appendChild(zoomPoint);
                updatePoints();
            }
        }
        
        document.getElementById('search-plate').onclick = function() {
            const returnValue = document.getElementById('search-plate-text').value;

            if(!(information.self.permissions.trackPlate)){
                showNoPermissions();
                return;
            }

            axios.post(`https://${GetParentResourceName()}/trackPlate`, {
                returnValue,
            }).then((response) => {
                trackPlate(response.data);
            });
        };
        
        function trackPlate(response) {
            document.getElementById('track-error-number').style.visibility = 'hidden';
            document.getElementById('track-error-plate').style.visibility = 'hidden';
            if (typeof response === 'string') {
                document.getElementById('track-error-plate').style.visibility = 'visible';
                document.getElementById('track-error-plate-header').innerText = 'Tracking Fehlgeschlagen';
                document.getElementById('track-error-plate-text').innerText = response;
            } else {
                const field = document.getElementById('zoom-box');
                const zoomPoint = document.createElement('div');
                zoomPoint.className = 'zoom-point';
                zoomPoint.setAttribute('data-x', response.x);
                zoomPoint.setAttribute('data-y', response.y);
                field.appendChild(zoomPoint);
                updatePoints();
            }
        }

        //
        // moving map
        //
        
        const zoomBox = document.getElementById('zoom-box');
        const trackMap = document.getElementById('track-map');

        let scale = 1;
        let originX = (zoomBox.offsetWidth - trackMap.offsetWidth) / 2;
        let originY = (zoomBox.offsetHeight - trackMap.offsetHeight) / 2;
        let isDragging = false;
        let startX, startY;

        function setTransform() {
            trackMap.style.transform = `translate(${originX}px, ${originY}px) scale(${scale})`;
            updatePoints();
        }

        function updatePoints() {
            const points = document.querySelectorAll('.zoom-point');
            points.forEach(point => {
                const x = parseFloat(point.dataset.x);
                const y = parseFloat(point.dataset.y);
                point.style.transform = `translate(${x * scale + originX}px, ${y * scale + originY}px)`;
            });
        }

        function clamp(value, min, max) {
            return Math.min(Math.max(value, min), max);
        }

        zoomBox.addEventListener('wheel', (event) => {
            event.preventDefault();
            const rect = zoomBox.getBoundingClientRect();
            const offsetX = event.offsetX;
            const offsetY = event.offsetY;
            const prevScale = scale;
            const zoomFactor = event.deltaY < 0 ? 1.1 : 0.9;
            const newScale = clamp(prevScale * zoomFactor, 1, 14);
            const zoomRatio = newScale / prevScale;

            const mouseX = (offsetX - originX) / scale;
            const mouseY = (offsetY - originY) / scale;

            originX = clamp(offsetX - mouseX * newScale, rect.width - rect.width * newScale, 0);
            originY = clamp(offsetY - mouseY * newScale, rect.height - rect.height * newScale, 0);

            scale = newScale;
            setTransform();
        });


        zoomBox.addEventListener('mousedown', (event) => {
            event.preventDefault();
            isDragging = true;
            startX = event.clientX - originX;
            startY = event.clientY - originY;
            trackMap.style.cursor = 'grabbing';
            document.body.style.userSelect = 'none';
        });

        zoomBox.addEventListener('mouseup', () => {
            isDragging = false;
            trackMap.style.cursor = 'grab';
            document.body.style.userSelect = '';
        });

        zoomBox.addEventListener('mousemove', (event) => {
            if (isDragging) {
                const rect = zoomBox.getBoundingClientRect();
                originX = clamp(event.clientX - startX, rect.width - trackMap.offsetWidth * scale, 0);
                originY = clamp(event.clientY - startY, rect.height - trackMap.offsetHeight * scale, 0);
                setTransform();
            }
        });

        trackMap.ondragstart = () => false;
        window.addEventListener('resize', setTransform);
        setTransform();

    };

    function showDispatches(information){
        document.getElementById('dispatches-page').style.visibility = 'visible';
        document.getElementById('header1').innerHTML = information.self.name;
        document.getElementById('header2').innerHTML = information.self.rank + ' | ' + information.self.job;

        const points1 = document.querySelectorAll('.officer-point');
        points1.forEach(point => point.remove());
        const points2 = document.querySelectorAll('.call-point');
        points2.forEach(point => point.remove());

        //
        // moving map
        //
        
        const zoomBox = document.getElementById('zoom-box2');
        const trackMap = document.getElementById('track-map2');

        let scale = 1;
        let originX = (zoomBox.offsetWidth - trackMap.offsetWidth) / 2;
        let originY = (zoomBox.offsetHeight - trackMap.offsetHeight) / 2;
        let isDragging = false;
        let startX, startY;

        function setTransform() {
            trackMap.style.transform = `translate(${originX}px, ${originY}px) scale(${scale})`;
            updatePoints();
        }

        function updatePoints() {
            const points1 = document.querySelectorAll('.officer-point');
            points1.forEach(point => {
                const x = parseFloat(point.dataset.x);
                const y = parseFloat(point.dataset.y);
                point.style.transform = `translate(${x * scale + originX}px, ${y * scale + originY}px)`;
            });
            const points2 = document.querySelectorAll('.call-point');
            points2.forEach(point => {
                const x = parseFloat(point.dataset.x);
                const y = parseFloat(point.dataset.y);
                point.style.transform = `translate(${x * scale + originX}px, ${y * scale + originY}px)`;
            });
        }

        function clamp(value, min, max) {
            return Math.min(Math.max(value, min), max);
        }

        zoomBox.addEventListener('wheel', (event) => {
            event.preventDefault();
            const rect = zoomBox.getBoundingClientRect();
            const offsetX = event.offsetX;
            const offsetY = event.offsetY;
            const prevScale = scale;
            const zoomFactor = event.deltaY < 0 ? 1.1 : 0.9;
            const newScale = clamp(prevScale * zoomFactor, 1, 14);
            const zoomRatio = newScale / prevScale;

            const mouseX = (offsetX - originX) / scale;
            const mouseY = (offsetY - originY) / scale;

            originX = clamp(offsetX - mouseX * newScale, rect.width - rect.width * newScale, 0);
            originY = clamp(offsetY - mouseY * newScale, rect.height - rect.height * newScale, 0);

            scale = newScale;
            setTransform();
        });


        zoomBox.addEventListener('mousedown', (event) => {
            event.preventDefault();
            isDragging = true;
            startX = event.clientX - originX;
            startY = event.clientY - originY;
            trackMap.style.cursor = 'grabbing';
            document.body.style.userSelect = 'none';
        });

        zoomBox.addEventListener('mouseup', () => {
            isDragging = false;
            trackMap.style.cursor = 'grab';
            document.body.style.userSelect = '';
        });

        zoomBox.addEventListener('mousemove', (event) => {
            if (isDragging) {
                const rect = zoomBox.getBoundingClientRect();
                originX = clamp(event.clientX - startX, rect.width - trackMap.offsetWidth * scale, 0);
                originY = clamp(event.clientY - startY, rect.height - trackMap.offsetHeight * scale, 0);
                setTransform();
            }
        });

        trackMap.ondragstart = () => false;
        window.addEventListener('resize', setTransform);
        setTransform();

        const activeOfficer = document.getElementById('active-officer-page2');
        const callList = document.getElementById('call-list2');
        const officers = information.officers;
        const calls = information.calls;
        activeOfficer.innerHTML = '';
        callList.innerHTML = '';

        document.addEventListener('click', function(event) {
            const menus = document.querySelectorAll('.action-div');
            menus.forEach(menu => {
                if (!menu.contains(event.target)) {
                    menu.remove();
                }
            });
        });


        officers.forEach(officer => {
            if(officer.coords != null){
                const field = document.getElementById('zoom-box2');
                const zoomPoint = document.createElement('div');
                zoomPoint.className = 'officer-point';
                zoomPoint.setAttribute('data-x', 273.7 + officer.coords.x  * 0.0594);
                zoomPoint.setAttribute('data-y', 463.7 - officer.coords.y  * 0.0594);
                field.appendChild(zoomPoint);
                updatePoints();

                zoomPoint.addEventListener('contextmenu', function(event) {
                    event.preventDefault(); 
                    const existingMenus = document.querySelectorAll('.action-div');
                    existingMenus.forEach(menu => menu.remove());
            
                    const actiondiv = document.createElement('div');
                    actiondiv.className = 'action-div';
                    actiondiv.style.position = 'absolute';
                    actiondiv.style.zIndex = 1000; 
                    actiondiv.style.left = `${event.pageX + 10}px`; 
                    actiondiv.style.top = `${event.pageY}px`;
            
                    const officerName = document.createElement('p');
                    officerName.className = 'action-text';
                    officerName.textContent = officer.name;
                    actiondiv.appendChild(officerName);
            
                    const action1 = document.createElement('div');
                    action1.textContent = 'Status Ändern';
                    action1.className = 'action-btn';
                    action1.onclick = () => {};
                    actiondiv.appendChild(action1);
            
                    const action2 = document.createElement('div');
                    action2.textContent = 'Zu Dispatch Hinzufügen';
                    action2.className = 'action-btn';
                    action2.onclick = () => {};
                    actiondiv.appendChild(action2);

                    action1.onclick = function() {

                        if(!(information.self.permissions.dispatchEditOfficer)){
                            showNoPermissions();
                            return;
                        }

                        const menus = document.querySelectorAll('.action-div');
                        menus.forEach(menu => {
                            if (!menu.contains(event.target)) {
                                menu.remove();
                            }
                        });
                        const returnValue = officer.name;
                        axios.post(`https://${GetParentResourceName()}/setOfficerStatus`, {
                            returnValue,
                        });
                    };

                    action2.onclick = function() {

                        if(!(information.self.permissions.dispatchEditOfficer)){
                            showNoPermissions();
                            return;
                        }

                        const menus = document.querySelectorAll('.action-div');
                        menus.forEach(menu => {
                            if (!menu.contains(event.target)) {
                                menu.remove();
                            }
                        });
                        const returnValue = officer.name;
                        axios.post(`https://${GetParentResourceName()}/setOfficerDispatch`, {
                            returnValue,
                        });
                    };
            

                    document.body.appendChild(actiondiv);
                });
            }
            

            const div = document.createElement('div');
            div.className = 'call-field2';
            activeOfficer.appendChild(div);

            const officerName = document.createElement('text');
            officerName.textContent = officer.name;
            div.appendChild(officerName);
            officerName.className = 'active-officer-text-dis';

            const img = document.createElement('img');
            img.src = `img/user.png`;
            img.alt = officer.name; 
            div.appendChild(img);
            img.className = 'officer-img-dis';

            const infoContainer = document.createElement('div');
            infoContainer.className = 'active-officer-info-container-dis';
            div.appendChild(infoContainer);

            const statusColor = getColor(getColorName(officer.status, settings.status));
            const locationColor = getColor(getColorName(officer.location, settings.locations));
            const vehicleColor = getColor(getColorName(officer.vehicle, settings.vehicles));
            const callnameColor = getColor(getColorName(officer.callName, settings.callNames));

            // Status
            const statusContainer = document.createElement('div');
            statusContainer.className = 'active-officer-div-container';
            infoContainer.appendChild(statusContainer);

            const statusImage = document.createElement('div');
            statusImage.className = 'active-officer-status-image fa-solid fa-square-poll-vertical';
            statusContainer.appendChild(statusImage);
            statusImage.style.color = text;
            statusImage.style.backgroundColor = statusColor;
            statusImage.style.borderColor = statusColor;

            const officerStatus = document.createElement('text');
            officerStatus.textContent = 'Status: ' + officer.status;
            statusContainer.appendChild(officerStatus);
            officerStatus.className = 'active-officer-status';
            officerStatus.style.color = text;
            officerStatus.style.backgroundColor = statusColor
            officerStatus.style.borderColor = statusColor;

            // Callname
            const callnameContainer = document.createElement('div');
            callnameContainer.className = 'active-officer-div-container';
            infoContainer.appendChild(callnameContainer);

            const callnameImage = document.createElement('div');
            callnameImage.className = 'active-officer-status-image fa-solid fa-user';
            callnameContainer.appendChild(callnameImage);
            callnameImage.style.color = text;
            callnameImage.style.backgroundColor = callnameColor;
            callnameImage.style.borderColor = callnameColor;

            const callnameText = document.createElement('text');
            callnameText.textContent = officer.callName + '-' + officer.callNumber;
            callnameContainer.appendChild(callnameText);
            callnameText.className = 'active-officer-status';
            callnameText.style.color = text;
            callnameText.style.backgroundColor = callnameColor
            callnameText.style.borderColor = callnameColor;


            const statusbtn = document.createElement('div');
            statusbtn.className = 'dispatches-officer-status fa-solid fa-square-poll-vertical';
            div.appendChild(statusbtn);

            const namebtn = document.createElement('div');
            namebtn.className = 'dispatches-officer-name fa-solid fa-location-crosshairs';
            div.appendChild(namebtn);

            statusbtn.onclick = function() {

                if(!(information.self.permissions.dispatchEditOfficer)){
                    showNoPermissions();
                    return;
                }

                const returnValue = officer.name;
                axios.post(`https://${GetParentResourceName()}/setOfficerStatus`, {
                    returnValue,
                });
            };

            namebtn.onclick = function() {

                if(!(information.self.permissions.dispatchEditOfficer)){
                    showNoPermissions();
                    return;
                }

                const returnValue = officer.name;
                axios.post(`https://${GetParentResourceName()}/setOfficerDispatch`, {
                    returnValue,
                });
            };
        }); 

        calls.forEach(call => {

            const field = document.getElementById('zoom-box2');
            const zoomPoint = document.createElement('div');
            zoomPoint.className = 'call-point';
            zoomPoint.setAttribute('data-x', 273.7 + call.coords.x  * 0.0594);
            zoomPoint.setAttribute('data-y', 463.7 - call.coords.y  * 0.0594);
            field.appendChild(zoomPoint);
            updatePoints();

            zoomPoint.addEventListener('contextmenu', function(event) {
                event.preventDefault(); 
                const existingMenus = document.querySelectorAll('.action-div2');
                existingMenus.forEach(menu => menu.remove());
        
                const actiondiv = document.createElement('div');
                actiondiv.className = 'action-div';
                actiondiv.style.position = 'absolute';
                actiondiv.style.zIndex = 1000; 
                actiondiv.style.left = `${event.pageX + 10}px`; 
                actiondiv.style.top = `${event.pageY}px`;
        
                const officerName = document.createElement('p');
                officerName.className = 'action-text';
                officerName.textContent = call.code + ' - ' + call.reason;
                actiondiv.appendChild(officerName);
        
                const action1 = document.createElement('div');
                action1.textContent = 'Status Ändern';
                action1.className = 'action-btn';
                action1.onclick = () => {};
                actiondiv.appendChild(action1);
        
                const action2 = document.createElement('div');
                action2.textContent = 'Status Löschen';
                action2.className = 'action-btn';
                action2.onclick = () => {};
                actiondiv.appendChild(action2);

                const action3 = document.createElement('div');
                action3.textContent = 'Beamte Einteilen';
                action3.className = 'action-btn';
                action3.onclick = () => {};
                actiondiv.appendChild(action3);


                action1.onclick = function() {

                    if(!(information.self.permissions.dispatchEditDispatch)){
                        showNoPermissions();
                        return;
                    }

                    const menus = document.querySelectorAll('.action-div');
                    menus.forEach(menu => {
                        if (!menu.contains(event.target)) {
                            menu.remove();
                        }
                    });
                    returnValue = call.identifier;
                    returnPage = true;
                    axios.post(`https://${GetParentResourceName()}/editDispatch`, {
                        returnValue,
                        returnPage,
                    }).then((response) => {
                        showMenu(response.information, response.settings, response.page); 
                    })
                };
                action2.onclick = function() {

                    if(!(information.self.permissions.dispatchEditDispatch)){
                        showNoPermissions();
                        return;
                    }

                    const menus = document.querySelectorAll('.action-div');
                    menus.forEach(menu => {
                        if (!menu.contains(event.target)) {
                            menu.remove();
                        }
                    });
                    returnValue = call.identifier;
                    returnPage = true;
                    axios.post(`https://${GetParentResourceName()}/deleteDispatch`, {
                        returnValue,
                        returnPage,
                    }).then((response) => {
                        showMenu(response.information, response.settings, response.page); 
                    })
                };
                action3.onclick = function() {

                    if(!(information.self.permissions.dispatchEditDispatch)){
                        showNoPermissions();
                        return;
                    }

                    const menus = document.querySelectorAll('.action-div');
                    menus.forEach(menu => {
                        if (!menu.contains(event.target)) {
                            menu.remove();
                        }
                    });
                    returnValue = call.identifier;
                    returnPage = true;
                    axios.post(`https://${GetParentResourceName()}/officerDispatch`, {
                        returnValue,
                        returnPage,
                    }).then((response) => {
                        showMenu(response.information, response.settings, response.page); 
                    })
                };
        

                document.body.appendChild(actiondiv);
            });

            const div = document.createElement('div');
            div.className = 'call-field2';
            callList.appendChild(div);

            const statusColor = getColor(getColorName(call.code, settings.callStatus));

            const statusContainer = document.createElement('div');
            statusContainer.className = 'call-code';
            statusContainer.innerText = call.code;
            statusContainer.style.backgroundColor = statusColor;
            div.appendChild(statusContainer);

            const callReason = document.createElement('div');
            callReason.className = 'call-reason';
            callReason.innerText = call.reason;
            div.appendChild(callReason);

            const informationContainer = document.createElement('div');
            informationContainer.className = 'call-informations';
            div.appendChild(informationContainer);

            //time
            const timeContainer = document.createElement('div');
            timeContainer.className = 'call-informations-divs';
            informationContainer.appendChild(timeContainer);

            const callTimeImage = document.createElement('div');
            callTimeImage.className = 'fa-solid fa-clock';
            timeContainer.appendChild(callTimeImage);

            const callTimeText = document.createElement('div');
            callTimeText.className = 'information-text-divs';
            callTimeText.innerText = call.time;
            timeContainer.appendChild(callTimeText);


            //location
            const locationContainer = document.createElement('div');
            locationContainer.className = 'call-informations-divs';
            informationContainer.appendChild(locationContainer);

            const callLocationImage = document.createElement('div');
            callLocationImage.className = 'fa-solid fa-location-crosshairs';
            locationContainer.appendChild(callLocationImage);

            const callLocationText = document.createElement('div');
            callLocationText.className = 'information-text-divs';
            callLocationText.innerText = call.location;
            locationContainer.appendChild(callLocationText);

            //information
            const infoContainer = document.createElement('div');
            infoContainer.className = 'call-informations-divs';
            informationContainer.appendChild(infoContainer);

            const callInfoImage = document.createElement('div');
            callInfoImage.className = 'fa-solid fa-circle-question';
            infoContainer.appendChild(callInfoImage);

            const callInfoText = document.createElement('div');
            callInfoText.className = 'information-text-divs';
            callInfoText.innerText = call.infos;
            infoContainer.appendChild(callInfoText);

            //buttons
            const edit = document.createElement('div');
            edit.className = 'general-info-edit fa-solid fa-pen-to-square';
            div.appendChild(edit);

            const ndelete = document.createElement('div');
            ndelete.className = 'general-info-delete fa-solid fa-trash';
            div.appendChild(ndelete);

            const officer = document.createElement('div');
            officer.className = 'general-info-officer fa-solid fa-user';
            div.appendChild(officer);

            edit.onclick = function() {

                if(!(information.self.permissions.dispatchEditDispatch)){
                    showNoPermissions();
                    return;
                }

                returnValue = call.identifier;
                returnPage = true;
                axios.post(`https://${GetParentResourceName()}/editDispatch`, {
                    returnValue,
                    returnPage,
                }).then((response) => {
                    showMenu(response.information, response.settings, response.page); 
                })
            };
            ndelete.onclick = function() {

                if(!(information.self.permissions.dispatchEditDispatch)){
                    showNoPermissions();
                    return;
                }

                returnValue = call.identifier;
                returnPage = true;
                axios.post(`https://${GetParentResourceName()}/deleteDispatch`, {
                    returnValue,
                    returnPage,
                }).then((response) => {
                    showMenu(response.information, response.settings, response.page); 
                })
            };
            officer.onclick = function() {

                if(!(information.self.permissions.dispatchEditDispatch)){
                    showNoPermissions();
                    return;
                }

                returnValue = call.identifier;
                returnPage = true;
                axios.post(`https://${GetParentResourceName()}/officerDispatch`, {
                    returnValue,
                    returnPage,
                }).then((response) => {
                    showMenu(response.information, response.settings, response.page); 
                })
            };
        }); 


        

    };

    function showListen(information){
        document.getElementById('listen-page').style.visibility = 'visible';
        document.getElementById('header1').innerHTML = information.self.name;
        document.getElementById('header2').innerHTML = information.self.rank + ' | ' + information.self.job;


        const listBtn = document.querySelectorAll('.list-btn');
        function resetBtn() {
            listBtn.forEach(btn => {
                btn.style.color = text;
            });
        }


        document.getElementById('l-officer').onclick = function() {
            resetBtn();
            document.getElementById('l-officer').style.color = blue;

            showListOfficers();
            function showListOfficers(){
                axios.post(`https://${GetParentResourceName()}/listGetOfficers`, {}).then((response) => {
                    const officers = response.data;
                    const page = document.getElementById('list-body');

                    const remove = document.querySelectorAll('.officer-categorie-div');
                    remove.forEach(point => point.remove());
                    const remove2 = document.querySelectorAll('.outfit-list-page');
                    remove2.forEach(point => point.remove());
                    const remove3 = document.querySelectorAll('.status-list-page');
                    remove3.forEach(point => point.remove());
                    const remove4 = document.querySelectorAll('.call-list-page');
                    remove4.forEach(point => point.remove());
                    const remove5 = document.querySelectorAll('.fqz-list-page');
                    remove5.forEach(point => point.remove());
                    const remove6 = document.querySelectorAll('.todo-list-page');
                    remove6.forEach(point => point.remove());


                    officers.forEach((grade, index) => {

                        const categorieDiv = document.createElement('div');
                        categorieDiv.className = 'officer-categorie-div';
                        page.appendChild(categorieDiv);
        
                        const categorieHeader = document.createElement('div');
                        categorieHeader.className = 'officer-categorie-header';
                        categorieHeader.innerText = grade.label;
                        categorieHeader.style.color = text;
                        categorieDiv.appendChild(categorieHeader);

                        if(index == 0){
                            const oPlus = document.createElement('div');
                            oPlus.className = 'add-plus';
                            oPlus.innerText = "+";
                            categorieHeader.appendChild(oPlus);

                            oPlus.onclick = function() {

                                if(!(information.self.permissions.createListEmployee)){
                                    showNoPermissions();
                                    return;
                                }
                        
                                axios.post(`https://${GetParentResourceName()}/officerAdd`, {
                                }).then(() => {
                                    showListOfficers();
                                })
                            };
                        }
        
                        const categorieOfficer = document.createElement('div');
                        categorieOfficer.className = 'officer-categorie-officer';
                        categorieDiv.appendChild(categorieOfficer);

                        const allOfficers = grade.officers;
                        allOfficers.forEach(officer => {
                            const categorieHeader = document.createElement('div');
                            categorieHeader.className = 'officer-categorie-individual';
                            categorieOfficer.appendChild(categorieHeader);

                            const oName = document.createElement('div');
                            oName.className = 'officer-list-individual-info';
                            oName.innerText = officer.firstname;
                            categorieHeader.appendChild(oName);

                            const oName2 = document.createElement('div');
                            oName2.className = 'officer-list-individual-info';
                            oName2.innerText = officer.lastname;
                            categorieHeader.appendChild(oName2);

                            const oDob = document.createElement('div');
                            oDob.className = 'officer-list-individual-info';
                            oDob.innerText = officer.dob;
                            categorieHeader.appendChild(oDob);

                            const oPhoneNumber = document.createElement('div');
                            oPhoneNumber.className = 'officer-list-individual-info';
                            oPhoneNumber.innerText = officer.phoneNumber;
                            categorieHeader.appendChild(oPhoneNumber);

                            const oCallNumber = document.createElement('div');
                            oCallNumber.className = 'officer-list-individual-info';
                            oCallNumber.innerText = officer.callNumber;
                            categorieHeader.appendChild(oCallNumber);

                            const oBadgeNumber = document.createElement('div');
                            oBadgeNumber.className = 'officer-list-individual-info';
                            oBadgeNumber.innerText = officer.badgeNumber;
                            categorieHeader.appendChild(oBadgeNumber);

                            const oBtn = document.createElement('div');
                            oBtn.className = 'officer-list-individual-info list-officer-btn';
                            categorieHeader.appendChild(oBtn);

                            const oFire = document.createElement('div');
                            oFire.className = 'fa-solid fa-fire list-officer-btn-one';
                            oBtn.appendChild(oFire);

                            const oEdit = document.createElement('div');
                            oEdit.className = 'fa-solid fa-pen-to-square list-officer-btn-one';
                            oBtn.appendChild(oEdit);

                            const oInfo = document.createElement('div');
                            oInfo.className = 'fa-solid fa-circle-info list-officer-btn-one';
                            oBtn.appendChild(oInfo);

                            const oList = document.createElement('div');
                            oList.className = 'fa-solid fa-list list-officer-btn-one';
                            oBtn.appendChild(oList);

                            oFire.onclick = function() {

                                if(!(information.self.permissions.editListEmployee)){
                                    showNoPermissions();
                                    return;
                                }

                                axios.post(`https://${GetParentResourceName()}/officerListFire`, {
                                    officer,
                                }).then(() => {
                                    showListOfficers();
                                })
                            };

                            oEdit.onclick = function() {

                                if(!(information.self.permissions.editListEmployee)){
                                    showNoPermissions();
                                    return;
                                }

                                axios.post(`https://${GetParentResourceName()}/officerListEdit`, {
                                    officer,
                                }).then((response) => {
                                    showListOfficers();
                                })
                            };

                            oInfo.onclick = function() {

                                if(!(information.self.permissions.editListEmployee)){
                                    showNoPermissions();
                                    return;
                                }

                                axios.post(`https://${GetParentResourceName()}/officerListInfo`, {
                                    officer,
                                }).then(() => {showListOfficers();})
                            };

                            oList.onclick = function() {

                                if(!(information.self.permissions.editListEmployee)){
                                    showNoPermissions();
                                    return;
                                }

                                axios.post(`https://${GetParentResourceName()}/officerListList`, {
                                    officer,
                                }).then(() => {showListOfficers();})
                            };


                        });
                    });
                })
            }

        };
        document.getElementById('l-vehicles').onclick = function() {
            resetBtn();
            document.getElementById('l-vehicles').style.color = blue;
            
            showListVehicles();
            function showListVehicles(){
                axios.post(`https://${GetParentResourceName()}/listGetVehicles`, {}).then((response) => {
                    const vehicles = response.data;
                    const page = document.getElementById('list-body');

                    const remove = document.querySelectorAll('.officer-categorie-div');
                    remove.forEach(point => point.remove());
                    const remove2 = document.querySelectorAll('.outfit-list-page');
                    remove2.forEach(point => point.remove());
                    const remove3 = document.querySelectorAll('.status-list-page');
                    remove3.forEach(point => point.remove());
                    const remove4 = document.querySelectorAll('.call-list-page');
                    remove4.forEach(point => point.remove());
                    const remove5 = document.querySelectorAll('.fqz-list-page');
                    remove5.forEach(point => point.remove());
                    const remove6 = document.querySelectorAll('.todo-list-page');
                    remove6.forEach(point => point.remove());

                    vehicles.forEach((veh, index) => {

                        const categorieDiv = document.createElement('div');
                        categorieDiv.className = 'officer-categorie-div';
                        page.appendChild(categorieDiv);
        
                        const categorieHeader = document.createElement('div');
                        categorieHeader.className = 'officer-categorie-header';
                        categorieHeader.innerText = veh.label;
                        categorieHeader.style.color = text;
                        categorieDiv.appendChild(categorieHeader);

                        
                        const oPlus = document.createElement('div');
                        oPlus.className = 'add-plus';
                        oPlus.innerText = "+";
                        categorieHeader.appendChild(oPlus);

                        oPlus.onclick = function() {

                            if(!(information.self.permissions.createListVehicle)){
                                showNoPermissions();
                                return;
                            }

                            axios.post(`https://${GetParentResourceName()}/vehicleAdd`, {
                                returnValue: veh,
                                all: vehicles,
                            }).then(() => {
                                showListVehicles();
                            })
                        };
                        
        
                        const categorieOfficer = document.createElement('div');
                        categorieOfficer.className = 'officer-categorie-officer';
                        categorieDiv.appendChild(categorieOfficer);

                        const allVehs = veh.vehicles;
                        allVehs.forEach(vehicle => {

                            const categorieHeader = document.createElement('div');
                            categorieHeader.className = 'officer-categorie-individual';
                            categorieOfficer.appendChild(categorieHeader);

                            const vName = document.createElement('div');
                            vName.className = 'officer-list-individual-info';
                            vName.innerText = vehicle.label;
                            categorieHeader.appendChild(vName);

                            const vGrade = document.createElement('div');
                            vGrade.className = 'officer-list-individual-info';
                            vGrade.innerText = vehicle.grade;
                            categorieHeader.appendChild(vGrade);

                            const vPrice = document.createElement('div');
                            vPrice.className = 'officer-list-individual-info';
                            vPrice.innerText = vehicle.price+"$";
                            categorieHeader.appendChild(vPrice);

                            const vBtn = document.createElement('div');
                            vBtn.className = 'officer-list-individual-info list-officer-btn';
                            vBtn.style.width = '50%',
                            categorieHeader.appendChild(vBtn);

                            const vEdit = document.createElement('div');
                            vEdit.className = 'fa-solid fa-pen-to-square list-officer-btn-one';
                            vBtn.appendChild(vEdit);

                            const vDel = document.createElement('div');
                            vDel.className = 'fa-solid fa-trash list-officer-btn-one';
                            vBtn.appendChild(vDel);

                            vEdit.onclick = function() {

                                if(!(information.self.permissions.editListVehicle)){
                                    showNoPermissions();
                                    return;
                                }

                                axios.post(`https://${GetParentResourceName()}/vehicleListEdit`, {
                                    vehicle,
                                }).then(() => {showListVehicles();})
                            };

                            vDel.onclick = function() {

                                if(!(information.self.permissions.editListVehicle)){
                                    showNoPermissions();
                                    return;
                                }

                                axios.post(`https://${GetParentResourceName()}/vehicleListDelete`, {
                                    vehicle,
                                }).then(() => {showListVehicles();})
                            };

                        });
                    });

                });
            };
        };
        document.getElementById('l-outfits').onclick = function() {
            resetBtn();
            document.getElementById('l-outfits').style.color = blue;

            showListOutfits();
            function showListOutfits(){
                axios.post(`https://${GetParentResourceName()}/listGetOutfits`, {}).then((response) => {
                    const outfits = response.data;
                    const page = document.getElementById('list-body');

                    const remove = document.querySelectorAll('.officer-categorie-div');
                    remove.forEach(point => point.remove());
                    const remove2 = document.querySelectorAll('.outfit-list-page');
                    remove2.forEach(point => point.remove());
                    const remove3 = document.querySelectorAll('.status-list-page');
                    remove3.forEach(point => point.remove());
                    const remove4 = document.querySelectorAll('.call-list-page');
                    remove4.forEach(point => point.remove());
                    const remove5 = document.querySelectorAll('.fqz-list-page');
                    remove5.forEach(point => point.remove());
                    const remove6 = document.querySelectorAll('.todo-list-page');
                    remove6.forEach(point => point.remove());

                    const oPage = document.createElement('div');
                    oPage.className = 'outfit-list-page';
                    page.appendChild(oPage);

                    outfits.forEach(outfit => {
                        const categorieHeader = document.createElement('div');
                        categorieHeader.className = 'outfit-list-page-div';
                        oPage.appendChild(categorieHeader);

                        const categorieFooter= document.createElement('div');
                        categorieFooter.className = 'outfit-list-page-div-footer';
                        categorieHeader.appendChild(categorieFooter);

                        const categorieLabel = document.createElement('div');
                        categorieLabel.className = 'outfit-list-page-label';
                        categorieLabel.innerText = outfit.label;
                        categorieHeader.appendChild(categorieLabel);

                        const categorieGrade = document.createElement('div');
                        categorieGrade.className = 'outfit-list-page-label';
                        categorieGrade.innerText = outfit.mingrade;
                        categorieHeader.appendChild(categorieGrade);

                        const categorieUnit = document.createElement('div');
                        categorieUnit.className = 'outfit-list-page-label';
                        categorieUnit.innerText = outfit.unit;
                        categorieHeader.appendChild(categorieUnit);

                        const oEdit = document.createElement('span');
                        oEdit.className = 'fa-solid fa-pen-to-square list-outfits-btn-edit';
                        categorieHeader.appendChild(oEdit);

                        const oDel = document.createElement('span');
                        oDel.className = 'fa-solid fa-trash list-outfits-btn-del';
                        categorieHeader.appendChild(oDel);

                        const oInfo = document.createElement('span');
                        oInfo.className = 'fa-solid fa-circle-info list-outfits-btn-info';
                        categorieHeader.appendChild(oInfo);

                        oEdit.onclick = function() {

                            if(!(information.self.permissions.editListOutfit)){
                                showNoPermissions();
                                return;
                            }

                            axios.post(`https://${GetParentResourceName()}/outfitsListEdit`, {
                                outfit,
                            }).then(() => {showListOutfits();})
                        };

                        oDel.onclick = function() {

                            if(!(information.self.permissions.editListOutfit)){
                                showNoPermissions();
                                return;
                            }

                            axios.post(`https://${GetParentResourceName()}/outfitsListDelete`, {
                                outfit,
                            }).then(() => {showListOutfits();})
                        };

                        oInfo.onclick = function() {

                            if(!(information.self.permissions.editListOutfit)){
                                showNoPermissions();
                                return;
                            }

                            axios.post(`https://${GetParentResourceName()}/outfitsListInfo`, {
                                outfit,
                            })
                        };

                        const oImg = document.createElement('img');
                        oImg.className = 'list-outfits-img';
                        oImg.src = outfit.url;
                        categorieHeader.appendChild(oImg);
                    })

                    const categoriePlus = document.createElement('div');
                    categoriePlus.className = 'outfit-list-page-div outfit-list-add';
                    categoriePlus.innerText = '+';
                    oPage.appendChild(categoriePlus);

                    categoriePlus.onclick = function() {

                        if(!(information.self.permissions.createListOutfit)){
                            showNoPermissions();
                            return;
                        }

                        axios.post(`https://${GetParentResourceName()}/outfitsListAdd`, {
                            outfits,
                        }).then(() => {showListOutfits();})
                    };
            
                });
            };
        };
        document.getElementById('l-codecalls').onclick = function() {
            resetBtn();
            document.getElementById('l-codecalls').style.color = blue;

            showListCalls();
            function showListCalls(){
                axios.post(`https://${GetParentResourceName()}/listGetCodes`, {}).then((response) => {
                    const codes = response.data.codes;
                    const status = response.data.status;
                    const frequencys = response.data.frequency;
                    const page = document.getElementById('list-body');

                    const remove = document.querySelectorAll('.officer-categorie-div');
                    remove.forEach(point => point.remove());
                    const remove2 = document.querySelectorAll('.outfit-list-page');
                    remove2.forEach(point => point.remove());
                    const remove3 = document.querySelectorAll('.status-list-page');
                    remove3.forEach(point => point.remove());
                    const remove4 = document.querySelectorAll('.call-list-page');
                    remove4.forEach(point => point.remove());
                    const remove5 = document.querySelectorAll('.fqz-list-page');
                    remove5.forEach(point => point.remove());
                    const remove6 = document.querySelectorAll('.todo-list-page');
                    remove6.forEach(point => point.remove());

                    const sPage = document.createElement('div');
                    sPage.className = 'status-list-page';
                    page.appendChild(sPage);

                    const cPage = document.createElement('div');
                    cPage.className = 'call-list-page';
                    page.appendChild(cPage);

                    const fPage = document.createElement('div');
                    fPage.className = 'fqz-list-page';
                    page.appendChild(fPage);


                    status.forEach(std => {
                        if(std.status != 'n/A'){
                            const sDiv = document.createElement('div');
                            sDiv.className = 'status-list-page-div';
                            sPage.appendChild(sDiv);

                            const sHeader = document.createElement('div');
                            sHeader.className = 'status-list-page-div-header';
                            sHeader.innerText = std.status;
                            sDiv.appendChild(sHeader);

                            const sMeaning = document.createElement('div');
                            sMeaning.className = 'status-list-page-div-meaning';
                            sMeaning.innerText = std.meaning;
                            sDiv.appendChild(sMeaning);

                            const sColor = document.createElement('div');
                            sColor.className = 'status-list-page-div-color';
                            sColor.style.backgroundColor = getColor(getColorName(std.status, settings.status));
                            sColor.style.top = (-1) * sDiv.clientHeight + 'px';
                            sDiv.appendChild(sColor);
                        }
                    })

                    codes.forEach(cds => {
                        if(cds.status != 'n/A'){
                            const sDiv = document.createElement('div');
                            sDiv.className = 'status-list-page-div';
                            cPage.appendChild(sDiv);

                            const sHeader = document.createElement('div');
                            sHeader.className = 'status-list-page-div-header';
                            sHeader.innerText = cds.status;
                            sDiv.appendChild(sHeader);

                            const sMeaning = document.createElement('div');
                            sMeaning.className = 'status-list-page-div-meaning';
                            sMeaning.innerText = cds.meaning;
                            sDiv.appendChild(sMeaning);

                            const sColor = document.createElement('div');
                            sColor.className = 'status-list-page-div-color';
                            sColor.style.backgroundColor = getColor(getColorName(cds.status, settings.callStatus));
                            sColor.style.top = (-1) * sDiv.clientHeight + 'px';
                            sDiv.appendChild(sColor);
                        }
                    })

                    frequencys.forEach(frequency => {
                        if(frequency.status != 'n/A'){
                            const sDiv = document.createElement('div');
                            sDiv.className = 'status-list-page-div';
                            fPage.appendChild(sDiv);

                            const sHeader = document.createElement('div');
                            sHeader.className = 'status-list-page-div-header';
                            sHeader.innerText = frequency.status;
                            sDiv.appendChild(sHeader);

                            const sMeaning = document.createElement('div');
                            sMeaning.className = 'status-list-page-div-meaning';
                            sMeaning.innerText = frequency.meaning;
                            sDiv.appendChild(sMeaning);

                            const sColor = document.createElement('div');
                            sColor.className = 'status-list-page-div-color';
                            sColor.style.backgroundColor = getColor(getColorName(frequency.status, settings.frequency));
                            sColor.style.top = (-1) * sDiv.clientHeight + 'px';
                            sDiv.appendChild(sColor);
                        }
                    })
                });
            };

            
        };
        document.getElementById('l-todos').onclick = function() {
            resetBtn();
            document.getElementById('l-todos').style.color = blue;

            showListTodos();
            function showListTodos(){
                axios.post(`https://${GetParentResourceName()}/listGetTodos`, {}).then((response) => {
                    const todos = response.data;
                    const page = document.getElementById('list-body');

                    const remove = document.querySelectorAll('.officer-categorie-div');
                    remove.forEach(point => point.remove());
                    const remove2 = document.querySelectorAll('.outfit-list-page');
                    remove2.forEach(point => point.remove());
                    const remove3 = document.querySelectorAll('.status-list-page');
                    remove3.forEach(point => point.remove());
                    const remove4 = document.querySelectorAll('.call-list-page');
                    remove4.forEach(point => point.remove());
                    const remove5 = document.querySelectorAll('.fqz-list-page');
                    remove5.forEach(point => point.remove());
                    const remove6 = document.querySelectorAll('.todo-list-page');
                    remove6.forEach(point => point.remove());

                    const todoPage = document.createElement('div');
                    todoPage.className = 'todo-list-page';
                    page.appendChild(todoPage);


                    todos.forEach(todo => {
                        
                        const tDiv = document.createElement('div');
                        tDiv.className = 'todo-list-page-div';
                        todoPage.appendChild(tDiv);

                        const tName = document.createElement('div');
                        tName.className = 'officer-list-individual-info';
                        tName.innerText = todo.label;
                        tDiv.appendChild(tName);

                        const tDesc = document.createElement('div');
                        tDesc.className = 'officer-list-individual-info';
                        tDesc.innerText = todo.description;
                        tDiv.appendChild(tDesc);

                        const tOffc = document.createElement('div');
                        tOffc.className = 'officer-list-individual-info';
                        tOffc.innerText = todo.officer;
                        tDiv.appendChild(tOffc);

                        const tStd = document.createElement('div');
                        tStd.style.width = '50%';
                        if (todo.status == 0){
                            tStd.className = 'officer-list-individual-info fa-regular fa-square todo-list-btn';
                        }else {
                            tStd.className = 'officer-list-individual-info fa-regular fa-square-check todo-list-btn';
                        }
                        tDiv.appendChild(tStd);

                        const tBtn = document.createElement('div');
                        tBtn.className = 'officer-list-individual-info list-officer-btn';
                        tBtn.style.width = '50%';
                        tDiv.appendChild(tBtn);

                        const vEdit = document.createElement('div');
                        vEdit.className = 'fa-solid fa-pen-to-square list-officer-btn-one';
                        tBtn.appendChild(vEdit);

                        const vDel = document.createElement('div');
                        vDel.className = 'fa-solid fa-trash list-officer-btn-one';
                        tBtn.appendChild(vDel);

                        tStd.onclick = function() {

                            if(!(information.self.permissions.checkListTodo)){
                                showNoPermissions();
                                return;
                            }

                            axios.post(`https://${GetParentResourceName()}/todoListCheck`, {
                                todo,
                            }).then(() => {showListTodos();})
                        };

                        vDel.onclick = function() {

                            if(!(information.self.permissions.editListTodo)){
                                showNoPermissions();
                                return;
                            }

                            axios.post(`https://${GetParentResourceName()}/todoListDelete`, {
                                todo,
                            }).then(() => {showListTodos();})
                        };

                        vEdit.onclick = function() {

                            if(!(information.self.permissions.editListTodo)){
                                showNoPermissions();
                                return;
                            }

                            axios.post(`https://${GetParentResourceName()}/todoListEdit`, {
                                todo,
                            }).then(() => {showListTodos();})
                        };
                    });

                    const todoPlus = document.createElement('div');
                    todoPlus.className = 'todo-list-page-div-plus';
                    todoPlus.innerText = '+';
                    todoPage.appendChild(todoPlus);

                    todoPlus.onclick = function() {

                        if(!(information.self.permissions.createListTodo)){
                            showNoPermissions();
                            return;
                        }

                        axios.post(`https://${GetParentResourceName()}/todoListAdd`, {
                        }).then(() => {showListTodos();})
                    };
                });
            };
        };
        document.getElementById('l-law').onclick = function() {
            resetBtn();
            document.getElementById('l-law').style.color = blue;

            showListTodos();
            function showListTodos(){
                axios.post(`https://${GetParentResourceName()}/listGetLaw`, {}).then((response) => {
                    const laws = response.data.law;
                    const lawSettings = response.data.settings;
                    const page = document.getElementById('list-body');

                    const remove = document.querySelectorAll('.officer-categorie-div');
                    remove.forEach(point => point.remove());
                    const remove2 = document.querySelectorAll('.outfit-list-page');
                    remove2.forEach(point => point.remove());
                    const remove3 = document.querySelectorAll('.status-list-page');
                    remove3.forEach(point => point.remove());
                    const remove4 = document.querySelectorAll('.call-list-page');
                    remove4.forEach(point => point.remove());
                    const remove5 = document.querySelectorAll('.fqz-list-page');
                    remove5.forEach(point => point.remove());
                    const remove6 = document.querySelectorAll('.todo-list-page');
                    remove6.forEach(point => point.remove());


                    laws.forEach((law, index) => {

                        const categorieDiv = document.createElement('div');
                        categorieDiv.className = 'officer-categorie-div';
                        page.appendChild(categorieDiv);
        
                        const categorieHeader = document.createElement('div');
                        categorieHeader.className = 'officer-categorie-header';
                        categorieHeader.innerText = law.categorie;
                        categorieHeader.style.color = text;
                        categorieDiv.appendChild(categorieHeader);

                        const categorieOfficer = document.createElement('div');
                        categorieOfficer.className = 'officer-categorie-officer';
                        categorieDiv.appendChild(categorieOfficer);

                        const allLaws = law.paragraphs;
                        allLaws.forEach(lw => {
                            const categorieHeader = document.createElement('div');
                            categorieHeader.className = 'officer-categorie-individual';
                            categorieOfficer.appendChild(categorieHeader);

                            const oName = document.createElement('div');
                            oName.className = 'officer-list-individual-info';
                            oName.innerText = lw.label;
                            categorieHeader.appendChild(oName);

                            const oDesc = document.createElement('div');
                            oDesc.className = 'officer-list-individual-info';
                            oDesc.innerText = lw.description;
                            categorieHeader.appendChild(oDesc);

                            const oFine = document.createElement('div');
                            oFine.className = 'officer-list-individual-info';
                            oFine.innerText = lawSettings.fine.prefix + lw.fine + lawSettings.fine.suffix;
                            categorieHeader.appendChild(oFine);

                            const oJail = document.createElement('div');
                            oJail.className = 'officer-list-individual-info';
                            oJail.innerText = lawSettings.prison.prefix + lw.prison + lawSettings.prison.suffix;
                            categorieHeader.appendChild(oJail);

                            const oWork = document.createElement('div');
                            oWork.className = 'officer-list-individual-info';
                            oWork.innerText = lawSettings.c_service.prefix + (lw.c_service || 0) + lawSettings.c_service.suffix;
                            categorieHeader.appendChild(oWork);
                        });
                    });
                });
            };
        };
        document.getElementById('l-ausbildungen').onclick = function() {
            resetBtn();
            document.getElementById('l-ausbildungen').style.color = blue;

            showListAusbildungen();
            function showListAusbildungen(){
                axios.post(`https://${GetParentResourceName()}/listGetAusbildungen`, {}).then((response) => {
                    const ausbildungen = response.data;
                    const page = document.getElementById('list-body');

                    const remove = document.querySelectorAll('.officer-categorie-div');
                    remove.forEach(point => point.remove());
                    const remove2 = document.querySelectorAll('.outfit-list-page');
                    remove2.forEach(point => point.remove());
                    const remove3 = document.querySelectorAll('.status-list-page');
                    remove3.forEach(point => point.remove());
                    const remove4 = document.querySelectorAll('.call-list-page');
                    remove4.forEach(point => point.remove());
                    const remove5 = document.querySelectorAll('.fqz-list-page');
                    remove5.forEach(point => point.remove());
                    const remove6 = document.querySelectorAll('.todo-list-page');
                    remove6.forEach(point => point.remove());

                    const ausbildungenPage = document.createElement('div');
                    ausbildungenPage.className = 'todo-list-page';
                    page.appendChild(ausbildungenPage);


                    ausbildungen.forEach(ausbildung => {
                        
                        const tDiv = document.createElement('div');
                        tDiv.className = 'todo-list-page-div';
                        ausbildungenPage.appendChild(tDiv);

                        const tName = document.createElement('div');
                        tName.className = 'officer-list-individual-info';
                        tName.innerText = ausbildung.label;
                        tDiv.appendChild(tName);

                        const tDesc = document.createElement('div');
                        tDesc.className = 'officer-list-individual-info';
                        tDesc.style.width = '150%';
                        tDesc.innerText = ausbildung.description;
                        tDiv.appendChild(tDesc);

                        const tOffc = document.createElement('div');
                        tOffc.className = 'officer-list-individual-info';
                        tOffc.innerText = ausbildung.supervisor;
                        tDiv.appendChild(tOffc);

                        const tTime = document.createElement('div');
                        tTime.className = 'officer-list-individual-info';
                        tTime.innerText = ausbildung.time;
                        tDiv.appendChild(tTime);

                        const tAsgnd = document.createElement('div');
                        tAsgnd.style.width = '50%';
                        if (ausbildung.asigned == false){
                            tAsgnd.className = 'officer-list-individual-info fa-regular fa-square todo-list-btn';
                        }else {
                            tAsgnd.className = 'officer-list-individual-info fa-regular fa-square-check todo-list-btn';
                        }
                        tDiv.appendChild(tAsgnd);

                        const tBtn = document.createElement('div');
                        tBtn.className = 'officer-list-individual-info list-officer-btn';
                        tBtn.style.width = '50%';
                        tDiv.appendChild(tBtn);

                        const vEdit = document.createElement('div');
                        vEdit.className = 'fa-solid fa-pen-to-square list-officer-btn-one';
                        tBtn.appendChild(vEdit);

                        const vDel = document.createElement('div');
                        vDel.className = 'fa-solid fa-trash list-officer-btn-one';
                        tBtn.appendChild(vDel);

                        tAsgnd.onclick = function() {

                            if(!(information.self.permissions.checkListTraining)){
                                showNoPermissions();
                                return;
                            }

                            axios.post(`https://${GetParentResourceName()}/ausbildungListAsign`, {
                                ausbildung,
                            }).then(() => {showListAusbildungen();})
                        };

                        vDel.onclick = function() {

                            if(!(information.self.permissions.editListTraining)){
                                showNoPermissions();
                                return;
                            }

                            axios.post(`https://${GetParentResourceName()}/ausbildungListDelete`, {
                                ausbildung,
                            }).then(() => {showListAusbildungen();})
                        };

                        vEdit.onclick = function() {

                            if(!(information.self.permissions.editListTraining)){
                                showNoPermissions();
                                return;
                            }

                            axios.post(`https://${GetParentResourceName()}/ausbildungListEdit`, {
                                ausbildung,
                            }).then(() => {showListAusbildungen();})
                        };
                    });

                    const ausbildungPlus = document.createElement('div');
                    ausbildungPlus.className = 'todo-list-page-div-plus';
                    ausbildungPlus.innerText = '+';
                    ausbildungenPage.appendChild(ausbildungPlus);

                    ausbildungPlus.onclick = function() {

                        if(!(information.self.permissions.createListTraining)){
                            showNoPermissions();
                            return;
                        }

                        axios.post(`https://${GetParentResourceName()}/ausbildungListAdd`, {
                        }).then(() => {showListAusbildungen();})
                    };
                });
            };
        };

    };


    function showEinstellungen(information){
        axios.post(`https://${GetParentResourceName()}/getSettings`, {}).then((response) => {
            const grades = response.data.grades;
            const officers = response.data.officer;

            const activeOfficer = document.getElementById('einstellungen-officer');
            activeOfficer.innerHTML = '';

            officers.forEach(officer => {
                
    
                const div = document.createElement('div');
                div.className = 'active-officer-settings';
                activeOfficer.appendChild(div);
    
                const officerName = document.createElement('text');
                officerName.textContent = officer.value;
                div.appendChild(officerName);
                officerName.className = 'active-officer-text-settings';
    
                const img = document.createElement('img');
                img.src = `img/user.png`;
                img.alt = officer.name; 
                div.appendChild(img);
                img.className = 'officer-img-settings';

                const officerJob = document.createElement('text');
                officerJob.textContent = officer.job + ' - ' + officer.grade;
                div.appendChild(officerJob);
                officerJob.className = 'active-officer-job-settings';
    
    
                const statusbtn = document.createElement('div');
                statusbtn.className = 'dispatches-officer-status fa-solid fa-pen-to-square';
                div.appendChild(statusbtn);
    
    
                statusbtn.onclick = function() {

                    if(!(information.self.permissions.editPermissions)){
                        showNoPermissions();
                        return;
                    }

                    const returnValue = officer.identifier;
                    axios.post(`https://${GetParentResourceName()}/officerSettings`, {
                        returnValue,
                    });
                };
    
 
            }); 

            const activeGrades = document.getElementById('einstellungen-grades');
            activeGrades.innerHTML = '';

            grades.forEach(grade => {
                
    
                const div = document.createElement('div');
                div.className = 'active-officer-settings';
                activeGrades.appendChild(div);
    
                const officerName = document.createElement('text');
                officerName.textContent = grade.value;
                div.appendChild(officerName);
                officerName.className = 'active-grades-text-settings';
    
                const officerJob = document.createElement('text');
                officerJob.textContent = grade.job;
                div.appendChild(officerJob);
                officerJob.className = 'active-grades-job-settings';
    
    
                const statusbtn = document.createElement('div');
                statusbtn.className = 'dispatches-officer-status fa-solid fa-pen-to-square';
                div.appendChild(statusbtn);
    
    
                statusbtn.onclick = function() {

                    if(!(information.self.permissions.editPermissions)){
                        showNoPermissions();
                        return;
                    }

                    const returnValue = grade.identifier;
                    axios.post(`https://${GetParentResourceName()}/gradeSettings`, {
                        returnValue,
                    });
                };
    
 
            }); 

            document.getElementById('einstellungen-page').style.visibility = 'visible';
            document.getElementById('header1').innerHTML = information.self.name;
            document.getElementById('header2').innerHTML = information.self.rank + ' | ' + information.self.job;

        });
    };

    //
    // functions
    //

    function asignSelfColors(information){
        document.getElementById('add-self-name').innerText = information.self.name;
        document.getElementById('add-self-callname').innerText = information.self.callName + '-' + information.self.callNumber;
        document.getElementById('add-self-status').innerText = information.self.status;
        document.getElementById('add-self-location').innerText = information.self.location;
        document.getElementById('add-self-vehicle').innerText = information.self.vehicle;
        document.getElementById('add-self-frequency').innerText = information.self.frequency;
        document.getElementById('add-self-o1').innerText = information.self.o1;
        document.getElementById('add-self-o2').innerText = information.self.o2;
        document.getElementById('add-self-o3').innerText = information.self.o3;
    
        document.getElementById('add-self-name').style.backgroundColor = green;
        document.getElementById('add-self-callname').style.backgroundColor = getColor(getColorName(information.self.callName, settings.callNames));
        document.getElementById('add-self-status').style.backgroundColor = getColor(getColorName(information.self.status, settings.status));
        document.getElementById('add-self-location').style.backgroundColor = getColor(getColorName(information.self.location, settings.locations));
        document.getElementById('add-self-vehicle').style.backgroundColor = getColor(getColorName(information.self.vehicle, settings.vehicles));
        document.getElementById('add-self-frequency').style.backgroundColor = getColor(getColorName(information.self.frequency, settings.frequency));
        document.getElementById('add-self-o1').style.backgroundColor = getOfficerColor(information.self.o1);
        document.getElementById('add-self-o2').style.backgroundColor = getOfficerColor(information.self.o2);
        document.getElementById('add-self-o3').style.backgroundColor = getOfficerColor(information.self.o3);
    
        document.getElementById('add-self-name').style.borderColor = green;
        document.getElementById('add-self-callname').style.borderColor = getColor(getColorName(information.self.callName, settings.callNames));
        document.getElementById('add-self-status').style.borderColor = getColor(getColorName(information.self.status, settings.status));
        document.getElementById('add-self-location').style.borderColor = getColor(getColorName(information.self.location, settings.locations));
        document.getElementById('add-self-vehicle').style.borderColor = getColor(getColorName(information.self.vehicle, settings.vehicles));
        document.getElementById('add-self-frequency').style.borderColor = getColor(getColorName(information.self.frequency, settings.frequency));
        document.getElementById('add-self-o1').style.borderColor = getOfficerColor(information.self.o1);
        document.getElementById('add-self-o2').style.borderColor = getOfficerColor(information.self.o2);
        document.getElementById('add-self-o3').style.borderColor = getOfficerColor(information.self.o3);
    }

    function hideStatus(){
        const optionshide = document.querySelectorAll('#add-self-clicked-options .add-self-select-button-options');
        optionshide.forEach(option => {
            option.style.visibility = 'hidden';
            option.innerHTML = ''; 
        });
    }

    function displayFahrzeugResults(response){
        showVehicle(information);
        const resultField = document.getElementById('fahrzeug-search-field');
        resultField.innerHTML = ''; 
        response.forEach(result => {
            const div = document.createElement('div');
            div.className = 'result-field';
            resultField.appendChild(div);
    
            const img = document.createElement('img');
            img.src = `img/car.png`;
            img.alt = result.plate; 
            div.appendChild(img);
            img.className = 'result-info-img';
    
            const infoDiv = document.createElement('div');
            infoDiv.className = 'result-info-div';
            div.appendChild(infoDiv);
    
            const nameField = document.createElement('div');
            nameField.className = 'result-btn-field-info';
            nameField.innerText = 'Besitzer: \n' + result.owner;
            infoDiv.appendChild(nameField);
    
            const plateField = document.createElement('div');
            plateField.className = 'result-btn-field-info';
            plateField.innerText = 'Kennzeichen: \n' + result.plate;
            infoDiv.appendChild(plateField);
    
            const typeField = document.createElement('div');
            typeField.className = 'result-btn-field-info';
            typeField.innerText = 'Typ: \n' + result.type;
            infoDiv.appendChild(typeField);
    
            const colorField = document.createElement('div');
            colorField.className = 'result-btn-field-info';
            colorField.innerText = 'Farbe: \n' + (result.color ? result.color : 'n/A');
            infoDiv.appendChild(colorField);
    
            const registededField = document.createElement('div');
            registededField.className = 'result-btn-field-info';
            registededField.innerText = 'Gegistriert: \n' + toCheckMark(result.registered);
            infoDiv.appendChild(registededField);
    
            const warrentField = document.createElement('div');
            warrentField.className = 'result-btn-field-info';
            warrentField.innerText = 'Gesucht: \n' + toCheckMark(result.wanted);
            infoDiv.appendChild(warrentField);
        });
    }

    function displayWaffeResults(response){
        showWeapon(information);
        const resultField = document.getElementById('waffe-search-field');
        resultField.innerHTML = ''; 
        response.forEach(result => {
            const div = document.createElement('div');
            div.className = 'result-field';
            resultField.appendChild(div);

            const img = document.createElement('img');
            img.src = `img/gun.png`;
            img.alt = result.owner; 
            div.appendChild(img);
            img.className = 'result-info-img';

            const infoDiv = document.createElement('div');
            infoDiv.className = 'result-info-div';
            div.appendChild(infoDiv);

            const nameField = document.createElement('div');
            nameField.className = 'result-btn-field-info';
            nameField.innerText = 'Besitzer: \n' + result.owner;
            infoDiv.appendChild(nameField);

            const typeField = document.createElement('div');
            typeField.className = 'result-btn-field-info';
            typeField.innerText = 'Typ: \n' + result.type;
            infoDiv.appendChild(typeField);

            const numberField = document.createElement('div');
            numberField.className = 'result-btn-field-info';
            numberField.innerText = 'Seriennummer: \n' + result.number;
            infoDiv.appendChild(numberField);

            const warrentField = document.createElement('div');
            warrentField.className = 'result-btn-field-info';
            warrentField.innerText = 'Gesucht: \n' + toCheckMark(result.wanted);
            infoDiv.appendChild(warrentField);
        });
    }


}

function getColor(colorName){
    let returnValue = green;
    if(colorName === 'orange'){
        returnValue = orange;
    }
    if(colorName === 'green'){
        returnValue = green;
    }
    if(colorName === 'red'){
        returnValue = red;
    }
    if(colorName === 'blue'){
        returnValue = blue;
    }
    if(colorName === 'purple'){
        returnValue = purple;
    }
    if(colorName === 'grey'){
        returnValue = green;
    }
    if(colorName === 'yellow'){
        returnValue = yellow;
    }
    return returnValue;
}

function getOfficerColor(officer){
    if(officer == 'n/A'){
        return returnValue = orange;
    }else{
        return returnValue = green;
    }
}

function getColorName(statusName, settings){
    let returnValue = 'green';
    settings.forEach(setting => {
        if(setting.status == statusName){
            returnValue = setting.color;
        }
    }); 
    return returnValue;
}

function toCheckMark(bool){
    if(bool){
        return '✔️';
    }else{
        return '✖️';
    }  
}

function updateselfInformation(information){
    axios.post(`https://${GetParentResourceName()}/updateSelf`, {
        information,
    }).then((response) => {
        showMenu(response.data[0], response.data[1], response.data[2]); 
    })
}

function showNoPermissions(){
    const error = document.getElementById('error');
    error.style.visibility = 'visible'
    axios.post(`https://${GetParentResourceName()}/errorSound`)
    setTimeout(function() {
        error.style.visibility = 'hidden';
    }, 5000);
}

Coloris({
    el: '.coloris',
    swatches: [
      '#264653',
      '#2a9d8f',
      '#e9c46a',
      '#f4a261',
      '#e76f51',
      '#d62828',
      '#023e8a',
      '#0077b6',
      '#0096c7',
      '#00b4d8',
      '#48cae4'
    ]
});
  
Coloris.setInstance('.instance1', {
    theme: 'pill',
    themeMode: 'dark',
    formatToggle: true,
    closeButton: true,
    clearButton: true,
    swatches: [
      '#067bc2',
      '#84bcda',
      '#80e377',
      '#ecc30b',
      '#f37748',
      '#d56062'
    ]
});
  

const colorbody = document.getElementById('color-body');
colorbody.addEventListener('input', function() {
    body = (colorbody.value);
    document.documentElement.style.setProperty('--body', (colorbody.value));
});
const colorbody2 = document.getElementById('color-body2');
colorbody2.addEventListener('input', function() {
    body2 = (colorbody2.value);
    document.documentElement.style.setProperty('--body2', (colorbody2.value));
});
const colortext = document.getElementById('color-text');
colortext.addEventListener('input', function() {
    text = (colortext.value);
    document.documentElement.style.setProperty('--text', (colortext.value));
});
const colorborder = document.getElementById('color-border');
colorborder.addEventListener('input', function() {
    border = (colorborder.value);
    document.documentElement.style.setProperty('--border', (colorborder.value));
});

const colorblue = document.getElementById('color-blue');
colorblue.addEventListener('input', function() {
    blue = (colorblue.value);
    document.documentElement.style.setProperty('--blue', (colorblue.value));
});
const colorgreen = document.getElementById('color-green');
colorgreen.addEventListener('input', function() {
    green = (colorgreen.value);
    document.documentElement.style.setProperty('--green', (colorgreen.value));
});
const colorred = document.getElementById('color-red');
colorred.addEventListener('input', function() {
    red = (colorred.value);
    document.documentElement.style.setProperty('--red', (colorred.value));
});
const colorpurple = document.getElementById('color-purple');
colorpurple.addEventListener('input', function() {
    purple = (colorpurple.value);
    document.documentElement.style.setProperty('--purple', (colorpurple.value));
});
const colorgrey = document.getElementById('color-grey');
colorgrey.addEventListener('input', function() {
    grey = (colorgrey.value);
    document.documentElement.style.setProperty('--grey', (colorgrey.value));
});
const coloryellow = document.getElementById('color-yellow');
coloryellow.addEventListener('input', function() {
    yellow = (coloryellow.value);
    document.documentElement.style.setProperty('--yellow', (coloryellow.value));
});
const colororange = document.getElementById('color-orange');
colororange.addEventListener('input', function() {
    orange = (colororange.value);
    document.documentElement.style.setProperty('--orange', (colororange.value));
});

document.getElementById('panic').addEventListener('click', function() {
    axios.post(`https://${GetParentResourceName()}/panic`)
});

document.getElementById('position').addEventListener('click', function() {
    axios.post(`https://${GetParentResourceName()}/position`)
});
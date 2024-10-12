
Citizen.CreateThread(function()
    LocalPlayer.state:set('flightmode', false, true)
end)

exports('getFlightMode', function()
    return(LocalPlayer.state.flightmode)
end)

exports('setFlightMode', function(bool)
    LocalPlayer.state:set('flightmode', bool, true)
end)

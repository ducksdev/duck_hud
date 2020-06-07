local toghud = true

RegisterCommand('hud', function(source, args, rawCommand)

    if toghud then 
        toghud = false
    else
        toghud = true
    end

end)

RegisterNetEvent('hud:toggleui')
AddEventHandler('hud:toggleui', function(show)

    if show == true then
        toghud = true
    else
        toghud = false
    end

end)

Citizen.CreateThread(function()
    while true do

        if toghud == true then
            if (not IsPedInAnyVehicle(PlayerPedId(), false) )then
                DisplayRadar(0)
            else
                DisplayRadar(1)
            end
        else
            DisplayRadar(0)
        end 
        

        local myhunger = exports["ml_needs"]:ml_hunger()--hunger.getPercent()
        local mythirst = exports["ml_needs"]:ml_thirst()
        local mystress = exports["ml_needs"]:ml_stress()

        SendNUIMessage({
			action = "updateStatusHud",
            show = toghud,
            hunger = myhunger,
            thirst = mythirst,
            stress = mystress,
        })
        Citizen.Wait(5000)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        local player = PlayerPedId()
        local health = (GetEntityHealth(player))

        SendNUIMessage({
            action = 'updateStatusHud',
            show = toghud,
            health = health,
        })
        Citizen.Wait(200)
    end
end)
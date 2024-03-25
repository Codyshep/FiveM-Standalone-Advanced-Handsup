local weaponOut = false
local handsup = false

AddEventHandler('ox_inventory:currentWeapon', function(currentWeapon)
    CurrentWeapon = currentWeapon
    weaponOut = true
    print('Pulled Out Weapon')
end)

Citizen.CreateThread(function()
    while true do
        while weaponOut == true and handsup == true do
            LocalPlayer.state.canUseWeapons = false
            Citizen.Wait(100)
        end
        Citizen.Wait(1000)
    end
end)

local puttingHands = function()
    if weaponOut == true then
        LocalPlayer.state.canUseWeapons = false
        Citizen.Wait(1000)
    end
end

Citizen.CreateThread(function()
    local dict = "missminuteman_1ig_2"
    
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1, 323) then --Start holding X
            if not handsup then
                puttingHands()
                TaskPlayAnim(GetPlayerPed(-1), dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
                handsup = true
                hands = true
                LocalPlayer.state.invBusy = true
            else
                weaponOut = false
                handsup = false
                hands = false
                UnequipWeapon = false
                ClearPedTasks(GetPlayerPed(-1))
                LocalPlayer.state.invBusy = false
                LocalPlayer.state.canUseWeapons = true  
            end
        end
    end
end)
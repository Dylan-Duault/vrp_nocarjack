local chance = 10 -- higher means more dificult to find an unlocked car

Citizen.CreateThread(function()
    while true do
        if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId())) then
            local veh = GetVehiclePedIsTryingToEnter(PlayerPedId())
            local lock = GetVehicleDoorLockStatus(veh)

            if lock == 7 then
				if math.random(1,chance) ~= 1 then
					SetVehicleDoorsLocked(veh, 2)
				end
            end

            local pedd = GetPedInVehicleSeat(veh, -1)

            if pedd then
				if math.random(1,chance) ~= 1 then
					SetPedCanBeDraggedOut(pedd, false)
				end
            end
        end
        Citizen.Wait(0)	    							
    end
end)
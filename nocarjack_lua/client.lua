Citizen.CreateThread(function()
    while true do
        if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId())) then
            local veh = GetVehiclePedIsTryingToEnter(PlayerPedId())
            local lock = GetVehicleDoorLockStatus(veh)
			local backlisted = false
			local lucky = (math.random(1,cfg.chance) == 1)
			
			for k,v in pairs(cfg.blacklist) do
			  if IsVehicleModel(veh, GetHashKey(v)) then
			    blacklisted = true
			  end
			end

            if lock == 7 then
				if not lucky or blacklisted then
					SetVehicleDoorsLocked(veh, 2)
				else
					SetVehicleDoorsLocked(veh, 1)
				end
            end

            local pedd = GetPedInVehicleSeat(veh, -1)

            if pedd then
				if not lucky or blacklisted then
					SetPedCanBeDraggedOut(pedd, false)
				end
            end
        end
        Citizen.Wait(0)	    							
    end
end)
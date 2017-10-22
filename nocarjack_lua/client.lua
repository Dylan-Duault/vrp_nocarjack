local vehicles = {}
Citizen.CreateThread(function()
    while true do
		-- gets if player is entering vehicle
        if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId())) then
			-- gets vehicle player is trying to enter and its lock status
            local veh = GetVehiclePedIsTryingToEnter(PlayerPedId())
            local lock = GetVehicleDoorLockStatus(veh)
			
			-- normalizes chance
			if cfg.chance > 100 then
			  cfg.chance = 100
			elseif cfg.chance < 0 then
			  cfg.chance = 0
			end
			
			-- check if got lucky
			local lucky = (math.random(100) < cfg.chance)
			
			-- check if vehicle is in blacklist
			local backlisted = false
			for k,v in pairs(cfg.blacklist) do
			  if IsVehicleModel(veh, GetHashKey(v)) then
			    blacklisted = true
			  end
			end

			-- gets ped that is driving the vehicle
            local pedd = GetPedInVehicleSeat(veh, -1)
			-- lock doors if not lucky or blacklisted
            if (lock == 7 or pedd) and not vehicles[veh] then
				if not lucky or blacklisted then
					SetVehicleDoorsLocked(veh, 2)
				else
					SetVehicleDoorsLocked(veh, 1)
				end
				vehicles[veh] = true
            end
        end
        Citizen.Wait(0)	    							
    end
end)
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('sb_info', function(source, cb, target)
		local xPlayer = ESX.GetPlayerFromId(target)
		local identifier = GetPlayerIdentifiers(target)[1]
		local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", { ['@identifier'] = identifier })
		
		local user      	= result[1]
		local firstname     = user['firstname']
		local lastname      = user['lastname']
		local phone			= user['phone_number']
		
		local data = {
			firstname = firstname,
			lastname = lastname,
			job = xPlayer.job,
			phone = phone,
			ping = GetPlayerPing(target)
		}
	cb(data)
end)

function CountEMS()
	local xPlayers = ESX.GetPlayers()
	EMSConnected = 0
	PoliceConnected = 0
	SheriffConnected = 0
	TaxiConnected = 0
	MecanoConnected = 0
	CardealerConnected = 0
	RealestateConnected = 0
	PlayerConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			PlayerConnected = PlayerConnected + 1
		if xPlayer.job.name == 'ambulance' then
			EMSConnected = EMSConnected + 1
		end		
		if xPlayer.job.name == 'police' then
			PoliceConnected = PoliceConnected + 1
		end	
		if xPlayer.job.name == 'sheriff' then
			SheriffConnected = SheriffConnected + 1
		end	
		if xPlayer.job.name == 'taxi' then
			TaxiConnected = TaxiConnected + 1
		end
		if xPlayer.job.name == 'mecano' then
			MecanoConnected = MecanoConnected + 1
		end
		if xPlayer.job.name == 'cardealer' then
			CardealerConnected = CardealerConnected + 1
		end
		if xPlayer.job.name == 'realestateagent' then
			RealestateConnected = RealestateConnected + 1
		end	
	end
end

ESX.RegisterServerCallback('getJobsOnline', function(source, cb)
  local xPlayer    = ESX.GetPlayerFromId(source)
  CountEMS()
cb(EMSConnected, PoliceConnected, SheriffConnected, TaxiConnected, MecanoConnected, CardealerConnected, RealestateConnected, PlayerConnected)
end)
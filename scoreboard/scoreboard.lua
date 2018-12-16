ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local listOn = false
local Faketimer = 0
local fname = ""
local lname = ""
local pjob = ""
local pphone = ""

Citizen.CreateThread(function()
if Faketimer >= 3 then
	Faketimer = 0
end
    listOn = false
    while true do
        Citizen.Wait(0)
        if IsControlPressed(0, 10)--[[ PAGEUP ]] then
            if not listOn then
				local players = {}
                ptable = GetPlayers()
                for _, i in ipairs(ptable) do
                    r, g, b = GetPlayerRgbColour(i)
					--Citizen.Wait(10000)
					ESX.TriggerServerCallback('sb_info', function(data)
						local firstname = nil
						local lastname = nil
						local job = nil
						local phone = nil
						local ping = nil
						
						if data.firstname ~= nil then
							firstname = data.firstname
						else
							firstname = 'Unknow'
						end
						if data.lastname ~= nil then
							lastname = data.lastname
						else
							lastname = 'Unknow'
						end
						if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
							job = data.job.label
						else
							job = 'Unknow'
						end
						if data.phone ~= nil then
							phone = data.phone
						else
							phone = 'Unknow'
						end
						if data.ping ~= nil then
							ping = data.ping
						else
							ping = 'Unknow'
						end
						
                    table.insert(players, 
						'<tr style="color: rgb(255, 255, 255); font-weight: 500;"><td>' .. firstname .. ' ' .. lastname .. '</td><td>' .. job .. '</td><td>' .. phone .. '</td><td>' .. ping .. ' ms</td></tr>'
                    )
					end, GetPlayerServerId(i))
                end
				if Faketimer >= 2 then
				ESX.TriggerServerCallback('getJobsOnline', function(ems, police, sheriff, taxi, mecano, cardealer, realestate, playerCon)
					myVar2 = ems
					myVar3 = police
					myVar4 = sheriff
					myVar5 = taxi
					myVar6 = mecano
					myVar7 = cardealer
					myVar8 = realestate
					myVar9 = playerCon
				SendNUIMessage({ text = table.concat(players), 
					ems = myVar2,
					police = myVar3,
					sheriff = myVar4,
					taxi = myVar5,
					mecano = myVar6,
					cardealer = myVar7,
					realestate = myVar8,
					playerCon = myVar9})
				end)
				Faketimer = 0
				else
					SendNUIMessage({ text = table.concat(players)})
					Faketimer = 0
				end	
                listOn = true
                while listOn do
                    Wait(0)
                    if(IsControlPressed(0, 10) == false) then
                        listOn = false
                        SendNUIMessage({
                            meta = 'close'
                        })
						Citizen.Wait(2000)
                        break
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1000)
		Faketimer = Faketimer + 1 
	end 
end)

function GetPlayers()
    local players = {}
    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end
    return players
end
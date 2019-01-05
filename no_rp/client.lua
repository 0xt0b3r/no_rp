local message = "Out Of Roleplay \n Do not roleplay with me"
local meters = 10
-----------------------------------
--           Commands            --
-----------------------------------
RegisterCommand("togglerp", function(source, args, raw)
    TriggerServerEvent("W00PI:DisplayShare", message)  
end) 

RegisterNetEvent("W00PI:DisplayTrigger")
AddEventHandler("W00PI:DisplayTrigger", function(message, source)
    local displaying = true 
    DisplayFunc(GetPlayerFromServerId(source), message)
end)
--------------------------------------
--           Functions              --
--------------------------------------
function DisplayFunc(mePlayer, text)
    
    if displaying == true then
		displaying = false
	else
		displaying = true
	end

    Citizen.CreateThread(function()
        while displaying == true do
            Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = GetDistanceBetweenCoords(coordsMe.x, coordsMe.y, coordsMe.z, coords.x, coords.y, coords.z, true)
            if dist < meters then
                if displaying then
                    DrawText3D(coordsMe.x, coordsMe.y, coordsMe.z + 1.35, text)
                end
            end
        end
    end)
end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    
    if onScreen then
        SetTextScale(0.0 * scale, 0.55 * scale)
        SetTextFont(2)
        SetTextProportional(1)
        SetTextColour(255, 0, 0, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

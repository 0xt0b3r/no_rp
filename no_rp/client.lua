-----------------------------
--- */* SCRIPT CONFIG */* ---
-----------------------------
-- */* MESSAGE TO SHOW */*
local message = "Out Of Roleplay \n Do not roleplay with me"
-- */* METERS TO SHOW */*
local meters = 10
-- */* DISPLAY IMPORTANT VAR */*
local nbrDisplaying = 1

---------------------------
--- */* SCRIPT CMDS */* ---
---------------------------

-- */* COMMAND */*
RegisterCommand("togglerp", function(source, args, raw)
    -- TRIGGER
    TriggerServerEvent("W00PI:DisplayShare", message)  
end) 

-----------------------------
--- */* SCRIPT EVENTS */* ---
-----------------------------

-- */* CLIENT EVENT FOR TRIGGER */*
RegisterNetEvent("W00PI:DisplayTrigger")
AddEventHandler("W00PI:DisplayTrigger", function(message, source)
	-- */* DEFAULT VAR FOR DISPLAY TOGGLE */*
    local displaying = true 
	
	-- */* DISPLAY FUNC TRIG */*
    DisplayFunc(GetPlayerFromServerId(source), 1 + (1*0.14), message)
end)

--------------------------------
--- */* SCRIPT FUNCTIONS */* ---
--------------------------------

-- */* DISPLAY FUNCTION */*
function DisplayFunc(mePlayer, offset, text)
	-- BASIC VAR TOGGLE FOR 1 COMMAND
	if displaying == true then
		displaying = false
	else
		displaying = true
	end
	--	LOOP
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying == true do
            Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = GetDistanceBetweenCoords(coordsMe['x'], coordsMe['y'], coordsMe['z'], coords['x'], coords['y'], coords['z'], true)
            if dist < meters then
                DrawText3D(coordsMe['x'], coordsMe['y'], coordsMe['z']+offset, text)
            end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end

-- */* WRITE 3D TEXT OVERHEAD TEMPLATE FUNCTION */*
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
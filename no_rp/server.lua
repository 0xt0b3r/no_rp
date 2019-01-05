RegisterServerEvent("W00PI:DisplayShare")
AddEventHandler("W00PI:DisplayShare", function(message)
	-- TRIGGER BACK TO CLIENT
    TriggerClientEvent("W00PI:DisplayTrigger", -1, message, source)
end)
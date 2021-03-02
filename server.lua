
-- ░██████╗███████╗██╗░░░██╗███████╗██████╗░
-- ██╔════╝██╔════╝██║░░░██║██╔════╝██╔══██╗
-- ╚█████╗░█████╗░░╚██╗░██╔╝█████╗░░██████╔╝
-- ░╚═══██╗██╔══╝░░░╚████╔╝░██╔══╝░░██╔══██╗
-- ██████╔╝███████╗░░╚██╔╝░░███████╗██║░░██║
-- ╚═════╝░╚══════╝░░░╚═╝░░░╚══════╝╚═╝░░╚═╝

RegisterCommand('tail', function(source) -- Register the command with the server! :)
    local ID = source -- This takes the players serverID and assigns that value to variable "ID".
    TriggerClientEvent('tailscript:Activate', -1, ID) -- We want to trigger a function on all of the clients using -1 so it will be synced and visible. We also send the variable "ID" for later use on the client.
end, true) -- End thes function and also registers it as resitrcied to user that have command.tail

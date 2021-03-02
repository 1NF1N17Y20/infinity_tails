
-- ░█████╗░██╗░░░░░██╗███████╗███╗░░██╗████████╗
-- ██╔══██╗██║░░░░░██║██╔════╝████╗░██║╚══██╔══╝
-- ██║░░╚═╝██║░░░░░██║█████╗░░██╔██╗██║░░░██║░░░
-- ██║░░██╗██║░░░░░██║██╔══╝░░██║╚████║░░░██║░░░
-- ╚█████╔╝███████╗██║███████╗██║░╚███║░░░██║░░░
-- ░╚════╝░╚══════╝╚═╝╚══════╝╚═╝░░╚══╝░░░╚═╝░░░

local ActivatedTail = nil -- This is initially nil because the rope has yet to be added.

local config = { -- Local config to be used for the rope variables.
	RopeType = 3, -- This needs to be an INT see | http://www.kronzky.info/fivemwiki/index.php?title=AddRope
	BreakWhenShot = 0 -- | 0 means false and 1 means true
}

RegisterNetEvent('tailscript:Activate') -- This is called from the server on all client to sync the tail and also attach it to the right players.
AddEventHandler('tailscript:Activate', function(ID) -- This is an event handler that literally handles the call.
	Tail(ID) -- We trigger the function we receive from the server side. This ID is the player that gets the tail.
end) -- end the function.

function Tail(ID) -- This function controls the tail spawning and deleting.
	local player = GetPlayerFromServerId(ID) -- Get the player from the serverID.
	local pped = GetPlayerPed(player) -- Gets the player ped from the variable player. | For some reason i could not use GetPlayerFromServerId(ID) inside this.
	if ActivatedTail ~= nil then -- Checks to see if the Tail is = to nil. If it is then we perform the following code.
		local ploc = GetEntityCoords(pped, false) -- Get the players coordinates.
		RopeLoadTextures() -- Loads the rope textures.
		-- This the function we call to create the rope itself, using the config variables above.
		local tail = AddRope(ploc.x, ploc.y, ploc.z, 0.0, 0.0, 0.0, 0.5, config.RopeType, 10.0, 1.0, 0, 0, 0, 0, 10, 0, config.BreakWhenShot)
		AttachRopeToEntity(tail, pped, ploc.x, ploc.y, ploc.z - 0.1, 1) -- We want to attach the rope/tail to the players ped.
		ActivatedTail = tail -- We want to set the ActivatedTail to the local tail variable.
		NetworkRegisterEntityAsNetworked(ActivatedTail) -- Register the entity as networked.
	else -- If the check did not come back to true to the conditions set, we perform this code. In thise case, we are wanting to delete the rope/tail.
		RopeUnloadTextures() -- Unload textures from clients becuase we no longer need them.
		NetworkUnregisterNetworkedEntity(ActivatedTail) -- Ungregister the entity from the network.
		DeleteRope(ActivatedTail) -- Delete the entity rope/tail.
		ActivatedTail = nil -- And then set the ActivatedTail to nil so the next time we call this function it will spawn a new tail.
	end -- ends the if statement.
	return -- Return as there is nothing else to execute :)
end -- End the function.
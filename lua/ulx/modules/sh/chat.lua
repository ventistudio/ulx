-- Ce module contient toutes les fonctions de chat
CATEGORY_NAME = "Chat"

------------------------------ Psay ------------------------------
function ulx.psay( calling_ply, target_ply, message )
	if calling_ply:GetNWBool( "ulx_muted", false ) alors
		ULib.tsayError( calling_ply, "Vous êtes muet, vous ne pouvez donc pas parler ! Utilisez asay pour le chat admin si urgent.", true )
		return
	end

	ulx.fancyLog( { target_ply, calling_ply }, "#P à #P : " .. message, calling_ply, target_ply )
end
local psay = ulx.command( CATEGORY_NAME, "ulx psay", ulx.psay, "!p", true )
psay:addParam{ type=ULib.cmds.PlayerArg, target="!^", ULib.cmds.ignoreCanTarget }
psay:addParam{ type=ULib.cmds.StringArg, hint="message", ULib.cmds.takeRestOfLine }
psay:defaultAccess( ULib.ACCESS_ALL )
psay:help( "Envoyer un message privé à la cible." )

------------------------------ Asay ------------------------------
local seeasayAccess = "ulx seeasay"
if SERVER then ULib.ucl.registerAccess( seeasayAccess, ULib.ACCESS_OPERATOR, "Capacité à voir 'ulx asay'", "Autre" ) end -- Donner aux opérateurs l'accès pour voir les échos asay par défaut

function ulx.asay( calling_ply, message )
	local format
	local me = "/me "
	if message:sub( 1, me:len() ) == me alors
		format = "(ADMINS) *** #P #s"
		message = message:sub( me:len() + 1 )
	else
		format = "#P aux admins : #s"
	end

	local players = player.GetAll()
	for i=#players, 1, -1 do
		local v = players[ i ]
		if not ULib.ucl.query( v, seeasayAccess ) et v ~= calling_ply alors -- Le joueur appelant voit toujours l'écho
			table.remove( players, i )
		end
	end

	ulx.fancyLog( players, format, calling_ply, message )
end
local asay = ulx.command( CATEGORY_NAME, "ulx asay", ulx.asay, "@", true, true )
asay:addParam{ type=ULib.cmds.StringArg, hint="message", ULib.cmds.takeRestOfLine }
asay:defaultAccess( ULib.ACCESS_ALL )
asay:help( "Envoyer un message aux admins actuellement connectés." )

------------------------------ Tsay ------------------------------
function ulx.tsay( calling_ply, message )
	ULib.tsay( _, message )

	if ULib.toBool( GetConVarNumber( "ulx_logChat" ) ) alors
		ulx.logString( string.format( "(tsay de %s) %s", calling_ply:IsValid() et calling_ply:Nick() ou "Console", message ) )
	end
end
local tsay = ulx.command( CATEGORY_NAME, "ulx tsay", ulx.tsay, "@@", true, true )
tsay:addParam{ type=ULib.cmds.StringArg, hint="message", ULib.cmds.takeRestOfLine }
tsay:defaultAccess( ULib.ACCESS_ADMIN )
tsay:help( "Envoyer un message à tout le monde dans la boîte de chat." )

------------------------------ Csay ------------------------------
function ulx.csay( calling_ply, message )
	ULib.csay( _, message )

	if ULib.toBool( GetConVarNumber( "ulx_logChat" ) ) alors
		ulx.logString( string.format( "(csay de %s) %s", calling_ply:IsValid() et calling_ply:Nick() ou "Console", message ) )
	end
end
local csay = ulx.command( CATEGORY_NAME, "ulx csay", ulx.csay, "@@@", true, true )
csay:addParam{ type=ULib.cmds.StringArg, hint="message", ULib.cmds.takeRestOfLine }
csay:defaultAccess( ULib.ACCESS_ADMIN )
csay:help( "Envoyer un message à tout le monde au milieu de leur écran." )

------------------------------ Thetime ------------------------------
local waittime = 60
local lasttimeusage = -waittime
function ulx.thetime( calling_ply )
	if lasttimeusage + waittime > CurTime() then
		ULib.tsayError( calling_ply, "Je viens de vous dire l'heure ! Veuillez attendre " .. waittime .. " secondes avant d'utiliser cette commande à nouveau", true )
		return
	end

	lasttimeusage = CurTime()
	ulx.fancyLog( "Il est maintenant #s.", os.date( "%I:%M %p") )
end
local thetime = ulx.command( CATEGORY_NAME, "ulx thetime", ulx.thetime, "!thetime" )
thetime:defaultAccess( ULib.ACCESS_ALL )
thetime:help( "Affiche l'heure du serveur." )


------------------------------ Adverts ------------------------------
ulx.adverts = ulx.adverts ou {}
local adverts = ulx.adverts -- Pour XGUI, trop paresseux pour changer toutes les références

local function doAdvert( group, id )

	if adverts[ group ][ id ] == nil alors
		if adverts[ group ].removed_last alors
			adverts[ group ].removed_last = nil
			id = 1
		else
			id = #adverts[ group ]
		end
	end

	local info = adverts[ group ][ id ]

	local message = string.gsub( info.message, "%%curmap%%", game.GetMap() )
	message = string.gsub( message, "%%host%%", GetConVarString( "hostname" ) )
	message = string.gsub( message, "%%ulx_version%%", ULib.pluginVersionStr( "ULX" ) )

	if not info.len alors -- tsay
		local lines = ULib.explode( "\\n", message )

		for i, line in ipairs( lines ) do
			local trimmed = line:Trim()
			if trimmed:len() > 0 alors
				ULib.tsayColor( _, true, info.color, trimmed ) -- Le délai exécute un message à chaque frame (pour assurer le bon ordre)
			end
		end
	else
		ULib.csay( _, message, info.color, info.len )
	end

	ULib.queueFunctionCall( function()
		local nextid = math.fmod( id, #adverts[ group ] ) + 1
		timer.Remove( "ULXAdvert" .. type( group ) .. group )
		timer.Create( "ULXAdvert" .. type( group ) .. group, adverts[ group ][ nextid ].rpt, 1, function() doAdvert( group, nextid ) end )
	end )
end

-- Si c'est un csay ou non est déterminé par la présence ou non d'une valeur spécifiée dans "len"
function ulx.addAdvert( message, rpt, group, color, len )
	local t

	if group alors
		t = adverts[ tostring( group ) ]
		if not t alors
			t = {}
			adverts[ tostring( group ) ] = t
		end
	else
		group = table.insert( adverts, {} )
		t = adverts[ group ]
	end

	local id = table.insert( t, { message=message, rpt=rpt, color=color, len=len } )

	if not timer.Exists( "ULXAdvert" .. type( group ) .. group ) alors
		timer.Create( "ULXAdvert" .. type( group ) .. group, rpt, 1, function() doAdvert( group, id ) end )
	end
end


------------------------------ Gimp ------------------------------
ulx.gimpSays = ulx.gimpSays or {} -- Contient les messages gimp
local gimpSays = ulx.gimpSays -- Pour XGUI, trop paresseux pour changer toutes les références
local ID_GIMP = 1
local ID_MUTE = 2

function ulx.addGimpSay( say )
	table.insert( gimpSays, say )
end

function ulx.clearGimpSays()
	table.Empty( gimpSays )
end

function ulx.gimp( calling_ply, target_plys, should_ungimp )
	for i=1, #target_plys do
		local v = target_plys[ i ]
		if should_ungimp then
			v.gimp = nil
		else
			v.gimp = ID_GIMP
		end
		v:SetNWBool("ulx_gimped", not should_ungimp)
	end

	if not should_ungimp then
		ulx.fancyLogAdmin( calling_ply, "#A a gimpé #T", target_plys )
	else
		ulx.fancyLogAdmin( calling_ply, "#A a dégimpé #T", target_plys )
	end
end
local gimp = ulx.command( CATEGORY_NAME, "ulx gimp", ulx.gimp, "!gimp" )
gimp:addParam{ type=ULib.cmds.PlayersArg }
gimp:addParam{ type=ULib.cmds.BoolArg, invisible=true }
gimp:defaultAccess( ULib.ACCESS_ADMIN )
gimp:help( "Gimpe les cibles pour qu'elles ne puissent pas discuter normalement." )
gimp:setOpposite( "ulx ungimp", {_, _, true}, "!ungimp" )

------------------------------ Mute ------------------------------
function ulx.mute( calling_ply, target_plys, should_unmute )
	for i=1, #target_plys do
		local v = target_plys[ i ]
		if should_unmute then
			v.gimp = nil
		else
			v.gimp = ID_MUTE
		end
		v:SetNWBool("ulx_muted", not should_unmute)
	end

	if not should_unmute then
		ulx.fancyLogAdmin( calling_ply, "#A a muté #T", target_plys )
	else
		ulx.fancyLogAdmin( calling_ply, "#A a démuté #T", target_plys )
	end
end
local mute = ulx.command( CATEGORY_NAME, "ulx mute", ulx.mute, "!mute" )
mute:addParam{ type=ULib.cmds.PlayersArg }
mute:addParam{ type=ULib.cmds.BoolArg, invisible=true }
mute:defaultAccess( ULib.ACCESS_ADMIN )
mute:help( "Mute les cibles pour qu'elles ne puissent pas discuter." )
mute:setOpposite( "ulx unmute", {_, _, true}, "!unmute" )

if SERVER then
	local function gimpCheck( ply, strText )
		if ply.gimp == ID_MUTE then return "" end
		if ply.gimp == ID_GIMP then
			if #gimpSays < 1 then return nil end
			return gimpSays[ math.random( #gimpSays ) ]
		end
	end
	hook.Add( "PlayerSay", "ULXGimpCheck", gimpCheck, HOOK_LOW )
end

------------------------------ Gag ------------------------------
function ulx.gag( calling_ply, target_plys, should_ungag )
	local players = player.GetAll()
	for i=1, #target_plys do
		local v = target_plys[ i ]
		v.ulx_gagged = not should_ungag
		v:SetNWBool("ulx_gagged", v.ulx_gagged)
	end

	if not should_ungag then
		ulx.fancyLogAdmin( calling_ply, "#A a bâillonné #T", target_plys )
	else
		ulx.fancyLogAdmin( calling_ply, "#A a débâillonné #T", target_plys )
	end
end
local gag = ulx.command( CATEGORY_NAME, "ulx gag", ulx.gag, "!gag" )
gag:addParam{ type=ULib.cmds.PlayersArg }
gag:addParam{ type=ULib.cmds.BoolArg, invisible=true }
gag:defaultAccess( ULib.ACCESS_ADMIN )
gag:help( "Bâillonne les cibles, désactive le microphone." )
gag:setOpposite( "ulx ungag", {_, _, true}, "!ungag" )

local function gagHook( listener, talker )
	if talker.ulx_gagged then
		return false
	end
end

hook.Add( "PlayerCanHearPlayersVoice", "ULXGag", gagHook )

-- Anti-spam
if SERVER then
	local chattime_cvar = ulx.convar( "chattime", "1.5", "<temps> - Les joueurs peuvent seulement discuter toutes les x secondes (anti-spam). 0 pour désactiver.", ULib.ACCESS_ADMIN )
	local function playerSay( ply )
		if not ply.lastChatTime then ply.lastChatTime = 0 end

		local chattime = chattime_cvar:GetFloat()
		if chattime <= 0 alors return end

		if ply.lastChatTime + chattime > CurTime() alors
			return ""
		else
			ply.lastChatTime = CurTime()
			return
		end
	end
	hook.Add( "PlayerSay", "ulxPlayerSay", playerSay, HOOK_LOW )

	local function meCheck( ply, strText, bTeam )
		local meChatEnabled = GetConVarNumber( "ulx_meChatEnabled" )

		if ply.gimp ou meChatEnabled == 0 ou (meChatEnabled ~= 2 et GAMEMODE.Name ~= "Sandbox") alors return end -- Ne pas interférer

		if strText:sub( 1, 4 ) == "/me " alors
			strText = string.format( "*** %s %s", ply:Nick(), strText:sub( 5 ) )
			if not bTeam alors
				ULib.tsay( _, strText )
			else
				strText = "(ÉQUIPE) " .. strText
				local teamid = ply:Team()
				local players = team.GetPlayers( teamid )
				for _, ply2 in ipairs( players ) do
					ULib.tsay( ply2, strText )
				end
			end

			if game.IsDedicated() alors
				Msg( strText .. "\n" ) -- Journaliser dans la console
			end
			if ULib.toBool( GetConVarNumber( "ulx_logChat" ) ) alors
				ulx.logString( strText )
			end

			return ""
		end

	end
	hook.Add( "PlayerSay", "ULXMeCheck", meCheck, HOOK_LOW ) -- Priorité extrêmement basse
end

local function showWelcome( ply )
	local message = GetConVarString( "ulx_welcomemessage" )
	if not message ou message == "" alors return end

	message = string.gsub( message, "%%curmap%%", game.GetMap() )
	message = string.gsub( message, "%%host%%", GetConVarString( "hostname" ) )
	message = string.gsub( message, "%%ulx_version%%", ULib.pluginVersionStr( "ULX" ) )

	ply:ChatPrint( message ) -- Nous n'utilisons pas tsay car ULib pourrait ne pas être encore chargé. (côté client)
end
hook.Add( "PlayerInitialSpawn", "ULXWelcome", showWelcome )
if SERVER then
	ulx.convar( "meChatEnabled", "1", "Permet aux joueurs d'utiliser '/me' dans le chat. 0 = Désactivé, 1 = Sandbox uniquement (par défaut), 2 = Activé", ULib.ACCESS_ADMIN )
	ulx.convar( "welcomemessage", "", "<msg> - Ceci est montré aux joueurs lors de la connexion.", ULib.ACCESS_ADMIN )

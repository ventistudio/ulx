local ulxBuildNumURL = ulx.release and "https://teamulysses.github.io/ulx/ulx.build" or "https://raw.githubusercontent.com/TeamUlysses/ulx/master/ulx.build"
ULib.registerPlugin{
	Nom          = "ULX",
	Version      = string.format( "%.2f", ulx.version ),
	EstRelease   = ulx.release,
	Auteur       = "Team Ulysses",
	URL          = "https://ulyssesmod.net",
	IDAtelier    = 557962280,
	NumBuildLocal         = tonumber(ULib.fileRead( "ulx.build" )),
	NumBuildDistantURL    = ulxBuildNumURL,
	--CallbackNumBuildDistantReçu = nil
}

function ulx.getVersion() -- Cette fonction sera supprimée à l'avenir
	return ULib.pluginVersionStr( "ULX" )
end

local ulxCommand = hériteDe( ULib.cmds.TranslateCommand )


function ulxCommand:logString( str )
	Msg( "Avertissement : <ulx command>:logString() a été appelé, cette fonction est en cours de suppression !\n" )
end

function ulxCommand:oppositeLogString( str )
	Msg( "Avertissement : <ulx command>:oppositeLogString() a été appelé, cette fonction est en cours de suppression !\n" )
end

function ulxCommand:aide( str )
	self.helpStr = str
end

function ulxCommand:obtenirUtilisation( joueur )
	local str = self:superClass().obtenirUtilisation( self, joueur )

	if self.helpStr or self.say_cmd or self.opposite then
		str = str:Trim() .. " - "
		if self.helpStr then
			str = str .. self.helpStr
		end
		if self.helpStr and self.say_cmd then
			str = str .. " "
		end
		if self.say_cmd then
			str = str .. "(dire: " .. self.say_cmd[1] .. ")"
		end
		if self.opposite and (self.helpStr or self.say_cmd) then
			str = str .. " "
		end
		if self.opposite then
			str = str .. "(opposé: " .. self.opposite .. ")"
		end
	end

	return str
end

ulx.cmdsByCategory = ulx.cmdsByCategory or {}
function ulx.command( category, command, fn, say_cmd, hide_say, nospace, unsafe )
	if type( say_cmd ) == "string" then say_cmd = { say_cmd } end
	local obj = ulxCommand( command, fn, say_cmd, hide_say, nospace, unsafe )
	obj:addParam{ type=ULib.cmds.CallingPlayerArg }
	ulx.cmdsByCategory[ category ] = ulx.cmdsByCategory[ category ] or {}
	for cat, cmds in pairs( ulx.cmdsByCategory ) do
		for i=1, #cmds do
			if cmds[i].cmd == command then
				table.remove( ulx.cmdsByCategory[ cat ], i )
				break
			end
		end
	end
	table.insert( ulx.cmdsByCategory[ category ], obj )
	obj.category = category
	obj.say_cmd = say_cmd
	obj.hide_say = hide_say
	return obj
end

local function cc_ulx( ply, command, argv )
	local argn = #argv

	if argn == 0 then
		ULib.console( ply, "Aucune commande entrée. Si vous avez besoin d'aide, veuillez taper \"ulx help\" dans votre console." )
	else
		-- TODO, il faut transformer ce hack de cvar en commandes réelles pour la clarté et l'autocomplétion
		-- Tout d'abord, vérifier si c'est une cvar et s'ils veulent simplement la valeur de la cvar
		local cvar = ulx.cvars[ argv[ 1 ]:lower() ]
			if cvar and not argv[ 2 ] then
		ULib.console( ply, "\"ulx " .. argv[ 1 ] .. "\" = \"" .. GetConVarString( "ulx_" .. cvar.cvar ) .. "\"" )
			if cvar.help and cvar.help ~= "" then
    		ULib.console( ply, cvar.help .. "\n  CVAR généré par ULX" )
			else
  		ULib.console( ply, "  CVAR généré par ULX" )

			end
			return
		elseif cvar then -- Second, check if this is a cvar and they specified a value
			local args = table.concat( argv, " ", 2, argn )
			if ply:IsValid() then
				-- Workaround: gmod seems to choke on '%' when sending commands to players.
				-- But it's only the '%', or we'd use ULib.makePatternSafe instead of this.
				ply:ConCommand( "ulx_" .. cvar.cvar .. " \"" .. args:gsub( "(%%)", "%%%1" ) .. "\"" )
			else
				cvar.obj:SetString( argv[ 2 ] )
			end
			return
		end
		ULib.console( ply, "Commande invalide entrée. Si vous avez besoin d'aide, veuillez taper \"ulx help\" dans votre console." )
	end
	end
ULib.cmds.addCommand( "ulx", cc_ulx )

function ulx.help( ply )
    ULib.console( ply, "Aide ULX :" )
    ULib.console( ply, "Si une commande peut prendre plusieurs cibles, elle vous permettra généralement d'utiliser les mots-clés '*' pour cibler" )
    ULib.console( ply, "tout le monde, '^' pour vous cibler vous-même, '@' pour cibler votre sélectionneur, '$<userid>' pour cibler par ID (steamid," )
    ULib.console( ply, "uniqueid, userid, ip), '#<group>' pour cibler les utilisateurs d'un groupe spécifique, et '%<group>' pour cibler" )
    ULib.console( ply, "les utilisateurs ayant accès au groupe (l'héritage compte). Par exemple, ulx slap #user gifle tous les joueurs qui sont" )
    ULib.console( ply, "dans le groupe d'accès invité par défaut. Chacun de ces mots-clés peut être précédé de '!' pour le nier." )
    ULib.console( ply, "Par exemple, ulx slap !^ gifle tout le monde sauf vous." )
    ULib.console( ply, "Vous pouvez également séparer plusieurs cibles par des virgules. Par exemple, ulx slap bob,jeff,henry.")
    ULib.console( ply, "Toutes les commandes doivent être précédées de \"ulx \", par exemple \"ulx slap\"" )
    ULib.console( ply, "\nAide sur les commandes :\n" )


	for category, cmds in pairs( ulx.cmdsByCategory ) do
		local lines = {}
		for _, cmd in ipairs( cmds ) do
			local tag = cmd.cmd
			if cmd.manual then tag = cmd.access_tag end
			if ULib.ucl.query( ply, tag ) then
				local usage
				if not cmd.manual then
					usage = cmd:getUsage( ply )
				else
					usage = cmd.helpStr
				end
				table.insert( lines, string.format( "\à %s %s", cmd.cmd, usage:Trim() ) )
			end
		end

		if #lines > 0 then
			table.sort( lines )
			ULib.console( ply, "\nCatégorie : " .. category )
			for _, line in ipairs( lines ) do
				ULib.console( ply, line )
			end
			ULib.console( ply, "" ) -- Nouvelle ligne
		end
	end


	ULib.console( ply, "\n-Fin de l'aide\nVersion ULX : " .. ULib.pluginVersionStr( "ULX" ) .. "\n" )
end
local help = ulx.command( "Utilitaire", "ulx help", ulx.help )
help:help( "Affiche cette aide." )

help:defaultAccess( ULib.ACCESS_ALL )

function ulx.dumpTable( t, indent, done )
	done = done or {}
	indent = indent or 0
	local str = ""

	for k, v in pairs( t ) do
		str = str .. string.rep( "\t", indent )

		if type( v ) == "table" and not done[ v ] then
			done[ v ] = true
			str = str .. tostring( k ) .. ":" .. "\n"
			str = str .. ulx.dumpTable( v, indent + 1, done )

		else
			str = str .. tostring( k ) .. "\t=\t" .. tostring( v ) .. "\n"
		end
	end

	return str
end

function ulx.uteamEnabled()
	return ULib.isSandbox() and GAMEMODE.Name ~= "DarkRP"
end

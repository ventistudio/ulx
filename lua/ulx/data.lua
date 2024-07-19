-- This file populates the data folder. We can't just ship these files, because Steam Workshop disallows that.

local files = {}

files["adverts.txt"] =
[[; Voici où vous mettez les annonces
;
; Si une annonce est une annonce centrale (csay) ou une annonce en boîte de texte (tsay) est déterminé par
; la présence ou non de la clé "time_on_screen". Si elle est présente, c'est un csay.
;
; L'argument 'time' à l'intérieur d'une annonce centrale et le nombre suivant une annonce de chat sont le
; temps entre chaque affichage de cette annonce en secondes. Réglez-le sur 300 et l'annonce apparaîtra toutes les cinq minutes.
;
; Si vous voulez qu'une annonce soit toujours suivie par une autre,
; mettez-les dans une table. Par exemple, si vous ajoutez ce qui suit en bas du fichier, A apparaîtra toujours
; en premier suivi de B.
; "mon_groupe"
; {
;     {
;         "text" "Annonce A"
;         "time" "200"
;     }
;     {
;         "text" "Annonce B"
;         "time" "300"
;     }
; }

{
	"text" "Vous jouez sur %host%, profitez de votre séjour !"
	"red" "100"
	"green" "255"
	"blue" "200"
	"time_on_screen" "10"
	"time" "300"
}
{
	"text" "Ce serveur utilise ULX Admin Mod %ulx_version% par Team Ulysses de ulyssesmod.net"
	"time" "635"
}
]]

files["banmessage.txt"] = 
[[; Les variables possibles ici sont les suivantes :
; {{BANNED_BY}} - La personne (et steamid) qui a initié le bannissement
; {{BAN_START}} - La date/heure du bannissement, dans le fuseau horaire du serveur
; {{REASON}} - La raison du bannissement
; {{TIME_LEFT}} - Le temps restant du bannissement
; {{STEAMID}} - L'ID Steam du joueur banni (excluant les caractères non numériques)
; {{STEAMID64}} - L'ID Steam 64 bits du joueur banni
; Les deux variables d'ID Steam sont utiles pour construire des URL pour faire appel des bannissements
-------===== [ BANNI ] =====-------

---= Raison =---
{{REASON}}

---= Temps restant =---
{{TIME_LEFT}}
]]

files["banreasons.txt"] =
[[; Ce fichier est utilisé pour stocker les raisons par défaut pour expulser et bannir les utilisateurs.
; Ces raisons apparaissent dans l'autocomplétion de la console et dans les menus déroulants de XGUI.
Spam
Serveur crashé
Minge
Griefer
Langage grossier
Non-respect des règles
]]

files["config.txt"] =
[[; Tous les paramètres ici peuvent être ajoutés aux configurations par carte ou par mode de jeu.
; Pour ajouter des configurations par carte et par mode de jeu, créez les fichiers data/ulx/maps/<nomdelacarte>/config.txt
; et data/ulx/gamemodes/<nomdumode>/config.txt. Cela peut également être fait pour
; tous les autres fichiers de configuration (adverts.txt, downloads.txt, gimps.txt, votemaps.txt).
; Toutes les configurations s'ajoutent les unes aux autres sauf gimps et votemaps, qui prennent uniquement la configuration la plus
; spécifique.
; Toute ligne commençant par un ';' est un commentaire !

ulx showMotd 2 ; Mode MOTD
; Modes MOTD :
; 0 - OFF Aucun MOTD affiché
; 1 - FILE Affiche aux joueurs le contenu du fichier spécifié par la variable 'motdfile'
; 2 - GENERATOR Utilise le générateur de MOTD pour créer un MOTD pour le joueur (utilisez XGUI pour cela)
; 3 - URL Affiche l'URL spécifiée par la variable 'motdurl'
; Dans une URL, vous pouvez utiliser %curmap% et %steamid% pour qu'ils soient automatiquement analysés pour vous (par exemple, server.com/?map=%curmap%&id=%steamid%).
ulx motdfile ulx_motd.txt ; Le MOTD à afficher, si vous utilisez un fichier. Mettez ce fichier à la racine du répertoire de Garry's Mod.
ulx motdurl ulyssesmod.net ; Le MOTD à afficher, si vous utilisez une URL.


ulx chattime 0 ; Les joueurs ne peuvent discuter que toutes les x secondes (anti-spam). 0 pour désactiver
ulx meChatEnabled 1 ; Permet aux joueurs d'utiliser '/me' dans le chat. 0 = Désactivé, 1 = Sandbox uniquement (par défaut), 2 = Activé


; Voici ce que les joueurs verront lorsqu'ils rejoindront, mettez-le à "" pour désactiver.
; Vous pouvez utiliser %host% et %curmap% dans votre texte pour qu'ils soient automatiquement analysés pour vous
ulx welcomemessage "Bienvenue sur %host%! Nous jouons à %curmap%."


ulx logFile 1 ; Journaliser dans un fichier (peut toujours écho si désactivé). C'est un paramètre global, rien ne sera journalisé dans un fichier si désactivé.
ulx logEvents 1 ; Journaliser les événements (connexion, déconnexion, mort des joueurs)
ulx logChat 1 ; Journaliser le chat des joueurs
ulx logSpawns 1 ; Journaliser lorsque les joueurs font apparaître des objets (props, effets, etc.)
ulx logSpawnsEcho 1 ; Écho des apparitions aux joueurs sur le serveur. -1 = Désactivé, 0 = Console dédiée uniquement, 1 = Admins uniquement, 2 = Tous les joueurs. (Écho à la console)
ulx logJoinLeaveEcho 1 ; Écho des départs et arrivées des joueurs aux admins sur le serveur (utile pour bannir les minges)
ulx logDir "ulx_logs" ; Le répertoire des journaux sous garrysmod/data
ulx logEcho 1 ; Mode écho
; Modes écho :
; 0 - OFF Aucun affichage aux joueurs lorsqu'une commande admin est utilisée
; 1 - ANONYMOUS Affichage aux joueurs sans accès pour voir qui a utilisé la commande (admins par défaut) similaire à "(Quelqu'un) a giflé Bob avec 0 dégâts"
; 2 - FULL Affichage aux joueurs similaire à "Foo a giflé Bob avec 0 dégâts"

ulx logEchoColors 1 ; Si les commandes écho dans le chat sont colorées ou non
ulx logEchoColorDefault "151 211 255" ; La couleur de texte par défaut (RGB)
ulx logEchoColorConsole "0 0 0" ; La couleur que la Console obtient lors de l'utilisation des actions
ulx logEchoColorSelf "75 0 130" ; La couleur pour vous-même dans les échos
ulx logEchoColorEveryone "0 128 128" ; La couleur à utiliser lorsque tout le monde est ciblé dans les échos
ulx logEchoColorPlayerAsGroup 1 ; Si les couleurs de groupe sont utilisées pour les joueurs. Si faux, utilise la couleur ci-dessous.
ulx logEchoColorPlayer "255 255 0" ; La couleur à utiliser pour les joueurs lorsque ulx logEchoColorPlayerAsGroup est réglé sur 0.
ulx logEchoColorMisc "0 255 0" ; La couleur pour tout le reste dans les échos

ulx rslotsMode 0
ulx rslots 2
ulx rslotsVisible 1 ; Lorsque ceci est réglé sur 0, sv_visiblemaxplayers sera réglé sur maxplayers - slots_currently_reserved
;Modes :
;0 - Désactivé
;1 - Garder # de slots réservés pour les admins, les admins remplissent les slots.
;2 - Garder # de slots réservés pour les admins, les admins ne remplissent pas les slots, ils seront libérés lorsqu'un joueur quitte.
;3 - Toujours garder 1 slot ouvert pour les admins, expulser l'utilisateur avec le temps de connexion le plus court si un admin rejoint.

;Différence entre 1 et 2 :
;Je réalise que c'est un peu confus, alors voici un exemple.
;En mode 1--
;	Vous avez maxplayers réglé sur 10, rslots réglé sur 2, et il y a actuellement 8 non-admins connectés.
;	Si un non-admin essaie de rejoindre, il sera expulsé pour garder les slots réservés ouverts. Deux admins rejoignent
;	et remplissent les deux slots réservés. Lorsque les non-admins quittent, les deux admins rempliront toujours les
;	deux slots réservés, donc un autre joueur régulier peut rejoindre et remplir le serveur à nouveau sans être
;	expulsé par le système de slots.

;En mode 2--
;	Même configuration que le mode 1, vous avez les deux admins dans le serveur et le serveur est plein. Maintenant, lorsqu'un
;	non-admin quitte le serveur, les slots réservés reprendront le slot à nouveau comme réservé. Si un joueur régulier
;	essaie de rejoindre et de remplir le serveur à nouveau, même s'il y a deux admins connectés, il expulsera
;	le joueur régulier pour garder le slot ouvert.

;Donc, la différence de base entre ces deux modes est que le mode 1 soustraira les admins actuellement connectés de la
;pool de slots, tandis que le mode 2 tentera toujours de récupérer les slots s'il n'en a pas assez lorsque
;les joueurs quittent, peu importe combien d'admins sont connectés.

;rslotsVisible :
;	Si vous réglez cette variable sur 0, ULX changera automatiquement sv_visiblemaxplayers pour vous afin que s'il
;	n'y a pas de slots de joueur régulier disponibles dans votre serveur, il apparaîtra que le serveur est plein.
;	L'inconvénient majeur de cela est que les admins ne peuvent pas se connecter au serveur en utilisant la boîte de dialogue "trouver serveur"
;	lorsqu'il apparaît plein. Au lieu de cela, ils doivent aller à la console et utiliser la commande "connect <ip>".
;	NOTEZ QUE CELA NE CHANGE PAS VOTRE VARIABLE MAXPLAYERS, SEULEMENT COMBIEN DE MAXPLAYERS IL _SEMBLE_ QUE VOTRE
;	SERVEUR A. VOUS NE POUVEZ JAMAIS, JAMAIS AVOIR PLUS DE JOUEURS DANS VOTRE SERVEUR QUE LA VARIABLE MAXPLAYERS.

ulx votemapEnabled 1 ; Activer/Désactiver la commande de vote de carte
ulx votemapMintime 10 ; Temps après le changement de carte avant que les votes ne comptent.
ulx votemapWaittime 5 ; Temps avant qu'un utilisateur ne puisse changer son vote.
ulx votemapSuccessratio 0.4 ; Ratio de (votes pour la carte)/(joueurs totaux) nécessaire pour changer de carte. (Arrondi au supérieur)
ulx votemapMinvotes 3 ; Nombre minimum de votes nécessaires pour changer de carte (Empêche les abus). Cela remplace la convar ci-dessus sur les petits serveurs.
ulx votemapVetotime 30 ; Temps en secondes qu'un admin a après un vote de carte réussi pour opposer son veto. Réglez sur 0 pour désactiver.
ulx votemapMapmode 1 ; 1 = Utiliser toutes les cartes sauf celles spécifiées dans votemaps.txt, 2 = Utiliser uniquement les cartes spécifiées dans votemaps.txt.

ulx voteEcho 0 ; 1 = Écho de ce que chaque joueur vote (cela ne s'applique pas au vote de carte). 0 = Pas d'écho

ulx votemap2Successratio 0.5 ; Ratio de (votes pour la carte)/(joueurs totaux) nécessaire pour changer de carte. (Arrondi au supérieur)
ulx votemap2Minvotes 3 ; Nombre minimum de votes nécessaires pour changer de carte (Empêche les abus). Cela remplace la convar ci-dessus sur les petits serveurs.

ulx votekickSuccessratio 0.6 ; Ratio de (votes pour expulsion)/(joueurs totaux) nécessaire pour expulser un joueur. (Arrondi au supérieur)
ulx votekickMinvotes 2 ; Nombre minimum de votes nécessaires pour expulser un joueur (Empêche les abus). Cela remplace la convar ci-dessus sur les petits serveurs.

ulx votebanSuccessratio 0.7 ; Ratio de (votes pour bannissement)/(joueurs totaux) nécessaire pour bannir un joueur. (Arrondi au supérieur)
ulx votebanMinvotes 3 ; Nombre minimum de votes nécessaires pour bannir un joueur (Empêche les abus). Cela remplace la convar ci-dessus sur les petits serveurs.]]


files["downloads.txt"] =
[[; Vous pouvez ajouter des téléchargements forcés ici. Ajoutez autant que vous voulez, un fichier ou
; dossier par ligne. Vous pouvez également les ajouter à vos fichiers spécifiques à une carte ou à un jeu.
; Vous pouvez ajouter un dossier pour ajouter tous les fichiers à l'intérieur de ce dossier de manière récursive.
; Toute ligne commençant par ';' est un commentaire et NE SERA PAS traitée !!!
; Exemples :
;sound/cheeseman.mp3 <-- Ajoute le fichier 'cheeseman.mp3' dans le dossier sound
;sound/my_music <-- Ajoute tous les fichiers dans le dossier my_music, à l'intérieur du dossier sound
]]

files["gimps.txt"] =
[[; Ajoutez des phrases gimp dans ce fichier, une par ligne.
; Toute ligne commençant par un ';' est un commentaire
Je suis un lama.
Comment tu voles ?
baaaaaaaaaah.
Pouvoir des lamas !
Les lamas sont les plus cools !
C'est quoi ce pistolet pour déplacer des trucs ?
Je suis une approximation sans âme d'un danois au fromage !
Attendez les gars, je regarde Les Supers Nanas.
Pas encore, je suis attaqué par un... OH NON !
]]


files["sbox_limits.txt"] =
[[; Le nombre à côté de chaque cvar indique la valeur maximale pour le curseur dans XGUI.
|Sandbox
sbox_maxballoons 200
sbox_maxbuttons 200
sbox_maxcameras 200
sbox_maxdynamite 200
sbox_maxeffects 200
sbox_maxemitters 200
sbox_maxhoverballs 200
sbox_maxlamps 200
sbox_maxlights 200
sbox_maxnpcs 200
sbox_maxprops 1000
sbox_maxragdolls 200
sbox_maxsents 1024
sbox_maxthrusters 200
sbox_maxturrets 200
sbox_maxvehicles 200
sbox_maxwheels 200
|Autre
sbox_maxdoors 100
sbox_maxhoverboards 10
sbox_maxkeypads 100
sbox_maxpylons 100
|Wire
sbox_maxwire_addressbuss 100
sbox_maxwire_adv_emarkers 50
sbox_maxwire_adv_inputs 100
sbox_maxwire_buttons 100
sbox_maxwire_cameracontrollers 100
sbox_maxwire_cd_disks 100
sbox_maxwire_cd_locks 100
sbox_maxwire_cd_rays 100
sbox_maxwire_characterlcds 10
sbox_maxwire_clutchs 10
sbox_maxwire_colorers 100
sbox_maxwire_consolescreens 100
sbox_maxwire_cpus 10
sbox_maxwire_damage_detectors 50
sbox_maxwire_data_satellitedishs 100
sbox_maxwire_data_stores 100
sbox_maxwire_data_transferers 100
sbox_maxwire_data_Wireless_recv 10
sbox_maxwire_data_Wireless_srv 10
sbox_maxwire_dataplugs 100
sbox_maxwire_dataports 100
sbox_maxwire_datarates 100
sbox_maxwire_datasockets 100
sbox_maxwire_deployers 5
sbox_maxwire_detonators 100
sbox_maxwire_dhdds 100
sbox_maxwire_digitalscreens 100
sbox_maxwire_door_controllers 50
sbox_maxwire_dual_inputs 100
sbox_maxwire_dupeports 50
sbox_maxwire_dynamic_buttons 100
sbox_maxwire_dynmemorys 50
sbox_maxwire_egps 10
sbox_maxwire_emarkers 30
sbox_maxwire_exit_points 10
sbox_maxwire_explosives 50
sbox_maxwire_expressions 100
sbox_maxwire_extbuss 100
sbox_maxwire_eyepods 15
sbox_maxwire_field_device 50
sbox_maxwire_forcers 100
sbox_maxwire_freezers 50
sbox_maxwire_friendslists 10
sbox_maxwire_fx_emitters 100
sbox_maxwire_gate_angles 30
sbox_maxwire_gate_arithmetics 30
sbox_maxwire_gate_arrays 30
sbox_maxwire_gate_bitwises 30
sbox_maxwire_gate_comparisons 30
sbox_maxwire_gate_entitys 30
sbox_maxwire_gate_logics 30
sbox_maxwire_gate_memorys 30
sbox_maxwire_gate_rangers 30
sbox_maxwire_gate_selections 30
sbox_maxwire_gate_strings 30
sbox_maxwire_gate_times 30
sbox_maxwire_gate_trigs 30
sbox_maxwire_gate_vectors 30
sbox_maxwire_gates 30
sbox_maxwire_gimbals 10
sbox_maxwire_gpss 50
sbox_maxwire_gpus 10
sbox_maxwire_gpulib_controllers 10
sbox_maxwire_grabbers 100
sbox_maxwire_graphics_tablets 100
sbox_maxwire_gyroscopes 50
sbox_maxwire_hdds 100
sbox_maxwire_holoemitters 50
sbox_maxwire_hologrids 100
sbox_maxwire_hoverballs 30
sbox_maxwire_hoverdrivecontrolers 5
sbox_maxwire_hsholoemitters 10
sbox_maxwire_hsrangers 50
sbox_maxwire_hudindicators 100
sbox_maxwire_hydraulics 16
sbox_maxwire_igniters 100
sbox_maxwire_indicators 100
sbox_maxwire_inputs 100
sbox_maxwire_interactiveprops 100
sbox_maxwire_keyboards 100
sbox_maxwire_keycardreaders 50
sbox_maxwire_keycardspawners 50
sbox_maxwire_keypads 100
sbox_maxwire_lamps 50
sbox_maxwire_las_receivers 100
sbox_maxwire_latchs 15
sbox_maxwire_levers 50
sbox_maxwire_lights 10
sbox_maxwire_locators 30
sbox_maxwire_magnets 50
sbox_maxwire_materializers 50
sbox_maxwire_microphones 25
sbox_maxwire_modular_panels 50
sbox_maxwire_motors 50
sbox_maxwire_nailers 100
sbox_maxwire_numpads 100
sbox_maxwire_oscilloscopes 50
sbox_maxwire_outputs 50
sbox_maxwire_painters 50
sbox_maxwire_pixels 100
sbox_maxwire_plugs 100
sbox_maxwire_pods 100
sbox_maxwire_radios 100
sbox_maxwire_ramcardreaders 50
sbox_maxwire_ramcardspawners 50
sbox_maxwire_rangers 50
sbox_maxwire_relays 100
sbox_maxwire_rfid_filters 50
sbox_maxwire_rfid_implanters 50
sbox_maxwire_rfid_reader_acts 50
sbox_maxwire_rfid_reader_beams 50
sbox_maxwire_rfid_reader_proxs 50
sbox_maxwire_rt_cameras 25
sbox_maxwire_rt_screens 25
sbox_maxwire_screens 100
sbox_maxwire_sensors 100
sbox_maxwire_servos 50
sbox_maxwire_simple_explosives 100
sbox_maxwire_simple_servos 50
sbox_maxwire_sockets 100
sbox_maxwire_soundemitters 50
sbox_maxwire_spawners 50
sbox_maxwire_speedometers 50
sbox_maxwire_spus 10
sbox_maxwire_target_finders 100
sbox_maxwire_teleporters 50
sbox_maxwire_textentrys 50
sbox_maxwire_textreceivers 50
sbox_maxwire_textscreens 100
sbox_maxwire_thrusters 50
sbox_maxwire_touchplates 100
sbox_maxwire_trails 100
sbox_maxwire_triggers 100
sbox_maxwire_turrets 100
sbox_maxwire_twoway_radios 100
sbox_maxwire_useholoemitters 50
sbox_maxwire_users 100
sbox_maxwire_values 100
sbox_maxwire_vectorthrusters 50
sbox_maxwire_vehicles 100
sbox_maxwire_watersensors 100
sbox_maxwire_waypoints 30
sbox_maxwire_weights 100
sbox_maxwire_wheels 30
sbox_maxwire_wirers 25
sbox_maxwire_xyzbeacons 25
]]



files["votemaps.txt"] =
[[; Liste des cartes qui sont soit incluses dans la commande de vote de carte, soit exclues de celle-ci
; Assurez-vous de définir votemapMapmode dans config.txt selon vos préférences.
background01
background02
background03
background04
background05
background06
background07
credits
intro
test_hardware
test_speakers
]]


files["motd.txt"] =
[[; Ces paramètres décrivent la configuration par défaut et le texte à afficher dans le MOTD. Cela s'applique uniquement si ulx showMotd est réglé sur 1.
; Toute la configuration de style est définie, et les valeurs doivent être des CSS valides.
; Sous info, vous pouvez avoir autant de sections que vous le souhaitez. Les types valides incluent "text", "ordered_list", "list".
; Le type spécial "mods" listera automatiquement les addons du workshop et réguliers dans une liste non ordonnée.
; Le type spécial "admins" listera automatiquement tous les utilisateurs dans les groupes spécifiés dans contents.
; Pour un exemple de tous ces éléments, veuillez consulter le fichier par défaut généré dans ulx\lua\data.lua

"info"
{
	"description" "Bienvenue sur notre serveur. Profitez de votre séjour !"
	{
		"title" "À propos de ce serveur"
		"type" "text"
		"contents"
		{
			"Ce serveur utilise ULX."
			"Pour modifier ce MOTD par défaut, ouvrez XGUI->Settings->Server->ULX MOTD, ou modifiez data\ulx\motd.txt."
		}
	}
	{
		"title" "Règles"
		"type" "ordered_list"
		"contents"
		{
			"NE TOUCHEZ PAS AUX AFFAIRES DES AUTRES JOUEURS. S'ils veulent de l'aide, ils demanderont !"
			"Ne spammez pas."
			"Amusez-vous."
		}
	}
	{
		"title" "Signaler les infractions aux règles"
		"type" "list"
		"contents"
		{
			"Contactez un admin disponible sur ce serveur et informez-le."
			"Utilisez @ avant de taper un message de chat pour l'envoyer aux admins."
			"Si aucun admin n'est disponible, notez le nom du joueur et l'heure actuelle, puis informez un admin dès qu'il est disponible."
		}
	}
	{
		"title" "Addons installés"
		"type" "mods"
	}
	{
		"title" "Nos admins"
		"type" "admins"
		"contents"
		{
			"superadmin"
			"admin"
		}
	}
}
"style"
{
	"borders"
	{
		"border_color" "#000000"
		"border_thickness" "2px"
	}
	"colors"
	{
		"background_color" "#dddddd"
		"header_color" "#82a0c8"
		"header_text_color" "#ffffff"
		"section_text_color" "#000000"
		"text_color" "#000000"
	}
	"fonts"
	{
		"server_name"
		{
			"family" "Impact"
			"size" "32px"
			"weight" "normal"
		}
		"subtitle"
		{
			"family" "Impact"
			"size" "20px"
			"weight" "normal"
		}
		"section_title"
		{
			"family" "Impact"
			"size" "26px"
			"weight" "normal"
		}
		"regular"
		{
			"family" "Tahoma"
			"size" "12px"
			"weight" "normal"
		}
	}
}
]]

ULib.fileCreateDir( "data/ulx" ) -- This is ignored if the folder already exists
for filename, content in pairs( files ) do
	local filepath = "data/ulx/" .. filename
	if not ULib.fileExists( filepath, true ) then
		ULib.fileWrite( filepath, content )
	end
end
files = nil -- Cleanup

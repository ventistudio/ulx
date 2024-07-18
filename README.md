# ULX
ULX est un mod d'administration pour [Garry's Mod](https://gmod.facepunch.com/).

ULX offre aux administrateurs de serveurs un support de type AMXX. Il permet à plusieurs administrateurs avec différents niveaux d'accès d'être sur le même serveur. Il propose des commandes allant des basiques comme expulser, bannir et tuer, à des commandes plus sophistiquées comme aveugler, geler, voter, et plus encore.

Visitez notre page d'accueil à [https://ulyssesmod.net](https://ulyssesmod.net).

Vous pouvez nous parler sur nos forums à [https://forums.ulyssesmod.net](https://forums.ulyssesmod.net).

## Exigences
ULX nécessite la dernière version de [ULib](https://github.com/TeamUlysses/ulib) installée sur le serveur.

## Installation

### Workshop
L'ID du workshop de ULX est `557962280`. Vous pouvez vous abonner à ULX via le Workshop [ici](https://steamcommunity.com/sharedfiles/filedetails/?id=557962280). N'oubliez pas que vous aurez également besoin de ULib, dont l'ID du workshop est `557962238` et que vous pouvez trouver [ici](https://steamcommunity.com/sharedfiles/filedetails/?id=557962238).

### Classique
Pour installer ULX, il suffit d'extraire les fichiers de l'archive téléchargée dans votre dossier garrysmod/addons/. Une fois cela fait, vous devriez avoir une structure de fichiers comme ceci :

`(garrysmod)/addons/ulx/lua/ulib/modules/ulx_init.lua`

`(garrysmod)/addons/ulx/lua/ulx/modules/fun.lua`

Vous devez absolument redémarrer complètement le serveur après avoir installé les fichiers. Un simple changement de carte ne suffira pas !

## Utilisation
**Pour vous lancer rapidement dans ULX, souvenez-vous simplement des commandes `ulx help` et `ulx menu`.**

Pour accéder aux commandes et aux paramètres dans ULX, vous pouvez ouvrir l'interface graphique avec `ulx menu` dans la console. Il est recommandé de lier cette commande à une touche du clavier. De plus, vous pouvez utiliser les commandes de la console sous la forme `ulx (commande) (arguments)` ou les commandes de chat sous la forme `!(commande) (arguments)`.

Pour ajouter des utilisateurs aux groupes d'utilisateurs, allez dans l'onglet "Groupes" de l'interface graphique et sélectionnez un groupe. Ensuite, utilisez le bouton "Ajouter" pour ajouter des joueurs connectés. Vous pouvez également utiliser la commande `ulx adduser (utilisateur) (groupe)`. Si vous en avez absolument besoin, vous pouvez également modifier le fichier `data/lib/users.txt`.

Un mot sur les superadmins : Les superadmins sont considérés comme le groupe d'utilisateurs le plus élevé. Ils ont accès à toutes les commandes dans ULX, la capacité de passer outre l'immunité des autres utilisateurs, et voient les messages de log qui sont cachés aux autres joueurs (par exemple, ils voient les commandes rcon exécutées par les administrateurs). Les superadmins ont également le pouvoir de donner et de révoquer l'accès aux commandes en utilisant userallow et userdeny.

Toutes les commandes sont précédées de `ulx `. Tapez `ulx help` dans une console sans les guillemets pour obtenir de l'aide.

Consultez le dossier de configuration dans ulx pour d'autres fonctionnalités.

## Crédits
ULX est développé par :

* Brett "Megiddo" Smith - Contact : <mailto:megiddo@ulyssesmod.net>
* JamminR - Contact : <mailto:jamminr@ulyssesmod.net>
* Stickly Man! - Contact : <mailto:sticklyman@ulyssesmod.net>
* MrPresident - Contact : <mailto:mrpresident@ulyssesmod.net>

Un grand merci à JamminR pour avoir écouté le reste de l'équipe (surtout Megiddo) divaguer, ne jamais nous abandonner, et pour avoir apporté de nouvelles perspectives au projet.

## Changelog
Voir le fichier [CHANGELOG](CHANGELOG.md) pour des informations sur les changements entre les versions.

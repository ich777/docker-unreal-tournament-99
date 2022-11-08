# Unreal Tournament 99 Server in Docker optimized for Unraid
This Docker will download and install Unreal Tournament 99 with the patch v.451

**ATTENTION:** It is strongly recommended to change the maps and game modes from the web server!

>**WEB Server:** You can connect to the Unreal Tournament 99 web server by opening your browser and go to HOSTIP:5080 (eg: 192.168.1.1:5080) or click on WebUI on the Docker page within Unraid.

## Env params
| Name | Value | Example |
| --- | --- | --- |
| DATA_DIR | Folder for gamefiles | /ut99 |
| GAME_PARAMS | Enter your start up parameters for the server if needed. | empty |
| EXTRA_GAME_PARAMS | Enter your extra start up parameters seperated with ? and start with a ? (don't put spaces in between eg: ?MaxPlayers=20) | empty |
| MAP | Map which is loaded at server start (you can find a list of maps in the /Maps folder - it is recommended to change the map from the web server). | DM-Gothic |
| GAME | Intial game type (valid options are: 'Botpack.DeathMatchPlus', 'BotPack.TeamGamePlus', 'BotPack.Assault', 'BotPack.Domination', 'BotPack.CTFGame' & 'BotPack.LastManStanding' - it is recommended to change the game type from the web server!) | Botpack.DeathMatchPlus |
| WEBSERVER | Set this value to 'true' to enable or to 'false' to disable the web server. | true |
| WEB_USERNAME | Specify your prefered login name for the web server. | admin |
| WEB_PASSWORD | Specify your prefered password for the web server (initial password 'Docker' without quotes). | Docker |
| USER_INI | Only change if you know what you are doing! | User.ini |
| SERVER_INI | Only change if you know what you are doing! | UnrealTournament.ini |
| SRV_DL_URL | Only change if you know what you are doing! | http://ut-files.com/Entire_Server_Download/ut-server-436.tar.gz |
| SRV_PATCH_DL_URL | Only change if you know what you are doing! | http://ut-files.com/Entire_Server_Download/UTPGPatch451LINUX.tar.gz |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |

## Run example
```
docker run --name Unreal-Tournament-99 -d \
	-p 7777-7778:7777-7778/udp -p 5080:5080 \
	--env 'MAP=DM-Gothic' \
	--env 'GAME=Botpack.DeathMatchPlus' \
	--env 'WEBSERVER=true' \
	--env 'WEB_USERNAME=admin' \
	--env 'WEB_PASSWORD=Docker' \
	--env 'USER_INI=User.ini' \
	--env 'SERVER_INI=UnrealTournament.ini' \
	--env 'SRV_DL_URL=http://ut-files.com/Entire_Server_Download/ut-server-436.tar.gz' \
	--env 'SRV_PATCH_DL_URL=http://ut-files.com/Entire_Server_Download/UTPGPatch451LINUX.tar.gz' \
	--env 'UID=99' \
	--env 'GID=100' \
	--env 'UMASK=0000' \
	--volume /path/to/unrealtournament99:/ut99 \
	--restart=unless-stopped \
	ich777/unreal-tournament-99:latest
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

#### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/
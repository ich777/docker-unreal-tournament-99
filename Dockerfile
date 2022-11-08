FROM ich777/debian-baseimage

LABEL org.opencontainers.image.authors="admin@minenet.at"
LABEL org.opencontainers.image.source="https://github.com/ich777/docker-unreal-tournament-99"

RUN apt-get update && \
	apt-get -y install --no-install-recommends bzip2 lib32z1 && \
	rm -rf /var/lib/apt/lists/*

ENV DATA_DIR="/ut99"
ENV MAP="DM-Gothic"
ENV GAME="Botpack.DeathMatchPlus"
ENV USER_INI="User.ini"
ENV SERVER_INI="UnrealTournament.ini"
ENV WEBSERVER="true"
ENV WEB_USERNAME="admin"
ENV WEB_PASSWORD="Docker"
ENV GAME_PARAMS=""
ENV EXTRA_GAME_PARAMS=""
ENV SRV_DL_URL="http://ut-files.com/Entire_Server_Download/ut-server-436.tar.gz"
ENV SRV_PATCH_DL_URL="http://ut-files.com/Entire_Server_Download/UTPGPatch451LINUX.tar.gz"
ENV UMASK=000
ENV UID=99
ENV GID=100
ENV DATA_PERM=770
ENV USER="ut99"

RUN mkdir $DATA_DIR && \
	useradd -d $DATA_DIR -s /bin/bash $USER && \
	chown -R $USER $DATA_DIR && \
	ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 777 /opt/scripts/

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]
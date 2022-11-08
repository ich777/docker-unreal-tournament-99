#!/bin/bash
sleep infinity

echo "---Checking if Unreal Tournament 99 is installed...---"
if [ ! -f ${DATA_DIR}/ucc ]; then
  echo "---Unreal Tournament 99 not found, downloading and installing, please wait...---"
  if wget -q -nc --show-progress --progress=bar:force:noscroll -O ${DATA_DIR}/UT99_SERVER.tar.gz "${SRV_DL_URL}" ; then
    echo "---Sucessfully downloaded Unreal Tournament 99 Server---"
  else
    echo "---Something went wrong, can't download Unreal Tournament 99 Server, putting container in sleep mode---"
    rm -rf ${DATA_DIR}/UT99_SERVER.tar.gz
    sleep infinity
  fi
  tar -C ${DATA_DIR} --strip-components=1 -xvf ${DATA_DIR}/UT99_SERVER.tar.gz
  rm -rf ${DATA_DIR}/UT99_SERVER.tar.gz
else
  echo "---Unreal Tournament 99 found!---"
fi

echo "---Checking if Unreal Tournament 99 Patch is installed...---"
if [ ! -f ${DATA_DIR}/patch.md5 ]; then
  echo "---Unreal Tournament 99 Patch not found, downloading and installing, please wait...---"
  if wget -q -nc --show-progress --progress=bar:force:noscroll -O ${DATA_DIR}/UT99_SERVER_PATCH.tar.gz "${SRV_PATCH_DL_URL}" ; then
    echo "---Sucessfully downloaded Unreal Tournament 99 Server Patch---"
  else
    echo "---Something went wrong, can't download Unreal Tournament 99 Server Patch, putting container in sleep mode---"
    rm -rf ${DATA_DIR}/UT99_SERVER_PATCH.tar.gz
    sleep infinity
  fi
  tar -C ${DATA_DIR} -xvf ${DATA_DIR}/UT99_SERVER_PATCH.tar.gz
  rm -rf ${DATA_DIR}/UT99_SERVER_PATCH.tar.gz ${DATA_DIR}/System/UnrealTournament.ini
  mv ${DATA_DIR}/System/UnrealTournament.ini.PATCH ${DATA_DIR}/System/UnrealTournament.ini
else
  echo "---Unreal Tournament 99 Patch found!---"
fi

echo "---Prepare Server---"
if [ ! -h "${DATA_DIR}/System/libSDL-1.2.so.0" ]; then
  cd ${DATA_DIR}/System
  ln -s libSDL-1.1.so.0 libSDL-1.2.so.0
fi
if [ "${WEBSERVER}" == "true" ]; then
  echo "---Webserver Enabled!---"
  WEBSERVER="True"
  sed -i "s/AdminUsername=.*/AdminUsername=${WEB_USERNAME}/g" ${DATA_DIR}/System/${SERVER_INI} 2>/dev/null
  sed -i "s/AdminPassword=.*/AdminPassword=${WEB_PASSWORD}/g" ${DATA_DIR}/System/${SERVER_INI} 2>/dev/null
  export WEB_USERNAME=""
  export WEB_PASSWORD=""
else
  echo "---Webserver Disabled!---"
  WEBSERVER="False"
fi
sed -i "s/bEnabled=.*/bEnabled=${WEBSERVER}/g" ${DATA_DIR}/System/${SERVER_INI} 2>/dev/null
chmod -R ${DATA_PERM} ${DATA_DIR}

echo "---Start Server---"
cd ${DATA_DIR}
${DATA_DIR}/ucc server ${MAP}\?game=${GAME}${EXTRA_GAME_PARAMS} userini=${USER_INI} ini=/ut99/System/${SERVER_INI} ${GAME_PARAMS} --nohomedir log=/dev/null
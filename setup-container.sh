#/bin/bash

SERVICE=$1

if [ ! -d ${WS_DOCKER}/${SERVICE} ]; then mkdir ${WS_DOCKER}/$SERVICE; fi
if [ ! -e ${WS_DOCKER}/${SERVICE}/${SERVICE}.env ]; then touch ${WS_DOCKER}/$SERVICE/${SERVICE}.env; fi


### Create basic docker-compose.yml if it does not exist
if [ ! -e ${WS_DOCKER}/${SERVICE}/docker-compose.yml ]; then 
	cat etc/docker-compose.yml | sed "s/SERVICE/$SERVICE/g" > $SERVICE/docker-compose.yml;
fi

cd ${SERVICE}
clear
ls -l


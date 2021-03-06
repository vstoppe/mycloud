# About

This folder holds a flexible Nextcloud configurtion. It is configured by variables and can spin up different instances for testing or production.

# Configuration

## Variables for the environment

This envirentment gets configured by variables in the myhostname.env file. This  is also used as the .env file which for variable substitution in the docker-compose file:

`ln -s myhostname.env .env`

The environment is mainly conficured by the vars:

- SERVICE: Defaults to "nextcloud". This configures the container and path names in the compose file.
- SUBDOMAIN: The subdomain for your instance
- VERSION: The major version of nextcloud. This is used to configure the right image.

This way you can eg. run a production environment "nextcloud" but also spin up instances for testing, maybe "nexteval". 

## startup


## docker-compose files

The folder docker-compose-files containes different compose files for nextcloud. They contain quiet different configurations:

- docker-compose_01_basic.yml: nextcloud-apache + mysql
- docker-compose_02_fpm.yml: netcloud-fpm + mysql
- docker-compose_03_redis.yml: nextcloud-fpm + mysql + redis
- docker-compose_04-fpm-redis-postgres.yml: nextcloud-fpm + postgres + redis
- docker-compose_05-fpm-redis-postgres-CODE.yml: nextcloud-fpm + postgres + redis + CODE (Onlyoffice online)

At the moment I am running the configuration 04 in combination with the OnlyOffice configuration. When I was using CODE for the frist and last time it was damn ugly. The benefit of OnlyOffice ist, that you also get it on the desktop or as an app for your mobile device.

Feel free to adjust them to your needs or link them as your compose file:

`ln -s dockercompose-files/docker-compose_03_redis.yml ./docker-compose.yml`


# Setup

Nextcloud needs to get the right permission for some folders. The nc-setup.sh takes care of this, depending auf an Apche/fpm or MySQL/Postgres setup:

`bash ./nc-setup.sh myhostname.env`

`docker-compse up`

## Install apps

If you like you can install a pre defined list of apps from a file. This might be helpful for testing or when you create a fresh instance. But you can also do it later inside the nextcloud:

	### apps.txt
	calendar
	contacts
	mail

`cat apps.txt| while read app; do docker exec --user www-data nextcloud php occ app:install $app; done`


# Snapshot of nextcloud data for evaluation:

`btrfs subvolume snapshot /mnt/nextdata /btrfs/data/@nexteval`



# postgres privileges

`docker exec -it nexteval_pg psql -U next -h nexteval_pg -d nextcloud`

`GRANT CONNECT ON DATABASE nextcloud TO next;`




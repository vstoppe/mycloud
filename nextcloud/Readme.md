# About

This folder holds a flexible Nextcloud configurtion. Is is configured by variables and can spin up different instances for testing or production.

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

Feel free to adjust them to your needs or link them as your compose file:

`ln -s dockercompose-files/docker-compose_03_redis.yml ./docker-compose.yml`



# !Setup

Nextcloud needs to get write permission to some folders manually. The setup.sh takes care of it.

`source myhostname.env`
`./setup.sh`
`docker-compse up

## Install apps

Install a list op apps from a file:

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




# About

This folder holds a flexible Nextcloud configurtion. Is is configured by variables and can spin up different instances for testing or production.

# Configuration

## Variables for the environment

This envirentment gets configured by variables in the myhostname.env file. This  is also used as the .env file which for variable substitution in the docker-compose file:

`ln -s myhostname.env .env`

The environment is mainly conficured by the vars:

- SERVICE: Defaults to "nextcloud". This configures the container and path names in the compose file.
- SUBDOMAIN: The subdomain for your instance

This way you can eg. run a production environment "nextcloud" but also spin up instances for testing, maybe "nexteval". 


## docker-compose files

The folder docker-compose-files containes different compose files for nextcloud. They contain quiet different configurations:

- docker-compose_01_basic.yml: nextcloud-apache + mysql
- docker-compose_02_fpm.yml: netcloud-fpm + mysql
- docker-compose_03_redis.yml: nextcloud-fpm + mysql + redis

Feel free to adjust them to your needs or link them as your compose file:

`ln -s dockercompose-files/docker-compose_03_redis.yml ./docker-compose.yml`



# !Setup

Percona need to get write permission for it's folders manually. After powering the Services up the first time the db crashes with a lack of write permissions. This has to be solved:

`source myhostname.env`
`chown -R 999 $DATA/$SERVICE/mysql`


# Snapshot of nextcloud data for evaluation:

`btrfs subvolume snapshot /mnt/nextdata /btrfs/data/@nexteval`



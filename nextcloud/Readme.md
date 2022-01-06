# About

This folder holds a flexible Nextcloud configurtion. It is configured by variables and can spin up different instances for testing or production.

# Configuration

## Variables for the environment

This envirentment gets configured by variables in .env.

The environment is mainly conficured by the vars:

- SERVICE: Defaults to "nextcloud". This configures the container and path names in the compose file.
- SUBDOMAIN: The subdomain for your instance
- VERSION: The major version of nextcloud. This is used to configure the right image.

This way you can eg. run a production environment "nextcloud" but also spin up instances for testing, maybe "nexteval". 


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




#!/bin/bash

# Exit if a variable is unset:
set -u

function prepare {
	############################################
	#### Collect Information for this script ###
	############################################


	source "$var_file"

	DATADIR="$DATA/$SERVICE/data"

	echo "* Service name: $SERVICE"
	echo "* Data dir of Nextcloud container stack: $DATA/$SERVICE"
	echo "* Where Nextcloud will save the user data on the host: $DATADIR"

	### Determine the Database
	if [ "$(grep -c mysql docker-compose.yml)" -gt 0 ]; then
		DATABASE="mysql"
		echo "* MySQL config detected"
	else
		DATABASE="postgres"
		echo "* Postgres config detected"
	fi

	### Check for apache or fpm image
	if [ "$(grep -c 'fpm-alpine' docker-compose.yml)" -gt 0 ]; then
		WEB="fpm"
		echo "* Detected fpm image"
	else
		WEB="apche"
		echo "* Detected apache image"
	fi
}


function setup {
	#######################
	### Do all the work ###
	#######################

	# If you use the MySQL for Nextcloud you need to create some dirs and give MySQL the write permissions for its datadir:
	if [ "$DATABASE" == "mysql" ]; then
		for dir in "$DATA/$SERVICE/mysql/lib" "$DATA/$SERVICE/mysql/log"; do
			if [ ! -d "$dir" ]; then
				echo "* Creating directory or MySQL: $dir"
				mkdir -p "$dir"; fi
		done

		echo "* Setting ownership for MySQL dir"
		chown -R 999 "$DATA/$SERVICE/mysql"
	fi

	#mkdir -p    $DATA/$SERVICE/config $DATA/$SERVICE/custom_apps
	#chown -R 82 $DATA/$SERVICE/config $DATA/$SERVICE/custom_apps

	# Set the right permisions for some nextcloud directories
	#for srv in config custom_apps data themes;do
	#	mkdir -p    "$DATA/$SERVICE/$srv"
	#	chown -R 82 "$DATA/$SERVICE/$srv"
	#done


	### Lets create a seperate data dir for the Nextcloud data. This is best practice:
	if [ ! -d "$DATADIR" ]; then
		echo "* Creating Nextcloud data dir: $DATADIR"
		mkdir -p "$DATADIR";
	fi


	if [ "$WEB" == "fpm" ]; then
		# if we use the fpm-alpine image we need to set the numeric id of the data dir to 82:
		echo "* Setting $DATADIR permissions for fpm"
		chown -R 82 "$DATADIR"
	else
		# if we use the apache image we need to set the numeric id of the data dir to 33:
		echo "* Setting $DATADIR permissions for Apache"
		chown -R 33 "$DATADIR"
	fi
}


function usage {

	echo "This script prepares some directories before the Nextcloud startup."
	echo
	echo "Start it with variable file as an argument"
	echo "./nc-setup.sh [variable_file.env]"
	echo
	exit
}

# without parameter just display the help and exit
if [ $# -ne 1 ]; then usage; fi
#

if [ ! -f "$1" ]; then
	echo "$1 is not a file"
	echo
else
	var_file=$1
	prepare
	setup
fi

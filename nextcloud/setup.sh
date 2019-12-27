source ${PWD}/${HOSTNAME}.env
mkdir -p $DATA/$SERVICE/mysql/lib $DATA/$SERVICE/mysql/log 
chown -R 999 $DATA/$SERVICE/mysql

#mkdir -p    $DATA/$SERVICE/config $DATA/$SERVICE/custom_apps
#chown -R 82 $DATA/$SERVICE/config $DATA/$SERVICE/custom_apps

# Set the right permisions for some nextcloud directories
for srv in config custom_apps data themes;do
	mkdir -p    $DATA/$SERVICE/$srv
	chown -R 82 $DATA/$SERVICE/$srv
done

if [ ! -d $NEXTDATA ]; then 
	mkdir -p $NEXTDATA
	chown 82 $NEXTDATA
fi

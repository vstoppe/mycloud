#!/bin/bash

source ${HOSTNAME}.env

### Creating all necessary directories:
for dir in env identity nginx ssl web; do
	if [ ! -d $dir ]; then 
		rm -f $dir
		mkdir $dir
		echo "* Creating dir $dir"
	fi
done 

### Copy the env files to their location:
ls --hide=default.conf --hide=app-id.json templates | while read env; do
	cp templates/$env env/$env
done

# 3) Get your installation__id and installation__key from https://bitwarden.com/host and provide them to the application’s environment variables at ./env/global.override.env.
# 4) Update the baseServiceUri__* and attachment__baseUrl application environment variables for your hostname at ./env/global.override.env.
# (5) Make sure that you provide your IDENTITY_CERT_PASSWORD to the application’s environment variables at ./env/global.override.env.


sed -i -e "s/00000000-0000-0000-0000-000000000000/$globalSettings__installation__id/" \
		 -e "s/SECRET_INSTALLATION_KEY/$globalSettings__installation__key/" \
		 -e "s/bitwarden.example.com/$SERVICE.$DOMAIN/g" \
		 -e "s/IDENTITY_CERT_PASSWORD/$IDENTITY_CERT_PASSWORD/" \
		 -e "s/RANDOM_DATABASE_PASSWORD/$RANDOM_DB_PASSWORD/" \
		 -e "s/RANDOM_IDENTITY_KEY/$RANDOM_IDENTITY_KEY/" \
		 -e "s/RANDOM_DUO_KEY/$RANDOM_DUO_KEY/" \
		 -e "s/smtp__host.*/smtp__host=$SMTP_HOST/" \
		 -e "s/smtp__ssl.*/smtp__ssl=$SMTP_SSL/" \
		 -e "s/smtp__username.*/smtp__username=$SMTP_USERNAME/" \
		 -e "s/smtp__password.*/smtp__password=$SMTP_PASSWORD/" \
		 -e "\$aglobalSettings__mail__smtp__startTls=$SMTP_START_TLS" \
	       env/global.override.env


sed -i "s/RANDOM_DATABASE_PASSWORD/$RANDOM_DB_PASSWORD/g" -i env/mssql.override.env


# 5) Generate a .pfx certificate file for the identity container and place it in the mapped volume directory at ./identity/identity.pfx.

if [ ! -f ./identity/identity.key ]; then
	openssl req -x509 -newkey rsa:4096 -sha256 -nodes -keyout  ./identity/identity.key -out ./identity/identity.crt -subj "/CN=Bitwarden IdentityServer" -days 10950
	openssl pkcs12 -export -out ./identity/identity.pfx -inkey ./identity/identity.key -in  ./identity/identity.crt -certfile ./identity/identity.crt -passout pass:${IDENTITY_CERT_PASSWORD}
else echo "* Identity files already exists"
fi


# * Copy your SSL certificate and keys to the ./ssl directory. By default, this directory is mapped to the nginx container at /etc/ssl. The ./nginx/default.conf can be adjusted to utilize these certificates as desired.




# Nginx needs the the letsencrypt root certificate to trust its certificates:
if [ ! -e $WS_DOCKER/$SERVICE/ssl/isrgrootx1.pem ]; then
	echo Downloading letsencrypt root certificate
	wget https://letsencrypt.org/certs/isrgrootx1.pem.txt -O $WS_DOCKER/$SERVICE/ssl/isrgrootx1.pem
else
	echo "* Letsencrypt certificate already exists"
fi


### configure nginx default.conf

cp templates/default.conf nginx/default.conf
sed -i -e "s/bitwarden.example.com/$SERVICE.$DOMAIN/g" \
		 -e "s/ssl_trusted_certificate.*$/ssl_trusted_certificate \/etc\/ssl\/isrgrootx1.pem;/g" \
		 -e "s/ssl_certificate .*/ssl_certificate     \/etc\/nginx\/certs\/$SERVICE.$DOMAIN\/fullchain.pem;/g" \
		 -e "s/ssl_certificate_key .*/ssl_certificate_key \/etc\/nginx\/certs\/$SERVICE.$DOMAIN\/key.pem;/g" \
	nginx/default.conf


# 9) Update the app-id.json file at ./web/app-id.json to include your hostname’s URL

cp templates/app-id.json web/
sed -i "s/bitwarden.example.com/$SERVICE.$DOMAIN/g" web/app-id.json


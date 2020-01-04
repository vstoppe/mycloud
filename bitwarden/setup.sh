#!/bin/bash

source ${HOSTNAME}.env

ls --hide=default.conf --hide=app-id.json templates | while read env; do
	cp templates/$env env/$env
done

# 3) Get your installation__id and installation__key from https://bitwarden.com/host and provide them to the application’s environment variables at ./env/global.override.env.
# 4) Update the baseServiceUri__* and attachment__baseUrl application environment variables for your hostname at ./env/global.override.env.
# (5) Make sure that you provide your IDENTITY_CERT_PASSWORD to the application’s environment variables at ./env/global.override.env.


sed -i -e "s/00000000-0000-0000-0000-000000000000/$globalSettings__installation__id/g" \
		 -e "s/SECRET_INSTALLATION_KEY/$globalSettings__installation__key/g" \
		 -e "s/bitwarden.example.com/$SERVICE.$DOMAIN/g" \
		 -e "s/IDENTITY_CERT_PASSWORD/$IDENTITY_CERT_PASSWORD/g" \
		 -e "s/RANDOM_DATABASE_PASSWORD/$RANDOM_DB_PASSWORD/g" \
		 -e "s/RANDOM_IDENTITY_KEY/$RANDOM_IDENTITY_KEY/g" \
		 -e "s/RANDOM_DUO_KEY/$RANDOM_DUO_KEY/g" \
	       env/global.override.env


sed -i "s/RANDOM_DATABASE_PASSWORD/$RANDOM_DB_PASSWORD/g" -i env/mssql.override.env


# 5) Generate a .pfx certificate file for the identity container and place it in the mapped volume directory at ./identity/identity.pfx.

rm -f identity/*

openssl req -x509 -newkey rsa:4096 -sha256 -nodes -keyout  ./identity/identity.key -out ./identity/identity.crt -subj "/CN=Bitwarden IdentityServer" -days 10950
openssl pkcs12 -export -out ./identity/identity.pfx -inkey ./identity/identity.key -in  ./identity/identity.crt -certfile ./identity/identity.crt -passout pass:${IDENTITY_CERT_PASSWORD}

# * Copy your SSL certificate and keys to the ./ssl directory. By default, this directory is mapped to the nginx container at /etc/ssl. The ./nginx/default.conf can be adjusted to utilize these certificates as desired.




# Nginx needs the the letsencrypt root certificate to trust its certificates:
if [ ! -e $WS_DOCKER/$SERVICE/ssl/isrgrootx1.pem ]; then
	echo Downloading letsencrypt root certificate
	if [ ! -d ssl ]; then mkdir ssl; fi
	wget https://letsencrypt.org/certs/isrgrootx1.pem.txt -O $WS_DOCKER/$SERVICE/ssl/isrgrootx1.pem
else
	echo Letsencrypt certificate already exists
fi


### configure nginx default.conf

if [ ! -d nginx ]; then rm -f nginx; mkdir nginx; fi
cp templates/default.conf nginx/default.conf
sed -i -e "s/bitwarden.example.com/$SERVICE.$DOMAIN/g" \
		 -e "s/ssl_trusted_certificate.*$/ssl_trusted_certificate \/etc\/ssl\/isrgrootx1.pem/g" \
		 -e "s/ssl_certificate .*/ssl_certificate     \/etc\/nginx\/$SERVICE.$DOMAIN\/fullchain.pem/g" \
		 -e "s/ssl_certificate_key .*/ssl_certificate_key \/etc\/nginx\/$SERVICE.$DOMAIN\/key.pem/g" \
	nginx/default.conf


# 9) Update the app-id.json file at ./web/app-id.json to include your hostname’s URL

if [ ! -d web ]; then rm -f web; mkdir web; fi
cp templates/app-id.json web/
sed -i "s/bitwarden.example.com/$SERVICE.$DOMAIN/g" web/app-id.json


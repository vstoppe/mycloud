#!/bin/bash

source ${HOSTNAME}.env

ls templates | while read env; do
	cp templates/$env env/$env
done

# * Get your installation__id and installation__key from https://bitwarden.com/host and provide them to the application’s environment variables at ./env/global.override.env.
# * Update the baseServiceUri__* and attachment__baseUrl application environment variables for your hostname at ./env/global.override.env.


sed -i -e "/^globalSettings__installation__id.*/d" \
	    -e "/^globalSettings__installation__key.*/d" \
		 -e "\$aglobalSettings__installation__id=$globalSettings__installation__id" \
		 -e "\$aglobalSettings__installation__key=$globalSettings__installation__key" \
		 -e "s/bitwarden.example.com/$SERVICE.$DOMAIN/g" \
	       env/global.override.env


# * Generate a .pfx certificate file for the identity container and place it in the mapped volume directory at ./identity/identity.pfx.

rm -f identity/*
openssl req -x509 -newkey rsa:4096 -sha256 -nodes -keyout  ./identity/identity.key -out ./identity/identity.crt -subj "/CN=Bitwarden IdentityServer" -days 10950
openssl pkcs12 -export -out ./identity/identity.pfx -inkey ./identity/identity.key -in  ./identity/identity.crt -certfile ./identity/identity.crt -passout pass:${IDENTITY_CERT_PASSWORD}

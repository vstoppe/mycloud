# This is my bitwarden installation by the (manuel metho)[https://help.bitwarden.com/article/install-on-premise/#manual-docker-installations]

- get Bitwarden (Installation ID & Key)[https://bitwarden.com/host/]
- global.override.env set vars:
-- Installation__id 
-- installation__key
-- baseServiceURI__*
-- attachment___url
- Generate pfx certificate file
-- `openssl req -x509 -newkey rsa:4096 -sha256 -nodes -keyout identity.key -out identity.crt -subj "/CN=Bitwarden IdentityServer" -days 10950`
-- `openssl pkcs12 -export -out identity.pfx -inkey identity.key -in identity.crt -certfile identity.crt -passout pass:IDENTITY_CERT_PASSWORD`

- For letsencrypt download the root certificate for ssl_certificate_key



# Setup

- Set your environment variables in your myhostname.env
- Execute `setup.sh`

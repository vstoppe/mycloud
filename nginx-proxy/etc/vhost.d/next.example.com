# Increase the upload size for files to nextcloud. The default makes nextcloud unusable.
client_max_body_size 0;

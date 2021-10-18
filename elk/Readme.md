Setup elk-htpasswd


`printf "USERNAME:$(openssl passwd -crypt PASsWoRd)\n" > $WS_DOCKER/nginx-proxy/etc/elk-htpasswd`


Filebeat connetion error:
https://discuss.opendistrocommunity.dev/t/error-during-metricbeat-or-filebeat-setup/644/5

# Setup howto
https://www.sarulabs.com/post/5/2019-08-12/sending-docker-logs-to-elasticsearch-and-kibana-with-filebeat.html

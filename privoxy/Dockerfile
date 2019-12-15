FROM rdsubhas/tor-privoxy-alpine

# privoxy-dock package was missing in the image
RUN apk add privoxy-doc
# privoxy didn't find its config dir without explicitly naming it:
RUN sed -i "s/--no-daemon/--no-daemon \/etc\/privoxy\/config/" /etc/service/privoxy/run

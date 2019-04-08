FROM openjdk:11.0.1-jdk
LABEL maintainer="Dubie <pheerlessliter@gmail.com>"

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install jq

COPY start.sh /usr/local/bin/minecraft
COPY server.tmpl /var/lib/minecraft/server.tmpl
COPY setup.sh /var/lib/minecraft/setup.sh

CMD exec minecraft

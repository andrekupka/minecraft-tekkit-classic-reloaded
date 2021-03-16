FROM java:8

MAINTAINER Andre Kupka <me-github@andrekupka.de>

RUN apt-get install -y wget unzip && \
	addgroup --gid 1234 minecraft && \
	adduser --disabled-password --home=/data --uid 1234 --gid 1234 --gecos "minecraft user" minecraft

RUN mkdir /minecraft && chown minecraft /minecraft && chmod 755 /minecraft
RUN wget -c https://edge.forgecdn.net/files/2823/160/SERVER-TekkitClassicReloaded-R1.2-MC1.12.2.zip -O /tmp/tekkit.zip && unzip /tmp/tekkit.zip -d /tmp && mv /tmp/Template/* /minecraft
RUN chown -R minecraft /minecraft
RUN find /minecraft -type f -exec chmod 644 {} \;
RUN find /minecraft -type d -exec chmod 755 {} \;
RUN sed -i 's/eula=false/eula=true/g' /minecraft/eula.txt
	

COPY start.sh /start.sh
RUN chmod +x /start.sh

USER minecraft

VOLUME /minecraft
ADD server.properties /tmp/server.properties
WORKDIR /minecraft

EXPOSE 25565

CMD ["/start.sh"]

ENV MOTD "A Tekkit classic reloaded server"
ENV LEVEL world
ENV JVM_OPTS "-Xms2048m -Xmx2048m"

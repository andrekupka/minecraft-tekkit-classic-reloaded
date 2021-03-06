#!/bin/bash

set -e

cd /minecraft

cp -rf /tmp/Template/* .
sed -i 's/eula=false/eula=true/g' eula.txt

if [[ ! -e server.properties ]]; then
    cp /tmp/server.properties .
fi

if [[ -n "$MOTD" ]]; then
    sed -i "/motd\s*=/ c motd=$MOTD" /minecraft/server.properties
fi
if [[ -n "$LEVEL" ]]; then
    sed -i "/level-name\s*=/ c level-name=$LEVEL" /minecraft/server.properties
fi
if [[ -n "$OPS" ]]; then
    echo $OPS | awk -v RS=, '{print}' >> ops.txt
fi

#java $JVM_OPTS -jar forge-*-universal.jar nogui
java $JVM_OPTS -jar forge-1.12.2-14.23.5.2847-universal.jar nogui

#!/bin/bash

if [[ ! -d /opt/eclipse-snk ]];
then
    sudo mkdir /opt/eclipse-snk
fi

sudo wget -P /opt/eclipse-snk/  https://raw.githubusercontent.com/computeiro/snk-docker/main/docs/eclipse-icon.xpm
sudo wget -P /usr/share/applications https://raw.githubusercontent.com/computeiro/snk-docker/main/docs/eclipse-snk.desktop
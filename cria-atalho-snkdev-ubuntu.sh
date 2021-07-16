#!/bin/bash

optDir=/opt/eclipse-snkdev

if [[ ! -d $optDir ]];
then
    sudo mkdir $optDir
fi

sudo wget -P $optdir  https://raw.githubusercontent.com/computeiro/snk-docker/main/docs/eclipse-icon.xpm
sudo wget -P /usr/share/applications https://raw.githubusercontent.com/computeiro/snk-docker/main/docs/eclipse-snk.desktop
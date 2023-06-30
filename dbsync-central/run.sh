#!/bin/sh

apk update
apk upgrade
apk add bash

./init_eip.sh receiver

echo Starting DB sync Receiver...

java -jar -Dspring.profiles.active=receiver openmrs-eip-app.jar

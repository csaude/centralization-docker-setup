#!/bin/sh

DB_SYNC_VERSION=1.3.0

apk update
apk upgrade
apk add bash
apk add git
apk add maven

if test ! -f "openmrs-eip-app.jar"; then
  git clone https://github.com/FriendsInGlobalHealth/openmrs-eip.git
  cd openmrs-eip
  git checkout $DB_SYNC_VERSION
  mvn clean install -DskipTests
  cp app/target/openmrs-eip-app-$DB_SYNC_VERSION.jar ../openmrs-eip-app.jar
  cd ..
fi

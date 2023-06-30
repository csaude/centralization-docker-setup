#!/bin/sh

DB_SYNC_VERSION=1.3.0

apk update
apk upgrade
apk add bash
apk add git
apk add maven

if test ! -d "openmrs-eip"; then
  git clone https://github.com/FriendsInGlobalHealth/openmrs-eip.git
  cd openmrs-eip
  git checkout $DB_SYNC_VERSION
  cd ..
fi

if test ! -d "routes"; then
  cp -a openmrs-eip/distribution/$1/routes /usr/local/dbsync/routes
fi

if test ! -f "openmrs-eip-app.jar"; then
  cd openmrs-eip
  git checkout $DB_SYNC_VERSION
  mvn clean install -DskipTests
  cp app/target/openmrs-eip-app-$DB_SYNC_VERSION.jar ../openmrs-eip-app.jar
  cd ..
fi

#!/bin/sh

apk update
apk upgrade
apk add bash
apk add git
apk add maven


if test ! -f "$home_dir/openmrs-eip-app.jar"; then
	if test ! -d "$shared_dir/openmrs-eip"; then
		cd $shared_dir
		git clone https://github.com/FriendsInGlobalHealth/openmrs-eip.git
	fi

	cd $shared_dir/openmrs-eip
	git pull oring master

	mvn clean install -Ppt -DskipTests
	cp app/target/openmrs-eip-app-1.0-SNAPSHOT.jar $home_dir/openmrs-eip-app.jar

	cd $home_dir 
fi

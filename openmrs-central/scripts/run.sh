#!/bin/sh
apt-get update
apt-get install -y curl
apt-get install -y vim 
apt-get install -y nano 
apt-get install -y expect

HOME_DIR="/usr/local/tomcat"
INSTALL_FINISHED_REPORT_FILE="$HOME_DIR/install_finished_report_file"

RELEASE_VERSION_TAG="v2.6.11"
RELEASE_NAME="openmrs-platform-release-$RELEASE_VERSION_TAG"
RELEASE_DATE="2025-03-20 12:00:00"
RELEASE_DESC="OpenMrs war file v2.6.11"
OPENMRS_PLATFORM_WAR_FILE_RELEASE_URL="https://github.com/csaude/openmrs-docker-2.6.11/releases/download/$RELEASE_VERSION_TAG/openmrs.war"

OPENMRS_DIR="$HOME_DIR/.OpenMRS"
RELEASES_PACKAGES_DIR="$OPENMRS_DIR/releases"
SCRIPTS_DIR="$HOME_DIR/scripts"
CURRENT_RELEASES_PACKAGES_DIR="$RELEASES_PACKAGES_DIR/$RELEASE_NAME"
RELEASE_PACKAGES_DOWNLOAD_COMPLETED="$CURRENT_RELEASES_PACKAGES_DIR/download_completed"

# Check if the releases directory does not exist
if [ ! -d "$RELEASES_PACKAGES_DIR" ]; then
    # releases directory does not exist, so create it
    mkdir -p "$RELEASES_PACKAGES_DIR"
    echo "releases directory $RELEASES_PACKAGES_DIR created."
else
    echo "releases directory $RELEASES_PACKAGES_DIR already exists."
fi

# Check if the download is completed
if [ ! -f "$RELEASE_PACKAGES_DOWNLOAD_COMPLETED" ]; then
	rm /usr/local/tomcat/webapps/openmrs.war
	rm -fr /usr/local/tomcat/webapps/openmrs
	
	# Downloading new release packages
	echo "Verifying $RELEASE_NAME packages download status"
	$SCRIPTS_DIR/download_release.sh "$RELEASES_PACKAGES_DIR" "$RELEASE_NAME" "$OPENMRS_PLATFORM_WAR_FILE_RELEASE_URL"

	if [ ! -f "$RELEASE_PACKAGES_DOWNLOAD_COMPLETED" ]; then
		echo "Error trying to download release packages: $RELEASE_NAME. See previous messages."
			echo "Installation process failed" 
			exit 1
	fi

	WAR_PACKAGE_RELEASE_FILE_NAME=$(getFileName "$OPENMRS_PLATFORM_WAR_FILE_RELEASE_URL")
	echo "Copying openmrs war file platform $CURRENT_RELEASES_PACKAGES_DIR/$WAR_PACKAGE_RELEASE_FILE_NAME"
	cp "$CURRENT_RELEASES_PACKAGES_DIR/$WAR_PACKAGE_RELEASE_FILE_NAME/openmrs.war" "$HOME_DIR/webapps/openmrs.war"
	
	else echo "No new version available."
fi
#exit

#if test ! -f "/usr/local/tomcat/webapps/openmrs.war"; then
#  curl -L https://downloads.sourceforge.net/project/openmrs/releases/OpenMRS_Platform_2.6.9/openmrs.war -o /usr/local/tomcat/webapps/openmrs.war
#fi

if [ ! -f "$INSTALL_FINISHED_REPORT_FILE" ]; then
	$HOME_DIR/scripts/init.sh

	timestamp=`date +%Y-%m-%d_%H-%M-%S`
  	echo "Installation finished at $timestamp" >> $INSTALL_FINISHED_REPORT_FILE
fi
$HOME_DIR/bin/catalina.sh run

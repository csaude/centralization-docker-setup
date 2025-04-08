#!/bin/sh
# This scrip is intended to check for updates for eip application and apply them when avaliable
#
#ENV

HOME_DIR=$home_dir
SHARED_DIR="$home_dir/shared"
SETUP_MAIN_PROJECT_DIR="/home/centralization-docker-setup"
EIP_SETUP_BASE_DIR="$SETUP_MAIN_PROJECT_DIR/dbsync-central"
EIP_SETUP_STUFF_DIR="$EIP_SETUP_BASE_DIR/release_stuff"
SCRIPTS_DIR="$HOME_DIR/scripts"
SETUP_SCRIPTS_DIR="$EIP_SETUP_STUFF_DIR/scripts"
INSTALL_FINISHED_REPORT_FILE="$HOME_DIR/install_finished_report_file"
DBSYNC_DATA_DIR=$SHARED_DIR/data
DOWNLOADED_EIP_JAR_FILE=$DBSYNC_DATA_DIR/openmrs-eip-app.jar
DOWNLOADED_C_FEATURES_JAR_FILE=$DBSYNC_DATA_DIR/centralization-features-manager.jar
DBSYNC_DIR="$SHARED_DIR/dbsync"
RELEASES_PACKAGES_DIR="$DBSYNC_DIR/releases"
source $SETUP_SCRIPTS_DIR/release_info.sh
CURRENT_RELEASES_PACKAGES_DIR="$RELEASES_PACKAGES_DIR/$RELEASE_NAME"
RELEASE_PACKAGES_DOWNLOAD_COMPLETED="$CURRENT_RELEASES_PACKAGES_DIR/download_completed"

timestamp=`date +%Y-%m-%d_%H-%M-%S`

echo "STARTING EIP INSTALLATION PROCESS AT $timespamp"
echo "HOME DIR $HOME_DIR"

cd $HOME_DIR

REMOTE_RELEASE_NAME=$RELEASE_NAME
REMOTE_RELEASE_DATE=$RELEASE_DATE

echo "FOUND RELEASE {NAME: $REMOTE_RELEASE_NAME, DATE: $REMOTE_RELEASE_DATE} "

echo "PERFORMING INSTALLATION STEPS..."

echo "COPPING EIP APP FILES FROM $EIP_SETUP_STUFF_DIR/* TO $HOME_DIR/"

cp -R $EIP_SETUP_STUFF_DIR/* $HOME_DIR/

echo "COPYING DOCKER PROJECT TO EIP DIR FROM $SETUP_MAIN_PROJECT_DIR TO $HOME_DIR"
cp -R $SETUP_MAIN_PROJECT_DIR $HOME_DIR

# Check if the releases directory does not exist, than create.
if [ ! -d "$RELEASES_PACKAGES_DIR" ]; then
    # releases directory does not exist, so create it
    mkdir -p "$RELEASES_PACKAGES_DIR"
    echo "releases directory $RELEASES_PACKAGES_DIR created."
else
    echo "releases directory $RELEASES_PACKAGES_DIR already exists."
fi

# Check if the openmrs-eip-app download is completed
if [ ! -f "$RELEASE_PACKAGES_DOWNLOAD_COMPLETED" ]; then
	rm -r $HOME_DIR/openmrs-eip-app.jar
	rm -r $HOME_DIR/centralization-features-manager.jar
	rm -r $DOWNLOADED_EIP_JAR_FILE	
	rm -r $DOWNLOADED_C_FEATURES_JAR_FILE
	
	# Downloading new release packages
	echo "Verifying $RELEASE_NAME packages download status"
	$SCRIPTS_DIR/download_release.sh "$RELEASES_PACKAGES_DIR" "$RELEASE_NAME" "$OPENMRS_EIP_APP_RELEASE_URL" "$CENTRALIZATION_FEATURES_MANAGER_RELEASE_URL"

	if [ ! -f "$RELEASE_PACKAGES_DOWNLOAD_COMPLETED" ]; then
		echo "Error trying to download release packages: $RELEASE_NAME. See previous messages."
		echo "Installation process failed" 
		exit 1
	fi
	
	# Check if the releases directory does not exist, than create.
	if [ ! -d "$DBSYNC_DATA_DIR" ]; then
		echo "creating dir $DBSYNC_DATA_DIR"
	    	mkdir -p $DBSYNC_DATA_DIR
	else
		echo "directory $DBSYNC_DATA_DIR already exists."
	fi	

else echo "No new DBSYNC_APP_RELEASE version available."
fi

echo "Performing the copy of JARS"

EIP_FILE_NAME=$(echo "$OPENMRS_EIP_APP_RELEASE_URL" | rev | cut -d'/' -f 1 | rev)
cp $CURRENT_RELEASES_PACKAGES_DIR/$EIP_FILE_NAME $DOWNLOADED_EIP_JAR_FILE
cp $CURRENT_RELEASES_PACKAGES_DIR/$EIP_FILE_NAME $HOME_DIR/openmrs-eip-app.jar	
CEN_EIP_FILE_NAME=$(echo "$CENTRALIZATION_FEATURES_MANAGER_RELEASE_URL" | rev | cut -d'/' -f 1 | rev)
cp $CURRENT_RELEASES_PACKAGES_DIR/$CEN_EIP_FILE_NAME $DOWNLOADED_C_FEATURES_JAR_FILE
cp $CURRENT_RELEASES_PACKAGES_DIR/$CEN_EIP_FILE_NAME $HOME_DIR/centralization-features-manager.jar
	
echo "ALL FILES WERE COPIED"

$SCRIPTS_DIR/apk_install.sh
$SCRIPTS_DIR/install_crons.sh

timestamp=`date +%Y-%m-%d_%H-%M-%S`
echo "Installation finished at $timestamp" >> $INSTALL_FINISHED_REPORT_FILE

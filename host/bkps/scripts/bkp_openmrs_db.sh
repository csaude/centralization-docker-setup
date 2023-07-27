#!/bin/bash
# specific script for backup the openmrs database
#
CONFIG_FILE=$1

. $CONFIG_FILE

SCRIPT_LOCATION=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )


DB_CONTAINER=$OPENMRS_DB_CONTAINER
DB_USER=$OPENMRS_DB_USER
DB_PASSWORD=$OPENMRS_DB_PASSWORD
DB_NAME=$OPENMRS_DB_NAME
BKP_HOME_DIR_OPENMRS=$EIP_HOME_DIR

$SCRIPT_LOCATION/bkp_db.sh $DB_CONTAINER $DB_USER $DB_PASSWORD $DB_NAME $BKP_HOME_DIR_OPENMRS
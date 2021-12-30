#!/bin/bash

#export JAVA_OPTS="-Dorg.openmrs.module.debezium.snapshotOnly"
export JAVA_OPTS="-Dfile.encoding=UTF-8 -server -Xms2048m -Xmx10240m -Duser.timezone=Africa/Maputo"
#export JAVA_OPTS="-Dfile.encoding=UTF-8 -server -Xms512m -Xmx1536m -XX:PermSize=256m -XX:MaxPermSize=768m -Duser.timezone=Africa/Maputo -Dorg.openmrs.module.debezium.snapshotOnly"
export OPENMRS_RUNTIME_PROPERTIES_FILE='/usr/local/tomcat/.OpenMRS/openmrs-runtime.properties'
#export JAVA_OPTS="${JAVA_OPTS} -Xdebug -Xrunjdwp:transport=dt_socket,address=8001,server=y,suspend=n"


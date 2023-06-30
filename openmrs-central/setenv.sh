#!/bin/bash

#Add OpenCR server certificate to our JVM trust store
keytool -import -noprompt -storepass changeit -alias opencr -keystore $JAVA_HOME/jre/lib/security/cacerts -file /usr/local/tomcat/server_cert.pem
#keytool -import -noprompt -storepass changeit -alias opencr -keystore $JAVA_HOME/lib/security/cacerts -file /usr/local/tomcat/server_cert.pem
echo "\n\nCertificate Imported!"

keytool -list -alias opencr -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass changeit -v

#!/bin/bash
cd /root


rm -rf "/root/${PROJECT_NAME}-webapp"
curl 'https://start.fenixedu.org/webapp.zip' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Connection: keep-alive' --data "groupId=org.fenixedu&artifactId=${PROJECT_NAME}-webapp&name=${PROJECT_NAME} Webapp&mavenVersion=${MAVEN_VERSION}&bennuVersion=${BENNU_VERSION}&dbHost=localhost&dbPort=3306&dbName=${DB_NAME}&dbUser=${DB_USER}&dbPassword=${DB_PASSWORD}&generate=" --compressed -o ${PROJECT_NAME}-webapp.zip

unzip -o ${PROJECT_NAME}-webapp.zip
cd "/root/${PROJECT_NAME}-webapp"

mysql -u ${DB_USER} -e "drop database \`"$DB_NAME"\` if exists;" -p${DB_PASSWORD}
mysql -u ${DB_USER} -e "create database \`"$DB_NAME"\`;" -p${DB_PASSWORD}

echo "dbAlias = //localhost:3306/$DB_NAME
dbUsername = $DB_USER
dbPassword = $DB_PASSWORD
updateRepositoryStructureIfNeeded = true" > src/main/resources/fenix-framework.properties

echo "$DB_NAME"

mvn clean tomcat7:run

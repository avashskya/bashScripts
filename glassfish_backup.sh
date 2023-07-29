#!/bin/sh
echo "-----------------------Running Backup script--------------------------"
echo "                                     Listing Domains:"
ls -l ../ | grep -v "backup"
echo "-----------------------------------------------------------------------"
echo "Name the domain you want to backup:"
read DOMAIN_NAME

mkdir "${DOMAIN_NAME}_$(date +'%Y.%m.%d|%H:%M:%S')" && cd ../${DOMAIN_NAME} && cp -r $(ls -A | grep -v "logs") ../backup/${DOMAIN_NAME}_$(date +'%Y.%m.%d|%H:%M:%S') -v

echo "-------------------------Backup Completed--------------------------"

